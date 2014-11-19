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

// SNMPv2-SMI::enterprises.8741.2.1.1.1.0 = STRING: "NSA 2400"
// SNMPv2-SMI::enterprises.8741.2.1.1.2.0 = STRING: "0017C599BD08"
// SNMPv2-SMI::enterprises.8741.2.1.1.3.0 = STRING: "SonicOS Enhanced 5.8.1.7-4o"
// SNMPv2-SMI::enterprises.8741.2.1.1.4.0 = STRING: "5.0.3.3"

// SNMPv2-SMI::enterprises.8741.2.1.1.1.0 = STRING: "TZ 210"
// SNMPv2-SMI::enterprises.8741.2.1.1.2.0 = STRING: "0017C568903C"
// SNMPv2-SMI::enterprises.8741.2.1.1.3.0 = STRING: "SonicOS Enhanced 5.6.0.11-61o"
// SNMPv2-SMI::enterprises.8741.2.1.1.4.0 = STRING: "5.0.2.11"

$hardware = trim(snmp_get($device, ".1.3.6.1.4.1.8741.2.1.1.1.0", "-OQv", "", ""),'" ');
$serial = trim(snmp_get($device, ".1.3.6.1.4.1.8741.2.1.1.2.0", "-OQv", "", ""),'" ');
$fwversion = trim(snmp_get($device, ".1.3.6.1.4.1.8741.2.1.1.3.0", "-OQv", "", ""),'" ');
$romversion = trim(snmp_get($device, ".1.3.6.1.4.1.8741.2.1.1.4.0", "-OQv", "", ""),'" ');
$version = "(Firmware $fwversion / ROM $romversion)";

// EOF
