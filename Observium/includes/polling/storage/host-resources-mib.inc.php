<?php

// HOST-RESOURCES-MIB

if (!is_array($cache_storage['host-resources-mib']))
{
  $cache_storage['host-resources-mib'] = snmpwalk_cache_oid($device, "hrStorageEntry", NULL, "HOST-RESOURCES-MIB", mib_dirs());
  if ($debug && count($cache_storage['host-resources-mib'])) { print_vars($cache_storage['host-resources-mib']); }
}

$entry = $cache_storage['host-resources-mib'][$storage['storage_index']];

$storage['units'] = $entry['hrStorageAllocationUnits'];
$storage['used']  = snmp_dewrap32bit($entry['hrStorageUsed']) * $storage['units'];
$storage['size']  = snmp_dewrap32bit($entry['hrStorageSize']) * $storage['units'];

$storage['free']  = $storage['size'] - $storage['used'];

// EOF
