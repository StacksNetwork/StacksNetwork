<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage discovery
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

echo(" S5-CHASSIS-MIB ");

# Processor information only know to work with 5500 and 5600 switches
if (preg_match("/5[56][0-9][0-9]/", $device["sysDescr"]))
{
  $procs = snmp_walk($device, ".1.3.6.1.4.1.45.1.6.3.8.1.1.6", "-Osqn");

  foreach (explode("\n", $procs) as $i => $t) {
    $t = explode(" ",$t);
    $oid = $t[0];
    $val = $t[1];
    discover_processor($valid['processor'], $device, $oid, zeropad($i+1), "avaya-ers", "Unit " . ($i+1) . " processor", "1", $val, $i, NULL);
  }
}

// EOF
