<?php

//  Hardcoded discovery of cpu usage on RADLAN devices.

echo(" RADLAN-rndMng ");

$descr = "Processor";
$usage = snmp_get($device, ".1.3.6.1.4.1.89.1.9.0", "-OQUvs", "RADLAN-rndMng", mib_dirs('dell'));

if (is_numeric($usage))
{
  discover_processor($valid['processor'], $device, ".1.3.6.1.4.1.89.1.9.0", 0, "radlan", $descr, 1, $usage, NULL, NULL);
}

// EOF
