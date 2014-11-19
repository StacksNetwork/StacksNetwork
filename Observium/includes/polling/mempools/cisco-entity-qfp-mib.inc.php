<?php

$mib = 'CISCO-ENTITY-QFP-MIB';

$cache_mempool = snmpwalk_cache_multi_oid($device, 'ceqfpMemoryResTotal', $cache_mempool, $mib, mib_dirs('cisco'));
$cache_mempool = snmpwalk_cache_multi_oid($device, 'ceqfpMemoryResInUse', $cache_mempool, $mib, mib_dirs('cisco'));

$index            = $mempool['mempool_index'];
$mempool['used']  = $cache_mempool[$index]['ceqfpMemoryResInUse'];
$mempool['total'] = $cache_mempool[$index]['ceqfpMemoryResTotal'];

// EOF
