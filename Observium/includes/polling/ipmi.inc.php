<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage poller
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

global $debug, $ipmi_sensors;

include_once("includes/polling/functions.inc.php");

/// FIXME. From this uses only check_valid_sensors(), maybe need move to global functions or copy to polling. --mike
include_once("includes/discovery/functions.inc.php");

echo("IPMI: ");

if ($ipmi['host'] = get_dev_attrib($device,'ipmi_hostname'))
{
  $ipmi['user']      = get_dev_attrib($device,'ipmi_username');
  $ipmi['password']  = get_dev_attrib($device,'ipmi_password');
  $ipmi['port']      = get_dev_attrib($device,'ipmi_port');
  $ipmi['interface'] = get_dev_attrib($device,'ipmi_interface');

  if (!is_numeric($ipmi['port'])) { $ipmi['port'] = 623; }

  if (array_search($ipmi['interface'],array_keys($config['ipmi']['interfaces'])) === FALSE) { $ipmi['interface'] = 'lan'; } // Also triggers on empty value

  if ($config['own_hostname'] != $device['hostname'] || $ipmi['host'] != 'localhost')
  {
    $remote = " -I " . escapeshellarg($ipmi['interface']) . " -p " . $ipmi['port'] . " -H " . escapeshellarg($ipmi['host']) . " -L USER -U " . escapeshellarg($ipmi['user']) . " -P " . escapeshellarg($ipmi['password']);
  }

  $ipmi_start = utime();

  $results = external_exec($config['ipmitool'] . $remote . " sensor 2>/dev/null");

  $ipmi_end = utime(); $ipmi_time = round(($ipmi_end - $ipmi_start) * 1000);

  echo('(' . $ipmi_time . 'ms) ');

  $ipmi_sensors = parse_ipmitool_sensor($device, $results);
}

if ($debug)
{
  print_vars($ipmi_sensors);
}

foreach ($config['ipmi_unit'] as $type)
{
  check_valid_sensors($device, $type, $ipmi_sensors, 'ipmi');
}

echo("\n");

// EOF
