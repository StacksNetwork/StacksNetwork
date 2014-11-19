<?php

$mib = 'Dell-Vendor-MIB';

$mempool['total'] = snmp_get($device, "dellLanExtension.6132.1.1.1.1.4.2.0", "-OvQ", $mib, mib_dirs('dell'));
$mempool['free']  = snmp_get($device, "dellLanExtension.6132.1.1.1.1.4.1.0", "-OvQ", $mib, mib_dirs('dell'));
$mempool['used']  = $mempool['total'] - $mempool['free'];

// EOF
