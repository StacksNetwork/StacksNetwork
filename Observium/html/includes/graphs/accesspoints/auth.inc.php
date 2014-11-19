<?php

if (is_numeric($vars['id']))
{
  $ap = accesspoint_by_id($vars['id']);

  if (is_numeric($ap['device_id']) && ($auth || device_permitted($ap['device_id'])))
  {
    $device = device_by_id_cache($ap['device_id']);

    $rrd_filename = $config['rrd_dir'] . "/" . $device['hostname'] ."/".
                    safename("arubaap-".$ap['name'].".".$ap['radio_number'].".rrd");

    $title  = generate_device_link($device);
    $title .= " :: AP :: " . htmlentities($ap['name']);
    $auth = TRUE;
  }
}

?>
