#!/usr/bin/env php
<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage snmptraps
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
ini_set('log_errors', 1);
ini_set('error_reporting', E_ALL);

include("includes/defaults.inc.php");
include("config.php");
include("includes/definitions.inc.php");
include("includes/functions.inc.php");

$entry = explode(",", $argv[1]);

logfile('SNMPTRAP: '.$argv[1]);

#print_vars($entry);

$device = @dbFetchRow("SELECT * FROM devices WHERE `hostname` = ?", array($entry['0']));

if (!$device['device_id'])
{
  $device = @dbFetchRow("SELECT * FROM ipv4_addresses AS A, ports AS I WHERE A.ipv4_address = ? AND I.port_id = A.port_id", array($entry['0']));
}

if (!$device['device_id']) { exit; }

$file = $config['install_dir'] . "/includes/snmptrap/".$entry['1'].".inc.php";
if (is_file($file)) { include("$file"); } else { echo("未知的陷阱 ($file)"); }

// EOF
