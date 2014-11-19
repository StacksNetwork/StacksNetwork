<?php

//  TRAPEZE-NETWORKS-SYSTEM-MIB::trpzSysCpuMemorySize.0
//  TRAPEZE-NETWORKS-SYSTEM-MIB::trpzSysCpuMemoryLast5MinutesUsage.0

$mib = 'TRAPEZE-NETWORKS-SYSTEM-MIB';
echo(" $mib ");

$descr  = "Memory";
$used   = snmp_get($device, "trpzSysCpuMemoryLast5MinutesUsage.0", "-OQUvs", $mib, mib_dirs('trapeze'));
$total  = snmp_get($device, "trpzSysCpuMemorySize.0",              "-OQUvs", $mib, mib_dirs('trapeze'));
$used  *= 1024;
$total *= 1024;

if (is_numeric($used) && is_numeric($total))
{
  discover_mempool($valid['mempool'], $device, 0, $mib, $descr, 1024, $total, $used);
}
unset ($descr, $total, $used);

// EOF
