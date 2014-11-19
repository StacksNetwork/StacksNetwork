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

echo(" GUDEADS-EPC8X-MIB ");

// GUDEADS-EPC8X-MIB::epc8TempSensor.1 = INTEGER: -9999 10th of degree Celsius
// GUDEADS-EPC8X-MIB::epc8TempSensor.2 = INTEGER: -9999 10th of degree Celsius
// GUDEADS-EPC8X-MIB::epc8HygroSensor.1 = INTEGER: -9999 10th of percentage humidity
// GUDEADS-EPC8X-MIB::epc8HygroSensor.2 = INTEGER: -9999 10th of percentage humidity

$cache['epc8x'] = snmpwalk_cache_multi_oid($device, "epc8SensorTable", array(), "GUDEADS-EPC8X-MIB", mib_dirs('gude'));

foreach ($cache['epc8x'] as $index => $entry)
{
  $oid   = ".1.3.6.1.4.1.28507.1.1.3.2.1.2.$index";
  $descr = "Temp Sensor $index";
  $value = $entry['epc8TempSensor'];

  if ($value != '' && $value != -9999)
  {
    discover_sensor($valid['sensor'], 'temperature', $device, $oid, 'epc8TempSensor.'.$index, 'epc8x', $descr, 10, 1, NULL, NULL, NULL, NULL, $value / 10);
  }

  $oid   = ".1.3.6.1.4.1.28507.1.1.3.2.1.3.$index";
  $descr = "Hygro Sensor $index";
  $value = $entry['epc8HygroSensor'];

  if ($value != '' && $value != -9999)
  {
    discover_sensor($valid['sensor'], 'humidity', $device, $oid, 'epc8HygroSensor.'.$index, 'epc8x', $descr, 10, 1, NULL, NULL, NULL, NULL, $value / 10);
  }
}

// GUDEADS-EPC8X-MIB::epc8Irms.0 = INTEGER: 3121 mA

$oid   = ".1.3.6.1.4.1.28507.1.1.3.1.0";
$descr = "Output";
$value = snmp_get($device, "epc8Irms.0","-Oqv", "GUDEADS-EPC8X-MIB", mib_dirs('gude'));

if ($value != '' && $value != -9999)
{
  discover_sensor($valid['sensor'], 'current', $device, $oid, 'epc8Irms.0', 'epc8x', $descr, 1000, 1, NULL, NULL, NULL, NULL, $value / 1000);
}

// EOF
