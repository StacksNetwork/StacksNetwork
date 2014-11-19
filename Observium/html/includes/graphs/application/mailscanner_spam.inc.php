<?php

include_once($config['html_dir']."/includes/graphs/common.inc.php");

$scale_min    = 0;
$nototal      = (($width < 550) ? 1 : 0);
$unit_text    = "Messages/sec";
$rrd_filename = $config['rrd_dir'] . "/" . $device['hostname'] . "/app-mailscannerV2-" . $app['app_id'] . ".rrd";
$array        = array(
                      'spam' => array('descr' => 'Spam', 'colour' => 'FF8800'),
                      'virus' => array('descr' => 'Virus', 'colour' => 'FF0000')
                     );

$i            = 0;

if (is_file($rrd_filename))
{
  foreach ($array as $ds => $data)
  {
    $rrd_list[$i]['filename'] = $rrd_filename;
    $rrd_list[$i]['descr']    = $data['descr'];
    $rrd_list[$i]['ds']       = $ds;
    $rrd_list[$i]['colour']   = $data['colour'];
    $i++;
  }
}

include("includes/graphs/generic_multi_simplex_separated.inc.php");

// EOF
