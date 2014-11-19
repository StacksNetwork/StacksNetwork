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

// Yes, that's the Kenel version.
$version = "Kernel " . trim(snmp_get($device, "entKenelVersion.0", "-OQv", "SENAO-ENTERPRISE-INDOOR-AP-CB-MIB", mib_dirs('senao')),'" ');
$version .= " / Apps " . trim(snmp_get($device, "entAppVersion.0", "-OQv", "SENAO-ENTERPRISE-INDOOR-AP-CB-MIB", mib_dirs('senao')),'" ');

$serial = trim(snmp_get($device, "entSN.0", "-OQv", "SENAO-ENTERPRISE-INDOOR-AP-CB-MIB", mib_dirs('senao')),'" ');

// There doesn't seem to be a real hardware identification.. sysName will have to do?
$hardware = str_replace("EnGenius ","",snmp_get($device,"sysName.0", "-OQv")) . " v" . trim(snmp_get($device, "entHwVersion.0", "-OQv", "SENAO-ENTERPRISE-INDOOR-AP-CB-MIB", mib_dirs('senao')),'" .');

$mode = snmp_get($device, "entSysMode.0", "-OQv", "SENAO-ENTERPRISE-INDOOR-AP-CB-MIB", mib_dirs('senao'));

switch ($mode)
{
  case 0:
    $features = "Router mode";
    break;
  case 1:
    $features = "Universal repeater mode";
    break;
  case 2:
    $features = "Access Point mode";
    break;
  case 3:
    $features = "Client Bridge mode";
    break;
  case 4:
    $features = "Client router mode";
    break;
  case 5:
    $features = "WDS Bridge mode";
    break;
}

// EOF
