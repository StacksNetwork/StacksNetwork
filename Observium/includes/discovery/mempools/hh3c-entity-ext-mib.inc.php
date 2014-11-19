<?php

// HH3C-ENTITY-EXT-MIB::hh3cEntityExtMemUsage.30 = INTEGER: 58
// HH3C-ENTITY-EXT-MIB::hh3cEntityExtMemUsage.36 = INTEGER: 59
// HH3C-ENTITY-EXT-MIB::hh3cEntityExtMemUsage.42 = INTEGER: 58
// HH3C-ENTITY-EXT-MIB::hh3cEntityExtMemUsage.48 = INTEGER: 58

$mib = 'HH3C-ENTITY-EXT-MIB';
echo(" $mib ");

$mempool_array = snmpwalk_cache_oid($device, "hh3cEntityExtMemUsage", NULL, $mib, mib_dirs('hh3c'));

if (is_array($mempool_array))
{
  $chassis_count = 0;
  $mempool_array = snmpwalk_cache_oid($device, "hh3cEntityExtMemSize", $mempool_array, $mib, mib_dirs('hh3c'));
  foreach ($mempool_array as $index => $entry)
  {
    if (is_numeric($entry['hh3cEntityExtMemUsage']) && $entry['hh3cEntityExtMemSize'] > 0)
    {
      $chassis_count++;
      $descr   = "Memory - Chassis #" . $chassis_count;
      $percent = $entry['hh3cEntityExtMemUsage'];
      $total   = $entry['hh3cEntityExtMemSize'];
      $used    = $total * $percent / 100;
      discover_mempool($valid['mempool'], $device, $index, $mib, $descr, 1, $total, $used);
    }
  }
}
unset ($mempool_array, $index, $descr, $total, $used, $chassis_count, $percent);

// EOF
