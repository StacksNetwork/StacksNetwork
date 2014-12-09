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

$link_array = array('page'    => 'device',
                    'device'  => $device['device_id'],
                    'tab'     => 'routing',
                    'proto'   => 'vrf');

$navbar = array('brand' => "VRFs", 'class' => "navbar-narrow");

$navbar['options']['basic']['text']   = '基本';
// $navbar['options']['details']['text'] = 'Details';
$navbar['options']['graphs']     = array('text' => '图像', 'class' => 'pull-right', 'icon' => 'oicon-system-monitor');

foreach ($navbar['options'] as $option => $array)
{
  if ($vars['view'] == $option) { $navbar['options'][$option]['class'] .= " active"; }
  $navbar['options'][$option]['url'] = generate_url($link_array,array('view' => $option));
}

foreach (array('graphs') as $type)
{
  foreach ($config['graph_types']['port'] as $option => $data)
  {
    if ($vars['view'] == $type && $vars['graph'] == $option)
    {
      $navbar['options'][$type]['suboptions'][$option]['class'] = 'active';
      $navbar['options'][$type]['text'] .= ' ('.$data['name'].')';
    }
    $navbar['options'][$type]['suboptions'][$option]['text'] = $data['name'];
    $navbar['options'][$type]['suboptions'][$option]['url'] = generate_url($link_array, array('view' => $type, 'graph' => $option));
  }

}

print_navbar($navbar);
unset($navbar);

echo('<table class="table table-bordered table-striped">');
foreach (dbFetchRows("SELECT * FROM `vrfs` WHERE `device_id` = ? ORDER BY `vrf_name`", array($device['device_id'])) as $vrf)
{
  include("includes/print-vrf.inc.php");
}

echo("</table>");

// EOF
