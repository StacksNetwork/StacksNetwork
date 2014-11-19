<?php

include_once($config['html_dir']."/includes/graphs/common.inc.php");

$colours      = "mixed";
$nototal      = 1;
$unit_text    = "Requests";
$rrd_filename = $config['rrd_dir'] . "/" . $device['hostname'] . "/wmi-app-exchange-is.rrd";

if (is_file($rrd_filename))
{
  $rrd_list[0]['filename'] = $rrd_filename;
  $rrd_list[0]['descr']    = "RPC Requests";
  $rrd_list[0]['ds']       = "rpcrequests";

  $rrd_list[1]['filename'] = $rrd_filename;
  $rrd_list[1]['descr']    = "RPC Average Latency";
  $rrd_list[1]['ds']       = "rpcavglatency";

} else {
  echo("file missing: $file");
}

include("includes/graphs/generic_multi_line.inc.php");

// EOF
