<?php

$mib = 'FOUNDRY-SN-AGENT-MIB';

if ($mempool['mempool_hc'])
{
  $mempool['perc']  = snmp_get($device, "snAgSystemDRAMUtil.0",  "-OvQ", $mib, mib_dirs('foundry'));
  $mempool['total'] = snmp_get($device, "snAgSystemDRAMTotal.0", "-OvQ", $mib, mib_dirs('foundry'));
} else {
  $mempool['perc']  = snmp_get($device, "snAgGblDynMemUtil.0",   "-OvQ", $mib, mib_dirs('foundry'));
  $mempool['total'] = snmp_get($device, "snAgGblDynMemTotal.0",  "-OvQ", $mib, mib_dirs('foundry'));
}

// EOF
