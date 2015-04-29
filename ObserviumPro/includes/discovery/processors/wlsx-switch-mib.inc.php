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

$mib = 'WLSX-SWITCH-MIB';

echo(" $mib ");

$processors_array = snmpwalk_cache_oid($device, 'wlsxSysXProcessorTable', NULL, $mib, mib_dirs('aruba'));
if (is_array($processors_array))
{
  foreach ($processors_array as $index => $entry)
  {
    if (is_numeric($entry['sysXProcessorLoad']) && is_numeric($index))
    {
      $descr = $entry['sysXProcessorDescr'];
      $usage = $entry['sysXProcessorLoad'];
      $oid   = "1.3.6.1.4.1.14823.2.2.1.1.1.9.1.3." . $index;
      discover_processor($valid['processor'], $device, $oid, $index, $mib, $descr, "1", $usage, NULL, NULL);
    }
  }
}

unset ($processors_array, $index, $descr, $usage, $oid);

// EOF

