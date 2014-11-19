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

echo(" CAREL-ug40cdz-MIB ");

$humidities = array(
  array("mib" => "CAREL-ug40cdz-MIB::roomRH.0",     "descr" => "Room Relative Humidity",             "oid" => ".1.3.6.1.4.1.9839.2.1.2.6.0",  "precision" => "10"),
  array("mib" => "CAREL-ug40cdz-MIB::dehumPband.0", "descr" => "Dehumidification Prop. Band",        "oid" => ".1.3.6.1.4.1.9839.2.1.3.12.0", "precision" => "1"),
  array("mib" => "CAREL-ug40cdz-MIB::humidPband.0", "descr" => "Humidification Prop. Band",          "oid" => ".1.3.6.1.4.1.9839.2.1.3.13.0", "precision" => "1"),
  array("mib" => "CAREL-ug40cdz-MIB::dehumSetp.0",  "descr" => "Dehumidification Set Point",         "oid" => ".1.3.6.1.4.1.9839.2.1.3.16.0", "precision" => "1"),
  array("mib" => "CAREL-ug40cdz-MIB::humidSetp.0",  "descr" => "Humidification Set Point",           "oid" => ".1.3.6.1.4.1.9839.2.1.3.17.0", "precision" => "1"),
);

$temperatures = array(
  array("mib" => "CAREL-ug40cdz-MIB::roomTemp.0",     "descr" => "Room Temperature",                 "oid" => ".1.3.6.1.4.1.9839.2.1.2.1.0",  "precision" => "10"),
  array("mib" => "CAREL-ug40cdz-MIB::outdoorTemp.0",  "descr" => "Ambient Temperature",              "oid" => ".1.3.6.1.4.1.9839.2.1.2.2.0",  "precision" => "10"),
  array("mib" => "CAREL-ug40cdz-MIB::deliveryTemp.0", "descr" => "Delivery Air Temperature",         "oid" => ".1.3.6.1.4.1.9839.2.1.2.3.0",  "precision" => "10"),
  array("mib" => "CAREL-ug40cdz-MIB::cwTemp.0",       "descr" => "Chilled Water Temperature",        "oid" => ".1.3.6.1.4.1.9839.2.1.2.4.0",  "precision" => "10"),
  array("mib" => "CAREL-ug40cdz-MIB::hwTemp.0",       "descr" => "Hot Water Temperature",            "oid" => ".1.3.6.1.4.1.9839.2.1.2.5.0",  "precision" => "10"),
  array("mib" => "CAREL-ug40cdz-MIB::cwoTemp.0",      "descr" => "Chilled Water Outlet Temperature", "oid" => ".1.3.6.1.4.1.9839.2.1.2.7.0",  "precision" => "10"),
  array("mib" => "CAREL-ug40cdz-MIB::suctTemp1.0",    "descr" => "Circuit 1 Suction Temperature",    "oid" => ".1.3.6.1.4.1.9839.2.1.2.10.0", "precision" => "10"),
  array("mib" => "CAREL-ug40cdz-MIB::suctTemp2.0",    "descr" => "Circuit 2 Suction Temperature",    "oid" => ".1.3.6.1.4.1.9839.2.1.2.11.0", "precision" => "10"),
  array("mib" => "CAREL-ug40cdz-MIB::evapTemp1.0",    "descr" => "Circuit 1 Evap. Temperature",      "oid" => ".1.3.6.1.4.1.9839.2.1.2.12.0", "precision" => "10"),
  array("mib" => "CAREL-ug40cdz-MIB::evapTemp2.0",    "descr" => "Circuit 2 Evap. Temperature",      "oid" => ".1.3.6.1.4.1.9839.2.1.2.13.0", "precision" => "10"),
  array("mib" => "CAREL-ug40cdz-MIB::ssh1.0",         "descr" => "Circuit 1 Superheat",              "oid" => ".1.3.6.1.4.1.9839.2.1.2.14.0", "precision" => "10"),
  array("mib" => "CAREL-ug40cdz-MIB::ssh2.0",         "descr" => "Circuit 2 Superheat",              "oid" => ".1.3.6.1.4.1.9839.2.1.2.15.0", "precision" => "10"),
  array("mib" => "CAREL-ug40cdz-MIB::coolSetP.0",     "descr" => "Cooling Set Point",                "oid" => ".1.3.6.1.4.1.9839.2.1.2.20.0", "precision" => "10"),
  array("mib" => "CAREL-ug40cdz-MIB::coolDiff.0",     "descr" => "Cooling Prop. Band",               "oid" => ".1.3.6.1.4.1.9839.2.1.2.21.0", "precision" => "10"),
  array("mib" => "CAREL-ug40cdz-MIB::cool2SetP.0",    "descr" => "Cooling 2nd Set Point",            "oid" => ".1.3.6.1.4.1.9839.2.1.2.22.0", "precision" => "10"),
  array("mib" => "CAREL-ug40cdz-MIB::heatSetP.0",     "descr" => "Heating Set Point",                "oid" => ".1.3.6.1.4.1.9839.2.1.2.23.0", "precision" => "10"),
  array("mib" => "CAREL-ug40cdz-MIB::heatDiff.0",     "descr" => "Heating Prop. Band",               "oid" => ".1.3.6.1.4.1.9839.2.1.2.25.0", "precision" => "10"),
  array("mib" => "CAREL-ug40cdz-MIB::heat2SetP.0",    "descr" => "Heating 2nd Set Point",            "oid" => ".1.3.6.1.4.1.9839.2.1.2.24.0", "precision" => "10"),
);

foreach ($humidities as $humidity)
{
  $current = snmp_get($device, $humidity['mib'], "-OqvU") / $humidity['precision'];

  $high_limit = NULL;
  $low_limit = NULL;

  if (is_numeric($current) && $current != 0)
  {
    $index = implode(".",array_slice(explode(".",$humidity['oid']),-5));
    discover_sensor($valid['sensor'], 'humidity', $device, $humidity['oid'], $index, 'pcoweb', $humidity['descr'], $humidity['precision'], '1', $low_limit, NULL, NULL, $high_limit, $current);
  }
}

/*
FIXME

hhAlarmThrsh.0 = INTEGER: 80 rH%
lhAlarmThrsh.0 = INTEGER: 30 rH%
smDehumSetp.0 = INTEGER: 75 rH%
smHumidSetp.0 = INTEGER: 35 rH%
*/

foreach ($temperatures as $temperature)
{
  $current = snmp_get($device, $temperature['mib'], "-OqvU") / $temperature['precision'];

  $high_limit = NULL;
  $low_limit = NULL;

  if (is_numeric($current) && $current != 0)
  {
    $index = implode(".",array_slice(explode(".",$temperature['oid']),-5));
    discover_sensor($valid['sensor'], 'temperature', $device, $temperature['oid'], $index, 'pcoweb', $temperature['descr'], $temperature['precision'], '1', $low_limit, NULL, NULL, $high_limit, $current);
  }
}

/*
FIXME

thrsHT.0 = INTEGER: 30 degrees C x10
thrsLT.0 = INTEGER: 10 degrees C x10
smCoolSetp.0 = INTEGER: 280 degrees C
smHeatSetp.0 = INTEGER: 160 degrees C
cwDehumSetp.0 = INTEGER: 70 degrees C
cwHtThrsh.0 = INTEGER: 150 degrees C
cwModeSetp.0 = INTEGER: 70 degrees C
radcoolSpES.0 = INTEGER: 80 degrees C
radcoolSpDX.0 = INTEGER: 280 degrees C
delTempLimit.0 = INTEGER: 14 degrees C x10
dtAutChgMLT.0 = INTEGER: 20 degrees C
*/

// EOF
