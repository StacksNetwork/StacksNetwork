<?php

/**
 * Observium Network Management and Monitoring System
 * Copyright (C) 2006-2014, Adam Armstrong - http://www.observium.org
 *
 * @package    observium
 * @subpackage webui
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

$datas = array('processor','mempool','storage');

if ($toner_exists) { $datas[] = 'toner'; }

foreach (array_keys($config['sensor_types']) as $type)
{
  if ($cache['sensor_types'][$type]) { $datas[] = $type; }
}

if (!$vars['metric']) { $vars['metric'] = "processor"; }
if (!$vars['view']) { $vars['view'] = "detail"; }

$link_array = array('page'    => 'health');

$pagetitle[] = "健康状况";
?>

<div class="navbar navbar-narrow">
  <div class="navbar-inner">
    <a class="brand">健康状况</a>
    <ul class="nav">

<?php
$sep = "";
foreach ($datas as $texttype)
{
  $metric = strtolower($texttype);
  if ($vars['metric'] == $metric)
  {
    $class = "active";
  } else { unset($class); }

  echo('<li class="'.$class.'">');
  echo(generate_link(nicecase($metric),$link_array,array('metric'=> $metric, 'view' => $vars['view'])));
  echo('</li>');

}

echo('</ul><ul class="nav pull-right">');

if ($vars['view'] == "graphs")
{
  $class = "active";
} else {
  unset($class);
}

echo('<li class="pull-right '.$class.'">');
echo(generate_link("流量图",$link_array,array('metric'=> $vars['metric'], 'view' => "graphs")));
echo('</li>');

if ($vars['view'] != "graphs")
{
  $class = "active";
} else {
  unset($class);
}

echo('<li class="pull-right '.$class.'">');
echo(generate_link("无图显示",$link_array,array('metric'=> $vars['metric'], 'view' => "detail")));
echo('</li>');

echo('</ul></div></div>');

if (in_array($vars['metric'],array_keys($datas)))
{
  $sensor_type = $vars['metric'];

  if (file_exists('pages/health/'.$vars['metric'].'.inc.php'))
  {
    include('pages/health/'.$vars['metric'].'.inc.php');
  } else {
    include('pages/health/sensors.inc.php');
  }
}
else
{
  print_warning("没有发现该类型 " . $vars['metric'] . " 的传感器.");
}

// EOF
