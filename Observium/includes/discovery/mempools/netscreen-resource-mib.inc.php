<?php

$mib = 'NETSCREEN-RESOURCE-MIB';
echo(" $mib ");

$used = snmp_get($device, "nsResMemAllocate.0", "-OvQ", $mib, mib_dirs('netscreen'));
$free = snmp_get($device, "nsResMemLeft.0",     "-OvQ", $mib, mib_dirs('netscreen'));

if (is_numeric($free) && is_numeric($used))
{
  $total = $free + $used;
  discover_mempool($valid['mempool'], $device, 0, $mib, "Memory", 1, $total, $used);
}
unset ($total, $used, $free);

// EOF
