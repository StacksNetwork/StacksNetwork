<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage graphs
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

include_once($config['html_dir']."/includes/graphs/common.inc.php");

$rrd_filename = get_rrd_path($device, 'app-mysql-'.$app["app_id"].'.rrd');

$array = array('TOC'  => array('descr' => 'Table Cache'),
               'OFs'  => array('descr' => 'Open Files'),
               'OTs'  => array('descr' => 'Open Tables'),
               'OdTs' => array('descr' => 'Opened Tables'),
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
$unit_text = "";

include("includes/graphs/generic_multi_simplex_separated.inc.php");

// EOF
