<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage webui
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

$ap['text'] = $ap['name'] . " " . $ap['type'];

echo("<tr onclick=\"location.href='" . generate_ap_url($ap) . "/'\" style='cursor: pointer;'>
         <td valign=top width=350>");
echo("        <span class=entity-title> " . generate_ap_link($ap,  " ".$ap['text']." </span><br />"));
echo("<span class=small>");
echo("$break".$ap['mac_addr']."<br>".$ap['type']. " - channel ".$ap['channel']);
echo("<br />txpow ".$ap['txpow']);
echo("</span>");
echo("</td><td width=100>");

echo("</td><td width=150>");
$ap['graph_type'] = "accesspoints_numasoclients";
echo(generate_ap_link($ap, "<img src='graph.php?type=".$ap['graph_type']."&amp;id=".$ap['accesspoint_id']."&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=100&amp;height=20&amp;legend=no&amp;bg=".str_replace("#","", $row_colour)."'>"));
echo("<br>\n");
$ap['graph_type'] = "accesspoints_radioutil";
echo(generate_ap_link($ap, "<img src='graph.php?type=".$ap['graph_type']."&amp;id=".$ap['accesspoint_id']."&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=100&amp;height=20&amp;legend=no&amp;bg=".str_replace("#","", $row_colour)."'>"));
echo("<br>\n");
$ap['graph_type'] = "accesspoints_interference";
echo(generate_ap_link($ap, "<img src='graph.php?type=".$ap['graph_type']."&amp;id=".$ap['accesspoint_id']."&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=100&amp;height=20&amp;legend=no&amp;bg=".str_replace("#","", $row_colour)."'>"));
echo("<br>\n");

echo("</td><td width=120>");

echo("<img src='images/icons/wireless.png' align=absmiddle /> ".format_bi($ap['numasoclients'])." 客户端<br />");
echo("<img src='images/icons/wireless.png' align=absmiddle /> ".format_bi($ap['radioutil'])." % busy<br />");
echo("<img src='images/icons/wireless.png' align=absmiddle /> ".format_bi($ap['interference'])." interference index<br />");

echo("</td></tr>");

if ($vars['tab'] == "accesspoint")
{
    $graphs = array('accesspoints_numasoclients' => '相关客户',
                    'accesspoints_interference' => '干扰',
                    'accesspoints_channel' => '频道',
                    'accesspoints_txpow' => '发射功率',
                    'accesspoints_radioutil' => '广播应用',
                    'accesspoints_nummonclients' => '监控客户端',
                    'accesspoints_nummonbssid' => '监控BSSIDs');

    foreach ($graphs as $key => $text)
    {

      $graph_array['height'] = "100";
      $graph_array['width']  = "215";
      $graph_array['to']     = $config['time']['now'];
      $graph_array['id']     = $ap['accesspoint_id'];
      $graph_array['type']   = $key;

      echo '<tr><td colspan=4>';
      echo '<h4>',$text,'</h4>';

      print_graph_row($graph_array);

      echo '</td></tr>';
    }

  echo("</td></tr>");

 }

?>
