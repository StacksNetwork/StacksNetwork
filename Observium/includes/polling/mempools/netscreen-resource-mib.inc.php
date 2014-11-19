<?php

$mempool['used']  = snmp_get($device, "nsResMemAllocate.0", "-OvQ", $mib, mib_dirs('netscreen'));
$mempool['free']  = snmp_get($device, "nsResMemLeft.0",     "-OvQ", $mib, mib_dirs('netscreen'));
$mempool['total'] = $mempool['used'] + $mempool['free'];

// EOF
