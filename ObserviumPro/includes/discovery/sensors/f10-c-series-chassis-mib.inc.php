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

// Force10 C-Series

#F10-C-SERIES-CHASSIS-MIB::chSysCardType.1 = INTEGER: lc4802E48TB(1024)
#F10-C-SERIES-CHASSIS-MIB::chSysCardType.2 = INTEGER: lc0810EX8PB(2049)
#F10-C-SERIES-CHASSIS-MIB::chSysCardTemp.1 = Gauge32: 25
#F10-C-SERIES-CHASSIS-MIB::chSysCardTemp.2 = Gauge32: 26

echo(" F10-C-SERIES-CHASSIS-MIB ");

$oids = snmpwalk_cache_oid($device, "chSysCardTemp", array(), "F10-C-SERIES-CHASSIS-MIB", mib_dirs('force10'));

foreach ($oids as $index => $entry)
{
  $descr = "Slot ".$index;
  $oid   = ".1.3.6.1.4.1.6027.3.8.1.2.1.1.5.".$index;
  $value = $entry['chSysCardTemp'];

  discover_sensor($valid['sensor'], 'temperature', $device, $oid, $index, 'ftos-cseries', $descr, 1, $value);
}

// EOF
