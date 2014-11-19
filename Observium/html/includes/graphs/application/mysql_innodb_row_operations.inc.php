<?php

include_once($config['html_dir']."/includes/graphs/common.inc.php");
 
$rrd_filename = $config["rrd_dir"] . '/' . $device["hostname"] . '/app-mysql-'.$app["app_id"].'.rrd';

$array = array('IDBRDd' => 'Deletes',
               'IDBRId'  => 'Inserts',
               'IDBRRd' => 'Reads',
               'IDBRUd' => 'Updates',
);

$i = 0;
if (is_file($rrd_filename))
{
  foreach ($array as $ds => $data)
  {
    $rrd_list[$i]['filename'] = $rrd_filename;
    if (is_array($data))
    {
      $rrd_list[$i]['descr'] = $data['descr'];
    } else {
      $rrd_list[$i]['descr'] = $data;
    }
    $rrd_list[$i]['ds'] = $ds;
    $i++;
  }
} else { echo("file missing: $file");  }

$colours   = "mixed";
$nototal   = 0;
$unit_text = "Rows";

include("includes/graphs/generic_multi_simplex_separated.inc.php");

// EOF
