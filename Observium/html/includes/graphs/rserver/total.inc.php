<?php

$scale_min = 0;

include_once($config['html_dir']."/includes/graphs/common.inc.php");

$graph_max = 1;

$ds = "RserverTotalConns";

$colour_area = "B0C4DE";
$colour_line = "191970";

$colour_area_max = "FFEE99";

$nototal   = 1;
$unit_text = "Conns";

include("includes/graphs/generic_simplex.inc.php");

// EOF
