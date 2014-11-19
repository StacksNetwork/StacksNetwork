<?php

$mib = 'FOUNDRY-SN-AGENT-MIB';
echo(" $mib ");

//snAgGblDynMemUtil OBJECT-TYPE
//        STATUS  deprecated
//        DESCRIPTION
//                "The system dynamic memory utilization, in unit of percentage.
//                Deprecated: Refer to snAgSystemDRAMUtil.
//                For NI platforms, refer to snAgentBrdMemoryUtil100thPercent"

$percent = snmp_get($device, "snAgGblDynMemUtil.0", "-OvQ", $mib, mib_dirs('foundry'));
if (is_numeric($percent))
{
  $hc = 0;
  $total   = snmp_get($device, "snAgGblDynMemTotal.0", "-OvQ", $mib, mib_dirs('foundry'));
} else {
  $hc = 1; // This is fake HC bit.
  $percent = snmp_get($device, "snAgSystemDRAMUtil.0", "-OvQ", $mib, mib_dirs('foundry'));
  $total   = snmp_get($device, "snAgSystemDRAMTotal.0", "-OvQ", $mib, mib_dirs('foundry'));
}

if (is_numeric($percent))
{
  $used = $total * $percent / 100;
  discover_mempool($valid['mempool'], $device, 0, $mib, "Memory", 1, $total, $used, $hc);
}
unset ($total, $used, $percent, $hc);

// EOF
