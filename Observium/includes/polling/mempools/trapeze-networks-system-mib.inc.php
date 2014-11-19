<?php

$mib = 'TRAPEZE-NETWORKS-SYSTEM-MIB';

$mempool['used']  = snmp_get($device, "trpzSysCpuMemoryLast5MinutesUsage.0", "-OQUvs", $mib, mib_dirs('trapeze'));
$mempool['total'] = snmp_get($device, "trpzSysCpuMemorySize.0",              "-OQUvs", $mib, mib_dirs('trapeze'));

// EOF
