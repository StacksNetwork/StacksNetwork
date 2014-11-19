<?php

$scale_min = 0;

include_once($config['html_dir']."/includes/graphs/common.inc.php");

$rrd   = $config['rrd_dir'] . '/' . $device['hostname'] . '/ping_snmp.rrd';
if (is_file($rrd))
{
  $rrd_filename = $rrd;
}

$ds = 'ping_snmp';
$colour_area = 'EEEEFF';
$colour_line = '0000CC';
$colour_area_max = 'FFEE99';
$unit_text = '毫秒';
$line_text = 'SNMP';

include('includes/graphs/generic_simplex.inc.php');

?>
