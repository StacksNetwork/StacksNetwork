<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage discovery
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

$mib = 'DNOS-SWITCHING-MIB';
echo(" $mib ");

// CPU Memory
// 
// agentSwitchCpuProcessMemFree.0 = INTEGER: 343320
// agentSwitchCpuProcessMemAvailable.0 = INTEGER: 1034740

$free  = snmp_get($device, 'agentSwitchCpuProcessMemFree.0',      '-OUvq', $mib);
$total = snmp_get($device, 'agentSwitchCpuProcessMemAvailable.0', '-OUvq', $mib);
$used  = $total - $free;

if (is_numeric($free))
{
  discover_mempool($valid['mempool'], $device, 0, $mib, 'CPU Memory', 1024, $total, $used);
}
unset ($total, $used, $free);

// EOF
