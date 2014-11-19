<?php

include_once($config['html_dir']."/includes/graphs/common.inc.php");

$colours      = "mixed";
$nototal      = 1;
$unit_text    = "Queues";
$rrd_filename = $config['rrd_dir'] . "/" . $device['hostname'] . "/wmi-app-exchange-smtp.rrd";

if (is_file($rrd_filename))
{
  $rrd_list[0]['filename'] = $rrd_filename;
  $rrd_list[0]['descr']    = "Current Connections";
  $rrd_list[0]['ds']       = "currentconnections";

  $rrd_list[1]['filename'] = $rrd_filename;
  $rrd_list[1]['descr']    = "Messages Sent per Second";
  $rrd_list[1]['ds']       = "msgsentpersec";

} else {
  echo("file missing: $file");
}

include("includes/graphs/generic_multi_line.inc.php");

// EOF
