<?php

$ds_in  = "TotalPktsRecvd";
$ds_out = "TotalPktsSent";

$unit_text = "Packets";

include("netscalersvc.inc.php");

$units ='pps';
$total_units ='Pkts';
$multiplier = 1;
$colours_in ='purples';
$colours_out = 'oranges';

#$nototal = 1;

$graph_title .= "::packets";

include("includes/graphs/generic_multi_separated.inc.php");

?>
