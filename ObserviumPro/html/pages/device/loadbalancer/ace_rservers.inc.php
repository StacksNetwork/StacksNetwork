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

print_optionbar_start();

echo("<span style='font-weight: bold;'>服务器集群</span> &#187; ");

#$auth = TRUE;

$menu_options = array('basic' => '基本',
                      );

if (!$_GET['opta']) { $_GET['opta'] = "basic"; }

$sep = "";
foreach ($menu_options as $option => $text)
{
  if ($_GET['optd'] == $option) { echo("<span class='pagemenu-selected'>"); }
  echo('<a href="device/device=' . $device['device_id'] . '/tab=routing/type=loadbalancer_rservers/' . $option . '/">' . $text
 . '</a>');
  if ($_GET['optd'] == $option) { echo("</span>"); }
  echo(" | ");
}

unset($sep);

echo(' 图像: ');

#$graph_types = array("bits"   => "Bits",
#                     "pkts"   => "Packets",
#                     "errors" => "Errors");

$graph_types = array("curr"   => "当前连接",
                     "failed"   => "错误连接",
                     "total" => "共计连接");

foreach ($graph_types as $type => $descr)
{
  echo("$type_sep");
  if ($_GET['opte'] == $type) { echo("<span class='pagemenu-selected'>"); }
  echo('<a href="device/device=' . $device['device_id'] . '/tab=routing/type=loadbalancer_rservers/graphs/'.$type.'/">'.$descr.'</a>');
  if ($_GET['opte'] == $type) { echo("</span>"); }

  $type_sep = " | ";
}

print_optionbar_end();

echo("<div style='margin: 5px;'><table border=0 cellspacing=0 cellpadding=0 width=100%>");
$i = "0";
foreach (dbFetchRows("SELECT * FROM `loadbalancer_rservers` WHERE `device_id` = ? ORDER BY `farm_id`", array($device['device_id'])) as $rserver)
{
if (is_integer($i/2)) { $bg_colour = $list_colour_a; } else { $bg_colour = $list_colour_b; }

if($rserver['状态描述'] == "服务器正在运行") { $rserver_class="green"; } else { $rserver_class="red"; }

echo("<tr bgcolor='$bg_colour'>");
#echo("<td width=320 class=entity-title>" . $tunnel['local_addr'] . "  &#187;  " . $tunnel['peer_addr'] . "</a></td>");
echo("<td width=700 class=list-small>" . $rserver['farm_id'] . "</a></td>");
#echo("<td width=150 class=small>" . $rserver['farm_id'] . "</td>");
echo("<td width=230 class=list-small><span class='".$rserver_class."'>" . $rserver['状态描述'] . "</span></td>");
echo("</tr>");
  if ($_GET['optd'] == "graphs")
  {
    echo('<tr class="entity">');
    echo("<td colspan = 3>");
    $graph_type = "rserver_" . $_GET['opte'];

$graph_array['height'] = "100";
$graph_array['width']  = "215";
$graph_array['to']     = $config['time']['now'];
$graph_array['id']     = $rserver['rserver_id'];
$graph_array['type']   = $graph_type;

print_graph_row($graph_array);

#include("includes/print-interface-graphs.inc.php");

   echo("
   </td>
   </tr>");
  }

echo("</td>");
echo("</tr>");

  $i++;
}

echo("</table></div>");

// EOF
