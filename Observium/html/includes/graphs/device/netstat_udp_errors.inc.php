<?php

$rrd_filename = $config['rrd_dir'] . "/" . $device['hostname'] . "/netstats-udp.rrd";

$stats = array('udpInErrors','udpNoPorts');

$i=0;
foreach ($stats as $stat)
{
  $i++;
  $rrd_list[$i]['filename'] = $rrd_filename;
  $rrd_list[$i]['descr'] = str_replace("udp", "", $stat);
  $rrd_list[$i]['ds'] = $stat;
  $rrd_list[$i]['colour'] = 'e34a33';
  if (strpos($stat, "NoPorts") !== FALSE)
  {
    $rrd_list[$i]['invert'] = TRUE;
  }
}

$colours='mixed';

$nototal = 1;
$simple_rrd = 1;

include("includes/graphs/generic_multi_line.inc.php");

?>
