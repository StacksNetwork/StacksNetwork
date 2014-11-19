<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage discovery
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

// This could probably do with a rewrite, I suspect there's 1 table that can be walked for all the info below instead of 4.
// Also, all types should be equal, not brocade-dom, brocade-dom-tx and brocade-dom-rx (requires better indexes too)

echo(" FOUNDRY-SN-SWITCH-GROUP-MIB ");

$oids = snmpwalk_cache_oid($device, "snIfOpticalMonitoringTxBiasCurrent", array(), "FOUNDRY-SN-SWITCH-GROUP-MIB", mib_dirs('foundry'));

if (is_array($oids))
{
  foreach ($oids as $index => $entry)
  {
    $entry['descr'] = snmp_get($device, "ifDescr.".$index,"-Oqv") . " DOM TX Bias Current";
    $entry['oid'] = ".1.3.6.1.4.1.1991.1.1.3.3.6.1.4.".$index;
    $entry['current'] = $entry['snIfOpticalMonitoringTxBiasCurrent'];
    $entry['port']    = get_port_by_index_cache($device['device_id'], $index);

    if (is_array($entry['port'])) { $entry['e_t'] = 'port'; $entry['e_e'] = $entry['port']['port_id']; }
    if (!preg_match("|N/A|",$entry['current']))
    {
      discover_sensor($valid['sensor'], 'current', $device, $entry['oid'], $index, 'brocade-dom', $entry['descr'], 1000, 1, NULL, NULL, NULL, NULL, NULL,'snmp',NULL,NULL,$entry['e_t'], $entry['e_e']);
    }
  }
}

$oids = snmpwalk_cache_oid($device, "snIfOpticalMonitoringTxPower", array(), "FOUNDRY-SN-SWITCH-GROUP-MIB", mib_dirs('foundry'));

if (is_array($oids))
{
  foreach ($oids as $index => $entry)
  {
    $entry['descr'] = snmp_get($device, "ifDescr.".$index,"-Oqv") . " DOM TX Power";
    $entry['oid']   = ".1.3.6.1.4.1.1991.1.1.3.3.6.1.2.".$index;
    $entry['dbm']   =  $entry['snIfOpticalMonitoringTxPower'];
    $entry['port']  = get_port_by_index_cache($device['device_id'], $index);

    if (is_array($entry['port'])) { $entry['e_t'] = 'port'; $entry['e_e'] = $entry['port']['port_id']; }
    if (!preg_match("|N/A|",$entry['dbm']))
    {
      discover_sensor($valid['sensor'], 'dbm', $device, $entry['oid'], $index, 'brocade-dom-tx', $entry['descr'], 1, 1, NULL, NULL, NULL, NULL, NULL,'snmp',NULL,NULL,$entry['e_t'], $entry['e_e']);
    }
  }
}

$oids = snmpwalk_cache_oid($device, "snIfOpticalMonitoringRxPower", array(), "FOUNDRY-SN-SWITCH-GROUP-MIB", mib_dirs('foundry'));
if (is_array($oids))
{
  foreach ($oids as $index => $entry)
  {
    $entry['descr'] = snmp_get($device, "ifDescr.".$index,"-Oqv") . " DOM RX Power";
    $entry['oid'] = ".1.3.6.1.4.1.1991.1.1.3.3.6.1.3.".$index;
    $entry['dbm'] = $entry['snIfOpticalMonitoringRxPower'];
    $entry['port']        = get_port_by_index_cache($device['device_id'], $index);

    if (is_array($entry['port'])) { $entry['e_t'] = 'port'; $entry['e_e'] = $entry['port']['port_id']; }
    if (!preg_match("|N/A|",$entry['dbm']))
    {
      discover_sensor($valid['sensor'], 'dbm', $device, $entry['oid'], $index, 'brocade-dom-rx', $entry['descr'], 1, 1, NULL, NULL, NULL, NULL, NULL,'snmp',NULL,NULL,$entry['e_t'], $entry['e_e']);
    }
  }
}

$oids = snmpwalk_cache_oid($device, "snIfOpticalMonitoringTemperature", array(), "FOUNDRY-SN-SWITCH-GROUP-MIB", mib_dirs('foundry'));

if (is_array($oids))
{
  foreach ($oids as $index => $entry)
  {
    $entry['descr'] = snmp_get($device, "ifDescr.".$index,"-Oqv") . " DOM Temperature";
    $entry['oid'] = ".1.3.6.1.4.1.1991.1.1.3.3.6.1.1.".$index;
    $entry['temperature'] = $entry['snIfOpticalMonitoringTemperature'];
    $entry['port']        = get_port_by_index_cache($device['device_id'], $index);

    if (is_array($entry['port'])) { $entry['e_t'] = 'port'; $entry['e_e'] = $entry['port']['port_id']; }
    if (!preg_match("|N/A|",$entry['temperature']))
    {
      discover_sensor($valid['sensor'], 'temperature', $device, $entry['oid'], $index, 'brocade-dom', $entry['descr'], 1, 1, NULL, NULL, NULL, NULL, NULL,'snmp',NULL,NULL,$entry['e_t'], $entry['e_e']);
    }
  }
}

// EOF
