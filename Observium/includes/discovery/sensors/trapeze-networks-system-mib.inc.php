<?php

// Supply
echo(" TRAPEZE-NETWORKS-SYSTEM-MIB ");

$sensor_state_type = "trapeze-state";
$oids = snmpwalk_cache_oid($device, 'trpzSysPowerSupplyEntry', array(), 'TRAPEZE-NETWORKS-SYSTEM-MIB', mib_dirs('trapeze'));

foreach ($oids as $index => $entry)
{
  if (isset($entry['trpzSysPowerSupplyStatus']))
  {
    $oid  = '.1.3.6.1.4.1.14525.4.8.1.1.13.1.2.1.'.$index;
    echo($index);
    //Not numerical values, only states
    $value = state_string_to_numeric($sensor_state_type, $entry['trpzSysPowerSupplyStatus']);
    discover_sensor($valid['sensor'], 'power', $device, $oid, $index, $sensor_state_type, $entry['trpzSysPowerSupplyDescr'], 1, 1, NULL, NULL, NULL, NULL, $value);
  }
}

// EOF
