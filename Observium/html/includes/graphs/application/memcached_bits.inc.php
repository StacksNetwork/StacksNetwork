<?php

include("memcached.inc.php");
include_once($config['html_dir']."/includes/graphs/common.inc.php");

$multiplier = 8;

$ds_in = "bytes_read";
$ds_out = "bytes_written";

include("includes/graphs/generic_data.inc.php");

// EOF
