<?php

include_once($config['html_dir']."/includes/graphs/common.inc.php");

$scale_min    = 0;
$colours      = "mixed";
$nototal      = (($width<224) ? 1 : 0);
$unit_text    = "Packets/sec";
$rrd_filename = $config['rrd_dir'] . "/" . $device['hostname'] . "/app-powerdns-recursor-".$app['app_id'].".rrd";
$array        = array(
                      'tcpQuestions'    => array('descr' => 'TCP Questions', 'colour' => '0000FFFF'),
                      'tcpUnauthorized' => array('descr' => 'TCP Unauthorized', 'colour' => 'FF0000FF'),
                      'udpUnauthorized' => array('descr' => 'UDP Unauthorized', 'colour' => '00FF00FF'),
                     );

$i            = 0;

if (is_file($rrd_filename))
{
  foreach ($array as $ds => $data)
  {
    $rrd_list[$i]['filename'] = $rrd_filename;
    $rrd_list[$i]['descr'] = $data['descr'];
    $rrd_list[$i]['ds'] = $ds;
    $rrd_list[$i]['colour'] = $data['colour'];
    $i++;
  }
} else {
  echo("file missing: $file");
}

include("includes/graphs/generic_multi_simplex_separated.inc.php");

// EOF
