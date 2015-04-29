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
  $service = dbFetchRow("SELECT * FROM services WHERE service_id = ?", array($vars['id']));

  if (is_numeric($service['device_id']) && ($auth || device_permitted($service['device_id'])))
  {
    $device = device_by_id_cache($service['device_id']);

    $rrd_filename = get_rrd_path($device, "service-" . $service['service_type'] . "-" . $service['service_id'] . ".rrd");

    $title  = generate_device_link($device);
    $title .= " :: Service :: " . htmlentities($service['service_type']);
    $auth = TRUE;
  }
}

?>
