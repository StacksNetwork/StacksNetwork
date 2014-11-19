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

// Old CISCO-ENVMON-MIB

echo(" CISCO-ENVMON-MIB ");

$sensor_type       = 'cisco-envmon';
$sensor_state_type = 'cisco-envmon-state';

// Temperatures:
echo(" Temperatures ");

$oids = snmpwalk_cache_oid($device, 'ciscoEnvMonTemperatureStatusEntry', array(), 'CISCO-ENVMON-MIB', mib_dirs('cisco'));

foreach ($oids as $index => $entry)
{
  if (isset($entry['ciscoEnvMonTemperatureStatusValue']))
  {
    $oid  = '.1.3.6.1.4.1.9.9.13.1.3.1.3.'.$index;
    // Exclude duplicated entries from CISCO-ENTITY-SENSOR
    $ent_count = dbFetchCell('SELECT COUNT(*) FROM `sensors` WHERE `device_id` = ? AND `sensor_type` = ? AND `sensor_class` = ? AND `sensor_descr` LIKE ? AND CONCAT(`sensor_limit`) = ?;',
                              array($device['device_id'], 'cisco-entity-sensor', 'temperature', $entry['ciscoEnvMonTemperatureStatusDescr'].'%', $entry['ciscoEnvMonTemperatureThreshold']));
    if (!$ent_count)
    {
      discover_sensor($valid['sensor'], 'temperature', $device, $oid, $index, $sensor_type, $entry['ciscoEnvMonTemperatureStatusDescr'], 1, 1,
                      NULL, NULL, NULL, $entry['ciscoEnvMonTemperatureThreshold'], $entry['ciscoEnvMonTemperatureStatusValue']);
    }
  } elseif (isset($entry['ciscoEnvMonTemperatureState']))
  {
    $oid  = '.1.3.6.1.4.1.9.9.13.1.3.1.6.'.$index;
    //Not numerical values, only states
    $value = state_string_to_numeric($sensor_state_type, $entry['ciscoEnvMonTemperatureState']);
    if ($value <= 4) // Exclude 'notPresent' and 'notFunctioning'
    {
      discover_sensor($valid['sensor'], 'temperature', $device, $oid, $index, $sensor_state_type, $entry['ciscoEnvMonTemperatureStatusDescr'], 1, 1,
                      NULL, NULL, NULL, NULL, $value);
    }
  }
}

// Voltages
echo(" Voltages ");

$divisor = 1000;

$oids = snmpwalk_cache_oid($device, 'ciscoEnvMonVoltageStatusEntry', array(), 'CISCO-ENVMON-MIB', mib_dirs('cisco'));

foreach ($oids as $index => $entry)
{
  if (isset($entry['ciscoEnvMonVoltageStatusValue']))
  {
    $oid  = '.1.3.6.1.4.1.9.9.13.1.2.1.3.'.$index;
    // Exclude duplicated entries from CISCO-ENTITY-SENSOR
    $query = 'SELECT COUNT(*) FROM `sensors` WHERE `device_id` = ? AND `sensor_type` = ? AND `sensor_class` = ? AND `sensor_descr` LIKE ? ';
    $query .= ($entry['ciscoEnvMonVoltageThresholdHigh'] > $entry['ciscoEnvMonVoltageThresholdLow']) ? 'AND CONCAT(`sensor_limit`) = ? AND CONCAT(`sensor_limit_low`) = ?;' : 'AND CONCAT(`sensor_limit_low`) = ? AND CONCAT(`sensor_limit`) = ?;'; //swich negative numbers
    $ent_count = dbFetchCell($query, array($device['device_id'], 'cisco-entity-sensor', 'voltage', $entry['ciscoEnvMonVoltageStatusDescr'].'%', $entry['ciscoEnvMonVoltageThresholdHigh'] / $divisor, $entry['ciscoEnvMonVoltageThresholdLow'] / $divisor));
    if (!$ent_count)
    {
      discover_sensor($valid['sensor'], 'voltage', $device, $oid, $index, $sensor_type, $entry['ciscoEnvMonVoltageStatusDescr'], $divisor, 1,
                      $entry['ciscoEnvMonVoltageThresholdLow'] / $divisor, NULL, NULL, $entry['ciscoEnvMonVoltageThresholdHigh'] / $divisor, $entry['ciscoEnvMonVoltageStatusValue'] / $divisor);
    }
  } elseif (isset($entry['ciscoEnvMonVoltageState']))
  {
    $oid  = '.1.3.6.1.4.1.9.9.13.1.2.1.7.'.$index;
    //Not numerical values, only states
    $value = state_string_to_numeric($sensor_state_type, $entry['ciscoEnvMonVoltageState']);
    if ($value <= 4) // Exclude 'notPresent' and 'notFunctioning'
    {
      discover_sensor($valid['sensor'], 'voltage', $device, $oid, $index, $sensor_state_type, $entry['ciscoEnvMonVoltageStatusDescr'], 1, 1,
                      NULL, NULL, NULL, NULL, $value);
    }
  }
}
unset($divisor);

// Supply
echo(" Supply ");

$oids = snmpwalk_cache_oid($device, 'ciscoEnvMonSupplyStatusEntry', array(), 'CISCO-ENVMON-MIB', mib_dirs('cisco'));

foreach ($oids as $index => $entry)
{
  if (isset($entry['ciscoEnvMonSupplyState']))
  {
    $oid  = '.1.3.6.1.4.1.9.9.13.1.5.1.3.'.$index;
    //Not numerical values, only states
    $value = state_string_to_numeric($sensor_state_type, $entry['ciscoEnvMonSupplyState']);
    if ($value <= 4) // Exclude 'notPresent' and 'notFunctioning'
    {
      discover_sensor($valid['sensor'], 'power', $device, $oid, $index, $sensor_state_type, $entry['ciscoEnvMonSupplyStatusDescr'], 1, 1,
                      NULL, NULL, NULL, NULL, $value);
    }
  }
}

// Fans
echo(" Fans ");

$oids = snmpwalk_cache_oid($device, 'ciscoEnvMonFanStatusEntry', array(), 'CISCO-ENVMON-MIB', mib_dirs('cisco'));

foreach ($oids as $index => $entry)
{
  if (isset($entry['ciscoEnvMonFanState']))
  {
    $oid  = '.1.3.6.1.4.1.9.9.13.1.4.1.3.'.$index;
    //Not numerical values, only states
    $value = state_string_to_numeric($sensor_state_type, $entry['ciscoEnvMonFanState']);
    if ($value <= 4) // Exclude 'notPresent' and 'notFunctioning'
    {
      discover_sensor($valid['sensor'], 'fanspeed', $device, $oid, $index, $sensor_state_type, $entry['ciscoEnvMonFanStatusDescr'], 1, 1,
                      NULL, NULL, NULL, NULL, $value);
    }
  }
}

// EOF
