<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage poller
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

# Try multiple ways of getting firmware version
$version = snmp_get($device, "SNMPv2-SMI::enterprises.2272.1.1.7.0", "-Oqvn");
$version = explode(" on", $version);
$version = $version[0];

if ($version == "") {
  $version = snmp_get($device, "SNMPv2-SMI::enterprises.45.1.6.4.2.1.10.0", "-Oqvn");
  if ($version == "") {
    $version = "Unknown Version";
  }
}

# Get hardware details
$sysDescr = snmp_get($device, "SNMPv2-MIB::sysDescr.0", "-Oqvn");

$details = explode("  ", $sysDescr);
$details = str_replace("ERS-", "Ethernet Routing Switch ", $details);

$hardware = explode(" (", $details[0]);
$hardware = $hardware[0];

# Is this a 5500 series or 5600 series stack?
$features = "";

$stack = snmp_walk($device, "SNMPv2-SMI::enterprises.45.1.6.3.3.1.1.6.8", "-OsqnU");
$stack = explode("\n", $stack);
$stack_size = count($stack);
if ($stack_size > 1) {
  $features = "Stack of $stack_size units";
}

$version = str_replace("\"","", $version);
$features = str_replace("\"","", $features);
$hardware = str_replace("\"","", $hardware);

// EOF
