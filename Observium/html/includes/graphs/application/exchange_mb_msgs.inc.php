<?php

include_once($config['html_dir']."/includes/graphs/common.inc.php");

$colours      = "mixed";
$nototal      = 1;
$unit_text    = "Messages";
$rrd_filename = $config['rrd_dir'] . "/" . $device['hostname'] . "/wmi-app-exchange-mailbox.rrd";

if (is_file($rrd_filename))
{
  $rrd_list[0]['filename'] = $rrd_filename;
  $rrd_list[0]['descr']    = "Messages Sent per Second";
  $rrd_list[0]['ds']       = "msgsentsec";

  $rrd_list[1]['filename'] = $rrd_filename;
  $rrd_list[1]['descr']    = "Messages Delivered per Second";
  $rrd_list[1]['ds']       = "msgdeliversec";

  $rrd_list[2]['filename'] = $rrd_filename;
  $rrd_list[2]['descr']    = "Messages Submitted per Second";
  $rrd_list[2]['ds']       = "msgsubmitsec";

} else {
  echo("file missing: $file");
}

include("includes/graphs/generic_multi_line.inc.php");

// EOF
