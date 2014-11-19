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

// IPOMANII-MIB

// FIXME: Currently no EMD "stack" support

echo(" IPOMANII-MIB ");

echo("outletConfigDesc ");
$cache['ipoman']['out'] = snmpwalk_cache_multi_oid($device, "outletConfigDesc", $cache['ipoman']['out'], "IPOMANII-MIB");
echo("outletConfigLocation ");
$cache['ipoman']['out'] = snmpwalk_cache_multi_oid($device, "outletConfigLocation", $cache['ipoman']['out'], "IPOMANII-MIB");
echo("inletConfigDesc ");
$cache['ipoman']['in'] = snmpwalk_cache_multi_oid($device, "inletConfigDesc", $cache['ipoman'], "IPOMANII-MIB");

$oids_in = array();
$oids_out = array();

echo("inletConfigCurrentHigh ");
$oids_in = snmpwalk_cache_multi_oid($device, "inletConfigCurrentHigh", $oids_in, "IPOMANII-MIB");
echo("inletStatusCurrent ");
$oids_in = snmpwalk_cache_multi_oid($device, "inletStatusCurrent", $oids_in, "IPOMANII-MIB");
echo("outletConfigCurrentHigh ");
$oids_out = snmpwalk_cache_multi_oid($device, "outletConfigCurrentHigh", $oids_out, "IPOMANII-MIB");
echo("outletStatusCurrent ");
$oids_out = snmpwalk_cache_multi_oid($device, "outletStatusCurrent", $oids_out, "IPOMANII-MIB");

if (is_array($oids_in))
{
  foreach ($oids_in as $index => $entry)
  {
    $cur_oid = '.1.3.6.1.4.1.2468.1.4.2.1.3.1.3.1.3.' . $index;
    $divisor = 1000;
    $descr = (trim($cache['ipoman']['in'][$index]['inletConfigDesc'],'"') != '' ? trim($cache['ipoman']['in'][$index]['inletConfigDesc'],'"') : "Inlet $index");
    $current = $entry['inletStatusCurrent'] / $divisor;
    $high_limit = $entry['inletConfigCurrentHigh'] / 10;

    discover_sensor($valid['sensor'], 'current', $device, $cur_oid, '1.3.1.3.'.$index, 'ipoman', $descr, $divisor, 1, NULL, NULL, NULL, $high_limit, $current);
    // FIXME: iPoMan 1201 also says it has 2 inlets, at least until firmware 1.06 - wtf?
  }
}

if (is_array($oids_out))
{
  foreach ($oids_out as $index => $entry)
  {
    $cur_oid = '.1.3.6.1.4.1.2468.1.4.2.1.3.2.3.1.3.' . $index;
    $divisor = 1000;
    $descr = (trim($cache['ipoman']['out'][$index]['outletConfigDesc'],'"') != '' ? trim($cache['ipoman']['out'][$index]['outletConfigDesc'],'"') : "Output $index");
    $current = $entry['outletStatusCurrent'] / $divisor;
    $high_limit = $entry['outletConfigCurrentHigh'] / 10;

    discover_sensor($valid['sensor'], 'current', $device, $cur_oid, '2.3.1.3.'.$index, 'ipoman', $descr, $divisor, 1, NULL, NULL, NULL, $high_limit, $current);
  }
}

$oids = array();

echo("inletConfigFrequencyHigh ");
$oids = snmpwalk_cache_multi_oid($device, "inletConfigFrequencyHigh", $oids, "IPOMANII-MIB");
echo("inletConfigFrequencyLow ");
$oids = snmpwalk_cache_multi_oid($device, "inletConfigFrequencyLow", $oids, "IPOMANII-MIB");
echo("inletStatusFrequency ");
$oids = snmpwalk_cache_multi_oid($device, "inletStatusFrequency", $oids, "IPOMANII-MIB");

if (is_array($oids))
{
  foreach ($oids as $index => $entry)
  {
    $freq_oid = '.1.3.6.1.4.1.2468.1.4.2.1.3.1.3.1.4.' . $index;
    $divisor = 10;
    $descr = (trim($cache['ipoman']['in'][$index]['inletConfigDesc'],'"') != '' ? trim($cache['ipoman']['in'][$index]['inletConfigDesc'],'"') : "Inlet $index");
    $current = $entry['inletStatusFrequency'] / 10;
    $low_limit = $entry['inletConfigFrequencyLow'];
    $high_limit = $entry['inletConfigFrequencyHigh'];
    discover_sensor($valid['sensor'], 'frequency', $device, $freq_oid, $index, 'ipoman', $descr, $divisor, 1, $low_limit, NULL, NULL, $high_limit, $current);
    // FIXME: iPoMan 1201 also says it has 2 inlets, at least until firmware 1.06 - wtf?
  }
}

// FIXME: What to do with IPOMANII-MIB::ipmEnvEmdConfigHumiOffset.0 ?

$emd_installed = snmp_get($device, "IPOMANII-MIB::ipmEnvEmdStatusEmdType.0"," -Oqv");

if ($emd_installed == 'eMD-HT')
{
  $descr      = snmp_get($device, "IPOMANII-MIB::ipmEnvEmdConfigHumiName.0", "-Oqv");
  $current    = snmp_get($device, "IPOMANII-MIB::ipmEnvEmdStatusHumidity.0", "-Oqv") / 10;
  $high_limit = snmp_get($device, "IPOMANII-MIB::ipmEnvEmdConfigHumiHighSetPoint.0", "-Oqv");
  $low_limit  = snmp_get($device, "IPOMANII-MIB::ipmEnvEmdConfigHumiLowSetPoint.0", "-Oqv");

  if ($descr != "" && is_numeric($current) && $current > "0")
  {
    $current_oid = ".1.3.6.1.4.1.2468.1.4.2.1.5.1.1.3.0";
    $descr = trim(str_replace("\"", "", $descr));

    discover_sensor($valid['sensor'], 'humidity', $device, $current_oid, "1", 'ipoman', $descr, '10', 1, $low_limit, NULL, NULL, $high_limit, $current);
  }
}

if ($emd_installed != 'disabled')
{
  $descr      = snmp_get($device, "IPOMANII-MIB::ipmEnvEmdConfigTempName.0", "-Oqv");
  $current    = snmp_get($device, "IPOMANII-MIB::ipmEnvEmdStatusTemperature.0", "-Oqv") / 10;
  $high_limit = snmp_get($device, "IPOMANII-MIB::ipmEnvEmdConfigTempHighSetPoint.0", "-Oqv");
  $low_limit  = snmp_get($device, "IPOMANII-MIB::ipmEnvEmdConfigTempLowSetPoint.0", "-Oqv");

  if ($descr != "" && is_numeric($current) && $current > "0")
  {
    $current_oid = ".1.3.6.1.4.1.2468.1.4.2.1.5.1.1.2.0";
    $descr = trim(str_replace("\"", "", $descr));

    discover_sensor($valid['sensor'], 'temperature', $device, $current_oid, "1", 'ipoman', $descr, '10', 1, $low_limit, NULL, NULL, $high_limit, $current);
  }
}

// Inlet Disabled due to the fact thats it's Kwh instead of just Watt

#  $oids_in = array();
$oids_out = array();

#  echo("inletStatusWH ");
#  $oids_in = snmpwalk_cache_multi_oid($device, "inletStatusWH", $oids_in, "IPOMANII-MIB");
echo("outletStatusWH ");
$oids_out = snmpwalk_cache_multi_oid($device, "outletStatusWH", $oids_out, "IPOMANII-MIB");

#  if (is_array($oids_in))
#  {
#    foreach ($oids_in as $index => $entry)
#    {
#      $cur_oid = '.1.3.6.1.4.1.2468.1.4.2.1.3.1.3.1.5.' . $index;
#      $divisor = 10;
#      $descr = (trim($cache['ipoman']['in'][$index]['inletConfigDesc'],'"') != '' ? trim($cache['ipoman']['in'][$index]['inletConfigDesc'],'"') : "Inlet $index");
#      $power = $entry['inletStatusWH'] / $divisor;
#
#      discover_sensor($valid['sensor'], 'power', $device, $cur_oid, '1.3.1.3.'.$index, 'ipoman', $descr, $divisor, 1, NULL, NULL, NULL, NULL, $power);
#      // FIXME: iPoMan 1201 also says it has 2 inlets, at least until firmware 1.06 - wtf?
#    }
#  }

if (is_array($oids_out))
{
  foreach ($oids_out as $index => $entry)
  {
    $cur_oid = '.1.3.6.1.4.1.2468.1.4.2.1.3.2.3.1.5.' . $index;
    $divisor = 10;
    $descr = (trim($cache['ipoman']['out'][$index]['outletConfigDesc'],'"') != '' ? trim($cache['ipoman']['out'][$index]['outletConfigDesc'],'"') : "Output $index");
    $power = $entry['outletStatusWH'] / $divisor;

    discover_sensor($valid['sensor'], 'power', $device, $cur_oid, '2.3.1.3.'.$index, 'ipoman', $descr, $divisor, 1, NULL, NULL, NULL, NULL, $power);
  }
}

$oids = array();

echo("inletConfigVoltageHigh ");
$oids = snmpwalk_cache_multi_oid($device, "inletConfigVoltageHigh", $oids, "IPOMANII-MIB");
echo("inletConfigVoltageLow ");
$oids = snmpwalk_cache_multi_oid($device, "inletConfigVoltageLow", $oids, "IPOMANII-MIB");
echo("inletStatusVoltage ");
$oids = snmpwalk_cache_multi_oid($device, "inletStatusVoltage", $oids, "IPOMANII-MIB");

if (is_array($oids))
{
  foreach ($oids as $index => $entry)
  {
    $volt_oid = '.1.3.6.1.4.1.2468.1.4.2.1.3.1.3.1.2.' . $index;
    $divisor = 10;
    $descr = (trim($cache['ipoman']['in'][$index]['inletConfigDesc'],'"') != '' ? trim($cache['ipoman']['in'][$index]['inletConfigDesc'],'"') : "Inlet $index");
    $current = $entry['inletStatusVoltage'] / 10;
    $low_limit = $entry['inletConfigVoltageLow'];
    $high_limit = $entry['inletConfigVoltageHigh'];

    discover_sensor($valid['sensor'], 'voltage', $device, $volt_oid, $index, 'ipoman', $descr, $divisor, 1, $low_limit, NULL, NULL, $high_limit, $current);
    // FIXME: iPoMan 1201 also says it has 2 inlets, at least until firmware 1.06 - wtf?
  }
}

// EOF
