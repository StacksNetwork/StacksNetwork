#!/usr/bin/env php
<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage poller
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

chdir(dirname($argv[0]));

$options = getopt("h:i:m:n:dqrV");

if (isset($options['d']))
{
  echo("DEBUG!\n");
  $debug = TRUE;
  ini_set('display_errors', 1);
  ini_set('display_startup_errors', 1);
  ini_set('log_errors', 1);
#  ini_set('error_reporting', E_ALL ^ E_NOTICE);
} else {
  $debug = FALSE;
#  ini_set('display_errors', 0);
  ini_set('display_startup_errors', 0);
  ini_set('log_errors', 0);
#  ini_set('error_reporting', 0);
}

include("includes/defaults.inc.php");
include("config.php");
include("includes/definitions.inc.php");
include("includes/functions.inc.php");
include("includes/polling/functions.inc.php");

$scriptname = basename($argv[0]);

$cli = TRUE;

$poller_start = utime();

if (isset($options['V']))
{
  print_message(OBSERVIUM_PRODUCT." ".OBSERVIUM_VERSION);
  exit;
}
if (!isset($options['q']))
{
  print_message("%g".OBSERVIUM_PRODUCT." ".OBSERVIUM_VERSION."\n%W轮询%n\n", 'color');
}

if ($options['h'] == "odd")      { $options['n'] = "1"; $options['i'] = "2"; }
elseif ($options['h'] == "even") { $options['n'] = "0"; $options['i'] = "2"; }
elseif ($options['h'] == "all")  { $where = " "; $doing = "all"; }
elseif ($options['h'])
{
  $params = array();
  if (is_numeric($options['h']))
  {
    $where = "AND `device_id` = ?";
    $doing = $options['h'];
    $params[] = $options['h'];
  }
  else
  {
    $where = "AND `hostname` LIKE ?";
    $doing = $options['h'];
    $params[] = str_replace('*','%', $options['h']);
  }
}

if (isset($options['i']) && $options['i'] && isset($options['n']))
{
  $where = true; // FIXME

  $query = 'SELECT `device_id` FROM (SELECT @rownum :=0) r,
              (
                SELECT @rownum := @rownum +1 AS rownum, `device_id`
                FROM `devices`
                WHERE `disabled` = 0
                ORDER BY `device_id` ASC
              ) temp
            WHERE MOD(temp.rownum, '.$options['i'].') = ?;';
  $doing = $options['n'] ."/".$options['i'];
  $params[] = $options['n'];
}

if (!$where)
{
  print_message("%n
USAGE:
$scriptname [-drqV] [-i instances] [-n number] [-m module] [-h device]

EXAMPLE:
-h <device id> | <device hostname wildcard>  Poll single device
-h odd                                       Poll odd numbered devices  (same as -i 2 -n 0)
-h even                                      Poll even numbered devices (same as -i 2 -n 1)
-h all                                       Poll all devices
-h new                                       Poll all devices that have not had a discovery run before

-i <instances> -n <number>                   Poll as instance <number> of <instances>
                                             Instances start at 0. 0-3 for -n 4

OPTIONS:
 -h                                          Device hostname, id or key odd/even/all/new.
 -i                                          Poll instance.
 -n                                          Poll number.
 -q                                          Quiet output.
 -V                                          Show version and exit.

DEBUGGING OPTIONS:
 -r                                          Do not create or update RRDs
 -d                                          Enable debugging output.
 -m                                          Specify module(s) (separated by commas) to be run.

%r无效的参数!%n", 'color', FALSE);
  exit;
}

if (isset($options['r']))
{
  $config['norrd'] = TRUE;
}

rrdtool_pipe_open($rrd_process, $rrd_pipes);

echo("开始轮询:\n\n");
$polled_devices = 0;
if (!isset($query))
{
  $query = "SELECT `device_id` FROM `devices` WHERE `disabled` = 0 $where ORDER BY `device_id` ASC";
}

foreach (dbFetch($query, $params) as $device)
{
  $device = dbFetchRow("SELECT * FROM `devices` WHERE `device_id` = ?", array($device['device_id']));
  poll_device($device, $options);
  $polled_devices++;
}

$poller_end = utime(); $poller_run = $poller_end - $poller_start; $poller_time = substr($poller_run, 0, 5);

if ($polled_devices)
{
  dbInsert(array('type' => 'poll', 'doing' => $doing, 'start' => $poller_start, 'duration' => $poller_time, 'devices' => $polled_devices ), 'perf_times');
  if (is_numeric($doing)) { $doing = $device['hostname']; } // Single device ID convert to hostname for log
} else {
  print_warning("警告: 0 设备轮询. 您可能指定了一个不存在的设备?");
}

$string = $argv[0] . ": $doing - $polled_devices 设备轮询 $poller_time 秒";
print_debug($string);

if (!isset($options['q']))
{
  if ($config['snmp']['hide_auth'])
  {
    print_debug("注意, \$config['snmp']['hide_auth'] 设置为 TRUE, snmp community 与 snmp v3 认证从debug中被隐藏.");
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
rrdtool_pipe_close($rrd_process, $rrd_pipes);
unset($config); // Remove this for testing

#print_vars(get_defined_vars());

// EOF
