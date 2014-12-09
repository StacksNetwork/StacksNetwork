#!/usr/bin/env php
<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage alerts
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

chdir(dirname($argv[0]));

include("includes/defaults.inc.php");
include("config.php");
include("includes/definitions.inc.php");
include("includes/functions.inc.php");
include("html/includes/functions.inc.php");

// Check all of our interface RRD files for errors

if ($argv[1]) { $where = "AND `port_id` = ?"; $params = array($argv[1]); }

$i = 0;
$errored = 0;

foreach (dbFetchRows("SELECT * FROM `ports` AS I, `devices` AS D WHERE I.device_id = D.device_id $where", $params) as $interface)
{
  $errors = $interface['ifInErrors_delta'] + $interface['ifOutErrors_delta'];
  if ($errors > '1')
  {
    $errored[] = generate_device_link($interface, $interface['hostname'] . " - " . $interface['ifDescr'] . " - " . $interface['ifAlias'] . " - " . $interface['ifInErrors_delta'] . " - " . $interface['ifOutErrors_delta']);
    $errored++;
  }
  $i++;
}

echo("检测 $i 接口\n");

if (is_array($errored))
{ // If there are errored ports
  $i = 0;
  $msg = "接口上存在错误 : \n\n";

  foreach ($errored as $int)
  {
    $msg .= "$int\n";  // Add a line to the report email warning about them
    $i++;
  }
  // Send the alert email
  notify($device, "Observium 检测到接口 $i 正在报错" . ($i != 1 ? 's' : ''), $msg);
}

echo("$errored 接口报错已经超过5分钟.\n");

// EOF
