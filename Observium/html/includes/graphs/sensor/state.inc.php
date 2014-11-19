<?php

$scale_min = "0";

include_once($config['html_dir']."/includes/graphs/common.inc.php");

$rrd_options .= " COMMENT:'                         Last     Max\\n'";

$rrd_options .= " DEF:sensor=$rrd_filename:sensor:AVERAGE";
$rrd_options .= " LINE1.5:sensor#cc0000:'" . rrdtool_escape($sensor['sensor_descr'],20)."'";
$rrd_options .= " GPRINT:sensor:LAST:%3.0lf";
$rrd_options .= " GPRINT:sensor:MAX:%3.0lf\\\\l";

if (is_numeric($sensor['sensor_limit'])) $rrd_options .= " HRULE:".$sensor['sensor_limit']."#999999::dashes";
if (is_numeric($sensor['sensor_limit_low'])) $rrd_options .= " HRULE:".$sensor['sensor_limit_low']."#999999::dashes";

// EOF
