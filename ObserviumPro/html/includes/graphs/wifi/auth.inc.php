<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage graphs
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

if (is_numeric($vars['id']))
{
  $radio = dbFetchRow("SELECT * FROM `wifi_accesspoints`, `wifi_radios` WHERE  `wifi_accesspoints`.`wifi_accesspoint_id` = `wifi_radios`.`accesspoint_id` AND `wifi_radios`.`wifi_radio_id` = ? ", array($vars['id']));
  if (is_numeric($radio['device_id']) && ($auth || device_permitted($radio['device_id'])))
  {
    $device = device_by_id_cache($radio['device_id']);

    $title  = generate_device_link($device);
    $title .= " :: WIFI - Accesspoint :: " . htmlentities($radio['name']);
    $auth = TRUE;
  }
}

?>
