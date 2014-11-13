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

$pagetitle[] = "伪流量";

if(!isset($vars['view'])) { $vars['view'] = 'detail'; }

$link_array = array('page' => 'pseudowires');

print_optionbar_start();

echo('<span style="font-weight: bold;">伪流量</span> &#187; ');

if ($vars['view'] == "detail") { echo('<span class="pagemenu-selected">'); }
echo(generate_link("详情",$link_array,array('view'=> 'detail')));
if ($vars['view'] == "detail") { echo('</span>'); }

echo(" | ");

if ($vars['view'] == "minigraphs") { echo('<span class="pagemenu-selected">'); }
echo(generate_link("标准流量图",$link_array,array('view' => "minigraphs")));
if ($vars['view'] == "minigraphs") { echo('</span>'); }

print_optionbar_end();

echo("<table cellpadding=5 cellspacing=0 class=devicetable width=100%>");

foreach (dbFetchRows("SELECT * FROM pseudowires AS P, ports AS I WHERE P.port_id = I.port_id AND I.device_id = ? ORDER BY I.ifDescr", array($device['device_id'])) as $pw_a)
{
  $i = 0;
  while ($i < count($linkdone))
  {
    $thislink = $pw_a['device_id'] . $pw_a['port_id'];
    if ($linkdone[$i] == $thislink) { $skip = "yes"; }
    $i++;
  }

  if ($peer_device_id) { $peer_device = get_device_by_id_cache($peer_device_id); }

  $pw_b = dbFetchRow("SELECT * from `devices` AS D, `ports` AS I, `pseudowires` AS P WHERE D.device_id = ? AND D.device_id = I.device_id
                      AND P.cpwVcID = ? AND P.port_id = I.port_id", array($pw_a['peer_device_id'], $pw_a['cpwVcID']));

  if (!port_permitted($pw_a['port_id'])) { $skip = "yes"; }
  if (!port_permitted($pw_b['port_id'])) { $skip = "yes"; }

  if ($skip)
  {
    unset($skip);
  } else {
    if ($bg == "ffffff") { $bg = "e5e5e5"; } else { $bg="ffffff"; }
    echo("<tr style=\"background-color: #$bg;\"><td rowspan=2 style='font-size:18px; padding:4px;'>".$pw_a['cpwVcID']."</td><td>".generate_port_link($pw_a)."</td>
                                                                                          <td rowspan=2> <img src='images/16/arrow_right.png'> </td>
                                                                                          <td>".generate_device_link($peer_device)."</td><td>".generate_port_link($pw_b)."</td></tr>");
    echo("<tr style=\"background-color: #$bg;\"><td colspan=2>".$pw_a['ifAlias']."</td><td>".$pw_b['ifAlias']."</td></tr>");

    if ($vars['view'] == "minigraphs")
    {
      echo("<tr style=\"background-color: #$bg;\"><td></td><td colspan=2>");

      if ($pw_a)
      {
        $pw_a['width'] = "150";
        $pw_a['height'] = "30";
        $pw_a['from'] = $config['time']['day'];
        $pw_a['to'] = $config['time']['now'];
        $pw_a['bg'] = $bg;
        $types = array('bits','upkts','errors');
        foreach ($types as $graph_type)
        {
          $pw_a['graph_type'] = "port_".$graph_type;
          generate_port_thumbnail($pw_a);
        }
      }
      echo("</td><td></td><td colspan=2>");

      if ($pw_b)
      {
        $pw_b['width'] = "150";
        $pw_b['height'] = "30";
        $pw_b['from'] = $config['time']['day'];
        $pw_b['to'] = $config['time']['now'];
        $pw_b['bg'] = $bg;
        $types = array('bits','upkts','errors');
        foreach ($types as $graph_type)
        {
          $pw_b['graph_type'] = "port_".$graph_type;
          generate_port_thumbnail($pw_b);
        }
      }

      echo("</td></tr>");
    }

    $linkdone[] = $pw_b['device_id'] . $pw_b['port_id'];
  }
}

echo("</table>");

?>
