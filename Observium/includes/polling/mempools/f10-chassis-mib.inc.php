<?php

$mib = 'F10-CHASSIS-MIB';

$cache_mempool = snmpwalk_cache_multi_oid($device, 'chRpmMemUsageUtil',     $cache_mempool, $mib, mib_dirs('force10'));
$cache_mempool = snmpwalk_cache_multi_oid($device, 'chSysProcessorMemSize', $cache_mempool, $mib, mib_dirs('force10'));

$index            = $mempool['mempool_index'];
$mempool['total'] = $cache_mempool[$index]['chSysProcessorMemSize'];
$mempool['perc']  = $cache_mempool[$index]['chRpmMemUsageUtil'];

// EOF
