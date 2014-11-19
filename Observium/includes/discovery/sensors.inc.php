<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage discovery
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

$valid['sensor'] = array();

echo("Sensors: ");

$include_dir = "includes/discovery/sensors";
include("includes/include-dir-mib.inc.php");

// Always include ENTITY-SENSOR-MIB
// Do this after the above include, as it checks for duplicates from CISCO-ENTITY-SENSOR-MIB
include("includes/discovery/senors/entity-sensor-mib.inc.php");

foreach (array_keys($config['sensor_types']) as $type)
{
  if ($debug) { print_vars($valid['sensor'][$type]); }
  check_valid_sensors($device, $type, $valid['sensor']);
}

echo(PHP_EOL);

// EOF
