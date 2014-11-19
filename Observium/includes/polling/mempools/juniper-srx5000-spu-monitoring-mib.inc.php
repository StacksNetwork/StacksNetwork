<?php

$mib = 'JUNIPER-SRX5000-SPU-MONITORING-MIB';

$cache_mempool = snmpwalk_cache_multi_oid($device, 'jnxJsSPUMonitoringMemoryUsage', $cache_mempool, $mib, mib_dirs('junos'));

$mempool['perc'] = $cache_mempool[$index]['jnxJsSPUMonitoringMemoryUsage'];

// EOF
