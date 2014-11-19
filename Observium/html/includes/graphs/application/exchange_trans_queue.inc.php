<?php

include_once($config['html_dir']."/includes/graphs/common.inc.php");

$colours      = "mixed";
$nototal      = 1;
$unit_text    = "Queues";
$rrd_filename = $config['rrd_dir'] . "/" . $device['hostname'] . "/wmi-app-exchange-tqs.rrd";

if (is_file($rrd_filename))
{
  $rrd_list[0]['filename'] = $rrd_filename;
  $rrd_list[0]['descr']    = "Total Queued Messages";
  $rrd_list[0]['ds']       = "aggregatequeue";

  $rrd_list[1]['filename'] = $rrd_filename;
  $rrd_list[1]['descr']    = "Delivery Queues per Second";
  $rrd_list[1]['ds']       = "deliveryqpersec";

} else {
  echo("file missing: $file");
}

include("includes/graphs/generic_multi_line.inc.php");

// EOF
