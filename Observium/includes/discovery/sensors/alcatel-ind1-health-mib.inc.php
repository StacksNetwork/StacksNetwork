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

echo(" ALCATEL-IND1-HEALTH-MIB ");

$descr = "Chassis Temperature";
$oid   = ".1.3.6.1.4.1.6486.800.1.2.1.16.1.1.1.17.0";
$value = snmp_get($device, $oid, "-Oqv");

if (is_numeric($value) && $value > 0)
{
  discover_sensor($valid['sensor'], 'temperature', $device, $oid, 1, 'alcatel-device', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
}

// EOF
