<?php

$mib = 'SW-MIB';

$mempool['total'] = 2147483648;
$mempool['perc']  = snmp_get($device, ".1.3.6.1.4.1.1588.2.1.1.1.26.6.0", "-Ovq", $mib, mib_dirs());

// EOF
