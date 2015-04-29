<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage graphs
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

$scale_min = "0";

include_once($config['html_dir']."/includes/graphs/common.inc.php");

$rrd_options .= " -A ";
$rrd_options .= " COMMENT:'                           Last    Max\\n'";

$rrd_options .= " DEF:sensor=$rrd_filename:sensor:AVERAGE";
$rrd_options .= " DEF:sensor_max=$rrd_filename:sensor:MAX";
$rrd_options .= " DEF:sensor_min=$rrd_filename:sensor:MIN";

$rrd_options .= " AREA:sensor_max#c5c5c5";
$rrd_options .= " AREA:sensor_min#ffffffff";

#$rrd_options .= " AREA:sensor#FFFF99";
$rrd_options .= " LINE1.5:sensor#cc0000:'" . rrdtool_escape($sensor['sensor_descr'],22)."'";
$rrd_options .= " GPRINT:sensor:LAST:%6.2lfV";
$rrd_options .= " GPRINT:sensor:MAX:%6.2lfV\\\\l";

if (is_numeric($sensor['sensor_limit'])) $rrd_options .= " HRULE:".$sensor['sensor_limit']."#999999::dashes";
if (is_numeric($sensor['sensor_limit_low'])) $rrd_options .= " HRULE:".$sensor['sensor_limit_low']."#999999::dashes";

$graph_return = array('rrds' => array($rrd_filename), 'descr' => 'Potential sensor measured in volts.', 'valid_options');

// EOF
