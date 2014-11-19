<?php

if (!is_integer($i/2)) { $bg_colour = $list_colour_a; } else { $bg_colour = $list_colour_b; }

echo("<tr bgcolor='$bg_colour'>");

echo("<td width=100 class=entity-title> Vlan " . $vlan['vlan_vlan'] . "</td>");
echo("<td width=200 class=small>" . $vlan['vlan_name'] . "</td>");
echo("<td class=strong>");

  $vlan_ports = array();
  $otherports = dbFetchRows("SELECT * FROM `ports_vlans` AS V, `ports` as P WHERE V.`device_id` = ? AND V.`vlan` = ? AND P.port_id = V.port_id", array($device['device_id'], $vlan['vlan_vlan']));
  foreach ($otherports as $otherport)
  {
   $vlan_ports[$otherport['ifIndex']] = $otherport;
  }
  $otherports = dbFetchRows("SELECT * FROM ports WHERE `device_id` = ? AND `ifVlan` = ?", array($device['device_id'], $vlan['vlan_vlan']));
  foreach ($otherports as $otherport)
  {
   $vlan_ports[$otherport['ifIndex']] = array_merge($otherport, array('untagged' => '1'));
  }
  ksort($vlan_ports);

foreach ($vlan_ports as $port)
{
  humanize_port($port);
  if ($vars['view'] == "graphs")
  {
    echo("<div style='display: block; padding: 2px; margin: 2px; min-width: 139px; max-width:139px; min-height:85px; max-height:85px; text-align: center; float: left; background-color: ".$list_colour_b_b.";'>
    <div style='font-weight: bold;'>".short_ifname($port['ifDescr'])."</div>
    <a href='device/device=".$device['device_id']."/tab=port/port=".$port['port_id']."/' onmouseover=\"return overlib('\
    <div style=\'font-size: 16px; padding:5px; font-weight: bold; color: #e5e5e5;\'>".$device['hostname']." - ".$port['ifDescr']."</div>\
    ".$port['ifAlias']." \
    <img src=\'graph.php?type=$graph_type&amp;id=".$port['port_id']."&amp;from=" .$config['time']['twoday']."&amp;to=".$config['time']['now']."&amp;width=450&amp;height=150\'>\
    ', CENTER, LEFT, FGCOLOR, '#e5e5e5', BGCOLOR, '#e5e5e5', WIDTH, 400, HEIGHT, 150);\" onmouseout=\"return nd();\"  >".
    "<img src='graph.php?type=$graph_type&amp;id=".$port['port_id']."&amp;from=".$config['time']['twoday']."&amp;to=".$config['time']['now']."&amp;width=132&amp;height=40&amp;legend=no'>
    </a>
    <div style='font-size: 9px;'>".short_port_descr($port['ifAlias'])."</div>
   </div>");
  }
  else
  {
    echo($vlan['port_sep'] . generate_port_link($port, short_ifname($port['label'])));
    $vlan['port_sep'] = ", ";
    if ($port['untagged']) { echo("(U)"); }

  }
}

echo('</td></tr>');

?>
