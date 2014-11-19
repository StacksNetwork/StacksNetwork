<?php

$mib = 'HOST-RESOURCES-MIB';

if (!is_array($cache_storage['host-resources-mib']))
{
  $cache_storage['host-resources-mib'] = snmpwalk_cache_oid($device, "hrStorageEntry", NULL, "HOST-RESOURCES-MIB:HOST-RESOURCES-TYPES", mib_dirs());
} else {
  print_debug("Cached!");
}

$index = $mempool['mempool_index'];
$entry = $cache_storage['host-resources-mib'][$index];

$mempool['mempool_precision'] = $entry['hrStorageAllocationUnits'];
$mempool['used']              = $entry['hrStorageUsed'];
$mempool['total']             = $entry['hrStorageSize'];

// EOF
