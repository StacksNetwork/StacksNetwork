<?php

include_once($config['html_dir']."/includes/graphs/common.inc.php");

$colours      = "mixed";
$nototal      = 1;
$unit_text    = "Milliseconds";
$rrd_filename = $config['rrd_dir'] . "/" . $device['hostname'] . "/wmi-app-exchange-owa.rrd";

if (is_file($rrd_filename))
{
  $rrd_list[0]['filename'] = $rrd_filename;
  $rrd_list[0]['descr']    = "Average Response Time";
  $rrd_list[0]['ds']       = "avgresponsetime";

  $rrd_list[1]['filename'] = $rrd_filename;
  $rrd_list[1]['descr']    = "Average Search Time";
  $rrd_list[1]['ds']       = "avgsearchtime";

} else {
  echo("file missing: $file");
}

include("includes/graphs/generic_multi_line.inc.php");

// EOF
