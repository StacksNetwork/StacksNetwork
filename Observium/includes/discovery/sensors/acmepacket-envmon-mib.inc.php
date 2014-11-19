<?php

echo(" ACMEPACKET-ENVMON-MIB ");

// Temperatures:
echo(" Temp ");

$oids = array();
$oids = snmpwalk_cache_multi_oid($device, "apEnvMonTemperatureStatusValue", $oids, "ACMEPACKET-ENVMON-MIB", mib_dirs('acme'));

if (is_array($oids))
{
  foreach ($oids as $index => $entry)
  {
    $descr = trim(snmp_get($device, "apEnvMonTemperatureStatusDescr.$index", "-Oqv", "ACMEPACKET-ENVMON-MIB", mib_dirs('acme')),'"');

    // remove some information from the temerature sensor description (including misspelling)
    $descr = preg_replace('/ \(degrees Cel[cs]ius\)/', '', $descr);
    $descr = preg_replace('/ Temperature/', '', $descr);
    $oid = ".1.3.6.1.4.1.9148.3.3.1.3.1.1.4.$index";
    $current = $entry['apEnvMonTemperatureStatusValue'];
    discover_sensor($valid['sensor'], 'temperature', $device, $oid, $index, 'acme-env', $descr, 1, 1, NULL, NULL, NULL, NULL, $current);
  }
}

// Voltage
echo(" Voltage ");

$oids = array();
$oids = snmpwalk_cache_multi_oid($device, "apEnvMonVoltageStatusValue", $oids, "ACMEPACKET-ENVMON-MIB", mib_dirs('acme'));

if (is_array($oids))
{
  foreach ($oids as $index => $entry)
  {
    $descr = trim(snmp_get($device, "apEnvMonVoltageStatusDescr.$index", "-Oqv", "ACMEPACKET-ENVMON-MIB", mib_dirs('acme')),'"');

    // remove some information from the voltage description
    $descr = preg_replace('/ \(millivolts\)/', '', $descr);
    $oid = ".1.3.6.1.4.1.9148.3.3.1.2.1.1.4.$index";
    $current = $entry['apEnvMonVoltageStatusValue'];
    discover_sensor($valid['sensor'], 'voltage', $device, $oid, $index, 'acme-env', $descr, 1000, 1, NULL, NULL, NULL, NULL, $current);
  }
}

// FAN:
echo(" Fan ");

$oids = array();
$oids = snmpwalk_cache_multi_oid($device, "apEnvMonFanState", $oids, "ACMEPACKET-ENVMON-MIB", mib_dirs('acme'));

if (is_array($oids))
{
  foreach ($oids as $index => $entry)
  {
    $descr = trim(snmp_get($device, "apEnvMonFanStatusDescr.$index", "-Oqv", "ACMEPACKET-ENVMON-MIB", mib_dirs('acme')),'"');

    // remove some information from the voltage description
    $descr = preg_replace('/ [Ss]peed/', '', $descr);
    $oid = ".1.3.6.1.4.1.9148.3.3.1.4.1.1.5.$index";
    $current = state_string_to_numeric('acme-env-state', $entry['apEnvMonFanState']);
    discover_sensor($valid['sensor'], 'state', $device, $oid, "apEnvMonFanState.$index", 'acme-env-state', $descr, 1, 1, NULL, NULL, NULL, NULL, $current);
  }
}

// Power
echo(" Power ");

$oids = array();
$oids = snmpwalk_cache_multi_oid($device, "apEnvMonPowerSupplyState", $oids, "ACMEPACKET-ENVMON-MIB", mib_dirs('acme'));

if (is_array($oids))
{
  foreach ($oids as $index => $entry)
  {
    $descr = trim(snmp_get($device, "apEnvMonPowerSupplyStatusDescr.$index", "-Oqv", "ACMEPACKET-ENVMON-MIB", mib_dirs('acme')),'"');
    $oid = ".1.3.6.1.4.1.9148.3.3.1.5.1.1.4.$index";
    $current = state_string_to_numeric('acme-env-state', $entry['apEnvMonPowerSupplyState']);
    discover_sensor($valid['sensor'], 'state', $device, $oid, "apEnvMonPowerSupplyState.$index", 'acme-env-state', $descr, 1, 1, NULL, NULL, NULL, NULL, $current);
  }
}

// EOF
