<?php

$ds_in  = "TotalRequests";
$ds_out = "TotalResponses";

$unit_text = "Requests";

include("netscalervsvr.inc.php");

$units ='pps';
$total_units ='Pkts';
$multiplier = 1;
$colours_in ='purples';
$colours_out = 'oranges';

#$nototal = 1;

$graph_title .= "::reqs";

include("includes/graphs/generic_multi_separated.inc.php");

?>
