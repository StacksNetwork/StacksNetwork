<?php

$mib = 'APSYSMGMT-MIB';

$mempool['perc'] = snmp_get($device, "apSysMemoryUtil.0", "-OvQ", $mib, mib_dirs('acme'));

// EOF
