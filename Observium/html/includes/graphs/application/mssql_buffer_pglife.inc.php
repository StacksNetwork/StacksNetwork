<?php

include_once($config['html_dir']."/includes/graphs/common.inc.php");

$colours      = "mixed";
$nototal      = 1;
$unit_text    = "Seconds";
$rrd_filename = $config['rrd_dir'] . "/" . $device['hostname'] . "/wmi-app-mssql_".$app['app_instance']."-buffer.rrd";

if (is_file($rrd_filename))
{
  $rrd_list[0]['filename'] = $rrd_filename;
  $rrd_list[0]['descr']    = "Page Life Expectancy";
  $rrd_list[0]['ds']       = "pagelifeexpect";

} else {
  echo("file missing: $file");
}

include("includes/graphs/generic_multi_line.inc.php");

// EOF
