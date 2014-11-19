<?php

$mib = 'ASYNCOS-MAIL-MIB';

$mempool['perc'] = snmp_get($device, "perCentMemoryUtilization.0", "-OvQ", $mib, mib_dirs('cisco'));

// EOF
