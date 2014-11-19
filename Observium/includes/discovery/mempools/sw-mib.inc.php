<?php

$mib = 'SW-MIB';
echo(" $mib ");

// Hardcoded for VDX switches that has 2GB of RAM includes all the current models.
$total   = 2147483648;
$percent = snmp_get($device, ".1.3.6.1.4.1.1588.2.1.1.1.26.6.0", "-Ovq", $mib, mib_dirs());
$used    = $total * $percent / 100;

if (is_numeric($percent))
{
  discover_mempool($valid['mempool'], $device, 0, $mib, "Memory", 1, $total, $used);
}
unset ($total, $used, $percent);

// EOF
