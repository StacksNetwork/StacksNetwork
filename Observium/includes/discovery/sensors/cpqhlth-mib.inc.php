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

echo(" CPQHLTH-MIB ");

// Power Supplies

$oids = snmpwalk_cache_oid($device, "cpqHeFltTolPwrSupply", array(), "CPQHLTH-MIB", mib_dirs('hp'));

foreach ($oids as $index => $entry)
{
  if (isset($entry['cpqHeFltTolPowerSupplyBay']))
  {
    $descr      = "PSU ".$entry['cpqHeFltTolPowerSupplyBay'];
    $oid        = ".1.3.6.1.4.1.232.6.2.9.3.1.7.".$index;
    $value      = $entry['cpqHeFltTolPowerSupplyCapacityUsed'];
    $high_limit = $entry['cpqHeFltTolPowerSupplyCapacityMaximum'];

    discover_sensor($valid['sensor'], 'power', $device, $oid, 'cpqHeFltTolPwrSupply.'.$index, 'cpqhlth', $descr, 1, 1, NULL, NULL, NULL, $high_limit, $value);
  }

  if (isset($entry['cpqHeFltTolPowerSupplyCondition']))
  {
    $descr      = $descr." Status";
    $oid        = ".1.3.6.1.4.1.232.6.2.9.3.1.4.".$index;
    $condition  = state_string_to_numeric('cpqhlth-state',$entry['cpqHeFltTolPowerSupplyCondition']);

    discover_sensor($valid['sensor'], 'state', $device, $oid, 'cpqHeFltTolPwrSupply.'.$index, 'cpqhlth-state', $descr, 1, 1, NULL, NULL, NULL, NULL, $condition);
  }
}

// Overal System Thermal Status

$thermal_status    = snmp_get($device, "cpqHeThermalCondition.0", "-Ovq", "CPQHLTH-MIB", mib_dirs('hp'));
$system_fan_status = snmp_get($device, "cpqHeThermalSystemFanStatus.0", "-Ovq", "CPQHLTH-MIB", mib_dirs('hp'));
$cpu_fan_status    = snmp_get($device, "cpqHeThermalCpuFanStatus.0", "-Ovq", "CPQHLTH-MIB", mib_dirs('hp'));

if ($thermal_status)
{
  $descr = "Thermal Status";
  $oid   = ".1.3.6.1.4.1.232.6.2.6.1.0";
  $value = state_string_to_numeric('cpqhlth-state',$thermal_status);
  discover_sensor($valid['sensor'], 'state', $device, $oid, 'cpqHeThermalCondition.0', 'cpqhlth-state', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
}

if ($system_fan_status)
{
  $descr = "System Fan Status";
  $oid   = ".1.3.6.1.4.1.232.6.2.6.4.0";
  $value = state_string_to_numeric('cpqhlth-state',$system_fan_status);
  discover_sensor($valid['sensor'], 'state', $device, $oid, 'cpqHeThermalSystemFanStatus.0', 'cpqhlth-state', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
}

if ($cpu_fan_status)
{
  $descr = "CPU Fan Status";
  $oid   = ".1.3.6.1.4.1.232.6.2.6.5.0";
  $value = state_string_to_numeric('cpqhlth-state',$cpu_fan_status);
  discover_sensor($valid['sensor'], 'state', $device, $oid, 'cpqHeThermalCpuFanStatus.0', 'cpqhlth-state', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
}

// Temperatures

$oids = snmpwalk_cache_oid($device, "CpqHeTemperatureEntry", array(), "CPQHLTH-MIB", mib_dirs('hp'));

$descPatterns = array('/Cpu/', '/PowerSupply/');
$descReplace = array('CPU', 'PSU');
$descCount = array('CPU' => 1, 'PSU' => 1);

foreach ($oids as $index => $entry)
{
  if ($entry['cpqHeTemperatureThreshold'] > 0)
  {
    $descr   = ucfirst($entry['cpqHeTemperatureLocale']);

    if ($descr === 'System' || $descr === 'Memory') { continue; }
    if ($descr === 'Cpu' || $descr === 'PowerSupply')
    {
      $descr = preg_replace($descPatterns, $descReplace, $descr);
      $descr = $descr.' '.$descCount[$descr]++;
    }

    $oid        = ".1.3.6.1.4.1.232.6.2.6.8.1.4.".$index;
    $value      = $entry['cpqHeTemperatureCelsius'];
    $high_limit = $entry['cpqHeTemperatureThreshold'];

    discover_sensor($valid['sensor'], 'temperature', $device, $oid, 'CpqHeTemperatureEntry.'.$index, 'cpqhlth', $descr, 1, 1, NULL, NULL, NULL, $high_limit, $value);
  }
}

// Controllers

$oids = snmpwalk_cache_oid($device, 'cpqDaCntlrEntry', array(), 'CPQIDA-MIB', mib_dirs('hp'));

foreach ($oids as $index => $entry)
{
  if (isset($entry['cpqDaCntlrBoardStatus']))
  {
    $hardware   = rewrite_cpqida_hardware($entry['cpqDaCntlrModel']);
    $descr      = $hardware.' ('.$entry['cpqDaCntlrHwLocation'].') Status';
    $oid        = ".1.3.6.1.4.1.232.3.2.2.1.1.10.".$index;
    $status     = state_string_to_numeric('cpqida-cntrl-state',$entry['cpqDaCntlrBoardStatus']);

    discover_sensor($valid['sensor'], 'state', $device, $oid, 'cpqDaCntlrEntry'.$index, 'cpqida-cntrl-state', $descr, 1, 1, NULL, NULL, NULL, NULL, $status);

    if ($entry['cpqDaCntlrCurrentTemp'] > 0)
    {
      $oid       = ".1.3.6.1.4.1.232.3.2.2.1.1.32.".$index;
      $value     = $entry['cpqDaCntlrCurrentTemp'];
      $descr     = $hardware.' ('.$entry['cpqDaCntlrHwLocation'].')';
      discover_sensor($valid['sensor'], 'temperature', $device, $oid, 'cpqDaCntlrEntry'.$index, 'cpqida-cntrl-temp', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
    }
  }
}

// Physical Disks

$oids = snmpwalk_cache_oid($device, 'cpqDaPhyDrv', array(), 'CPQIDA-MIB', mib_dirs('hp'));

foreach ($oids as $index => $entry)
{
  if ($entry['cpqDaPhyDrvTemperatureThreshold'] > 0)
  {
    $descr      = "HDD ".$entry['cpqDaPhyDrvBay'];
    $oid        = ".1.3.6.1.4.1.232.3.2.5.1.1.70.".$index;
    $value      = $entry['cpqDaPhyDrvCurrentTemperature'];
    $high_limit = $entry['cpqDaPhyDrvTemperatureThreshold'];

    discover_sensor($valid['sensor'], 'temperature', $device, $oid, 'cpqDaPhyDrv.'.$index, 'cpqida', $descr, 1, 1, NULL, NULL, NULL, $high_limit, $value);
  }

  if (isset($entry['cpqDaPhyDrvSmartStatus']))
  {
    $descr      = $descr." SMART Status";
    $oid        = ".1.3.6.1.4.1.232.3.2.5.1.1.57.".$index;
    $status     = state_string_to_numeric('cpqida-smart-state',$entry['cpqDaPhyDrvSmartStatus']);

    discover_sensor($valid['sensor'], 'state', $device, $oid, 'cpqDaPhyDrv.'.$index, 'cpqida-smart-state', $descr, 1, 1, NULL, NULL, NULL, NULL, $status);
  }
}

// Logical Disks

$oids = snmpwalk_cache_oid($device, 'cpqDaLogDrv', array(), 'CPQIDA-MIB', mib_dirs('hp'));

foreach ($oids as $index => $entry)
{
  if (isset($entry['cpqDaLogDrvCondition']))
  {
    $descr      = "Logical Drive ".$entry['cpqDaLogDrvIndex'].' ('.$entry['cpqDaLogDrvOsName'].') Status';
    $oid        = ".1.3.6.1.4.1.232.3.2.3.1.1.11.".$index;
    $status     = state_string_to_numeric('cpqida-smart-state',$entry['cpqDaLogDrvCondition']);

    discover_sensor($valid['sensor'], 'state', $device, $oid, 'cpqDaLogDrv.'.$index, 'cpqida-smart-state', $descr, 1, 1, NULL, NULL, NULL, NULL, $status);
  }
}

// EOF
