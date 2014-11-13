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
                    'proto'   => 'ipsec_tunnels');

print_optionbar_start();

echo("<span style='font-weight: bold;'>IPSEC隧道</span> &#187; ");

$menu_options = array('basic' => '基础',
                      );

if(!isset($vars['view'])) { $vars['view'] = "basic"; }

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

echo(' 流量图: ');

$graph_types = array("bits" => "Bits",
                     "pkts" => "数据包");

foreach ($graph_types as $type => $descr)
{
  echo("$type_sep");
  if ($vars['graph'] == $type) { echo("<span class='pagemenu-selected'>"); }
  echo(generate_link($descr, $link_array,array('view'=>'graphs','graph'=>$type)));
  if ($vars['graph'] == $type) { echo("</span>"); }

  $type_sep = " | ";
}

print_optionbar_end();

echo("<div style='margin: 5px;'><table border=0 cellspacing=0 cellpadding=0 width=100%>");
$i = "0";
foreach (dbFetchRows("SELECT * FROM `ipsec_tunnels` WHERE `device_id` = ? AND `tunnel_name` != '' ORDER BY `peer_addr`", array($device['device_id'])) as $tunnel)
{

if (is_integer($i/2)) { $bg_colour = $list_colour_a; } else { $bg_colour = $list_colour_b; }

if($tunnel['tunnel_status'] == "active") { $tunnel_class="green"; } else { $tunnel_class="red"; }

echo("<tr bgcolor='$bg_colour'>");
echo("<td width=320 class=entity-title>" . $tunnel['local_addr'] . "  &#187;  " . $tunnel['peer_addr'] . "</a></td>");
echo("<td width=150 class=small>" . $tunnel['tunnel_name'] . "</td>");
echo("<td width=100 class=entity-title><span class='".$tunnel_class."'>" . $tunnel['tunnel_status'] . "</span></td>");
echo("</tr>");
  if (isset($vars['graph']))
  {
    echo('<tr class="entity">');
    echo("<td colspan = 3>");
    $graph_type = "ipsectunnel_" . $vars['graph'];

    $graph_array['height'] = "100";
    $graph_array['width']  = "215";
    $graph_array['to']     = $config['time']['now'];
    $graph_array['id']     = $tunnel['tunnel_id'];
    $graph_array['type']   = $graph_type;

    print_graph_row($graph_array);

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
