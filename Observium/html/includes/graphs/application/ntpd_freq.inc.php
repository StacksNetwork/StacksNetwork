<?php

include_once($config['html_dir']."/includes/graphs/common.inc.php");

$scale_min       = 0;
$ds              = "frequency";
$colour_area     = "F6F6F6";
$colour_line     = "B3D0DB";
$colour_area_max = "FFEE99";
$graph_max       = 100;
$unit_text       = "Frequency";
$ntpdserver_rrd  = $config['rrd_dir'] . "/" . $device['hostname'] . "/app-ntpd-server-".$app['app_id'].".rrd";
$ntpdclient_rrd  = $config['rrd_dir'] . "/" . $device['hostname'] . "/app-ntpd-client-".$app['app_id'].".rrd";

if (is_file($ntpdclient_rrd)) {
  $rrd_filename = $ntpdclient_rrd;
}
if (is_file($ntpdserver_rrd)) {
  $rrd_filename = $ntpdserver_rrd;
}

include("includes/graphs/generic_simplex.inc.php");

// EOF
