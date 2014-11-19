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

# If only there was a valid (syntactically correct) MIB (and not one per controller sharing OIDs!)...
# This file would have been a lot cleaner, walking a complete sensor table, and picking values...

echo(" ARECA-SNMP-MIB ");

$type = 'areca';

$oids = snmp_walk($device, "1.3.6.1.4.1.18928.1.2.2.1.9.1.2", "-OsqnU", "");
if ($debug) { echo($oids."\n"); }
if ($oids) echo("Areca ");
foreach (explode("\n", $oids) as $data)
{
  $data = trim($data);
  if ($data)
  {
    list($oid,$descr) = explode(" ", $data,2);
    $split_oid = explode('.',$oid);
    $index = $split_oid[count($split_oid)-1];
    $oid  = "1.3.6.1.4.1.18928.1.2.2.1.9.1.3." . $index;
    $current = snmp_get($device, $oid, "-Oqv", "");

    discover_sensor($valid['sensor'], 'fanspeed', $device, $oid, $index, $type, trim($descr,'"'), 1, 1, NULL, NULL, NULL, NULL, $current);
  }
}

$oids = snmp_walk($device, "1.3.6.1.4.1.18928.1.1.2.14.1.2", "-Osqn", "");
if ($debug) { echo($oids."\n"); }
$oids = trim($oids);
if ($oids) echo("Areca Harddisk ");
foreach (explode("\n", $oids) as $data)
{
  $data = trim($data);
  if ($data)
  {
    list($oid,$descr) = explode(" ", $data,2);
    $split_oid = explode('.',$oid);
    $temperature_id = $split_oid[count($split_oid)-1];
    $temperature_oid  = "1.3.6.1.4.1.18928.1.1.2.14.1.2.$temperature_id";
    $temperature  = snmp_get($device, $temperature_oid, "-Oqv", "");
    $descr = "Hard disk $temperature_id";
    if ($temperature != -128) # -128 = not measured/present
    {
      discover_sensor($valid['sensor'], 'temperature', $device, $temperature_oid, zeropad($temperature_id), $type, $descr, 1, 1, NULL, NULL, NULL, NULL, $temperature);
    }
  }
}

$oids = snmp_walk($device, "1.3.6.1.4.1.18928.1.2.2.1.10.1.2", "-OsqnU", "");
if ($debug) { echo($oids."\n"); }
if ($oids) echo("Areca Controller ");
$precision = 1;
foreach (explode("\n", $oids) as $data)
{
  $data = trim($data);
  if ($data)
  {
    list($oid,$descr) = explode(" ", $data,2);
    $split_oid = explode('.',$oid);
    $index = $split_oid[count($split_oid)-1];
    $oid  = "1.3.6.1.4.1.18928.1.2.2.1.10.1.3." . $index;
    $current = snmp_get($device, $oid, "-Oqv", "");

    discover_sensor($valid['sensor'], 'temperature', $device, $oid, $index, $type, trim($descr,'"'), 1, 1, NULL, NULL, NULL, NULL, $current);
  }
}

$oids = snmp_walk($device, "1.3.6.1.4.1.18928.1.2.2.1.8.1.2", "-OsqnU", "");
if ($debug) { echo($oids."\n"); }
if ($oids) echo("Areca ");
foreach (explode("\n", $oids) as $data)
{
  $data = trim($data);
  if ($data)
  {
    list($oid,$descr) = explode(" ", $data,2);
    $split_oid = explode('.',$oid);
    $index = $split_oid[count($split_oid)-1];
    $oid  = "1.3.6.1.4.1.18928.1.2.2.1.8.1.3." . $index;
    $current = snmp_get($device, $oid, "-Oqv", "");
    if (trim($descr,'"') == 'Battery Status') # Battery Status is charge percentage, or 255 when no BBU
    {
      if ($current != 255)
      {
        discover_sensor($valid['sensor'], 'capacity', $device, $oid, $index, $type, trim($descr,'"'), 1, 1, NULL, NULL, NULL, NULL, $current);
      }
    } else { # Not a battery
      discover_sensor($valid['sensor'], 'voltage', $device, $oid, $index, $type, trim($descr,'"'), 1000, 1, NULL, NULL, NULL, NULL, $current / 1000);
    }
  }
}

// EOF
