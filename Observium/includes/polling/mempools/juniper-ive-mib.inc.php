<?php

$mib = 'JUNIPER-IVE-MIB';

$mempool['perc'] = snmp_get($device, "iveMemoryUtil.0", "-OvQ", $mib, mib_dirs('juniper'));

// EOF
