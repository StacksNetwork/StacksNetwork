<?php

include_once($config['html_dir']."/includes/graphs/common.inc.php");

$colours      = "mixed";
$nototal      = (($width<224) ? 1 : 0);
$unit_text    = "Requests";
$rrd_filename = $config['rrd_dir'] . "/" . $device['hostname'] . "/app-bind-".$app['app_id']."-query-out-default.rrd";

#$rrtypes = array('A', 'AAAA', 'PTR', 'ANY', 'IXFR', 'AXFR');
$rrtypes = array('SOA', 'A', 'AAAA', 'NS', 'MX', 'CNAME', 'DNAME', 'TXT', 'SPF', 'SRV', 'SSHFP', 'TLSA', 'IPSECKEY', 'PTR', 'DNSKEY', 'RRSIG', 'NSEC', 'NSEC3', 'NSEC3PARAM', 'DS', 'DLV', 'ANY', 'IXFR', 'AXFR');
$inverted = array('ANY', 'IXFR', 'AXFR');
$array = array();
foreach ($rrtypes as $rrtype)
{
 $array[$rrtype] = array('descr' => $rrtype);
}
$i = 0;

if (is_file($rrd_filename))
{
  foreach ($array as $ds => $data)
  {
    $rrd_list[$i]['filename'] = $rrd_filename;
    $rrd_list[$i]['descr']    = $data['descr'];
    $rrd_list[$i]['ds']       = $ds;
    $rrd_list[$i]['invert']   = in_array($data['descr'], $inverted);
    $i++;
  }
} else {
  echo("file missing: $file");
}

#include("includes/graphs/generic_multi_line.inc.php");
include("includes/graphs/generic_multi.inc.php");

// EOF
