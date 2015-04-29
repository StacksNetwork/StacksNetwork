#!/usr/bin/env php
<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage discovery
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2015 Adam Armstrong
 *
 */

chdir(dirname($argv[0]));

include_once("includes/defaults.inc.php");
include_once("config.php");

// Get options before definitions!
$options = getopt("h:i:m:n:dquV");

include_once("includes/definitions.inc.php");
include("includes/functions.inc.php");
include("includes/discovery/functions.inc.php");

$scriptname = basename($argv[0]);

$cli = TRUE;

//if (is_cron()) { $options['q'] = TRUE; } // Set quiet for cron

$start = utime();
$runtime_stats = array();

if (isset($options['V']))
{
  print_message(OBSERVIUM_PRODUCT." ".OBSERVIUM_VERSION);
  exit;
}

if (!isset($options['q']))
{
  print_message("%g".OBSERVIUM_PRODUCT." ".OBSERVIUM_VERSION."\n%WDiscovery%n\n", 'color');

  // Warning about obsolete configs.
  if (print_obsolete_config()) { echo PHP_EOL; }
}

if (isset($options['h']))
{
  $params = array();
  switch ($options['h'])
  {
    case 'odd':
      $options['n'] = 1;
      $options['i'] = 2;
      break;
    case 'even':
      $options['n'] = 0;
      $options['i'] = 2;
      break;
    case 'all':
      $where = ' ';
      $doing = 'all';
      break;
    case 'new':
      $where = 'AND (`last_discovered` IS NULL OR `last_discovered` = ? OR `force_discovery` = "1")';
      $params[] = '0000-00-00 00:00:00';
      $doing = 'new';
      break;
    case 'none':
      $options['u'] = TRUE;
      break;
    default:
      $doing      = $options['h'];
      if (is_numeric($options['h']))
      {
        $where    = 'AND `device_id` = ?';
        $params[] = $options['h'];
      } else {
        $where = 'AND `hostname` LIKE ?';
        $params[] = str_replace('*','%', $options['h']);
      }
  }
}

if (isset($options['i']) && $options['i'] && isset($options['n']))
{
  $where = 'AND MOD(device_id,'.$options['i'].') = ?';
  $params[] = $options['n'];
  $doing = $options['n'] .'/'.$options['i'];
}

if (isset($options['u']) || ($where && in_array($options['h'], array('all', 'odd', 'even'))))
{
  $options['u'] = TRUE;

  include($config['install_dir'].'/includes/update/update.php');
}
else if (!isset($options['q']))
{
  // Warn about need DB schema update
  $db_version = get_db_version();
  $db_version = sprintf("%03d", $db_version+1);
  if (is_file($config['install_dir']."/update/$db_version.sql") || is_file($config['install_dir']."/update/$db_version.php"))
  {
    print_warning("您的数据库模式是旧的, 需要更新. 从控制台运行:\n  ".$config['install_dir']."/discovery.php -u");
  }
  unset($db_version);
}

if (!$where && !$options['u'])
{
  print_message("%n
USAGE:
$scriptname [-dquV] [-i instances] [-n number] [-m module] [-h device]

EXAMPLE:
-h <device id> | <device hostname wildcard>  Discover single device
-h odd                                       Discover odd numbered devices  (same as -i 2 -n 0)
-h even                                      Discover even numbered devices (same as -i 2 -n 1)
-h all                                       Discover all devices
-h new                                       Discover all devices that have not had a discovery run before

-i <instances> -n <number>                   Discover as instance <number> of <instances>
                                             Instances start at 0. 0-3 for -n 4

OPTIONS:
 -h                                          Device hostname, id or key odd/even/all/new.
 -i                                          Discovery instance.
 -n                                          Discovery number.
 -q                                          Quiet output.
 -u                                          Upgrade DB schema
 -V                                          Show version and exit.

DEBUGGING OPTIONS:
 -d                                          Enable debugging output.
 -dd                                         More verbose debugging output.
 -m                                          Specify modules (separated by commas) to be run.

%r无效的参数!%n", 'color', FALSE);
}

if ($config['version_check'] && ($options['h'] != 'new' || $options['u']))
{
  include($config['install_dir'].'/includes/versioncheck.inc.php');
}

if (!$where) { exit; }

$discovered_devices = 0;

foreach (dbFetchRows("SELECT * FROM `devices` WHERE `status` = 1 AND `disabled` = 0 $where ORDER BY `last_discovered_timetaken` ASC", $params) as $device)
{
  // Additional check if device SNMPable, because during
  // discovery many devices (long time), the some device can be switched off
  if ($options['h'] == 'new' || isSNMPable($device))
  {
    discover_device($device, $options);
    if (!isset($options['m']) && function_exists('update_device_alert_table')) { update_device_alert_table($device); } // not exist in 'community' edition
  } else {
    $string = "设备 '" . $device['hostname'] . "' 跳过, 因为关闭了正在运行的自动发现进程.";
    print_debug($string);
    logfile($argv[0] . ": $string");
  }
}

$end = utime(); $run = $end - $start;
$proctime = substr($run, 0, 5);

if ($discovered_devices)
{
  dbInsert(array('type' => 'discover', 'doing' => $doing, 'start' => $start, 'duration' => $proctime, 'devices' => $discovered_devices), 'perf_times');
  if (is_numeric($doing)) { $doing = $device['hostname']; } // Single device ID convert to hostname for log
}
else if (!isset($options['q']) && !$options['u'])
{
  print_warning("警告: 0 设备被发现.".($options['h'] != 'new' ? " 您是否指定了一个不存在的设备?" : ''));
}

$string = $argv[0] . ": $doing - $discovered_devices 设备被发现, 耗时 $proctime 分钟";
print_debug($string);

if (!isset($options['q']))
{
  if ($config['snmp']['hide_auth'])
  {
    print_debug("NOTE, \$config['snmp']['hide_auth'] sets as TRUE, snmp community and snmp v3 auth hidden from debug output.");
  }
  print_message('Memory usage: '.formatStorage(memory_get_usage(TRUE), 2, 4).' (peak: '.formatStorage(memory_get_peak_usage(TRUE), 2, 4).')');
  print_message('MySQL: Cell['.($db_stats['fetchcell']+0).'/'.round($db_stats['fetchcell_sec']+0,2).'s]'.
                       ' Row['.($db_stats['fetchrow']+0). '/'.round($db_stats['fetchrow_sec']+0,2).'s]'.
                      ' Rows['.($db_stats['fetchrows']+0).'/'.round($db_stats['fetchrows_sec']+0,2).'s]'.
                    ' Column['.($db_stats['fetchcol']+0). '/'.round($db_stats['fetchcol_sec']+0,2).'s]'.
                    ' Update['.($db_stats['update']+0).'/'.round($db_stats['update_sec']+0,2).'s]'.
                    ' Insert['.($db_stats['insert']+0). '/'.round($db_stats['insert_sec']+0,2).'s]'.
                    ' Delete['.($db_stats['delete']+0). '/'.round($db_stats['delete_sec']+0,2).'s]');
}

logfile($string);

// EOF
