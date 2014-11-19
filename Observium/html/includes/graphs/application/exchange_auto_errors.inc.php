<?php

include_once($config['html_dir']."/includes/graphs/common.inc.php");

$colours      = "mixed";
$nototal      = 1;
$unit_text    = "Total Error Responses";
$rrd_filename = $config['rrd_dir'] . "/" . $device['hostname'] . "/wmi-app-exchange-auto.rrd";

if (is_file($rrd_filename))
{
  $rrd_list[0]['filename'] = $rrd_filename;
  $rrd_list[0]['descr']    = "Total Error Responses";
  $rrd_list[0]['ds']       = "errorresponses";

} else {
  echo("file missing: $file");
}

include("includes/graphs/generic_multi_line.inc.php");

// EOF
