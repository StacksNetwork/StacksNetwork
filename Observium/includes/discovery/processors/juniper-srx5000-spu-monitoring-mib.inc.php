<?php

echo(" JUNIPER-SRX5000-SPU-MONITORING-MIB ");

$srx_spu_array = snmpwalk_cache_multi_oid($device, "jnxJsSPUMonitoringNodeDescr", $srx_spu_array, "JUNIPER-SRX5000-SPU-MONITORING-MIB", mib_dirs('junos'));
$srx_spu_array = snmpwalk_cache_multi_oid($device, "jnxJsSPUMonitoringFPCIndex", $srx_spu_array, "JUNIPER-SRX5000-SPU-MONITORING-MIB", mib_dirs('junos'));
$srx_spu_array = snmpwalk_cache_multi_oid($device, "jnxJsSPUMonitoringCPUUsage", $srx_spu_array, "JUNIPER-SRX5000-SPU-MONITORING-MIB", mib_dirs('junos'));

if ($debug) { print_vars($processors_array); }

if (is_array($srx_spu_array))
{
  foreach ($srx_spu_array as $index => $entry)
  {
    if ($index)
    {
      $usage_oid = ".1.3.6.1.4.1.2636.3.39.1.12.1.1.1.4." . $index; // node0 FPC: SRX3k SPC
      $descr = $entry['jnxJsSPUMonitoringNodeDescr'] . ' SPC slot ' .  $entry['jnxJsSPUMonitoringFPCIndex'];
      $usage = $entry['jnxJsSPUMonitoringCPUUsage'];

      discover_processor($valid['processor'], $device, $usage_oid, $index, "junos", $descr, "1", $usage, NULL, NULL);
    }
  }
}

unset ($srx_spu_array);

// EOF
