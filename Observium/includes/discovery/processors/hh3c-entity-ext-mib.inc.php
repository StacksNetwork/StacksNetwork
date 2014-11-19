<?php

// HH3C-ENTITY-EXT-MIB::hh3cEntityExtCpuUsage.30 = INTEGER: 16
// HH3C-ENTITY-EXT-MIB::hh3cEntityExtCpuUsage.36 = INTEGER: 5
// HH3C-ENTITY-EXT-MIB::hh3cEntityExtCpuUsage.42 = INTEGER: 5
// HH3C-ENTITY-EXT-MIB::hh3cEntityExtCpuUsage.48 = INTEGER: 12

echo(" HH3C-ENTITY-EXT-MIB ");

$chassis_count = 0;
$descr_base = "Processor - Chassis #";

$processors_array = snmpwalk_cache_oid($device, "hh3cEntityExtCpuUsage", array(), "HH3C-ENTITY-EXT-MIB", mib_dirs('hh3c'));
if ($debug) { print_vars($processors_array); }

foreach ($processors_array as $index => $entry)
{
  if ($entry['hh3cEntityExtCpuUsage'] != 0) {
    $chassis_count++;
    $oid = ".1.3.6.1.4.1.25506.2.6.1.1.1.1.6.$index";
    $descr = $descr_base . $chassis_count;
    $usage = $entry['hh3cEntityExtCpuUsage'];
    discover_processor($valid['processor'], $device, $oid, $index, "hh3c-fixed", $descr, 1, $usage, NULL, NULL);
  }
}

unset ($processors_array);

// EOF
