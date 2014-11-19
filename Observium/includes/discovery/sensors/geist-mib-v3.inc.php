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

echo(" GEIST-MIB-V3 ");

// First read the Alarm table, it applies to anything that follows (sets the sensor limits).

// GEIST-MIB-V3::alarmCfgReadingID.1 = OID: GEIST-MIB-V3::digitalSensorDigital.1
// GEIST-MIB-V3::alarmCfgReadingID.2 = OID: GEIST-MIB-V3::airFlowSensorFlow.1
// GEIST-MIB-V3::alarmCfgReadingID.3 = OID: GEIST-MIB-V3::digitalSensorDigital.1
// GEIST-MIB-V3::alarmCfgReadingID.4 = OID: GEIST-MIB-V3::climateRelayTempC.1
// GEIST-MIB-V3::alarmCfgThreshold.1 = INTEGER: -9990 Tenths
// GEIST-MIB-V3::alarmCfgThreshold.2 = INTEGER: 220 Tenths
// GEIST-MIB-V3::alarmCfgThreshold.3 = INTEGER: -9990 Tenths
// GEIST-MIB-V3::alarmCfgThreshold.4 = INTEGER: 280 Tenths
// GEIST-MIB-V3::alarmCfgTripSelect.1 = INTEGER: tripBelow(0)
// GEIST-MIB-V3::alarmCfgTripSelect.2 = INTEGER: tripBelow(0)
// GEIST-MIB-V3::alarmCfgTripSelect.3 = INTEGER: tripBelow(0)
// GEIST-MIB-V3::alarmCfgTripSelect.4 = INTEGER: tripAbove(1)

// These devices support a large number of alarms for the same entities at different levels.
// This code supports 2 alarms per monitored item, by using the lower one (in case of "trip below") as low warning limit,
// and the higher one (in case of "trip above") as high warning limit.

$cache['geist']['alarmCfgTable'] = snmpwalk_cache_multi_oid($device, "alarmCfgTable", array(), "GEIST-MIB-V3", mib_dirs('geist'));

foreach ($cache['geist']['alarmCfgTable'] as $index => $entry)
{
  switch ($entry['alarmCfgTripSelect'])
  {
    case 'tripBelow':
      if (isset($geist_alarms[$entry['alarmCfgReadingID']]['low_limit']))
      {
        if ($entry['alarmCfgThreshold'] / 10 > $geist_alarms[$entry['alarmCfgReadingID']]['low_limit'])
        {
          $geist_alarms[$entry['alarmCfgReadingID']]['low_limit_warn'] = $geist_alarms[$entry['alarmCfgReadingID']]['low_limit'];
          $limit_type = 'low_limit';
        } else {
          $limit_type = 'low_limit_warn';
        }
      } else {
        $limit_type = 'low_limit';
      }
      break;
    case 'tripAbove':
      if (isset($geist_alarms[$entry['alarmCfgReadingID']]['high_limit']))
      {
        if ($entry['alarmCfgThreshold'] / 10 > $geist_alarms[$entry['alarmCfgReadingID']]['high_limit'])
        {
          $geist_alarms[$entry['alarmCfgReadingID']]['high_limit_warn'] = $geist_alarms[$entry['alarmCfgReadingID']]['high_limit'];
          $limit_type = 'high_limit';
        } else {
          $limit_type = 'high_limit_warn';
        }
      } else {
        $limit_type = 'high_limit';
      }
      break;
  }

  // Loads up array like $geist_alarms['digitalSensorDigital.1']['tripBelow'] = -999
  $geist_alarms[$entry['alarmCfgReadingID']][$limit_type] = $entry['alarmCfgThreshold'] / 10;
}

// GEIST-MIB-V3::ctrl3ChIECSerial.1 = STRING: 0000777654567777
// GEIST-MIB-V3::ctrl3ChIECName.1 = STRING: my-geist-pdu01
// GEIST-MIB-V3::ctrl3ChIECVoltsA.1 = Gauge32: 230 Volts (rms)
// GEIST-MIB-V3::ctrl3ChIECDeciAmpsA.1 = Gauge32: 0 0.1 Amps (rms)
// GEIST-MIB-V3::ctrl3ChIECRealPowerA.1 = Gauge32: 0 Watts
// GEIST-MIB-V3::ctrl3ChIECApparentPowerA.1 = Gauge32: 0 Volt-Amps
// GEIST-MIB-V3::ctrl3ChIECPowerFactorA.1 = INTEGER: 100 %
// GEIST-MIB-V3::ctrl3ChIECVoltsB.1 = Gauge32: 231 Volts (rms)
// GEIST-MIB-V3::ctrl3ChIECDeciAmpsB.1 = Gauge32: 0 0.1 Amps (rms)
// GEIST-MIB-V3::ctrl3ChIECRealPowerB.1 = Gauge32: 0 Watts
// GEIST-MIB-V3::ctrl3ChIECApparentPowerB.1 = Gauge32: 0 Volt-Amps
// GEIST-MIB-V3::ctrl3ChIECPowerFactorB.1 = INTEGER: 100 %
// GEIST-MIB-V3::ctrl3ChIECVoltsC.1 = Gauge32: 231 Volts (rms)
// GEIST-MIB-V3::ctrl3ChIECDeciAmpsC.1 = Gauge32: 0 0.1 Amps (rms)
// GEIST-MIB-V3::ctrl3ChIECRealPowerC.1 = Gauge32: 0 Watts
// GEIST-MIB-V3::ctrl3ChIECApparentPowerC.1 = Gauge32: 0 Volt-Amps
// GEIST-MIB-V3::ctrl3ChIECPowerFactorC.1 = INTEGER: 30 %
// GEIST-MIB-V3::ctrl3ChIECRealPowerTotal.1 = Gauge32: 0 Watts

// We don't do power factor yet.

// A note to the designer of this MIB: .1, .2, .3 instead of A/B/C would have been a much nicer parse.

$cache['geist']['ctrl3ChIECTable'] = snmpwalk_cache_multi_oid($device, "ctrl3ChIECTable", array(), "GEIST-MIB-V3", mib_dirs('geist'));

foreach ($cache['geist']['ctrl3ChIECTable'] as $index => $entry)
{
  if ($entry['ctrl3ChIECAvail'])
  {
    // Phase 1
    $descr = $entry['ctrl3ChIECName'] . " Phase 1";

    $oid   = ".1.3.6.1.4.1.21239.2.25.1.6.$index";
    $value = $entry['ctrl3ChIECVoltsA'];

    $low_limit = (isset($geist_alarms["ctrl3ChIECVoltsA.$index"]['low_limit']) ? $geist_alarms["ctrl3ChIECVoltsA.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["ctrl3ChIECVoltsA.$index"]['low_limit_warn']) ? $geist_alarms["ctrl3ChIECVoltsA.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["ctrl3ChIECVoltsA.$index"]['high_limit_warn']) ? $geist_alarms["ctrl3ChIECVoltsA.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["ctrl3ChIECVoltsA.$index"]['high_limit']) ? $geist_alarms["ctrl3ChIECVoltsA.$index"]['high_limit'] : NULL);

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'voltage', $device, $oid, 'ctrl3ChIECVoltsA.'.$index, 'geist-mib-v3', $descr, 1, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value);
    }

    $oid   = ".1.3.6.1.4.1.21239.2.25.1.10.$index";
    $value = $entry['ctrl3ChIECRealPowerA'];

    $low_limit = (isset($geist_alarms["ctrl3ChIECRealPowerA.$index"]['low_limit']) ? $geist_alarms["ctrl3ChIECRealPowerA.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["ctrl3ChIECRealPowerA.$index"]['low_limit_warn']) ? $geist_alarms["ctrl3ChIECRealPowerA.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["ctrl3ChIECRealPowerA.$index"]['high_limit_warn']) ? $geist_alarms["ctrl3ChIECRealPowerA.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["ctrl3ChIECRealPowerA.$index"]['high_limit']) ? $geist_alarms["ctrl3ChIECRealPowerA.$index"]['high_limit'] : NULL);

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'power', $device, $oid, 'ctrl3ChIECRealPowerA.'.$index, 'geist-mib-v3', $descr, 1, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value);
    }

    $oid   = ".1.3.6.1.4.1.21239.2.25.1.11.$index";
    $value = $entry['ctrl3ChIECApparentPowerA'];

    $low_limit = (isset($geist_alarms["ctrl3ChIECApparentPowerA.$index"]['low_limit']) ? $geist_alarms["ctrl3ChIECApparentPowerA.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["ctrl3ChIECApparentPowerA.$index"]['low_limit_warn']) ? $geist_alarms["ctrl3ChIECApparentPowerA.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["ctrl3ChIECApparentPowerA.$index"]['high_limit_warn']) ? $geist_alarms["ctrl3ChIECApparentPowerA.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["ctrl3ChIECApparentPowerA.$index"]['high_limit']) ? $geist_alarms["ctrl3ChIECApparentPowerA.$index"]['high_limit'] : NULL);

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'apower', $device, $oid, 'ctrl3ChIECApparentPowerA.'.$index, 'geist-mib-v3', $descr, 1, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value);
    }

    $oid   = ".1.3.6.1.4.1.21239.2.25.1.8.$index";
    $value = $entry['ctrl3ChIECDeciAmpsA'];

    $low_limit = (isset($geist_alarms["ctrl3ChIECDeciAmpsA.$index"]['low_limit']) ? $geist_alarms["ctrl3ChIECDeciAmpsA.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["ctrl3ChIECDeciAmpsA.$index"]['low_limit_warn']) ? $geist_alarms["ctrl3ChIECDeciAmpsA.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["ctrl3ChIECDeciAmpsA.$index"]['high_limit_warn']) ? $geist_alarms["ctrl3ChIECDeciAmpsA.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["ctrl3ChIECDeciAmpsA.$index"]['high_limit']) ? $geist_alarms["ctrl3ChIECDeciAmpsA.$index"]['high_limit'] : NULL);

    if ($value !== '')
    {
      discover_sensor($valid['sensor'], 'current', $device, $oid, 'ctrl3ChIECDeciAmpsA.'.$index, 'geist-mib-v3', $descr, 10, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value / 10);
    }

    // Phase 2
    $descr = $entry['ctrl3ChIECName'] . " Phase 2";

    $oid   = ".1.3.6.1.4.1.21239.2.25.1.14.$index";
    $value = $entry['ctrl3ChIECVoltsB'];

    $low_limit = (isset($geist_alarms["ctrl3ChIECVoltsB.$index"]['low_limit']) ? $geist_alarms["ctrl3ChIECVoltsB.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["ctrl3ChIECVoltsB.$index"]['low_limit_warn']) ? $geist_alarms["ctrl3ChIECVoltsB.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["ctrl3ChIECVoltsB.$index"]['high_limit_warn']) ? $geist_alarms["ctrl3ChIECVoltsB.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["ctrl3ChIECVoltsB.$index"]['high_limit']) ? $geist_alarms["ctrl3ChIECVoltsB.$index"]['high_limit'] : NULL);

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'voltage', $device, $oid, 'ctrl3ChIECVoltsB.'.$index, 'geist-mib-v3', $descr, 1, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value);
    }

    $oid   = ".1.3.6.1.4.1.21239.2.25.1.18.$index";
    $value = $entry['ctrl3ChIECRealPowerB'];

    $low_limit = (isset($geist_alarms["ctrl3ChIECRealPowerB.$index"]['low_limit']) ? $geist_alarms["ctrl3ChIECRealPowerB.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["ctrl3ChIECRealPowerB.$index"]['low_limit_warn']) ? $geist_alarms["ctrl3ChIECRealPowerB.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["ctrl3ChIECRealPowerB.$index"]['high_limit_warn']) ? $geist_alarms["ctrl3ChIECRealPowerB.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["ctrl3ChIECRealPowerB.$index"]['high_limit']) ? $geist_alarms["ctrl3ChIECRealPowerB.$index"]['high_limit'] : NULL);

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'power', $device, $oid, 'ctrl3ChIECRealPowerB.'.$index, 'geist-mib-v3', $descr, 1, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value);
    }

    $oid   = ".1.3.6.1.4.1.21239.2.25.1.19.$index";
    $value = $entry['ctrl3ChIECApparentPowerB'];

    $low_limit = (isset($geist_alarms["ctrl3ChIECApparentPowerB.$index"]['low_limit']) ? $geist_alarms["ctrl3ChIECApparentPowerB.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["ctrl3ChIECApparentPowerB.$index"]['low_limit_warn']) ? $geist_alarms["ctrl3ChIECApparentPowerB.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["ctrl3ChIECApparentPowerB.$index"]['high_limit_warn']) ? $geist_alarms["ctrl3ChIECApparentPowerB.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["ctrl3ChIECApparentPowerB.$index"]['high_limit']) ? $geist_alarms["ctrl3ChIECApparentPowerB.$index"]['high_limit'] : NULL);

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'apower', $device, $oid, 'ctrl3ChIECApparentPowerB.'.$index, 'geist-mib-v3', $descr, 1, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value);
    }

    $oid   = ".1.3.6.1.4.1.21239.2.25.1.16.$index";
    $value = $entry['ctrl3ChIECDeciAmpsB'];

    $low_limit = (isset($geist_alarms["ctrl3ChIECDeciAmpsB.$index"]['low_limit']) ? $geist_alarms["ctrl3ChIECDeciAmpsB.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["ctrl3ChIECDeciAmpsB.$index"]['low_limit_warn']) ? $geist_alarms["ctrl3ChIECDeciAmpsB.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["ctrl3ChIECDeciAmpsB.$index"]['high_limit_warn']) ? $geist_alarms["ctrl3ChIECDeciAmpsB.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["ctrl3ChIECDeciAmpsB.$index"]['high_limit']) ? $geist_alarms["ctrl3ChIECDeciAmpsB.$index"]['high_limit'] : NULL);

    if ($value !== '')
    {
      discover_sensor($valid['sensor'], 'current', $device, $oid, 'ctrl3ChIECDeciAmpsB.'.$index, 'geist-mib-v3', $descr, 10, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value / 10);
    }

    // Phase 3
    $descr = $entry['ctrl3ChIECName'] . " Phase 3";

    $oid   = ".1.3.6.1.4.1.21239.2.25.1.22.$index";
    $value = $entry['ctrl3ChIECVoltsC'];

    $low_limit = (isset($geist_alarms["ctrl3ChIECVoltsC.$index"]['low_limit']) ? $geist_alarms["ctrl3ChIECVoltsC.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["ctrl3ChIECVoltsC.$index"]['low_limit_warn']) ? $geist_alarms["ctrl3ChIECVoltsC.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["ctrl3ChIECVoltsC.$index"]['high_limit_warn']) ? $geist_alarms["ctrl3ChIECVoltsC.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["ctrl3ChIECVoltsC.$index"]['high_limit']) ? $geist_alarms["ctrl3ChIECVoltsC.$index"]['high_limit'] : NULL);

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'voltage', $device, $oid, 'ctrl3ChIECVoltsC.'.$index, 'geist-mib-v3', $descr, 1, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value);
    }

    $oid   = ".1.3.6.1.4.1.21239.2.25.1.26.$index";
    $value = $entry['ctrl3ChIECRealPowerC'];

    $low_limit = (isset($geist_alarms["ctrl3ChIECRealPowerC.$index"]['low_limit']) ? $geist_alarms["ctrl3ChIECRealPowerC.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["ctrl3ChIECRealPowerC.$index"]['low_limit_warn']) ? $geist_alarms["ctrl3ChIECRealPowerC.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["ctrl3ChIECRealPowerC.$index"]['high_limit_warn']) ? $geist_alarms["ctrl3ChIECRealPowerC.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["ctrl3ChIECRealPowerC.$index"]['high_limit']) ? $geist_alarms["ctrl3ChIECRealPowerC.$index"]['high_limit'] : NULL);

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'power', $device, $oid, 'ctrl3ChIECRealPowerC.'.$index, 'geist-mib-v3', $descr, 1, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value);
    }

    $oid   = ".1.3.6.1.4.1.21239.2.25.1.27.$index";
    $value = $entry['ctrl3ChIECApparentPowerC'];

    $low_limit = (isset($geist_alarms["ctrl3ChIECApparentPowerC.$index"]['low_limit']) ? $geist_alarms["ctrl3ChIECApparentPowerC.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["ctrl3ChIECApparentPowerC.$index"]['low_limit_warn']) ? $geist_alarms["ctrl3ChIECApparentPowerC.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["ctrl3ChIECApparentPowerC.$index"]['high_limit_warn']) ? $geist_alarms["ctrl3ChIECApparentPowerC.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["ctrl3ChIECApparentPowerC.$index"]['high_limit']) ? $geist_alarms["ctrl3ChIECApparentPowerC.$index"]['high_limit'] : NULL);

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'apower', $device, $oid, 'ctrl3ChIECApparentPowerC.'.$index, 'geist-mib-v3', $descr, 1, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value);
    }

    $oid   = ".1.3.6.1.4.1.21239.2.25.1.24.$index";
    $value = $entry['ctrl3ChIECDeciAmpsC'];

    $low_limit = (isset($geist_alarms["ctrl3ChIECDeciAmpsC.$index"]['low_limit']) ? $geist_alarms["ctrl3ChIECDeciAmpsC.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["ctrl3ChIECDeciAmpsC.$index"]['low_limit_warn']) ? $geist_alarms["ctrl3ChIECDeciAmpsC.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["ctrl3ChIECDeciAmpsC.$index"]['high_limit_warn']) ? $geist_alarms["ctrl3ChIECDeciAmpsC.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["ctrl3ChIECDeciAmpsC.$index"]['high_limit']) ? $geist_alarms["ctrl3ChIECDeciAmpsC.$index"]['high_limit'] : NULL);

    if ($value !== '')
    {
      discover_sensor($valid['sensor'], 'current', $device, $oid, 'ctrl3ChIECDeciAmpsC.'.$index, 'geist-mib-v3', $descr, 10, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value / 10);
    }

    // Total
    $descr = $entry['ctrl3ChIECName'] . " Total";
    $oid   = ".1.3.6.1.4.1.21239.2.25.1.30.$index";
    $value = $entry['ctrl3ChIECRealPowerTotal'];

    $low_limit = (isset($geist_alarms["ctrl3ChIECRealPowerTotal.$index"]['low_limit']) ? $geist_alarms["ctrl3ChIECRealPowerTotal.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["ctrl3ChIECRealPowerTotal.$index"]['low_limit_warn']) ? $geist_alarms["ctrl3ChIECRealPowerTotal.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["ctrl3ChIECRealPowerTotal.$index"]['high_limit_warn']) ? $geist_alarms["ctrl3ChIECRealPowerTotal.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["ctrl3ChIECRealPowerTotal.$index"]['high_limit']) ? $geist_alarms["ctrl3ChIECRealPowerTotal.$index"]['high_limit'] : NULL);

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'power', $device, $oid, 'ctrl3ChIECRealPowerTotal.'.$index, 'geist-mib-v3', $descr, 1, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value);
    }

  }
}

// GEIST-MIB-V3::airFlowSensorSerial.1 = STRING: 2000000012345678
// GEIST-MIB-V3::airFlowSensorName.1 = STRING: AF/HTD Sensor
// GEIST-MIB-V3::airFlowSensorAvail.1 = Gauge32: 1
// GEIST-MIB-V3::airFlowSensorTempC.1 = INTEGER: 22 Degrees Celsius
// GEIST-MIB-V3::airFlowSensorFlow.1 = INTEGER: 18
// GEIST-MIB-V3::airFlowSensorHumidity.1 = INTEGER: 37 %
// GEIST-MIB-V3::airFlowSensorDewPointC.1 = INTEGER: 6 Degrees Celsius

$cache['geist']['airFlowSensorTable'] = snmpwalk_cache_multi_oid($device, "airFlowSensorTable", array(), "GEIST-MIB-V3", mib_dirs('geist'));

foreach ($cache['geist']['airFlowSensorTable'] as $index => $entry)
{
  if ($entry['airFlowSensorAvail'])
  {
    $descr = $entry['airFlowSensorName'] . " Temperature";

    $oid   = ".1.3.6.1.4.1.21239.2.5.1.5.$index";
    $value = $entry['airFlowSensorTempC'];

    $low_limit = (isset($geist_alarms["airFlowSensorTempC.$index"]['low_limit']) ? $geist_alarms["airFlowSensorTempC.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["airFlowSensorTempC.$index"]['low_limit_warn']) ? $geist_alarms["airFlowSensorTempC.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["airFlowSensorTempC.$index"]['high_limit_warn']) ? $geist_alarms["airFlowSensorTempC.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["airFlowSensorTempC.$index"]['high_limit']) ? $geist_alarms["airFlowSensorTempC.$index"]['high_limit'] : NULL);

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'temperature', $device, $oid, 'airFlowSensorTempC.'.$index, 'geist-mib-v3', $descr, 1, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value);
    }

    $descr = $entry['airFlowSensorName'] . " Dew Point";
    $oid   = ".1.3.6.1.4.1.21239.2.5.1.9.$index";
    $value = $entry['airFlowSensorDewPointC'];

    $low_limit = (isset($geist_alarms["airFlowSensorDewPointC.$index"]['low_limit']) ? $geist_alarms["airFlowSensorDewPointC.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["airFlowSensorDewPointC.$index"]['low_limit_warn']) ? $geist_alarms["airFlowSensorDewPointC.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["airFlowSensorDewPointC.$index"]['high_limit_warn']) ? $geist_alarms["airFlowSensorDewPointC.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["airFlowSensorDewPointC.$index"]['high_limit']) ? $geist_alarms["airFlowSensorDewPointC.$index"]['high_limit'] : NULL);

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'temperature', $device, $oid, 'airFlowSensorDewPointC.'.$index, 'geist-mib-v3', $descr, 1, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value);
    }

    $descr = $entry['airFlowSensorName'] . " Air Flow";
    $oid   = ".1.3.6.1.4.1.21239.2.5.1.7.$index";
    $value = $entry['airFlowSensorFlow'];

    $low_limit = (isset($geist_alarms["airFlowSensorFlow.$index"]['low_limit']) ? $geist_alarms["airFlowSensorFlow.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["airFlowSensorFlow.$index"]['low_limit_warn']) ? $geist_alarms["airFlowSensorFlow.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["airFlowSensorFlow.$index"]['high_limit_warn']) ? $geist_alarms["airFlowSensorFlow.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["airFlowSensorFlow.$index"]['high_limit']) ? $geist_alarms["airFlowSensorFlow.$index"]['high_limit'] : NULL);

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'airflow', $device, $oid, 'airFlowSensorFlow.'.$index, 'geist-mib-v3', $descr, 1, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value);
    }

    $descr = $entry['airFlowSensorName'] . " Humidity";
    $oid   = ".1.3.6.1.4.1.21239.2.5.1.8.$index";
    $value = $entry['airFlowSensorHumidity'];

    $low_limit = (isset($geist_alarms["airFlowSensorHumidity.$index"]['low_limit']) ? $geist_alarms["airFlowSensorHumidity.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["airFlowSensorHumidity.$index"]['low_limit_warn']) ? $geist_alarms["airFlowSensorHumidity.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["airFlowSensorHumidity.$index"]['high_limit_warn']) ? $geist_alarms["airFlowSensorHumidity.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["airFlowSensorHumidity.$index"]['high_limit']) ? $geist_alarms["airFlowSensorHumidity.$index"]['high_limit'] : NULL);

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'humidity', $device, $oid, 'airFlowSensorHumidity.'.$index, 'geist-mib-v3', $descr, 1, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value);
    }
  }
}

// GEIST-MIB-V3::doorSensorSerial.1 = STRING: 0E00000123456789
// GEIST-MIB-V3::doorSensorName.1 = STRING: Door Sensor
// GEIST-MIB-V3::doorSensorAvail.1 = Gauge32: 1
// GEIST-MIB-V3::doorSensorStatus.1 = INTEGER: 99

$cache['geist']['doorSensorTable'] = snmpwalk_cache_multi_oid($device, "doorSensorTable", array(), "GEIST-MIB-V3", mib_dirs('geist'));

foreach ($cache['geist']['doorSensorTable'] as $index => $entry)
{
  if ($entry['doorSensorAvail'])
  {
    $descr = $entry['doorSensorName'];

    $oid   = ".1.3.6.1.4.1.21239.2.7.1.5.$index";
    $value = $entry['doorSensorStatus'];

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'state', $device, $oid, 'doorSensorStatus.'.$index, 'geist-mib-v3-door-state', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
    }
  }
}

// GEIST-MIB-V3::digitalSensorSerial.1 = STRING: 8C000004937CFABC
// GEIST-MIB-V3::digitalSensorName.1 = STRING: CCAT
// GEIST-MIB-V3::digitalSensorAvail.1 = Gauge32: 1
// GEIST-MIB-V3::digitalSensorDigital.1 = INTEGER: 99

$cache['geist']['digitalSensorTable'] = snmpwalk_cache_multi_oid($device, "digitalSensorTable", array(), "GEIST-MIB-V3", mib_dirs('geist'));

foreach ($cache['geist']['digitalSensorTable'] as $index => $entry)
{
  if ($entry['digitalSensorAvail'])
  {
    $descr = $entry['digitalSensorName'];

    $oid   = ".1.3.6.1.4.1.21239.2.18.1.5.$index";
    $value = $entry['digitalSensorDigital'];

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'state', $device, $oid, 'digitalSensorDigital.'.$index, 'geist-mib-v3-digital-state', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
    }
  }
}

// GEIST-MIB-V3::smokeAlarmSerial.1 = STRING: D900000498765432
// GEIST-MIB-V3::smokeAlarmName.1 = STRING: Smoke Alarm
// GEIST-MIB-V3::smokeAlarmAvail.1 = Gauge32: 1
// GEIST-MIB-V3::smokeAlarmStatus.1 = INTEGER: 99

$cache['geist']['smokeAlarmTable'] = snmpwalk_cache_multi_oid($device, "smokeAlarmTable", array(), "GEIST-MIB-V3", mib_dirs('geist'));

foreach ($cache['geist']['smokeAlarmTable'] as $index => $entry)
{
  if ($entry['smokeAlarmAvail'])
  {
    $descr = $entry['smokeAlarmName'];

    $oid   = ".1.3.6.1.4.1.21239.2.21.1.5.$index";
    $value = $entry['smokeAlarmStatus'];

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'state', $device, $oid, 'smokeAlarmStatus.'.$index, 'geist-mib-v3-smokealarm-state', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
    }
  }
}

// GEIST-MIB-V3::climateSerial.1 = STRING: 28FFFF120140000D
// GEIST-MIB-V3::climateName.1 = STRING: RSMINI163
// GEIST-MIB-V3::climateAvail.1 = Gauge32: 1
// GEIST-MIB-V3::climateTempC.1 = INTEGER: 26 Degrees Celsius
// GEIST-MIB-V3::climateHumidity.1 = INTEGER: 0 %
// GEIST-MIB-V3::climateLight.1 = INTEGER: 0 // Sensor not visible on (test?) device GUI, currently not discovered.
// GEIST-MIB-V3::climateAirflow.1 = INTEGER: 0
// GEIST-MIB-V3::climateSound.1 = INTEGER: 0 // Sensor not visible on (test?) device GUI, currently not discovered.
// GEIST-MIB-V3::climateIO1.1 = INTEGER: 0
// GEIST-MIB-V3::climateIO2.1 = INTEGER: 99
// GEIST-MIB-V3::climateIO3.1 = INTEGER: 99
// GEIST-MIB-V3::climateVolts.1 = Gauge32: 0 Volts (rms)
// GEIST-MIB-V3::climateDeciAmpsA.1 = Gauge32: 0 0.1 Amps (rms)
// GEIST-MIB-V3::climateRealPowerA.1 = Gauge32: 0 Watts
// GEIST-MIB-V3::climateApparentPowerA.1 = Gauge32: 0 Volt-Amps
// GEIST-MIB-V3::climatePowerFactorA.1 = Gauge32: 0 %
// GEIST-MIB-V3::climateDeciAmpsB.1 = Gauge32: 0 0.1 Amps (rms)
// GEIST-MIB-V3::climateRealPowerB.1 = Gauge32: 0 Watts
// GEIST-MIB-V3::climateApparentPowerB.1 = Gauge32: 0 Volt-Amps
// GEIST-MIB-V3::climatePowerFactorB.1 = Gauge32: 0 %
// GEIST-MIB-V3::climateDeciAmpsC.1 = Gauge32: 0 0.1 Amps (rms)
// GEIST-MIB-V3::climateRealPowerC.1 = Gauge32: 0 Watts
// GEIST-MIB-V3::climateApparentPowerC.1 = Gauge32: 0 Volt-Amps
// GEIST-MIB-V3::climatePowerFactorC.1 = Gauge32: 0 %
// GEIST-MIB-V3::climateDewPointC.1 = INTEGER: 0 Degrees Celsius

// We don't do power factor yet.

$cache['geist']['climateTable'] = snmpwalk_cache_multi_oid($device, "climateTable", array(), "GEIST-MIB-V3", mib_dirs('geist'));

foreach ($cache['geist']['climateTable'] as $index => $entry)
{
  if ($entry['climateAvail'])
  {
    $descr = $entry['climateName'] . " Temperature";

    $oid   = ".1.3.6.1.4.1.21239.2.2.1.5.$index";
    $value = $entry['climateTempC'];

    $low_limit = (isset($geist_alarms["climateTempC.$index"]['low_limit']) ? $geist_alarms["climateTempC.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["climateTempC.$index"]['low_limit_warn']) ? $geist_alarms["climateTempC.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["climateTempC.$index"]['high_limit_warn']) ? $geist_alarms["climateTempC.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["climateTempC.$index"]['high_limit']) ? $geist_alarms["climateTempC.$index"]['high_limit'] : NULL);

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'temperature', $device, $oid, 'climateTempC.'.$index, 'geist-mib-v3', $descr, 1, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value);
    }

    $descr = $entry['climateName'] . " Dew Point";
    $oid   = ".1.3.6.1.4.1.21239.2.2.1.31.$index";
    $value = $entry['climateDewPointC'];

    $low_limit = (isset($geist_alarms["climateDewPointC.$index"]['low_limit']) ? $geist_alarms["climateDewPointC.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["climateDewPointC.$index"]['low_limit_warn']) ? $geist_alarms["climateDewPointC.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["climateDewPointC.$index"]['high_limit_warn']) ? $geist_alarms["climateDewPointC.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["climateDewPointC.$index"]['high_limit']) ? $geist_alarms["climateDewPointC.$index"]['high_limit'] : NULL);

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'temperature', $device, $oid, 'climateDewPointC.'.$index, 'geist-mib-v3', $descr, 1, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value);
    }

    $descr = $entry['climateName'] . " Air Flow";
    $oid   = ".1.3.6.1.4.1.21239.2.2.1.9.$index";
    $value = $entry['climateAirflow'];

    $low_limit = (isset($geist_alarms["climateAirflow.$index"]['low_limit']) ? $geist_alarms["climateAirflow.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["climateAirflow.$index"]['low_limit_warn']) ? $geist_alarms["climateAirflow.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["climateAirflow.$index"]['high_limit_warn']) ? $geist_alarms["climateAirflow.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["climateAirflow.$index"]['high_limit']) ? $geist_alarms["climateAirflow.$index"]['high_limit'] : NULL);

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'airflow', $device, $oid, 'climateAirflow.'.$index, 'geist-mib-v3', $descr, 1, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value);
    }

    $descr = $entry['climateName'] . " Humidity";
    $oid   = ".1.3.6.1.4.1.21239.2.2.1.7.$index";
    $value = $entry['climateHumidity'];

    $low_limit = (isset($geist_alarms["climateHumidity.$index"]['low_limit']) ? $geist_alarms["climateHumidity.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["climateHumidity.$index"]['low_limit_warn']) ? $geist_alarms["climateHumidity.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["climateHumidity.$index"]['high_limit_warn']) ? $geist_alarms["climateHumidity.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["climateHumidity.$index"]['high_limit']) ? $geist_alarms["climateHumidity.$index"]['high_limit'] : NULL);

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'humidity', $device, $oid, 'climateHumidity.'.$index, 'geist-mib-v3', $descr, 1, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value);
    }

    $descr = $entry['climateName'];
    $oid   = ".1.3.6.1.4.1.21239.2.2.1.14.$index";
    $value = $entry['climateVolts'];

    $low_limit = (isset($geist_alarms["climateVolts.$index"]['low_limit']) ? $geist_alarms["climateVolts.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["climateVolts.$index"]['low_limit_warn']) ? $geist_alarms["climateVolts.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["climateVolts.$index"]['high_limit_warn']) ? $geist_alarms["climateVolts.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["climateVolts.$index"]['high_limit']) ? $geist_alarms["climateVolts.$index"]['high_limit'] : NULL);

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'voltage', $device, $oid, 'climateVolts.'.$index, 'geist-mib-v3', $descr, 1, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value);
    }

    // Phase 1
    $descr = $entry['climateName'] . " Phase 1";

    $oid   = ".1.3.6.1.4.1.21239.2.2.1.18.$index";
    $value = $entry['climateRealPowerA'];

    $low_limit = (isset($geist_alarms["climateRealPowerA.$index"]['low_limit']) ? $geist_alarms["climateRealPowerA.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["climateRealPowerA.$index"]['low_limit_warn']) ? $geist_alarms["climateRealPowerA.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["climateRealPowerA.$index"]['high_limit_warn']) ? $geist_alarms["climateRealPowerA.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["climateRealPowerA.$index"]['high_limit']) ? $geist_alarms["climateRealPowerA.$index"]['high_limit'] : NULL);

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'power', $device, $oid, 'climateRealPowerA.'.$index, 'geist-mib-v3', $descr, 1, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value);
    }

    $oid   = ".1.3.6.1.4.1.21239.2.2.1.19.$index";
    $value = $entry['climateApparentPowerA'];

    $low_limit = (isset($geist_alarms["climateApparentPowerA.$index"]['low_limit']) ? $geist_alarms["climateApparentPowerA.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["climateApparentPowerA.$index"]['low_limit_warn']) ? $geist_alarms["climateApparentPowerA.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["climateApparentPowerA.$index"]['high_limit_warn']) ? $geist_alarms["climateApparentPowerA.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["climateApparentPowerA.$index"]['high_limit']) ? $geist_alarms["climateApparentPowerA.$index"]['high_limit'] : NULL);

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'apower', $device, $oid, 'climateApparentPowerA.'.$index, 'geist-mib-v3', $descr, 1, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value);
    }

    $oid   = ".1.3.6.1.4.1.21239.2.2.1.16.$index";
    $value = $entry['climateDeciAmpsA'];

    $low_limit = (isset($geist_alarms["climateDeciAmpsA.$index"]['low_limit']) ? $geist_alarms["climateDeciAmpsA.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["climateDeciAmpsA.$index"]['low_limit_warn']) ? $geist_alarms["climateDeciAmpsA.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["climateDeciAmpsA.$index"]['high_limit_warn']) ? $geist_alarms["climateDeciAmpsA.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["climateDeciAmpsA.$index"]['high_limit']) ? $geist_alarms["climateDeciAmpsA.$index"]['high_limit'] : NULL);

    if ($value !== '')
    {
      discover_sensor($valid['sensor'], 'current', $device, $oid, 'climateDeciAmpsA.'.$index, 'geist-mib-v3', $descr, 10, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value / 10);
    }

    // Phase 2
    $descr = $entry['climateName'] . " Phase 2";

    $oid   = ".1.3.6.1.4.1.21239.2.2.1.23.$index";
    $value = $entry['climateRealPowerB'];

    $low_limit = (isset($geist_alarms["climateRealPowerB.$index"]['low_limit']) ? $geist_alarms["climateRealPowerB.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["climateRealPowerB.$index"]['low_limit_warn']) ? $geist_alarms["climateRealPowerB.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["climateRealPowerB.$index"]['high_limit_warn']) ? $geist_alarms["climateRealPowerB.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["climateRealPowerB.$index"]['high_limit']) ? $geist_alarms["climateRealPowerB.$index"]['high_limit'] : NULL);

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'power', $device, $oid, 'climateRealPowerB.'.$index, 'geist-mib-v3', $descr, 1, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value);
    }

    $oid   = ".1.3.6.1.4.1.21239.2.2.1.24.$index";
    $value = $entry['climateApparentPowerB'];

    $low_limit = (isset($geist_alarms["climateApparentPowerB.$index"]['low_limit']) ? $geist_alarms["climateApparentPowerB.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["climateApparentPowerB.$index"]['low_limit_warn']) ? $geist_alarms["climateApparentPowerB.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["climateApparentPowerB.$index"]['high_limit_warn']) ? $geist_alarms["climateApparentPowerB.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["climateApparentPowerB.$index"]['high_limit']) ? $geist_alarms["climateApparentPowerB.$index"]['high_limit'] : NULL);

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'apower', $device, $oid, 'climateApparentPowerB.'.$index, 'geist-mib-v3', $descr, 1, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value);
    }

    $oid   = ".1.3.6.1.4.1.21239.2.2.1.21.$index";
    $value = $entry['climateDeciAmpsB'];

    $low_limit = (isset($geist_alarms["climateDeciAmpsB.$index"]['low_limit']) ? $geist_alarms["climateDeciAmpsB.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["climateDeciAmpsB.$index"]['low_limit_warn']) ? $geist_alarms["climateDeciAmpsB.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["climateDeciAmpsB.$index"]['high_limit_warn']) ? $geist_alarms["climateDeciAmpsB.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["climateDeciAmpsB.$index"]['high_limit']) ? $geist_alarms["climateDeciAmpsB.$index"]['high_limit'] : NULL);

    if ($value !== '')
    {
      discover_sensor($valid['sensor'], 'current', $device, $oid, 'climateDeciAmpsB.'.$index, 'geist-mib-v3', $descr, 10, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value / 10);
    }

    // Phase 3
    $descr = $entry['climateName'] . " Phase 3";

    $oid   = ".1.3.6.1.4.1.21239.2.2.1.28.$index";
    $value = $entry['climateRealPowerC'];

    $low_limit = (isset($geist_alarms["climateRealPowerC.$index"]['low_limit']) ? $geist_alarms["climateRealPowerC.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["climateRealPowerC.$index"]['low_limit_warn']) ? $geist_alarms["climateRealPowerC.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["climateRealPowerC.$index"]['high_limit_warn']) ? $geist_alarms["climateRealPowerC.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["climateRealPowerC.$index"]['high_limit']) ? $geist_alarms["climateRealPowerC.$index"]['high_limit'] : NULL);

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'power', $device, $oid, 'climateRealPowerC.'.$index, 'geist-mib-v3', $descr, 1, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value);
    }

    $oid   = ".1.3.6.1.4.1.21239.2.2.1.29.$index";
    $value = $entry['climateApparentPowerC'];

    $low_limit = (isset($geist_alarms["climateApparentPowerC.$index"]['low_limit']) ? $geist_alarms["climateApparentPowerC.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["climateApparentPowerC.$index"]['low_limit_warn']) ? $geist_alarms["climateApparentPowerC.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["climateApparentPowerC.$index"]['high_limit_warn']) ? $geist_alarms["climateApparentPowerC.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["climateApparentPowerC.$index"]['high_limit']) ? $geist_alarms["climateApparentPowerC.$index"]['high_limit'] : NULL);

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'apower', $device, $oid, 'climateApparentPowerC.'.$index, 'geist-mib-v3', $descr, 1, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value);
    }

    $oid   = ".1.3.6.1.4.1.21239.2.2.1.26.$index";
    $value = $entry['climateDeciAmpsC'];

    $low_limit = (isset($geist_alarms["climateDeciAmpsC.$index"]['low_limit']) ? $geist_alarms["climateDeciAmpsC.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["climateDeciAmpsC.$index"]['low_limit_warn']) ? $geist_alarms["climateDeciAmpsC.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["climateDeciAmpsC.$index"]['high_limit_warn']) ? $geist_alarms["climateDeciAmpsC.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["climateDeciAmpsC.$index"]['high_limit']) ? $geist_alarms["climateDeciAmpsC.$index"]['high_limit'] : NULL);

    if ($value !== '')
    {
      discover_sensor($valid['sensor'], 'current', $device, $oid, 'climateDeciAmpsC.'.$index, 'geist-mib-v3', $descr, 10, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value / 10);
    }

    $descr = $entry['climateName'] . " Analog I/O Sensor 1";

    $oid   = ".1.3.6.1.4.1.21239.2.2.1.11.$index";
    $value = $entry['climateIO1'];

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'state', $device, $oid, 'climateIO1.'.$index, 'geist-mib-v3-climateio-state', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
    }

    $descr = $entry['climateName'] . " Analog I/O Sensor 2";

    $oid   = ".1.3.6.1.4.1.21239.2.2.1.12.$index";
    $value = $entry['climateIO2'];

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'state', $device, $oid, 'climateIO2.'.$index, 'geist-mib-v3-climateio-state', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
    }

    $descr = $entry['climateName'] . " Analog I/O Sensor 3";

    $oid   = ".1.3.6.1.4.1.21239.2.2.1.13.$index";
    $value = $entry['climateIO3'];

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'state', $device, $oid, 'climateIO3.'.$index, 'geist-mib-v3-climateio-state', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
    }
  }
}

// GEIST-MIB-V3::powerDMSerial.1 = STRING: E200000076221234
// GEIST-MIB-V3::powerDMName.1 = STRING: DM16 PDU
// GEIST-MIB-V3::powerDMAvail.1 = Gauge32: 1
// GEIST-MIB-V3::powerDMUnitInfoTitle.1 = STRING: DM16/GDM1
// GEIST-MIB-V3::powerDMUnitInfoVersion.1 = STRING: 3.00
// GEIST-MIB-V3::powerDMUnitInfoMainCount.1 = INTEGER: 1
// GEIST-MIB-V3::powerDMUnitInfoAuxCount.1 = INTEGER: 0
// GEIST-MIB-V3::powerDMChannelName1.1 = STRING: Circuit 1
// GEIST-MIB-V3::powerDMChannelFriendly1.1 = STRING: Amps Circuit 1
// GEIST-MIB-V3::powerDMChannelGroup1.1 = STRING: Total Amps
// GEIST-MIB-V3::powerDMDeciAmps1.1 = INTEGER: 0 0.1 Amps

// Oh dear, 48 possible OIDs done separately instead of indexed.

$cache['geist']['powerDMTable'] = snmpwalk_cache_multi_oid($device, "powerDMTable", array(), "GEIST-MIB-V3", mib_dirs('geist'));

foreach ($cache['geist']['powerDMTable'] as $index => $entry)
{
  if ($entry['powerDMAvail'])
  {
    for ($i = 1; $i <= $entry['powerDMUnitInfoMainCount']; $i++)
    {
      $descr = $entry['powerDMName'] . " " . $entry["powerDMChannelFriendly$i"];

      $oid   = ".1.3.6.1.4.1.21239.2.29.1.".(152+$i).".$index";
      $value = $entry["powerDMDeciAmps$i"];

      $low_limit = (isset($geist_alarms["powerDMDeciAmps$i.$index"]['low_limit']) ? $geist_alarms["powerDMDeciAmps$i.$index"]['low_limit'] : NULL);
      $low_limit_warn = (isset($geist_alarms["powerDMDeciAmps$i.$index"]['low_limit_warn']) ? $geist_alarms["powerDMDeciAmps$i.$index"]['low_limit_warn'] : NULL);
      $high_limit_warn = (isset($geist_alarms["powerDMDeciAmps$i.$index"]['high_limit_warn']) ? $geist_alarms["powerDMDeciAmps$i.$index"]['high_limit_warn'] : NULL);
      $high_limit = (isset($geist_alarms["powerDMDeciAmps$i.$index"]['high_limit']) ? $geist_alarms["powerDMDeciAmps$i.$index"]['high_limit'] : NULL);

      if ($value != '')
      {
        discover_sensor($valid['sensor'], 'current', $device, $oid, "powerDMDeciAmps$i.".$index, 'geist-mib-v3', $descr, 10, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value / 10);
      }
    }
  }
}

// GEIST-MIB-V3::ctrlRelayName.1 = STRING: Relay-1
// GEIST-MIB-V3::ctrlRelayState.1 = Gauge32: 0
// GEIST-MIB-V3::ctrlRelayLatchingMode.1 = Gauge32: 0
// GEIST-MIB-V3::ctrlRelayOverride.1 = Gauge32: 0
// GEIST-MIB-V3::ctrlRelayAcknowledge.1 = Gauge32: 0

$cache['geist']['ctrlRelayTable'] = snmpwalk_cache_multi_oid($device, "ctrlRelayTable", array(), "GEIST-MIB-V3", mib_dirs('geist'));

foreach ($cache['geist']['ctrlRelayTable'] as $index => $entry)
{
  $descr = $entry['ctrlRelayName'];

  $value = $entry['ctrlRelayState'];
  $oid   = ".1.3.6.1.4.1.21239.2.27.1.3.$index";

  if ($value != '')
  {
    discover_sensor($valid['sensor'], 'state', $device, $oid, 'ctrlRelayState.'.$index, 'geist-mib-v3-relay-state', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
  }
}

// GEIST-MIB-V3::climateRelaySerial.1 = STRING: 28789248020000A0
// GEIST-MIB-V3::climateRelayName.1 = STRING: GRSO Demo
// GEIST-MIB-V3::climateRelayAvail.1 = Gauge32: 1
// GEIST-MIB-V3::climateRelayTempC.1 = INTEGER: 27 Degrees Celsius
// GEIST-MIB-V3::climateRelayIO1.1 = INTEGER: 100
// GEIST-MIB-V3::climateRelayIO2.1 = INTEGER: 100
// GEIST-MIB-V3::climateRelayIO3.1 = INTEGER: 99
// GEIST-MIB-V3::climateRelayIO4.1 = INTEGER: 99
// GEIST-MIB-V3::climateRelayIO5.1 = INTEGER: 99
// GEIST-MIB-V3::climateRelayIO6.1 = INTEGER: 99

$cache['geist']['climateRelayTable'] = snmpwalk_cache_multi_oid($device, "climateRelayTable", array(), "GEIST-MIB-V3", mib_dirs('geist'));

foreach ($cache['geist']['climateRelayTable'] as $index => $entry)
{
  if ($entry['climateRelayAvail'])
  {
    $descr = $entry['climateRelayName'];

    $oid   = ".1.3.6.1.4.1.21239.2.26.1.5.$index";
    $value = $entry['climateRelayTempC'];

    $low_limit = (isset($geist_alarms["climateRelayTempC.$index"]['low_limit']) ? $geist_alarms["climateRelayTempC.$index"]['low_limit'] : NULL);
    $low_limit_warn = (isset($geist_alarms["climateRelayTempC.$index"]['low_limit_warn']) ? $geist_alarms["climateRelayTempC.$index"]['low_limit_warn'] : NULL);
    $high_limit_warn = (isset($geist_alarms["climateRelayTempC.$index"]['high_limit_warn']) ? $geist_alarms["climateRelayTempC.$index"]['high_limit_warn'] : NULL);
    $high_limit = (isset($geist_alarms["climateRelayTempC.$index"]['high_limit']) ? $geist_alarms["climateRelayTempC.$index"]['high_limit'] : NULL);

    if ($value != '')
    {
      discover_sensor($valid['sensor'], 'temperature', $device, $oid, 'climateRelayTempC.'.$index, 'geist-mib-v3', $descr, 1, 1, $low_limit, $low_limit_warn, $high_limit_warn, $high_limit, $value);
    }

    for ($i = 0; $i <= 6; $i++)
    {
      $descr = $entry['climateRelayName'] . " Analog I/O Sensor $i";
      $value = $entry["climateRelayIO$i"];
      $oid   = ".1.3.6.1.4.1.21239.2.26.1." . (6+$i) . ".$index";

      if ($value != '')
      {
        discover_sensor($valid['sensor'], 'state', $device, $oid, "climateRelayIO$i.".$index, 'geist-mib-v3-climateio-state', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
      }
    }
  }
}

unset($geist_alarms);

// EOF
