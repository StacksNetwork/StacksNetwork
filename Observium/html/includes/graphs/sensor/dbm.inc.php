<?php

$scale_min = "0";

include_once($config['html_dir']."/includes/graphs/common.inc.php");

$rrd_options .= " COMMENT:'                       Min       Last      Max\\n'";

$sensor['sensor_descr_fixed'] = substr(str_pad($sensor['sensor_descr'], 18),0,18);

$rrd_options .= " DEF:sensor=$rrd_filename:sensor:AVERAGE";
$rrd_options .= " LINE1.5:sensor#cc0000:'" . $sensor['sensor_descr_fixed']."'";
$rrd_options .= " GPRINT:sensor$current_id:MIN:%5.2lfdBm";
$rrd_options .= " GPRINT:sensor:LAST:%5.2lfdBm";
$rrd_options .= " GPRINT:sensor:MAX:%5.2lfdBm\\\\l";

if (is_numeric($sensor['sensor_limit'])) $rrd_options .= " HRULE:".$sensor['sensor_limit']."#999999::dashes";
if (is_numeric($sensor['sensor_limit_low'])) $rrd_options .= " HRULE:".$sensor['sensor_limit_low']."#999999::dashes";

$graph_return = array('rrds' => array($rrd_filename), 'descr' => 'dBm sensor.', 'valid_options' => array());

// EOF
