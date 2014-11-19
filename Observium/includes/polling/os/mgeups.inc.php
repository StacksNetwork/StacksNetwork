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

// MG-SNMP-UPS-MIB::upsmgIdentFamilyName.0 = STRING: "PULSAR M"
// MG-SNMP-UPS-MIB::upsmgIdentModelName.0 = STRING: "2200"
// MG-SNMP-UPS-MIB::upsmgIdentSerialNumber.0 = STRING: "AQ1H01024"

// MG-SNMP-UPS-MIB::upsmgIdentModelName.0 = STRING: "5000_60"

$version = trim(snmp_get($device, "upsmgIdentFirmwareVersion.0", "-OQv", "MG-SNMP-UPS-MIB"),'" ');

$model = trim(snmp_get($device,"upsmgIdentModelName.0","-OQv","MG-SNMP-UPS-MIB"),'" ');

// "5000_60" -> "5000 (60 kVA)"
if (strstr($model,'_')) { $model = join(' (',explode('_',$model)) . ' kVA)'; }

$hardware = trim(snmp_get($device,"upsmgIdentFamilyName.0","-OQv","MG-SNMP-UPS-MIB"),'" ') . ' ' . $model;

$serial = trim(snmp_get($device,"upsmgIdentSerialNumber.0","-OQv","MG-SNMP-UPS-MIB"),'" ');

// EOF
