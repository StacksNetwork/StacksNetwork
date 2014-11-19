<?php

$mib = 'HUAWEI-ENTITY-EXTENT-MIB';

$cache_mempool = snmpwalk_cache_multi_oid($device, 'hwEntityMemUsage', $cache_mempool, $mib, mib_dirs('huawei'));
$cache_mempool = snmpwalk_cache_multi_oid($device, 'hwEntityMemSize',  $cache_mempool, $mib, mib_dirs('huawei'));

$index            = $mempool['mempool_index'];
$mempool['total'] = $cache_mempool[$index]['hwEntityMemSize'];
$mempool['perc']  = $cache_mempool[$index]['hwEntityMemUsage'];

// EOF
