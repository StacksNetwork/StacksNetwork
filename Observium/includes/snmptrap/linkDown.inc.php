<?php

$interface = mysql_fetch_assoc(mysql_query("SELECT * FROM `ports` WHERE `device_id` = '".$device['device_id']."' AND `ifIndex` = '".$entry[2]."'"));

if (!$interface) { exit; }

$ifOperStatus = "down";
#$ifAdminStatus = "down";

log_event("SNMP Trap: 链路故障" . $interface['ifDescr'], $device, "interface", $interface['port_id']);

#if ($ifAdminStatus != $interface['ifAdminStatus'])
#{
#  log_event("接口失效 : " . $interface['ifDescr'] . " (TRAP)", $device, "interface", $interface['port_id']);
#}
if ($ifOperStatus != $interface['ifOperStatus'])
{
  log_event("接口断开 : " . $interface['ifDescr'] . " (TRAP)", $device, "interface", $interface['port_id']);
  mysql_query("UPDATE `ports` SET ifOperStatus = 'down' WHERE `port_id` = '".$interface['port_id']."'");
}

?>