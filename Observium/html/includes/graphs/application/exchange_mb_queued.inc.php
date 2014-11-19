<?php

include_once($config['html_dir']."/includes/graphs/common.inc.php");

$colours      = "mixed";
$nototal      = 1;
$unit_text    = "Messages";
$rrd_filename = $config['rrd_dir'] . "/" . $device['hostname'] . "/wmi-app-exchange-mailbox.rrd";

if (is_file($rrd_filename))
{
  $rrd_list[0]['filename'] = $rrd_filename;
  $rrd_list[0]['descr']    = "Queued Messages";
  $rrd_list[0]['ds']       = "msgqueued";

} else {
  echo("file missing: $file");
}

include("includes/graphs/generic_multi_line.inc.php");

// EOF
