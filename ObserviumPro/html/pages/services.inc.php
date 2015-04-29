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

$page_title[] = "服务";

print_optionbar_start();

echo("<span style='font-weight: bold;'>服务</span> &#187; ");

$menu_options = array('basic' => '基本',
                      'details' => '详情');

if (!$vars['view']) { $vars['view'] = "basic"; }

$sep = "";
foreach ($menu_options as $option => $text)
{
  if (empty($vars['view'])) { $vars['view'] = $option; }
  echo($sep);
  if ($vars['view'] == $option) { echo("<span class='pagemenu-selected'>"); }
  echo(generate_link($text, $vars, array('view'=>$option)));
  if ($vars['view'] == $option) { echo("</span>"); }
  $sep = " | ";
}

unset($sep);

print_optionbar_end();

if ($_GET['status'] == '0') { $where = " AND service_status = '0'"; } else { unset ($where); }

if ($vars['view'] == "details") { $stripe_class = "table-striped-two"; } else { $stripe_class = "table-striped"; }

echo('<table class="table table-condensed '.$stripe_class.'" style="margin-top: 10px;">');
//echo("<tr class=small bgcolor='#e5e5e5'><td>设备</td><td>服务</td><td>状态</td><td>变更</td><td>检测</td><td>信息</td></tr>");

if ($_SESSION['userlevel'] >= '5')
{
  $host_sql = "SELECT * FROM devices AS D, services AS S WHERE D.device_id = S.device_id GROUP BY D.hostname ORDER BY D.hostname";
  $host_par = array();
} else {
  $host_sql = "SELECT * FROM devices AS D, services AS S, devices_perms AS P WHERE D.device_id = S.device_id AND D.device_id = P.device_id AND P.user_id = ? GROUP BY D.hostname ORDER BY D.hostname";
  $host_par = array($_SESSION['user_id']);
}

foreach (dbFetchRows($host_sql, $host_par) as $device)
{
  $device_id = $device['device_id'];
  $device_hostname = $device['hostname'];
  foreach (dbFetchRows("SELECT * FROM `services` WHERE `device_id` = ?", array($device['device_id'])) as $service)
  {
    include("includes/print-service.inc.php");

    if ($vars['view'] == "details")
    {
      $graph_array['height'] = "100";
      $graph_array['width']  = "215";
      $graph_array['to']     = $config['time']['now'];
      $graph_array['id']     = $service['service_id'];
      $graph_array['type']   = "service_availability";

      $periods = array('天', '周', '月', '年');

      echo('<tr><td colspan=6>');

      print_graph_row($graph_array);

      echo("</td></tr>");
    }
  }
  unset ($samehost);
}

echo("</table></div>");

// EOF
