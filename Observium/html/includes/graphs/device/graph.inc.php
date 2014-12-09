<?php

if (isset($config['sensor_types'][$subtype]))
{
  $class     = $subtype;
  $unit      = $config['sensor_types'][$subtype]['symbol'];
  if ($unit == '%') { $unit = '%%'; }
  $unit_long = $config['sensor_types'][$subtype]['text'];
  include("includes/graphs/device/sensor.inc.php");
} else {
  graph_error($type.'_'.$subtype); // Graph Template Missing;
}

// EOL