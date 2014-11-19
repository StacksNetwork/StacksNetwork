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

echo(" Dell-Vendor-MIB ");

// Dell-Vendor-MIB::envMonFanStatusDescr.67109249 = STRING: fan1
// Dell-Vendor-MIB::envMonFanStatusDescr.67109250 = STRING: fan2
// Dell-Vendor-MIB::envMonFanState.67109249 = INTEGER: normal(1)
// Dell-Vendor-MIB::envMonFanState.67109250 = INTEGER: normal(1)

$oids = snmpwalk_cache_multi_oid($device, "envMonFanStatusTable", array(), "Dell-Vendor-MIB", mib_dirs('dell'));

if (is_array($oids))
{
  foreach ($oids as $index => $entry)
  {
    $descr   = ucfirst($entry['envMonFanStatusDescr']);
    $oid     = ".1.3.6.1.4.1.674.10895.3000.1.2.110.7.1.1.3.".$index;
    $current = state_string_to_numeric('dell-vendor-state',$entry['envMonFanState']);

    $query  = "SELECT sensor_id FROM `sensors` WHERE `device_id` = '".$device['device_id']."' AND `sensor_class` = 'fanspeed'";
    $query .= " AND `sensor_type` IN ('radlan-hwenvironment-state','fastpath-boxservices-private-state')";
    $query .= " AND (`sensor_index` IN ('rlEnvMonFanState.$index') OR `sensor_descr` = '$descr')";

    if ($entry['envMonFanState'] != 'notPresent' && !count(dbFetchRows($query)))
    {
      discover_sensor($valid['sensor'], 'fanspeed', $device, $oid, "envMonFanState.$index", 'dell-vendor-state', $descr, 1, 1, NULL, NULL, NULL, NULL, $current);
    }
  }
}

// Dell-Vendor-MIB::envMonSupplyStatusDescr.67109185 = STRING: ps1
// Dell-Vendor-MIB::envMonSupplyStatusDescr.67109186 = STRING: ps2
// Dell-Vendor-MIB::envMonSupplyState.67109185 = INTEGER: normal(1)
// Dell-Vendor-MIB::envMonSupplyState.67109186 = INTEGER: notPresent(5)
// Dell-Vendor-MIB::envMonSupplySource.67109185 = INTEGER: ac(2)
// Dell-Vendor-MIB::envMonSupplySource.67109186 = INTEGER: unknown(1)

$oids = snmpwalk_cache_multi_oid($device, "envMonSupplyStatusTable", array(), "Dell-Vendor-MIB", mib_dirs('dell'));

if (is_array($oids))
{
  foreach ($oids as $index => $entry)
  {
    $descr   = ucfirst($entry['envMonSupplyStatusDescr']);
    $oid     = ".1.3.6.1.4.1.674.10895.3000.1.2.110.7.2.1.3.".$index;
    $current = state_string_to_numeric('dell-vendor-state',$entry['envMonSupplyState']);

    // Ignore all PSU when we find another MIB has delivered. Descriptions and indexes are different so we cannot match them up.
    $query  = "SELECT sensor_id FROM `sensors` WHERE `device_id` = '".$device['device_id']."' AND `sensor_class` = 'power'";
    $query .= " AND `sensor_type` IN ('radlan-hwenvironment-state','fastpath-boxservices-private-state')";

    if ($entry['envMonSupplyState'] != 'notPresent' && !count(dbFetchRows($query)))
    {
      discover_sensor($valid['sensor'], 'power', $device, $oid, "envMonSupplyState.$index", 'dell-vendor-state', $descr, 1, 1, NULL, NULL, NULL, NULL, $current);
    }
  }
}

// EOF
