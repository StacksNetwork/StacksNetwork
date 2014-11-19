<?php

$mib = 'FORTINET-FORTIGATE-MIB';

$mempool['perc']  = snmp_get($device, "fgSysMemUsage.0",    "-OvQ", $mib, mib_dirs('fortinet'));
$mempool['total'] = snmp_get($device, "fgSysMemCapacity.0", "-OvQ", $mib, mib_dirs('fortinet'));

// EOF
