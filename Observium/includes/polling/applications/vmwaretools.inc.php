<?php

//<<<app-vmwaretools>>>
//vmtotalmem:2051
//vmswap:117
//vmballoon:1302
//vmmemres:256
//vmmemlimit:U
//vmspeed:2660000000
//vmcpulimit:U
//vmcpures:0

if (!empty($agent_data['app']['vmwaretools']))
{
  $vmwaretools                = $agent_data['app']['vmwaretools'];

      // Parse the data, first try key:value format
      $lines = explode("\n", $vmwaretools);
      foreach ($lines as $line) {

        // Parse key:value line
        list($key, $value) = explode(':', $line, 2);
        $values[$key] = $value;
      }

  $rrd_filename = $config['rrd_dir'] . "/" . $device['hostname'] . "/app-vmwaretools-".$app['app_id'].".rrd";

  list ($vmtotalmem, $vmswap, $vmballoon) = explode("\n", $agent_data['app']['vmwaretools']);

  if (!is_file($rrd_filename))
  {
    rrdtool_create($rrd_filename, " \
        DS:vmtotalmem:GAUGE:600:0:1000000 \
        DS:vmswap:GAUGE:600:0:1000000 \
        DS:vmballoon:GAUGE:600:0:1000000 \
        DS:vmmemres:GAUGE:600:0:1000000 \
        DS:vmmemlimit:GAUGE:600:0:1000000 \
        DS:vmspeed:GAUGE:600:0:10000000000  \
        DS:vmcpulimit:GAUGE:600:0:10000000000 \
        DS:vmcpures:GAUGE:600:0:10000000000  ");
  }

     // Construct the data
      $rrd_data = "";
      $rrd_keys = array('vmtotalmem', 'vmswap', 'vmballoon', 'vmmemres', 'vmmemlimit', 'vmspeed', 'vmcpulimit', 'vmcpures');

      foreach ($rrd_keys as $key)
      {
        $rrd_data .= ":".$values[$key];
      }

      rrdtool_update($rrd_filename, "N".$rrd_data);
}

?>
