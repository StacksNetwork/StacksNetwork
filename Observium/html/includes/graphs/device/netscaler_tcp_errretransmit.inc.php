<?php

$scale_min = 0;

include_once($config['html_dir']."/includes/graphs/common.inc.php");

$rrd_filename = $config['rrd_dir'] . "/" . $device['hostname'] . "/netscaler-stats-tcp.rrd";

$ds = "ErrRetransmit";

$colour_area = "ef3b2c";
$colour_line = "67000d";

$colour_area_max = "dddddd";

$graph_max = 1;

$unit_text = "Retransmits/s";

include("includes/graphs/generic_simplex.inc.php");

// EOF
