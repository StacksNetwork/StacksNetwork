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

$rrd_filename = get_rrd_path($device, "cipsec_flow.rrd");

$ds_in = "InPkts";
$ds_out = "OutPkts";

$colour_area_in = "AA66AA";
$colour_line_in = "330033";
$colour_area_out = "FFDD88";
$colour_line_out = "FF6600";

$colour_area_in_max = "CC88CC";
$colour_area_out_max = "FFEFAA";

$graph_max = 1;
$unit_text = "Pkts   ";

include("includes/graphs/generic_duplex.inc.php");

// EOF
