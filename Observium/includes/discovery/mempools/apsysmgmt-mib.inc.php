<?php

$mib = 'APSYSMGMT-MIB';
echo(" $mib ");

// APSYSMGMT-MIB not have information about total memory size.
$percent = snmp_get($device, "apSysMemoryUtil.0", "-OvQ", $mib, mib_dirs('acme'));

if (is_numeric($percent))
{
  discover_mempool($valid['mempool'], $device, 0, $mib, "Memory", 1, 100, $percent);
}
unset ($percent);

// EOF
