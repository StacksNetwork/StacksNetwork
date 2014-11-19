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

echo(" Sentry3-MIB ");

$divisor = 100;
$voltage_divisor = 10;
$multiplier = 1;

$sentry3_InfeedEntry = snmpwalk_cache_twopart_oid($device, 'InfeedEntry', array(), 'Sentry3-MIB');
$sentry3_OutletEntry = snmpwalk_cache_threepart_oid($device, 'OutletEntry', array(), 'Sentry3-MIB');

foreach ($sentry3_InfeedEntry as $tower => $feeds)
{
  foreach ($feeds as $feed => $entry)
  {
    $descr = str_replace('_', ', ', $entry['infeedName']);
    $index = "$tower.$feed";

    //infeedLoadValue
    $oid   = '.1.3.6.1.4.1.1718.3.2.2.1.7.' . $index;
    if (isset($entry['infeedLoadValue']) && $entry['infeedLoadValue'] >= 0)
    {
      $low_warn_limit  = NULL;
      $low_limit       = NULL;
      $high_warn_limit = $entry['infeedLoadHighThresh'];
      $high_limit      = $entry['infeedCapacity'];
      $value           = $entry['infeedLoadValue'] / $divisor;

      ## Rename code for older revisions
      $old_rrd  = $config['rrd_dir'].'/'.$device['hostname'].'/'.safename("sensor-current-sentry3-$tower.rrd");
      $new_rrd  = $config['rrd_dir'].'/'.$device['hostname'].'/'.safename("sensor-current-sentry3-infeedLoad.$index.rrd");
      if (is_file($old_rrd)) { rename($old_rrd, $new_rrd); print_message('Moved RRD'); }

      discover_sensor($valid['sensor'], 'current', $device, $oid, "infeedLoad.$index", 'sentry3', $descr, $divisor, $multiplier, $low_limit, $low_warn_limit, $high_warn_limit, $high_limit, $value);
    } else {
      /// FIXME. States for $entry['infeedLoadStatus']
    }

    //infeedVoltage
    $oid   = '.1.3.6.1.4.1.1718.3.2.2.1.11.' . $index;
    if (isset($entry['infeedVoltage']) && $entry['infeedVoltage'] >= 0)
    {
      $value = $entry['infeedVoltage'] / $voltage_divisor;

      ## Rename code for older revisions
      $old_rrd  = $config['rrd_dir'].'/'.$device['hostname'].'/'.safename("sensor-voltage-sentry3-$tower.rrd");
      $new_rrd  = $config['rrd_dir'].'/'.$device['hostname'].'/'.safename("sensor-voltage-sentry3-infeedVoltage.$index.rrd");
      if (is_file($old_rrd)) { rename($old_rrd, $new_rrd); print_message('Moved RRD'); }

      discover_sensor($valid['sensor'], 'voltage', $device, $oid, "infeedVoltage.$index", 'sentry3', $descr, $voltage_divisor, $multiplier, NULL, NULL, NULL, NULL, $value);
    }

    //infeedPower
    $oid   = '.1.3.6.1.4.1.1718.3.2.2.1.12.' . $index;
    if (isset($entry['infeedPower']) && $entry['infeedPower'] >= 0)
    {
      $value = $entry['infeedPower'];

      ## Rename code for older revisions
      $old_rrd  = $config['rrd_dir'].'/'.$device['hostname'].'/'.safename("sensor-power-sentry3-$tower.rrd");
      $new_rrd  = $config['rrd_dir'].'/'.$device['hostname'].'/'.safename("sensor-power-sentry3-infeedPower.$index.rrd");
      if (is_file($old_rrd)) { rename($old_rrd, $new_rrd); print_message('Moved RRD'); }

      discover_sensor($valid['sensor'], 'power', $device, $oid, "infeedPower.$index", 'sentry3', $descr, 1, $multiplier, NULL, NULL, NULL, NULL, $value);
    }

    //outletLoadValue
    foreach ($sentry3_OutletEntry[$tower][$feed] as $outlet => $ou_entry)
    {
      $descr = str_replace('_', ', ', $ou_entry['outletName']);
      $index = "$tower.$feed.$outlet";

      $oid   = '.1.3.6.1.4.1.1718.3.2.3.1.7.' . $index;
      if (isset($ou_entry['outletLoadValue']) && $ou_entry['outletLoadValue'] >= 0)
      {
        // Should be "outletCapacity" but is always -1. According to MIB: "A negative value indicates that the capacity was not available."
        $low_limit  = $ou_entry['outletLoadLowThresh'];
        $high_limit = $ou_entry['outletLoadHighThresh'];
        $value      = $ou_entry['outletLoadValue'] / $divisor;

        ## Rename code for older revisions
        $old_rrd  = $config['rrd_dir'].'/'.$device['hostname'].'/'.safename("sensor-current-sentry3-.$tower.$outlet.rrd");
        $new_rrd  = $config['rrd_dir'].'/'.$device['hostname'].'/'.safename("sensor-current-sentry3-outletLoad.$index.rrd");
        if (is_file($old_rrd)) { rename($old_rrd, $new_rrd); print_message('Moved RRD'); }

        discover_sensor($valid['sensor'], 'current', $device, $oid, "outletLoad.$index", 'sentry3', $descr, $divisor, $multiplier, NULL, NULL, NULL, $high_limit, $value);
      } else {
        /// FIXME. States for $ou_entry['outletLoadStatus'], $ou_entry['outletStatus']
      }
    }
  }
}

// temperature/humidity sensor
$sentry3_TempHumidSensorEntry = snmpwalk_cache_oid($device, 'TempHumidSensorEntry', array(), 'Sentry3-MIB');
if ($debug && count($sentry3_TempHumidSensorEntry)) { var_dump($sentry3_TempHumidSensorEntry); }

foreach ($sentry3_TempHumidSensorEntry as $index => $entry)
{
  $descr = $entry['tempHumidSensorName'];

  //tempHumidSensorTempValue
  $oid        = '.1.3.6.1.4.1.1718.3.2.5.1.6.1.'.$index;
  $divisor    = (isset($entry['tempHumidSensorTempScale']) ? $entry['tempHumidSensorTempScale'] : 1);
  if (isset($entry['tempHumidSensorTempValue']) && $entry['tempHumidSensorTempValue'] >= 0)
  {
    $low_limit  = (isset($entry['tempHumidSensorTempLowThresh'])  ? $entry['tempHumidSensorTempLowThresh'] * $divisor : NULL);
    $high_limit = (isset($entry['tempHumidSensorTempHighThresh']) ? $entry['tempHumidSensorTempHighThresh'] * $divisor : NULL);
    $value      = $entry['tempHumidSensorTempValue'] * $divisor;

    ## Rename code for older revisions
    $old_rrd  = $config['rrd_dir'].'/'.$device['hostname'].'/'.safename("sensor-temperature-sentry3-$index.rrd");
    $new_rrd  = $config['rrd_dir'].'/'.$device['hostname'].'/'.safename("sensor-temperature-sentry3-tempHumidSensor.$index.rrd");
    if (is_file($old_rrd)) { rename($old_rrd, $new_rrd); print_message('Moved RRD'); }

    discover_sensor($valid['sensor'], 'temperature', $device, $oid, "tempHumidSensor.$index", 'sentry3', $descr, $divisor, $multiplier, $low_limit, NULL, NULL, $high_limit, $value);
  }

  //tempHumidSensorHumidValue
  $oid        = '.1.3.6.1.4.1.1718.3.2.5.1.10.1.'.$index;
  $divisor    = 1;
  if (isset($entry['tempHumidSensorHumidValue']) && $entry['tempHumidSensorHumidValue'] >= 0)
  {
    $low_limit  = (isset($entry['tempHumidSensorHumidLowThresh'])  ? $entry['tempHumidSensorHumidLowThresh'] : NULL);
    $high_limit = (isset($entry['tempHumidSensorHumidHighThresh']) ? $entry['tempHumidSensorHumidHighThresh'] : NULL);
    $value      = $entry['tempHumidSensorHumidValue'];

    ## Rename code for older revisions
    $old_rrd  = $config['rrd_dir'].'/'.$device['hostname'].'/'.safename("sensor-humidity-sentry3-$index.rrd");
    $new_rrd  = $config['rrd_dir'].'/'.$device['hostname'].'/'.safename("sensor-humidity-sentry3-tempHumidSensor.$index.rrd");
    if (is_file($old_rrd)) { rename($old_rrd, $new_rrd); print_message('Moved RRD'); }

    discover_sensor($valid['sensor'], 'humidity', $device, $oid, "tempHumidSensor.$index", 'sentry3', $descr, $divisor, $multiplier, $low_limit, NULL, NULL, $high_limit, $value);
  }
}

// EOF
