<?php

include_once($config['html_dir']."/includes/graphs/common.inc.php");

$rrd_options .= " -l 0 -E ";

$radio1  = $config['rrd_dir'] . "/".$device['hostname']."/wificlients-radio1.rrd";
$radio2  = $config['rrd_dir'] . "/".$device['hostname']."/wificlients-radio2.rrd";

if (file_exists($radio1))
{
  $rrd_options .= " COMMENT:'                           Cur   Min  Max\\n'";
  $rrd_options .= " DEF:wificlients1=".$radio1.":wificlients:AVERAGE ";
  $rrd_options .= " LINE1:wificlients1#CC0000:'Clients on Radio1    ' ";
  $rrd_options .= " GPRINT:wificlients1:LAST:%3.0lf ";
  $rrd_options .= " GPRINT:wificlients1:MIN:%3.0lf ";
  $rrd_options .= " GPRINT:wificlients1:MAX:%3.0lf\\\l ";
  if (file_exists($radio2))
  {
    $rrd_options .= " DEF:wificlients2=".$radio2.":wificlients:AVERAGE ";
    $rrd_options .= " LINE1:wificlients2#008C00:'Clients on Radio2    ' ";
    $rrd_options .= " GPRINT:wificlients2:LAST:%3.0lf ";
    $rrd_options .= " GPRINT:wificlients2:MIN:%3.0lf ";
    $rrd_options .= " GPRINT:wificlients2:MAX:%3.0lf\\\l ";
  }
}

// EOF
