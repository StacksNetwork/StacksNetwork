<?php
/*
 DS:activechan:GAUGE:600:0:125000000000 \
        DS:activecall:GAUGE:600:0:125000000000 \
        DS:iaxchannels:GAUGE:600:0:125000000000 \
        DS:sipchannels:GAUGE:600:0:125000000000 \
        DS:sippeers:GAUGE:600:0:125000000000 \
        DS:sippeersonline:GAUGE:600:0:125000000000 \
        DS:iaxpeers:GAUGE:600:0:125000000000 \
        DS:iaxpeersonline:GAUGE:600:0:125000000000" . $config['rrd_rra']);
*/

$scale_min = 0;

include_once($config['html_dir']."/includes/graphs/common.inc.php");

$rrd_filename = $config['rrd_dir'] . "/" . $device['hostname'] . "/app-asterisk-".$app['app_id'].".rrd";

$array = array('activechan' => array('descr' => 'Active Channels', 'colour' => '750F7DFF'),
               'activecall' => array('descr' => 'Active Calls', 'colour' => '00FF00FF'),
               'iaxchannels' => array('descr' => 'IAX Channels', 'colour' => '4444FFFF'),
               'sipchannels' => array('descr' => 'SIP Channels', 'colour' => '157419FF'),
);

$i = 0;
if (is_file($rrd_filename))
{
  foreach ($array as $ds => $data)
  {
    $rrd_list[$i]['filename'] = $rrd_filename;
    $rrd_list[$i]['descr'] = $data['descr'];
    $rrd_list[$i]['ds'] = $ds;
    $rrd_list[$i]['colour'] = $data['colour'];
    $i++;
  }
} else { echo("file missing: $file");  }

$colours   = "mixed";
$nototal   = 0;
$unit_text = "Channels";

include("includes/graphs/generic_multi_line.inc.php");

#include("includes/graphs/generic_multi_simplex_separated.inc.php");

// EOF
