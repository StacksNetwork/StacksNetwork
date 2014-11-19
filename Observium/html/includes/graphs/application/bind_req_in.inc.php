<?php

include_once($config['html_dir']."/includes/graphs/common.inc.php");

$colours      = "mixed";
$nototal      = (($width<224) ? 1 : 0);
$unit_text    = "Requests";
$rrd_filename = $config['rrd_dir'] . "/" . $device['hostname'] . "/app-bind-".$app['app_id']."-req-in.rrd";

$array = array(
               'query' => array('descr' => 'Query'),
               'status' => array('descr' => 'Status'),
               'notify' => array('descr' => 'Notify'),
               'update' => array('descr' => 'Update'),
               );
$i = 0;

if (is_file($rrd_filename))
{
    foreach ($array as $ds => $data)
    {
        $rrd_list[$i]['filename'] = $rrd_filename;
        $rrd_list[$i]['descr']    = $data['descr'];
        $rrd_list[$i]['ds']       = $ds;
        $i++;
    }
} else {
    echo("file missing: $file");
}

include("includes/graphs/generic_multi_line.inc.php");

// EOF
