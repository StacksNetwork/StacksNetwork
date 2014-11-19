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

echo(" WWP-LEOS-PORT-XCVR-MIB (Bias) ");
$oids = snmpwalk_cache_oid($device, "wwpLeosPortXcvrBias", array(), "WWP-LEOS-PORT-XCVR-MIB", mib_dirs(array('wwp', 'ciena')) );
$oids = snmpwalk_cache_oid($device, "wwpLeosPortXcvrHighBiasAlarmThreshold", $oids, "WWP-LEOS-PORT-XCVR-MIB", mib_dirs(array('wwp', 'ciena')) );
$oids = snmpwalk_cache_oid($device, "wwpLeosPortXcvrLowBiasAlarmThreshold", $oids, "WWP-LEOS-PORT-XCVR-MIB",  mib_dirs(array('wwp', 'ciena')) );

if (is_array($oids))
{
  foreach ($oids as $index => $entry)
  {
                $entry['descr']   = dbFetchCell("SELECT ifDescr FROM `ports` WHERE `device_id` = ? AND `ifName` = ?", array($device['device_id'], $index)) . " Bias mA";
    $entry['oid'] = "1.3.6.1.4.1.6141.2.60.4.1.1.1.1.18.".$index;
    $entry['current']   = $entry['wwpLeosPortXcvrBias'];
    $entry['low']       = $entry['wwpLeosPortXcvrLowBiasAlarmThreshold'];
    $entry['loww']  = $entry['wwpLeosPortXcvrLowBiasAlarmThreshold'];
    $entry['high']      = $entry['wwpLeosPortXcvrHighBiasAlarmThreshold'];
    $entry['highw'] = $entry['wwpLeosPortXcvrHighBiasAlarmThreshold'];
    discover_sensor($valid['sensor'], 'current', $device, $entry['oid'], $index, 'ciena-dom', $entry['descr'], '1', '1', $entry['low'], NULL, $entry['high'], NULL, $entry['current'],'snmp',NULL,NULL);
  }
}

# WWP-LEOS-PORT-XCVR-MIB::wwpLeosPortXcvrRxDbmPower.11 = INTEGER: -10679 dBm

echo(" (RX) ");
$oids = snmpwalk_cache_oid($device, "wwpLeosPortXcvrRxDbmPower", array(), "WWP-LEOS-PORT-XCVR-MIB", mib_dirs(array('wwp', 'ciena')) );
$oids = snmpwalk_cache_oid($device, "wwpLeosPortXcvrHighRxDbmPwAlarmThreshold", $oids, "WWP-LEOS-PORT-XCVR-MIB", mib_dirs(array('wwp', 'ciena')) );
$oids = snmpwalk_cache_oid($device, "wwpLeosPortXcvrLowRxPwAlarmThreshold", $oids, "WWP-LEOS-PORT-XCVR-MIB", mib_dirs(array('wwp', 'ciena')) );
$oids = snmpwalk_cache_oid($device, "wwpLeosPortXcvrHighRxPwAlarmThreshold", $oids, "WWP-LEOS-PORT-XCVR-MIB", mib_dirs(array('wwp', 'ciena')) );
$oids = snmpwalk_cache_oid($device, "wwpLeosPortXcvrHighRxDbmPwAlarmThreshold", $oids, "WWP-LEOS-PORT-XCVR-MIB", mib_dirs(array('wwp', 'ciena')) );

if (is_array($oids))
{
  foreach ($oids as $index => $entry)
  {
    $entry['descr']   = dbFetchCell("SELECT ifDescr FROM `ports` WHERE `device_id` = ? AND `ifName` = ?", array($device['device_id'], $index)) . " Rx power";
    $entry['oid']        = ".1.3.6.1.4.1.6141.2.60.4.1.1.1.1.105." . $index;
    $entry['current']        = $entry['wwpLeosPortXcvrRxDbmPower']/100;
    $entry['low']        = $entry['wwpLeosPortXcvrLowRxPwAlarmThreshold']/100;
    $entry['loww']        = $entry['wwpLeosPortXcvrLowRxDbmPwAlarmThreshold']/100;
    $entry['high']        = $entry['wwpLeosPortXcvrHighRxPwAlarmThreshold']/100;
    $entry['highw']        = $entry['wwpLeosPortXcvrHighRxDbmPwAlarmThreshold']/100;

    discover_sensor($valid['sensor'], 'dbm', $device, $entry['oid'], $index, 'ciena-dom-rx', $entry['descr'], '10000', '1', $entry['low'], $entry['loww'], $entry['high'], $entry['highw'], $entry['current'],'snmp',NULL,NULL);
  }
}

# WWP-LEOS-PORT-XCVR-MIB::wwpLeosPortXcvrTxDbmPower.11 = INTEGER: -10679 dBm

echo(" (TX) ");
$oids = snmpwalk_cache_oid($device, "wwpLeosPortXcvrTxDbmPower", array(), "WWP-LEOS-PORT-XCVR-MIB", mib_dirs(array('wwp', 'ciena')) );
$oids = snmpwalk_cache_oid($device, "wwpLeosPortXcvrHighTxDbmPwAlarmThreshold", $oids, "WWP-LEOS-PORT-XCVR-MIB", mib_dirs(array('wwp', 'ciena')) );
$oids = snmpwalk_cache_oid($device, "wwpLeosPortXcvrLowTxPwAlarmThreshold", $oids, "WWP-LEOS-PORT-XCVR-MIB", mib_dirs(array('wwp', 'ciena')) );
$oids = snmpwalk_cache_oid($device, "wwpLeosPortXcvrHighTxPwAlarmThreshold", $oids, "WWP-LEOS-PORT-XCVR-MIB", mib_dirs(array('wwp', 'ciena')) );
$oids = snmpwalk_cache_oid($device, "wwpLeosPortXcvrHighTxDbmPwAlarmThreshold", $oids, "WWP-LEOS-PORT-XCVR-MIB", mib_dirs(array('wwp', 'ciena')) );

if (is_array($oids))
{
  foreach ($oids as $index => $entry)
  {
    $entry['descr']   = dbFetchCell("SELECT ifDescr FROM `ports` WHERE `device_id` = ? AND `ifName` = ?", array($device['device_id'], $index)) . " Tx power";
    $entry['oid']     = ".1.3.6.1.4.1.6141.2.60.4.1.1.1.1.105." . $index;
    $entry['current'] = $entry['wwpLeosPortXcvrTxDbmPower']/100;
    $entry['low']     = $entry['wwpLeosPortXcvrLowTxPwAlarmThreshold']/100;
    $entry['loww']    = $entry['wwpLeosPortXcvrLowTxDbmPwAlarmThreshold']/100;
    $entry['high']    = $entry['wwpLeosPortXcvrHighTxPwAlarmThreshold']/100;
    $entry['highw']   = $entry['wwpLeosPortXcvrHighTxDbmPwAlarmThreshold']/100;

    discover_sensor($valid['sensor'], 'dbm', $device, $entry['oid'], $index, 'ciena-dom-tx', $entry['descr'], '10000', '1', $entry['low'], $entry['loww'], $entry['high'], $entry['highw'], $entry['current'],'snmp',NULL,NULL);
  }
}

# WWP-LEOS-PORT-XCVR-MIB::wwpLeosPortXcvrTemperature (Transceiver temp)
# WWP-LEOS-PORT-XCVR-MIB::wwpLeosPortXcvrHighTempAlarmThreshold
#WWP-LEOS-PORT-XCVR-MIB::wwpLeosPortXcvrLowTempAlarmThreshold

echo(" (Temp) ");
$oids = snmpwalk_cache_oid($device, "wwpLeosPortXcvrTemperature", array(), "WWP-LEOS-PORT-XCVR-MIB", mib_dirs(array('wwp', 'ciena')) );
$oids = snmpwalk_cache_oid($device, "wwpLeosPortXcvrHighTempAlarmThreshold", $oids, "WWP-LEOS-PORT-XCVR-MIB", mib_dirs(array('wwp', 'ciena')) );
$oids = snmpwalk_cache_oid($device, "wwpLeosPortXcvrLowTempAlarmThreshold", $oids, "WWP-LEOS-PORT-XCVR-MIB", mib_dirs(array('wwp', 'ciena')) );

if (is_array($oids))
{
  foreach ($oids as $index => $entry)
  {
    $entry['descr']   = dbFetchCell("SELECT ifDescr FROM `ports` WHERE `device_id` = ? AND `ifName` = ?", array($device['device_id'], $index)) . " DegC";
    $entry['oid']     = ".1.3.6.1.4.1.6141.2.60.4.1.1.1.1.16.".$index;
    $entry['current'] = $entry['wwpLeosPortXcvrTemperature'];
    $entry['low']     = $entry['wwpLeosPortXcvrLowTempAlarmThreshold'];
    $entry['high']    = $entry['wwpLeosPortXcvrHighTempAlarmThreshold'];

    discover_sensor($valid['sensor'], 'temperature', $device, $entry['oid'], $index, 'ciena-dom-temp', $entry['descr'], '1', '1', $entry['low'], NULL, $entry['high'], NULL, $entry['current'],'snmp',NULL,NULL);
  }
}

# WWP-LEOS-PORT-XCVR-MIB::wwpLeosPortXcvrHighVccAlarmThreshold
# WWP-LEOS-PORT-XCVR-MIB::wwpLeosPortXcvrLowVccAlarmThreshold
# WWP-LEOS-PORT-XCVR-MIB::wwpLeosPortXcvrVcc

echo(" (Vcc) ");
$oids = snmpwalk_cache_oid($device, "wwpLeosPortXcvrVcc", array(), "WWP-LEOS-PORT-XCVR-MIB", mib_dirs(array('wwp', 'ciena')) );
$oids = snmpwalk_cache_oid($device, "wwpLeosPortXcvrHighVccAlarmThreshold", $oids, "WWP-LEOS-PORT-XCVR-MIB", mib_dirs(array('wwp', 'ciena')) );
$oids = snmpwalk_cache_oid($device, "wwpLeosPortXcvrLowVccAlarmThreshold", $oids, "WWP-LEOS-PORT-XCVR-MIB", mib_dirs(array('wwp', 'ciena')) );

if (is_array($oids))
{
  foreach ($oids as $index => $entry)
  {
    $entry['descr']   = dbFetchCell("SELECT ifDescr FROM `ports` WHERE `device_id` = ? AND `ifName` = ?", array($device['device_id'], $index)) . " Volts";
    $entry['oid']     = ".1.3.6.1.4.1.6141.2.60.4.1.1.1.1.16.".$index;
    $entry['current'] = $entry['wwpLeosPortXcvrVcc'];
    $entry['low']     = $entry['wwpLeosPortXcvrLowVccAlarmThreshold'];
    $entry['high']    = $entry['wwpLeosPortXcvrHighVccAlarmThreshold'];

    discover_sensor($valid['sensor'], 'voltage', $device, $entry['oid'], $index, 'ciena-dom-volt', $entry['descr'], '1', '1', $entry['low'], NULL, $entry['high'], NULL, $entry['current'],'snmp',NULL,NULL);
  }
}

// EOF
