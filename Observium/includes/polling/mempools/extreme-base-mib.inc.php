<?php

$mib = 'EXTREME-BASE-MIB';

$cache_mempool = snmpwalk_cache_multi_oid($device, 'extremeMemoryMonitorSystemTotal', $cache_mempool, $mib, mib_dirs('extreme'));
$cache_mempool = snmpwalk_cache_multi_oid($device, 'extremeMemoryMonitorSystemFree',  $cache_mempool, $mib, mib_dirs('extreme'));

$index            = $mempool['mempool_index'];
$mempool['free']  = $cache_mempool[$index]['extremeMemoryMonitorSystemFree'];
$mempool['total'] = $cache_mempool[$index]['extremeMemoryMonitorSystemTotal'];
$mempool['used']  = $mempool['total'] - $mempool['free'];

// EOF
