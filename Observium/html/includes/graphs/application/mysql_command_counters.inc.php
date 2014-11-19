<?php

include_once($config['html_dir']."/includes/graphs/common.inc.php");

$rrd_filename = $config["rrd_dir"] . '/' . $device["hostname"] . '/app-mysql-'.$app["app_id"].'.rrd';

$array = array('CDe'  => array('descr' => 'Delete', 'colour' => '22FF22'),
               'CIt'  => array('descr' => 'Insert', 'colour' => '0022FF'),
               'CISt' => array('descr' => 'Insert Select', 'colour' => 'FF0000'),
               'CLd'  => array('descr' => 'Load Data', 'colour' => '00AAAA'),
               'CRe'  => array('descr' => 'Replace', 'colour' => 'FF00FF'),
               'CRSt' => array('descr' => 'Replace Select', 'colour' => 'FFA500'),
               'CSt'  => array('descr' => 'Select', 'colour' => 'CC0000'),
               'CUe'  => array('descr' => 'Update', 'colour' => '0000CC'),
               'CUMi' => array('descr' => 'Update Multiple', 'colour' => '0080C0'),
);

$i = 0;
if (is_file($rrd_filename))
{
  foreach ($array as $ds => $data)
  {
    $rrd_list[$i]['filename'] = $rrd_filename;
    $rrd_list[$i]['descr'] = $data['descr'];
    $rrd_list[$i]['ds'] = $ds;
#    $rrd_list[$i]['colour'] = $data['colour'];
    $i++;
  }
} else { echo("file missing: $file");  }

$colours   = "mixed";
$nototal   = 1;
$unit_text = "Commands";

include("includes/graphs/generic_multi_simplex_separated.inc.php");

// EOF
