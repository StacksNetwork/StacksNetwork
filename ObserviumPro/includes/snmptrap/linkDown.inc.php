<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage poller
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

# FIXME dbFacile
$interface = mysql_fetch_assoc(mysql_query("SELECT * FROM `ports` WHERE `device_id` = '".$device['device_id']."' AND `ifIndex` = '".$entry[2]."'"));

if (!$interface) { exit; }

$ifOperStatus = "down";
#$ifAdminStatus = "down";

log_event("SNMP Trap: linkDown " . $interface['ifDescr'], $device, "interface", $interface['port_id']);

#if ($ifAdminStatus != $interface['ifAdminStatus'])
#{
#  log_event("Interface Disabled : " . $interface['ifDescr'] . " (TRAP)", $device, "interface", $interface['port_id']);
#}
if ($ifOperStatus != $interface['ifOperStatus'])
{
  log_event("接口状态异常 : " . $interface['ifDescr'] . " (TRAP)", $device, "interface", $interface['port_id']);
  #FIXME dbFacile
  mysql_query("UPDATE `ports` SET ifOperStatus = 'down' WHERE `port_id` = '".$interface['port_id']."'");
}

// EOF
