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

$rrd_filename = get_rrd_path($device, "netstats-udp.rrd");

$ds_in = "udpInDatagrams";
$ds_out = "udpOutDatagrams";

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
