#!/usr/bin/env php
<?php

include("includes/defaults.inc.php");
include("config.php");
include("includes/functions.php");

$device_query = mysql_query("SELECT * FROM `devices` WHERE `device_id` LIKE '%" . $argv[1] . "' AND disabled = '0' ORDER BY `device_id` DESC");

while ($device = mysql_fetch_assoc($device_query))
{
  $port = $device['snmp_port'];

  echo($device['hostname']. " ");

  if (isPingable($device['hostname']))
  {
    $pos = snmp_get($device, "sysDescr.0", "-Oqv", "SNMPv2-MIB");
    echo($device['protocol'].":".$device['hostname'].":".$device['snmp_port']." - ".$device['snmp_community']." ".$device['snmp_version'].": ");
    if ($pos == '')
    {
      $status='0';
    } else {
      $status='1';
    }
  } else {
    $status='0';
  }

  if ($status == '1')
  {
    echo("正常\n");
  } else {
    echo("异常\n");
  }

  if ($status != $device['status'])
  {
    mysql_query("UPDATE `devices` SET `status`= '$status' WHERE `device_id` = '" . $device['device_id'] . "'");

    if ($status == '1')
    {
      $stat = "正常";
      mysql_query("INSERT INTO alerts (importance, device_id, message) VALUES ('0', '" . $device['device_id'] . "', '设备正常\n')");
      if ($config['alerts']['email']['enable'])
      {
        notify($device, "设备正常: " . $device['hostname'], "设备正常: " . $device['hostname']);
      }
    } else {
      $stat = "异常";
      mysql_query("INSERT INTO alerts (importance, device_id, message) VALUES ('9', '" . $device['device_id'] . "', '设备异常\n')");
      if ($config['alerts']['email']['enable'])
      {
        notify($device, "设备异常: " . $device['hostname'], "设备异常: " . $device['hostname']);
      }
    }

    log_event("设备状态变更为 $stat", $device, strtolower($stat));
    echo("状态变更!\n");
  }
}

?>
