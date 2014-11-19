<?php

$mib = 'FROGFOOT-RESOURCES-MIB';

$mempool['total'] = snmp_get($device, "memTotal.0", "-OvQ", $mib, mib_dirs('ubiquiti'));
$mempool['free']  = snmp_get($device, "memFree.0", "-OvQ", $mib, mib_dirs('ubiquiti'));
$mempool['used']  = $mempool['total'] - $mempool['free'];

// EOF
