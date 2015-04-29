<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage webui
 * @copyright  (C) 2006-2015 Adam Armstrong
 *
 */

if ($device['type'] == 'wireless')
{
  $i = 1;

  $accesspoints = dbFetchRows('SELECT * FROM `wifi_accesspoints` WHERE `device_id` = ? ORDER BY `location`, `name` ASC', array($device['device_id']));
  $accesspoints_count = count($accesspoints);

  // Pagination
  echo(pagination($vars, $accesspoints_count));

  if ($vars['pageno'])
  {
    $accesspoints = array_chunk($accesspoints, $vars['pagesize']);
    $accesspoints = $accesspoints[$vars['pageno']-1];
  }

  echo('<table class="table table-hover table-bordered table-condensed table-rounded table-striped" style="vertical-align: middle; margin-top: 5px; margin-bottom: 10px;">');
  echo('<thead><tr><th>名称</th><th>类型</th><th>位置</th><th>序列号/指纹</th></tr></thead>');

  foreach ($accesspoints as $accesspoint)
  {
    echo('<tr><td>');
    echo('<h4><a href="'. generate_url(array('page' => 'device', 'device' => $device['device_id'], 'tab' => 'wifi', 'view' => 'accesspoint', 'accesspoint' => $accesspoint['wifi_accesspoint_id'])).'">' . $accesspoint['name'] .'</a></h4>');

    echo($accesspoint['ap_number'].'</td><td>'.$accesspoint['model'].'</td><td>'.$accesspoint['location'].'</td><td>'.$accesspoint['serial'].'</br>'.$accesspoint['fingerprint']);

    echo('</td></tr>');
  }

  echo('</table>');
  echo(pagination($vars, $accesspoints_count));
}

$page_title[] = '接入点';

// EOF
