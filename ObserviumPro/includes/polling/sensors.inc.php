<?php

/* Observium Network Management and Monitoring System
 *
 * @package    observium
 * @subpackage poller
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

global $graphs;

if (dbFetchCell('SELECT COUNT(*) FROM `sensors` WHERE `device_id` = ? AND `sensor_deleted` = ?;', array($device['device_id'], '0')) > 0)
{
  echo('传感器: '.PHP_EOL);

  // Cache data for use by polling modules
  foreach (dbFetchRows("SELECT `sensor_type` FROM `sensors` WHERE `device_id` = ? AND `poller_type` = 'snmp' AND `sensor_deleted` = '0' GROUP BY `sensor_type`", array($device['device_id'])) as $s_type)
  {
    if (is_array($config['sensor']['cache_oids'][$s_type['sensor_type']]))
    {
      echo('缓存中: ' . $s_type['sensor_type'] . ' ');
      foreach ($config['sensor']['cache_oids'][$s_type['sensor_type']] as $oid_to_cache)
      {
        if (!$oids_cached[$oid_to_cache])
        {
          echo($oid_to_cache . ' ');
          $oids_cached[$oid_to_cache] = TRUE;
          $oid_cache = snmpwalk_numericoids($device, $oid_to_cache, $oid_cache);
          $oids_cached[$oid_to_cache] = TRUE;
        }
      }
      echo(PHP_EOL);
    }
  }

  // Call poll_sensor for each sensor type that we support.
  foreach ($config['sensor_types'] as $sensor_class => $sensor_class_data)
  {
    poll_sensor($device, $sensor_class, $sensor_class_data['symbol'], $oid_cache);
  }

}

// EOF
