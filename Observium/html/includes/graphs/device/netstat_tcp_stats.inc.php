<?php

$rrd_filename = $config['rrd_dir'] . "/" . $device['hostname'] . "/netstats-tcp.rrd";

$stats = array('tcpActiveOpens','tcpPassiveOpens','tcpAttemptFails','tcpEstabResets','tcpRetransSegs');

$i=0;
foreach ($stats as $stat)
{
  $i++;
  $rrd_list[$i]['filename'] = $rrd_filename;
  $rrd_list[$i]['descr'] = str_replace("tcp", "", $stat);
  $rrd_list[$i]['ds'] = $stat;
  if (strpos($stat, "Out") !== FALSE || strpos($stat, "Retrans") !== FALSE || strpos($stat, "Attempt") !== FALSE)
  {
    $rrd_list[$i]['invert'] = TRUE;
  }
}

$colours='mixed';

$nototal = 1;
$simple_rrd = 1;

include("includes/graphs/generic_multi_line.inc.php");

?>
