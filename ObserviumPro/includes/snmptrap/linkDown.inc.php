<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage poller
 * @copyright  (C) 2006-2015 Adam Armstrong
 *
 */

$interface = dbFetchRow('SELECT * FROM `ports` WHERE `device_id` = ? AND `ifIndex` = ?', array($device['device_id'], $entry[2]));

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
  dbUpdate(array('ifOperStatus' => 'down'), 'ports', '`port_id` = ?', array($interface['port_id']));
}

// EOF
