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

// Supermicro Sensors
$sm_sensor_array = array();
$sm_sensor_array = snmpwalk_cache_multi_oid($device, "smHealthMonitorTable", $sm_sensor_array, "SUPERMICRO-HEALTH-MIB");

echo(" SUPERMICRO-HEALTH-MIB ");

if (!empty($sm_sensor_array))
{
  foreach (array_keys($sm_sensor_array) as $index)
  {
    $sensor_oid = "1.3.6.1.4.1.10876.2.1.1.1.1.4.$index";

    $descr      = $sm_sensor_array[$index]['smHealthMonitorName'];
    $current    = $sm_sensor_array[$index]['smHealthMonitorReading'];
    $limit      = $sm_sensor_array[$index]['smHealthMonitorHighLimit'];
    $low_limit  = $sm_sensor_array[$index]['smHealthMonitorLowLimit'];
    $monitor    = $sm_sensor_array[$index]['smHealthMonitorMonitor'];
    $type       = $sm_sensor_array[$index]['smHealthMonitorType'];

    switch ($type)
    {
      case 0: # Fanspeed
        $divisor    = "1";
        $descr      = str_replace(' Fan Speed','',$descr);
        $descr      = str_replace(' Speed','',$descr);
        $sensortype = 'fanspeed';
        break;
      case 1: # Voltage
        $divisor    = "1000";
        $sensortype = 'voltage';
        $descr      = trim(str_ireplace("Voltage", "", $descr));
        break;
      case 2: # Temperature
        $divisor    = "1";
         $descr      = trim(str_ireplace("temperature", "", $descr));
       $sensortype = 'temperature';
        break;
      default:
        $monitor    = 0; # Don't add other sensor types. FIXME: could alert on chassis intrusion trip and psu fail later.
        break;
    }

    if ($monitor === 'true') # Needs === because PHP is an idiot. == will always result in TRUE.
    {
      discover_sensor($valid['sensor'], $sensortype, $device, $sensor_oid, $index, 'supermicro', $descr, $divisor, 1, (empty($low_limit) ? NULL : $low_limit / $divisor), NULL, NULL, (empty($limit) ? NULL : $limit / $divisor), $current / $divisor);
    }
  }
}

unset($sm_sensor_array);

// EOF
