<?php

$rrd_list[0]['filename'] = $rrd_filename;
$rrd_list[0]['descr'] = "Channel";
$rrd_list[0]['ds'] = "channel";

$unit_text = "Channel";

$units='';
$total_units='';
$colours='mixed';

$scale_min = "0";

$nototal = 1;

if ($rrd_list)
{
  include("includes/graphs/generic_multi_line.inc.php");
}

?>
