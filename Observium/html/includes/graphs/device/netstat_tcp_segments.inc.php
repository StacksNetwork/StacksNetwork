<?php

$rrd_filename = $config['rrd_dir'] . "/" . $device['hostname'] . "/netstats-tcp.rrd";

$ds_in = "tcpInSegs";
$ds_out = "tcpOutSegs";

$colour_area_in = "AA66AA";
$colour_line_in = "330033";
$colour_area_out = "FFDD88";
$colour_line_out = "FF6600";

$colour_area_in_max = "cc88cc";
$colour_area_out_max = "FFefaa";

$graph_max = 1;
$unit_text = "Segments/s";


include("includes/graphs/generic_duplex.inc.php");

?>
