<?php

if (is_numeric($vars['device']) && ($auth || device_permitted($vars['device'])))
{
  $device = device_by_id_cache($vars['device']);
  $title = generate_device_link($device);
  $graph_title = $device['hostname'];
  $auth = TRUE;
}

// EOF
