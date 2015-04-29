#!/usr/bin/env php
<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage cli
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2015 Adam Armstrong
 *
 */

chdir(dirname($argv[0]));
$scriptname = basename($argv[0]);

include_once("includes/defaults.inc.php");
include_once("config.php");

$options = getopt("d");
if (isset($options['d'])) { array_shift($argv); } // for compatability

include_once("includes/definitions.inc.php");
include("includes/functions.inc.php");

print_message("%g".OBSERVIUM_PRODUCT." ".OBSERVIUM_VERSION."\n%W重命名设备%n\n", 'color');

// Remove a host and all related data from the system

if ($argv[1] && $argv[2])
{
  $host = strtolower($argv[1]);
  $id = get_device_id_by_hostname($host);
  if ($id)
  {
    $tohost = strtolower($argv[2]);
    $toid = get_device_id_by_hostname($tohost);
    if ($toid)
    {
      print_error("没有重命名. 新的主机名 $tohost 已经存在.");
    } else {
      if (renamehost($id, $tohost, 'console'))
      {
        print_message("主机 $host 重命名为 $tohost.");
      }
    }
  } else {
    print_error("主机 $host 不存在.");
  }
} else {
    print_message("%n
使用方法:
$scriptname <原主机名> <新主机名>

%r无效的参数!%n", 'color', FALSE);
}

// EOF
