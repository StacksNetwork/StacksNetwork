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

# This file prints a table row for each interface

$port['device_id'] = $device['device_id'];
$port['hostname'] = $device['hostname'];

$if_id = $port['port_id'];

humanize_port($port);

if ($port['ifInErrors_delta'] > 0 || $port['ifOutErrors_delta'] > 0)
{
  $error_img = generate_port_link($port,"<img src='images/16/chart_curve_error.png' alt='接口错误' border=0>","port_errors");
} else {
  $error_img = "";
}

echo("<tr valign=top onmouseover=\"this.style.backgroundColor='$list_highlight';\" onmouseout=\"this.style.backgroundColor='$row_colour';\"
onclick=\"location.href='device/".$device['device_id']."/port/".$port['port_id']."/'\" style='cursor: pointer;'>
 <td valign=top width=350>");
echo("        <span class=entity-title>
              " . generate_port_link($port, $port['ifIndex'] . ". ".rewrite_ifname($port['label'])) . "
           </span><br /><span class=small>".$port['ifAlias']."</span>");

if ($port['ifAlias']) { echo("<br />"); }

unset ($break);
if ($port_details)
{
  foreach (dbFetchRows("SELECT * FROM `ipv4_addresses` WHERE `port_id` = ?", array($port['port_id'])) as $ip)
  {
    echo("$break <a class=small href=\"javascript:popUp('netcmd.php?cmd=whois&amp;query=".$ip['ipv4_address']."')\">".$ip['ipv4_address']."/".$ip['ipv4_prefixlen']."</a>");
    $break = ",";
  }
  foreach (dbFetchRows("SELECT * FROM `ipv6_addresses` WHERE `port_id` = ?", array($port['port_id'])) as $ip6);
  {
    echo("$break <a class=small href=\"javascript:popUp('netcmd.php?cmd=whois&amp;query=".$ip6['ipv6_address']."')\">".Net_IPv6::compress($ip6['ipv6_address'])."/".$ip6['ipv6_prefixlen']."</a>");
    $break = ",";
  }
}

echo("</span>");

$width="120"; $height="40"; $from = $config['time']['day'];

echo("</td><td width=135>");
echo(formatRates($port['ifInOctets_rate'] * 8)." <img class='optionicon' src='images/icons/arrow_updown.png' /> ".formatRates($port['ifOutOctets_rate'] * 8));
echo("<br />");
$port['graph_type'] = "port_bits";
echo(generate_port_link($port, "<img src='graph.php?type=".$port['graph_type']."&amp;id=".$port['port_id']."&amp;from=".$from."&amp;to=".$config['time']['now']."&amp;width=".$width."&amp;height=".$height."&amp;legend=no&amp;bg=".
str_replace("#","", $row_colour)."'>", $port['graph_type']));

echo("</td><td width=135>");
echo("".formatRates($port['adslAturChanCurrTxRate']) . "/". formatRates($port['adslAtucChanCurrTxRate']));
echo("<br />");
$port['graph_type'] = "port_adsl_speed";
echo(generate_port_link($port, "<img src='graph.php?type=".$port['graph_type']."&amp;id=".$port['port_id']."&amp;from=".$from."&amp;to=".$config['time']['now']."&amp;width=".$width."&amp;height=".$height."&amp;legend=no&amp;bg=".
str_replace("#","", $row_colour)."'>", $port['graph_type']));

echo("</td><td width=135>");
echo("".formatRates($port['adslAturCurrAttainableRate']) . "/". formatRates($port['adslAtucCurrAttainableRate']));
echo("<br />");
$port['graph_type'] = "port_adsl_attainable";
echo(generate_port_link($port, "<img src='graph.php?type=".$port['graph_type']."&amp;id=".$port['port_id']."&amp;from=".$from."&amp;to=".$config['time']['now']."&amp;width=".$width."&amp;height=".$height."&amp;legend=no&amp;bg=".
str_replace("#","", $row_colour)."'>", $port['graph_type']));

echo("</td><td width=135>");
echo("".$port['adslAturCurrAtn'] . "dB/". $port['adslAtucCurrAtn'] . "dB");
echo("<br />");
$port['graph_type'] = "port_adsl_attenuation";
echo(generate_port_link($port, "<img src='graph.php?type=".$port['graph_type']."&amp;id=".$port['port_id']."&amp;from=".$from."&amp;to=".$config['time']['now']."&amp;width=".$width."&amp;height=".$height."&amp;legend=no&amp;bg=".
str_replace("#","", $row_colour)."'>", $port['graph_type']));

echo("</td><td width=135>");
echo("".$port['adslAturCurrSnrMgn'] . "dB/". $port['adslAtucCurrSnrMgn'] . "dB");
echo("<br />");
$port['graph_type'] = "port_adsl_snr";
echo(generate_port_link($port, "<img src='graph.php?type=".$port['graph_type']."&amp;id=".$port['port_id']."&amp;from=".$from."&amp;to=".$config['time']['now']."&amp;width=".$width."&amp;height=".$height."&amp;legend=no&amp;bg=".
str_replace("#","", $row_colour)."'>", $port['graph_type']));

echo("</td><td width=135>");
echo("".$port['adslAturCurrOutputPwr'] . "dBm/". $port['adslAtucCurrOutputPwr'] . "dBm");
echo("<br />");
$port['graph_type'] = "port_adsl_power";
echo(generate_port_link($port, "<img src='graph.php?type=".$port['graph_type']."&amp;id=".$port['port_id']."&amp;from=".$from."&amp;to=".$config['time']['now']."&amp;width=".$width."&amp;height=".$height."&amp;legend=no&amp;bg=".
str_replace("#","", $row_colour)."'>", $port['graph_type']));

#  if ($port['ifDuplex'] != 'unknown') { echo("<span class=small>Duplex " . $port['ifDuplex'] . "</span>"); } else { echo("-"); }

#    echo("</td><td width=150>");
#    echo($port_adsl['adslLineCoding']."/".$port_adsl['adslLineType']);
#    echo("<br />");
#    echo("Sync:".formatRates($port_adsl['adslAtucChanCurrTxRate']) . "/". formatRates($port_adsl['adslAturChanCurrTxRate']));
#    echo("<br />");
#    echo("Max:".formatRates($port_adsl['adslAtucCurrAttainableRate']) . "/". formatRates($port_adsl['adslAturCurrAttainableRate']));
#    echo("</td><td width=150>");
#    echo("Atten:".$port_adsl['adslAtucCurrAtn'] . "dB/". $port_adsl['adslAturCurrAtn'] . "dB");
#    echo("<br />");
#    echo("SNR:".$port_adsl['adslAtucCurrSnrMgn'] . "dB/". $port_adsl['adslAturCurrSnrMgn']. "dB");

echo("</td>");

?>
