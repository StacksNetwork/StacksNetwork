<?php

$mib = 'ALCATEL-IND1-HEALTH-MIB';
echo(" $mib ");

$total   = snmp_get($device, "systemHardwareMemorySize.0", "-OvQ", "ALCATEL-IND1-SYSTEM-MIB", mib_dirs('aos'));
$percent = snmp_get($device, "healthDeviceMemoryLatest.0", "-OvQ", $mib, mib_dirs('aos'));
$used    = $total / 100 * $percent;

if (is_numeric($total) && is_numeric($used))
{
  discover_mempool($valid['mempool'], $device, 0, $mib, "Memory", 1, $total, $used);
}
unset ($total, $used, $percent);

// EOF
