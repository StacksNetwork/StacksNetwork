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

echo(" CISCO-ENTITY-SENSOR-MIB ");

$oids = array();
echo("Caching OIDs:");

if (!is_array($entity_array))
{
  $entity_array = array();
  echo(" entPhysicalDescr");
  $entity_array = snmpwalk_cache_multi_oid($device, "entPhysicalDescr", $entity_array, "CISCO-ENTITY-SENSOR-MIB");
  echo(" entPhysicalName");
  $entity_array = snmpwalk_cache_multi_oid($device, "entPhysicalName", $entity_array, "CISCO-ENTITY-SENSOR-MIB");
}

echo("  entSensorType");
$oids = snmpwalk_cache_multi_oid($device, "entSensorType", $oids, "CISCO-ENTITY-SENSOR-MIB");
echo(" entSensorScale");
$oids = snmpwalk_cache_multi_oid($device, "entSensorScale", $oids, "CISCO-ENTITY-SENSOR-MIB");
echo(" entSensorValue");
$oids = snmpwalk_cache_multi_oid($device, "entSensorValue", $oids, "CISCO-ENTITY-SENSOR-MIB");
echo(" entSensorMeasuredEntity");
$oids = snmpwalk_cache_multi_oid($device, "entSensorMeasuredEntity", $oids, "CISCO-ENTITY-SENSOR-MIB");
echo(" entSensorPrecision");
$oids = snmpwalk_cache_multi_oid($device, "entSensorPrecision", $oids, "CISCO-ENTITY-SENSOR-MIB");

$t_oids = array();
echo(" entSensorThresholdSeverity");
$t_oids = snmpwalk_cache_twopart_oid($device, "entSensorThresholdSeverity", $t_oids, "CISCO-ENTITY-SENSOR-MIB");
echo(" entSensorThresholdRelation");
$t_oids = snmpwalk_cache_twopart_oid($device, "entSensorThresholdRelation", $t_oids, "CISCO-ENTITY-SENSOR-MIB");
echo(" entSensorThresholdValue");
$t_oids = snmpwalk_cache_twopart_oid($device, "entSensorThresholdValue", $t_oids, "CISCO-ENTITY-SENSOR-MIB");

if ($debug) { print_vars($oids); }

$entitysensor['voltsDC']   = "voltage";
$entitysensor['voltsAC']   = "voltage";
$entitysensor['amperes']   = "current";
$entitysensor['watt']      = "power";
$entitysensor['hertz']     = "freq";
$entitysensor['percentRH'] = "humidity";
$entitysensor['rpm']       = "fanspeed";
$entitysensor['celsius']   = "temperature";
$entitysensor['watts']     = "power";
$entitysensor['dBm']       = "dbm";

foreach ($oids as $index => $entry)
{
  $ok = TRUE;

  if ($entitysensor[$entry['entSensorType']] && is_numeric($entry['entSensorValue']) && is_numeric($index))
  {
    $entPhysicalIndex = $index;

    if ($entity_array[$index]['entPhysicalName'] || $device['os'] == "iosxr")
    {
      if ($entity_array[$index]['entPhysicalName'] == $entity_array[$index]['entPhysicalDescr'])
      {
        $descr = rewrite_entity_name($entity_array[$index]['entPhysicalName']);
      } else {
        $descr = rewrite_entity_name($entity_array[$index]['entPhysicalName']) . " - " . rewrite_entity_name($entity_array[$index]['entPhysicalDescr']);
      }
    } else {
      $descr = $entity_array[$index]['entPhysicalDescr'];
      $descr = rewrite_entity_name($descr);
    }

    // Set description based on measured entity if it exists
    if (is_numeric($entry['entSensorMeasuredEntity']) && $entry['entSensorMeasuredEntity'])
    {
      $measured_descr = $entity_array[$entry['entSensorMeasuredEntity']]['entPhysicalName'];
      if (!$measured_descr)
      {
        $measured_descr = $entity_array[$entry['entSensorMeasuredEntity']]['entPhysicalDescr'];
      }
      $descr = $measured_descr . " - " . $descr;
    }

    // Bit dirty also, clean later
    $descr = str_replace("Temp: ", "", $descr);
    $descr = str_ireplace("temperature ", "", $descr);

    $oid = ".1.3.6.1.4.1.9.9.91.1.1.1.1.4.".$index;
    $value = $entry['entSensorValue'];
    $type = $entitysensor[$entry['entSensorType']];

    #echo("$index : ".$entry['entSensorScale']."|");

    // Returning blatantly broken value. IGNORE.
    if ($value == "-32768") { $ok = FALSE; }

    // FIXME this stuff is foul
    if ($entry['entSensorScale'] == "nano")  { $divisor = "1000000000"; $multiplier = "1";  }
    if ($entry['entSensorScale'] == "micro") { $divisor = "1000000"; $multiplier = "1";  }
    if ($entry['entSensorScale'] == "milli") { $divisor = "1000"; $multiplier = "1";  }
    if ($entry['entSensorScale'] == "units") { $divisor = "1"; $multiplier = "1";  }
    if ($entry['entSensorScale'] == "kilo")  { $divisor = "1"; $multiplier = "1000";  }
    if ($entry['entSensorScale'] == "mega")  { $divisor = "1"; $multiplier = "1000000";  }
    if ($entry['entSensorScale'] == "giga")  { $divisor = "1"; $multiplier = "1000000000";  }
    if (is_numeric($entry['entSensorPrecision']) && $entry['entSensorPrecision'] > "0") { $divisor = $divisor . str_pad('', $entry['entSensorPrecision'], "0"); }
    $value = $value * $multiplier / $divisor;

    // Set thresholds to null
    $limit = NULL; $low_limit = NULL; $warn_limit = NULL; $warn_limit_low = NULL;

    // Check thresholds for this entry (bit dirty, but it works!)
    if (is_array($t_oids[$index]))
    {
      foreach ($t_oids[$index] as $t_index => $entry)
      {
        // Critical Limit
        if ($entry['entSensorThresholdSeverity'] == "major" && $entry['entSensorThresholdRelation'] == "greaterOrEqual" && $entry['entSensorThresholdValue'] != "-32768")
        {
          $limit = $entry['entSensorThresholdValue'] * $multiplier / $divisor;
        }

        if ($entry['entSensorThresholdSeverity'] == "major" && $entry['entSensorThresholdRelation'] == "lessOrEqual" && $entry['entSensorThresholdValue'] != "-32768")
        {
          $limit_low = $entry['entSensorThresholdValue'] * $multiplier / $divisor;
        }

        // Warning Limit
        if ($entry['entSensorThresholdSeverity'] == "minor" && $entry['entSensorThresholdRelation'] == "greaterOrEqual" && $entry['entSensorThresholdSeverity'] != "-32768")
        {
          $warn_limit = $entry['entSensorThresholdValue'] * $multiplier / $divisor;
        }

        if ($entry['entSensorThresholdSeverity'] == "minor" && $entry['entSensorThresholdRelation'] == "lessOrEqual" && $entry['entSensorThresholdSeverity'] != "-32768")
        {
          $warn_limit_low = $entry['entSensorThresholdValue'] * $multiplier / $divisor;
        }
      }
    }
    // End Threshold code

    if ($value == "-127") { $ok = FALSE; } // False reading
    if ($descr == "") { $ok = FALSE; }     // Invalid description. Lots of these on Nexus

    if ($ok)
    {
      discover_sensor($valid['sensor'], $type, $device, $oid, $index, 'cisco-entity-sensor', $descr, $divisor, $multiplier, $limit_low, $warn_limit_low, $warn_limit, $limit, $value, 'snmp', $entPhysicalIndex, $entry['entSensorMeasuredEntity']);
    }

    $cisco_entity_temperature = 1;
    unset($limit, $limit_low, $warn_limit, $warn_limit_low);
  }
}

// EOF
