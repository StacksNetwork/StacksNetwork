<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage discovery
 * @copyright  (C) 2006-2015 Adam Armstrong
 *
 */

echo(" JUNIPER-MIB ");
$processors_array = snmpwalk_cache_multi_oid($device, "jnxOperatingCPU",      $processors_array, "JUNIPER-MIB", mib_dirs('junos'));
$processors_array = snmpwalk_cache_multi_oid($device, "jnxOperatingDRAMSize", $processors_array, "JUNIPER-MIB", mib_dirs('junos'));
$processors_array = snmpwalk_cache_multi_oid($device, "jnxOperatingMemory",   $processors_array, "JUNIPER-MIB", mib_dirs('junos'));
$processors_array = snmpwalk_cache_multi_oid($device, "jnxOperatingDescr",    $processors_array, "JUNIPER-MIB", mib_dirs('junos'));
if (OBS_DEBUG > 1) { print_vars($processors_array); }

if (is_array($processors_array))
{
  foreach ($processors_array as $index => $entry)
  {
    if (strlen(strstr($entry['jnxOperatingDescr'], "Routing Engine")) || $entry['jnxOperatingDRAMSize'] && !strpos($entry['jnxOperatingDescr'], "sensor") && !strstr($entry['jnxOperatingDescr'], "fan"))
    {
      if (stripos($entry['jnxOperatingDescr'], "sensor") || stripos($entry['jnxOperatingDescr'], "fan")) continue;

      $usage_oid = ".1.3.6.1.4.1.2636.3.1.13.1.8." . $index;
      $descr = $entry['jnxOperatingDescr'];
      $usage = $entry['jnxOperatingCPU'];
      if (!strstr($descr, "No") && !strstr($usage, "No") && $descr != "")
      {
        discover_processor($valid['processor'], $device, $usage_oid, $index, "junos", $descr, "1", $usage, NULL, NULL);
      }
    } // End if checks
  } // End Foreach
} // End if array

unset ($processors_array);

// EOF
