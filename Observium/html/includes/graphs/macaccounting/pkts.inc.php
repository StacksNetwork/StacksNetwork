<?php

$ds_in = "PIN";
$ds_out = "POUT";

$colour_area_in = "AA66AA";
$colour_line_in = "330033";
$colour_area_out = "FFDD88";
$colour_line_out = "FF6600";

$colour_area_in_max = "cc88cc";
$colour_area_out_max = "FFefaa";

$graph_max = 1;
$unit_text = "Packets";

$args['nototal'] = 1; $print_total = 0; $nototal = 1;

include("includes/graphs/generic_duplex.inc.php");

?>