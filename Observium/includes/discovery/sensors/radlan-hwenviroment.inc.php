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

echo(" RADLAN-HWENVIROMENT ");

// RADLAN-HWENVIROMENT::rlEnvMonFanStatusDescr.67109249 = STRING: "fan1"
// RADLAN-HWENVIROMENT::rlEnvMonFanStatusDescr.67109250 = STRING: "fan2"
// RADLAN-HWENVIROMENT::rlEnvMonFanState.67109249 = INTEGER: normal(1)
// RADLAN-HWENVIROMENT::rlEnvMonFanState.67109250 = INTEGER: normal(1)

$oids = snmpwalk_cache_multi_oid($device, "rlEnvMonFanStatusTable", array(), "RADLAN-HWENVIROMENT", mib_dirs('radlan'));

if (is_array($oids))
{
  foreach ($oids as $index => $entry)
  {
    $descr   = ucfirst($entry['rlEnvMonFanStatusDescr']);
    $oid     = ".1.3.6.1.4.1.89.83.1.1.1.3.".$index;
    $current = state_string_to_numeric('radlan-hwenvironment-state',$entry['rlEnvMonFanState']);

    if ($entry['rlEnvMonFanState'] != 'notPresent')
    {
      discover_sensor($valid['sensor'], 'fanspeed', $device, $oid, "rlEnvMonFanState.$index", 'radlan-hwenvironment-state', $descr, 1, 1, NULL, NULL, NULL, NULL, $current);
    }
  }
}

// RADLAN-HWENVIROMENT::rlEnvMonSupplyStatusDescr.67109185 = STRING: "ps1"
// RADLAN-HWENVIROMENT::rlEnvMonSupplyStatusDescr.67109186 = STRING: "ps2"
// RADLAN-HWENVIROMENT::rlEnvMonSupplyState.67109185 = INTEGER: normal(1)
// RADLAN-HWENVIROMENT::rlEnvMonSupplyState.67109186 = INTEGER: notPresent(5)
// RADLAN-HWENVIROMENT::rlEnvMonSupplySource.67109185 = INTEGER: ac(2)
// RADLAN-HWENVIROMENT::rlEnvMonSupplySource.67109186 = INTEGER: unknown(1)

$oids = snmpwalk_cache_multi_oid($device, "rlEnvMonSupplyStatusTable", array(), "RADLAN-HWENVIROMENT", mib_dirs('radlan'));

if (is_array($oids))
{
  foreach ($oids as $index => $entry)
  {
    $descr   = ucfirst($entry['rlEnvMonSupplyStatusDescr']);
    $oid     = ".1.3.6.1.4.1.89.83.1.2.1.3.".$index;
    $current = state_string_to_numeric('radlan-hwenvironment-state',$entry['rlEnvMonSupplyState']);

    if ($entry['rlEnvMonSupplyState'] != 'notPresent')
    {
      discover_sensor($valid['sensor'], 'power', $device, $oid, "rlEnvMonSupplyState.$index", 'radlan-hwenvironment-state', $descr, 1, 1, NULL, NULL, NULL, NULL, $current);
    }
  }
}

// EOF
