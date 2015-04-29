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
  $ap = accesspoint_by_id($vars['id']);

  if (is_numeric($ap['device_id']) && ($auth || device_permitted($ap['device_id'])))
  {
    $device = device_by_id_cache($ap['device_id']);

    $rrd_filename = get_rrd_path($device, "arubaap-".$ap['name'].".".$ap['radio_number'].".rrd");

    $title  = generate_device_link($device);
    $title .= " :: AP :: " . htmlentities($ap['name']);
    $auth = TRUE;
  }
}

?>
