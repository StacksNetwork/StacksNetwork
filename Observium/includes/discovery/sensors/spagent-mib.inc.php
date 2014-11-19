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

echo(" SPAGENT-MIB ");

echo("Caching OIDs: ");
$akcp_array = array();
echo("sensorProbeTempTable ");
$akcp_array = snmpwalk_cache_multi_oid($device, "sensorProbeTempTable", $akcp_array, "SPAGENT-MIB", mib_dirs('akcp'));
echo("sensorProbeHumidityTable ");
$akcp_array = snmpwalk_cache_multi_oid($device, "sensorProbeHumidityTable", $akcp_array, "SPAGENT-MIB", mib_dirs('akcp'));
echo("sensorProbeSwitchTable ");
$akcp_array = snmpwalk_cache_multi_oid($device, "sensorProbeSwitchTable", $akcp_array, "SPAGENT-MIB", mib_dirs('akcp'));

foreach ($akcp_array as $index => $entry)
{
  if ($entry['sensorProbeTempStatus']) # 0 = not connected
  {
    # Temp sensor

    # FIXME do we need to take note of this? [sensorProbeTempOffset] => 0

    $descr = $entry['sensorProbeTempDescription'];
    $oid   = ".1.3.6.1.4.1.3854.1.2.2.1.16.1.3.$index"; # SPAGENT-MIB:sensorProbeTempDegree.$index
    $value = $entry['sensorProbeTempDegree'];

    $low_limit      = $entry['sensorProbeTempLowCritical'];
    $low_warn_limit = $entry['sensorProbeTempLowWarning'];
    $warn_limit     = $entry['sensorProbeTempHighWarning'];
    $limit          = $entry['sensorProbeTempHighCritical'];

    $divisor = 1; $multiplier = 1;

    if ($entry['sensorProbeTempDegreeType'] == 'fahr')
    {
      $divisor = 9; $multiplier = 5;
      foreach (array('value', 'low_limit', 'low_warn_limit', 'warn_limit', 'limit') as $param)
      {
        $$param = f2c($$param); // Convert from fahrenheit to celsius
      }
      print_debug('TEMP sensor: Fahrenheit -> Celsius');
    }

    if ($entry['sensorProbeTempStatus'] != 'noStatus')
    {
      discover_sensor($valid['sensor'], 'temperature', $device, $oid, $index, 'akcp', $descr, $divisor, $multiplier, $low_limit, $low_warn_limit, $warn_limit, $limit, $value);
    }
  }

  if ($entry['sensorProbeHumidityStatus']) # 0 = not connected
  {
    # Humidity sensor

    # FIXME do we need to take note of this? [sensorProbeHumidityOffset] => 0

    $descr = $entry['sensorProbeHumidityDescription'];
    $oid   = ".1.3.6.1.4.1.3854.1.2.2.1.17.1.3.$index"; # SPAGENT-MIB:sensorProbeHumidityPercent.$index
    $value = $entry['sensorProbeHumidityPercent'];

    $low_limit      = $entry['sensorProbeHumidityLowCritical'];
    $low_warn_limit = $entry['sensorProbeHumidityLowWarning'];
    $warn_limit     = $entry['sensorProbeHumidityHighWarning'];
    $limit          = $entry['sensorProbeHumidityHighCritical'];

    if ($entry['sensorProbeHumidityStatus'] != 'noStatus')
    {
      discover_sensor($valid['sensor'], 'humidity', $device, $oid, $index, 'akcp', $descr, 1, 1, $low_limit, $low_warn_limit, $warn_limit, $limit, $value);
    }
  }

  if ($entry['sensorProbeSwitchStatus']) # 0 = not connected
  {
    # Switch sensor

    $descr = $entry['sensorProbeSwitchDescription'];
    $oid   = ".1.3.6.1.4.1.3854.1.2.2.1.18.1.3.$index"; # SPAGENT-MIB:sensorProbeSwitchStatus.$index
    $value = state_string_to_numeric('spagent-state',$entry['sensorProbeSwitchStatus']);

    if ($entry['sensorProbeSwitchStatus'] != 'noStatus')
    {
      discover_sensor($valid['sensor'], 'state', $device, $oid, $index, 'spagent-state', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
    }
  }
}

// EOF
