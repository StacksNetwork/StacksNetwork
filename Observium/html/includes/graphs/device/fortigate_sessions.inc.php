<?php

$rrd_filename = $config['rrd_dir'] . "/" . $device['hostname'] . "/" . safename("fortigate_sessions.rrd");

include_once($config['html_dir']."/includes/graphs/common.inc.php");

$ds = "sessions";

$colour_area = "9999cc";
$colour_line = "0000cc";

$colour_area_max = "9999cc";

$graph_max = 1;

$unit_text = "Sessions";

include("includes/graphs/generic_simplex.inc.php");

// EOF
