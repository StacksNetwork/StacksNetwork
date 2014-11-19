<?php

include_once($config['html_dir']."/includes/graphs/common.inc.php");

$colours      = "mixed";
$nototal      = (($width<224) ? 1 : 0);
$unit_text    = "Blocks";
$rrd_filename = $config['rrd_dir'] . "/" . $device['hostname'] . "/app-postgresql-".$app['app_id'].".rrd";

$array = array(
               'blks_read' => array('descr' => 'Read'),
               'blks_hit' => array('descr' => 'Hit')
               );
$i = 0;

if (is_file($rrd_filename))
{
    foreach ($array as $ds => $data)
    {
        $rrd_list[$i]['filename']        = $rrd_filename;
        $rrd_list[$i]['descr']        = $data['descr'];
        $rrd_list[$i]['ds']                = $ds;
        $rrd_list[$i]['colour']        = $config['graph_colours'][$colours][$i];
        $i++;
    }
} else {
    echo("file missing: $file");
}

include("includes/graphs/generic_multi_line.inc.php");

// EOF
