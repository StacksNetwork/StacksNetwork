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

$version  = trim(snmp_get($device, "1.3.6.1.4.1.1588.2.1.1.1.1.6.0", "-Ovq"),'"');
$hardware = $entPhysical['entPhysicalDescr'];
$serial   = $entPhysical['entPhysicalSerialNum'];

// EOF
