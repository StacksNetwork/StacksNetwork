<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage discovery
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

echo(" ALCATEL-IND1-INTERSWITCH-PROTOCOL-MIB ");

$amap_array = snmpwalk_cache_threepart_oid($device, "aipAMAPportConnectionTable", array(), "ALCATEL-IND1-INTERSWITCH-PROTOCOL-MIB", mib_dirs('aos'), TRUE);

if ($amap_array)
{
  foreach (array_keys($amap_array) as $key)
  {
    $amap = array_shift(array_shift($amap_array[$key]));

    $port = dbFetchRow("SELECT * FROM `ports` WHERE `device_id` = ? AND `ifIndex` = ?", array($device['device_id'], $amap['aipAMAPLocalIfindex']));

    $remote_device = dbFetchRow("SELECT `device_id`, `hostname` FROM `devices` WHERE `sysName` = ? OR `hostname` = ?", array($amap['aipAMAPRemHostname'], $amap['aipAMAPRemHostname']));
    $remote_device_id = $remote_device['device_id'];

    if (!$remote_device_id && is_valid_hostname($amap['aipAMAPRemHostname']) && !is_bad_xdp($amap['aipAMAPRemHostname']))
    {
      $remote_device_id = discover_new_device($amap['aipAMAPRemHostname'], 'xdp', 'AMAP', $device, $port);
    }

    if ($remote_device_id)
    {
      $remote_port_id = $amap['aipAMAPRemSlot'] * 1000 + $amap['aipAMAPRemPort'];
    }

    if (!is_bad_xdp($amap['aipAMAPRemHostname']) && is_numeric($port['port_id']) && isset($amap['aipAMAPRemHostname']))
    {
      discover_link($valid_link, $port['port_id'], 'amap', $remote_port_id, $amap['aipAMAPRemHostname'], $amap['aipAMAPRemSlot']."/".$amap['aipAMAPRemPort'], $amap['aipAMAPRemDeviceType'], $amap['aipAMAPRemDevModelName']);
    }
  }
}

// EOF
