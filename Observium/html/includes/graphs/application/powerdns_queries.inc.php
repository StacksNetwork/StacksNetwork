<?php

include_once($config['html_dir']."/includes/graphs/common.inc.php");

$scale_min    = 0;
$colours      = "mixed";
$nototal      = (($width<224) ? 1 : 0);
$unit_text    = "Queries/sec";
$rrd_filename = $config['rrd_dir'] . "/" . $device['hostname'] . "/app-powerdns-".$app['app_id'].".rrd";
$array        = array(
                      'q_udpAnswers' => array('descr' => 'UDP Answers', 'colour' => '336699FF', 'invert' => 1),
                      'q_udpQueries' => array('descr' => 'UDP Queries', 'colour' => '6699CCFF', 'invert' => 0),
                      'q_tcpAnswers' => array('descr' => 'TCP Answers', 'colour' => '008800FF', 'invert' => 1),
                      'q_tcpQueries' => array('descr' => 'TCP Queries', 'colour' => '00FF00FF', 'invert' => 0),
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
    $rrd_list[$i]['invert'] = $data['invert'];
    $i++;
  }
} else {
  echo("file missing: $file");
}

include("includes/graphs/generic_multi_simplex_separated.inc.php");

// EOF
