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

#echo(generate_link("基础", $link_array,array('view'=>'basic')));

if(!isset($vars['view'])) { $vars['view'] = "basic"; }

print_optionbar_start();

echo("<span style='font-weight: bold;'>VRFs</span> &#187; ");

$menu_options = array('basic' => '基础',
#                      'detail' => '详情',
                      );

if (!$_GET['opta']) { $_GET['opta'] = "basic"; }

$sep = "";
foreach ($menu_options as $option => $text)
{
  if ($vars['view'] == $option) { echo("<span class='pagemenu-selected'>"); }
  echo(generate_link($text, $link_array,array('view'=>$option)));
  if ($vars['view'] == $option) { echo("</span>"); }
  echo(" | ");
}

unset($sep);

echo(' Graphs: ');

$graph_types = array("bits" => "Bits",
                     "upkts" => "单播数据包",
                     "nupkts" => "非单播数据包",
                     "errors" => "错误",
                     "etherlike" => "类以太网");

foreach ($graph_types as $type => $descr)
{
  echo("$type_sep");
  if ($vars['graph'] == $type) { echo("<span class='pagemenu-selected'>"); }
  echo(generate_link($descr, $link_array,array('view'=>'graphs','graph'=>$type)));
  if ($vars['graph'] == $type) { echo("</span>"); }

  $type_sep = " | ";
}

print_optionbar_end();

echo("<div style='margin: 5px;'><table border=0 cellspacing=0 cellpadding=5 width=100%>");
$i = "0";
foreach (dbFetchRows("SELECT * FROM `vrfs` WHERE `device_id` = ? ORDER BY `vrf_name`", array($device['device_id'])) as $vrf)
{
  include("includes/print-vrf.inc.php");

  $i++;
}

echo("</table></div>");

// EOF
