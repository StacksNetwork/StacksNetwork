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

// MS-SWITCH30-MIB::agentFirmware.0 = STRING: 5331V8.4.8.p
$version = trim(snmp_get($device, "agentFirmware.0", "-Ovq", "MS-SWITCH30-MIB"), '"');

// MS-SWITCH30-MIB::deviceArtNo = STRING: "MS450860M-G5"
$hardware = strstr(trim(snmp_get($device, "deviceArtNo.0", "-Ovq", "MS-SWITCH30-MIB"), '"'),'STRING: ');

// MS-SWITCH30-MIB::deviceSerNo.0 = STRING: "001146758"
$serial = trim(snmp_get($device, "deviceSerNo.0", "-Ovq", "MS-SWITCH30-MIB"), '"');

// EOF
