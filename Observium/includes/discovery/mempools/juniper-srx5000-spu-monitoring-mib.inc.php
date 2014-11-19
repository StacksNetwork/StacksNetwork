<?php

$mib = 'JUNIPER-SRX5000-SPU-MONITORING-MIB';
echo(" $mib ");

$mempool_array = snmpwalk_cache_multi_oid($device, "jnxJsSPUMonitoringMemoryUsage", NULL, $mib, mib_dirs('junos'));

if (is_array($mempool_array))
{
  $mempool_array = snmpwalk_cache_multi_oid($device, "jnxJsSPUMonitoringNodeDescr", $mempool_array, $mib, mib_dirs('junos'));
  foreach ($mempool_array as $index => $entry)
  {
    if (is_numeric($entry['jnxJsSPUMonitoringMemoryUsage']))
    {
      $descr   = "Memory ".$entry['jnxJsSPUMonitoringNodeDescr'];
      $percent = $entry['jnxJsSPUMonitoringMemoryUsage'];
      discover_mempool($valid['mempool'], $device, $index, $mib, $descr, 1, 100, $percent);
    }
  }
}
unset ($mempool_array, $index, $descr, $percent);

// EOF
