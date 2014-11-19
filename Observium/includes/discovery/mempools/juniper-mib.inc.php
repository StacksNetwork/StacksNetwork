<?php

$mib = 'JUNIPER-MIB';
echo(" $mib ");

$mempool_array = snmpwalk_cache_multi_oid($device, "jnxOperatingBuffer", NULL, $mib, mib_dirs('junos'));

if (is_array($mempool_array))
{
  $mempool_array = snmpwalk_cache_multi_oid($device, "jnxOperatingMemory",   $mempool_array, $mib, mib_dirs('junos'));
  $mempool_array = snmpwalk_cache_multi_oid($device, "jnxOperatingDRAMSize", $mempool_array, $mib, mib_dirs('junos'));
  $mempool_array = snmpwalk_cache_multi_oid($device, "jnxOperatingDescr",    $mempool_array, $mib, mib_dirs('junos'));
  foreach ($mempool_array as $index => $entry)
  {
    $descr = $entry['jnxOperatingDescr'];
    if (stripos($descr, "sensor") !== FALSE || stripos($descr, "fan")  !== FALSE) { continue; }
    if ($entry['jnxOperatingDRAMSize'])
    {
      $precision = 1;
      $total     = $entry['jnxOperatingDRAMSize'];            // Size in bytes
    }
    elseif ($entry['jnxOperatingMemory'])
    {
      $precision = 1024 * 1024;
      $total     = $entry['jnxOperatingMemory'] * $precision; // Size in megabytes
    } else {
      continue;
    }
    $percent = $entry['jnxOperatingBuffer'];
    $used    = $total * $percent / 100;
    if (!strstr($descr, "No") && !strstr($percent, "No") && $descr != "")
    {
      discover_mempool($valid['mempool'], $device, $index, $mib, $descr, $precision, $total, $used);
    }
  }
}
unset ($mempool_array, $index, $descr, $precision, $total, $used, $percent);

// EOF
