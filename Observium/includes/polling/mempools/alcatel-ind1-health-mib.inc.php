<?php

#ALCATEL-IND1-SYSTEM-MIB::systemHardwareMemoryMfg.0 = INTEGER: notreadable(12)
#ALCATEL-IND1-SYSTEM-MIB::systemHardwareMemorySize.0 = Gauge32: 268435456
#ALCATEL-IND1-HEALTH-MIB::healthDeviceMemoryLatest.0 = INTEGER: 74
#ALCATEL-IND1-HEALTH-MIB::healthDeviceMemory1MinAvg.0 = INTEGER: 74
#ALCATEL-IND1-HEALTH-MIB::healthDeviceMemory1HrAvg.0 = INTEGER: 74
#ALCATEL-IND1-HEALTH-MIB::healthDeviceMemory1HrMax.0 = INTEGER: 74

$mib = 'ALCATEL-IND1-HEALTH-MIB';

$mempool['total'] = snmp_get($device, "systemHardwareMemorySize.0", "-OvQ", "ALCATEL-IND1-SYSTEM-MIB", mib_dirs('aos'));
$mempool['perc']  = snmp_get($device, "healthDeviceMemoryLatest.0", "-OvQ", $mib, mib_dirs('aos'));

// EOF
