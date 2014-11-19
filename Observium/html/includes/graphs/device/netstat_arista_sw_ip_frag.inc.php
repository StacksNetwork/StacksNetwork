<?php

if (!isset($rrd_filename)) {
  # We can be included from arista_netstats_sw_ip6_frag, which just sets the filename.
  $rrd_filename = $config['rrd_dir'] . "/" . $device['hostname'] . "/arista-netstats-sw-ip.rrd";
  $ipv = "v4";
}

$stats = array(
                'ReasmReqds' => array(),
                'ReasmOKs' => array(),
                'ReasmFails' => array(),
                'OutFragFails' => array(),
                'OutFragCreates' => array());

$i=0;
foreach ($stats as $stat => $array)
{
  $i++;
  $rrd_list[$i]['filename'] = $rrd_filename;
  $rrd_list[$i]['descr'] = $stat . " " . $ipv;
  $rrd_list[$i]['ds'] = $stat;
  if (strpos($stat, "Out") !== FALSE)
  {
    $rrd_list[$i]['invert'] = TRUE;
  }
}

$colours='mixed';

$scale_min = "0";
$nototal = 1;
$simple_rrd = TRUE;

include("includes/graphs/generic_multi_line.inc.php");

?>
