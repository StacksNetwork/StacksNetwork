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

#SNMPv2-SMI::enterprises.2620.1.6.4.1.0 = STRING: "R76"

$version = trim(snmp_get($device, "svnVersion.0", "-OQv", 'CHECKPOINT-MIB', mib_dirs('checkpoint')),'"');

// EOF
