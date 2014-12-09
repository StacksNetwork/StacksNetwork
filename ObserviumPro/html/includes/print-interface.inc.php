<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 *   This file prints a table row for each interface
 *   Various port properties are processed by humanize_port(), generating class and description.
 *
 * @package    observium
 * @subpackage webinterface
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

$port['device_id'] = $device['device_id'];
$port['hostname'] = $device['hostname'];

// Process port properties and generate printable values
humanize_port($port);

if (!isset($ports_has_ext['ports_adsl']) || in_array($port['port_id'], $ports_has_ext['ports_adsl']))
{
  $port_adsl = dbFetchRow("SELECT * FROM `ports_adsl` WHERE `port_id` = ?", array($port['port_id']));
}

if ($port['ifInErrors_delta'] > 0 || $port['ifOutErrors_delta'] > 0)
{
  $port['tags'] .= generate_port_link($port, '<span class="label label-important">错误</span>', 'port_errors');
}

if ($port['deleted'] == '1')
{
  $port['tags'] .= '<a href="'.generate_url(array('page' => 'deleted-ports')).'"><span class="label label-important">已删除</span></a>';
}

if (isset($ports_has_ext['ports_cbqos']))
{
  if (in_array($port['port_id'], $ports_has_ext['ports_cbqos']))
  {
    $port['tags'] .= '<a href="' . generate_port_url($port, array('view' => 'cbqos')) . '"><span class="label label-info">CBQoS</span></a>';
  }
}
else if (dbFetchCell("SELECT COUNT(*) FROM `ports_cbqos` WHERE `port_id` = ?", array($port['port_id'])))
{
  $port['tags'] .= '<a href="' . generate_port_url($port, array('view' => 'cbqos')) . '"><span class="label label-info">CBQoS</span></a>';
}

if (isset($ports_has_ext['mac_accounting']))
{
  if (in_array($port['port_id'], $ports_has_ext['mac_accounting']))
  {
    $port['tags'] .= '<a href="' . generate_port_url($port, array('view' => 'macaccounting')) . '"><span class="label label-info">MAC</span></a>';
  }
}
else if (dbFetchCell("SELECT COUNT(*) FROM `mac_accounting` WHERE `port_id` = ?", array($port['port_id'])))
{
  $port['tags'] .= '<a href="' . generate_port_url($port, array('view' => 'macaccounting')) . '"><span class="label label-info">MAC</span></a>';
}

echo('<tr class="'.$port['row_class'].'" onclick="location.href=\'' . generate_port_url($port) . '\'" style="cursor: pointer;">
         <td style="width: 1px; background-color: '.$port['table_tab_colour'].'; margin: 0px; padding: 0px; width: 10px;"></td>
         <td style="width: 1px;"></td>
         <td style="width: 350px;">');

echo("        <span class='entity-title'>
              " . generate_port_link($port) . " ".$port['tags']."
           </span><br /><span class=small>".htmlentities($port['ifAlias'])."</span>");

if ($port['ifAlias']) { echo("<br />"); }

unset ($break);

if ($port_details)
{
  if (!isset($ports_has_ext['ipv4_addresses']) || in_array($port['port_id'], $ports_has_ext['ipv4_addresses']))
  {
    foreach (dbFetchRows("SELECT * FROM `ipv4_addresses` WHERE `port_id` = ?", array($port['port_id'])) as $ip)
    {
      echo($break ."<a class=small href=\"javascript:popUp('/netcmd.php?cmd=whois&amp;query=".$ip['ipv4_address']."')\">".$ip['ipv4_address']."/".$ip['ipv4_prefixlen']."</a>");
      $break = "<br />";
    }
  }
  if (!isset($ports_has_ext['ipv6_addresses']) || in_array($port['port_id'], $ports_has_ext['ipv6_addresses']))
  {
    foreach (dbFetchRows("SELECT * FROM `ipv6_addresses` WHERE `port_id` = ?", array($port['port_id'])) as $ip6)
    {
      echo($break ."<a class=small href=\"javascript:popUp('/netcmd.php?cmd=whois&amp;query=".$ip6['ipv6_address']."')\">".Net_IPv6::compress($ip6['ipv6_address'])."/".$ip6['ipv6_prefixlen']."</a>");
      $break = "<br />";
    }
  }
}

//echo("</span>");

echo("</td><td style='width: 147px;'>");

if ($port_details)
{
  $port['graph_type'] = "port_bits";
  echo(generate_port_link($port, "<img src='graph.php?type=port_bits&amp;id=".$port['port_id']."&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=100&amp;height=20&amp;legend=no' alt=\"\" />"));
  $port['graph_type'] = "port_upkts";
  echo(generate_port_link($port, "<img src='graph.php?type=port_upkts&amp;id=".$port['port_id']."&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=100&amp;height=20&amp;legend=no' alt=\"\" />"));
  $port['graph_type'] = "port_errors";
  echo(generate_port_link($port, "<img src='graph.php?type=port_errors&amp;id=".$port['port_id']."&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=100&amp;height=20&amp;legend=no' alt=\"\" />"));
}

echo('</td><td style="width: 120px; white-space: nowrap;">');

if ($port['ifOperStatus'] == "up" || $port['ifOperStatus'] == "monitoring")
{
  // Colours generated by humanize_port
  echo '<i class="icon-circle-arrow-down" style="',$port['bps_in_style'], '"></i> <span class="small" style="',$port['bps_in_style'], '">' , formatRates($port['in_rate']) , '</span><br />',
       '<i class="icon-circle-arrow-up"   style="',$port['bps_out_style'],'"></i> <span class="small" style="',$port['bps_out_style'],'">' , formatRates($port['out_rate']), '</span><br />',
       '<i class="icon-circle-arrow-down" style="',$port['pps_in_style'], '"></i> <span class="small" style="',$port['pps_in_style'], '">' , format_bi($port['ifInUcastPkts_rate']), 'pps</span><br />',
       '<i class="icon-circle-arrow-up"   style="',$port['pps_out_style'],'"></i> <span class="small" style="',$port['pps_out_style'],'">' , format_bi($port['ifOutUcastPkts_rate']),'pps</span>';
}

echo('</td><td style="width: 75px;">');
if ($port['ifSpeed']) { echo("<span class=small>".humanspeed($port['ifSpeed'])."</span>"); }
echo("<br />");

if ($port['ifDuplex'] != "unknown") { echo("<span class=small>" . $port['ifDuplex'] . "</span>"); } else { echo("-"); }

if ($port['ifTrunk'])
{
  if ($port['ifVlan'])
  {
    // Native VLAN
    if (!isset($ports_vlan_cache))
    {
      $native_state = dbFetchCell('SELECT `state` FROM `ports_vlans` WHERE `device_id` = ? AND `port_id` = ?',    array($device['device_id'], $port['port_id']));
      $native_name  = dbFetchCell('SELECT `vlan_name` FROM vlans     WHERE `device_id` = ? AND `vlan_vlan` = ?;', array($device['device_id'], $port['ifVlan']));
    } else {
      $native_state = $ports_vlan_cache[$port['port_id']][$port['ifVlan']]['state'];
      $native_name  = $ports_vlan_cache[$port['port_id']][$port['ifVlan']]['vlan_name'];
    }
    switch ($vlan_state)
    {
      case 'blocking':   $class = 'text-error';   break;
      case 'forwarding': $class = 'text-success'; break;
      default:           $class = 'muted';
    }
    if (empty($native_name)) {$native_name = 'VLAN'.str_pad($port['ifVlan'], 4, '0', STR_PAD_LEFT); }
    $native_tooltip = 'NATIVE: <strong class='.$class.'>'.$port['ifVlan'].' ['.$native_name.']</strong><br />';
  }

  if (!isset($ports_vlan_cache))
  {
    $vlans = dbFetchRows('SELECT * FROM `ports_vlans` AS PV
                         LEFT JOIN vlans AS V ON PV.`vlan` = V.`vlan_vlan` AND PV.`device_id` = V.`device_id`
                         WHERE PV.`port_id` = ? AND PV.`device_id` = ? ORDER BY PV.`vlan`;', array($port['port_id'], $device['device_id']));
  } else {
    $vlans = $ports_vlan_cache[$port['port_id']];
  }
  $vlans_count = count($vlans);
  $rel = ($vlans_count || $native_tooltip) ? 'tooltip' : ''; // Hide tooltip for empty
  echo('<p class="small"><a data-rel="'.$rel.'" data-tooltip="<div class=\'small\' style=\'max-width: 320px; text-align: justify;\'>'.$native_tooltip);
  if ($vlans_count)
  {
    echo('ALLOWED: ');
    $vlan_prev = 0;
    foreach ($vlans as $vlan)
    {
      if ($vlans_count > 20)
      {
        // Aggregate VLANs
        $last_char = $vlans_aggr[strlen($vlans_aggr)-1];
        if ($vlan_prev == 0)
        {
          $vlans_aggr = '<strong>'.$vlan['vlan'];
        } elseif (is_numeric($last_char))
        {
          $vlans_aggr .= ($vlan['vlan']-1 == $vlan_prev) ? '-' : ', '.$vlan['vlan'];
        } elseif ($last_char == '-')
        {
          if ($vlan['vlan']-1 == $vlan_prev)
          {
            $vlan_prev = $vlan['vlan'];
            continue;
          } else {
            $vlans_aggr .= $vlan_prev.', '.$vlan['vlan'];
          }
        } else {
          $vlans_aggr .= $vlan['vlan'];
        }
        $vlan_prev = $vlan['vlan'];
      } else {
        // List VLANs
        switch ($vlan['state'])
        {
          case 'blocking':   $class = 'text-error'; break;
          case 'forwarding': $class = 'text-success';  break;
          default:           $class = 'muted';
        }
        if (empty($vlan['vlan_name'])) { 'VLAN'.str_pad($vlan['vlan'], 4, '0', STR_PAD_LEFT); }
        echo("<strong class=".$class.">".$vlan['vlan'] ." [".$vlan['vlan_name']."]</strong><br />");
      }
    }
    if ($vlan_prev)
    {
      // End aggregate VLANs
      $last_char = $vlans_aggr[strlen($vlans_aggr)-1];
      if ($last_char == '-')
      {
        $vlans_aggr = substr($vlans_aggr, 0, -1);
      } elseif ($last_char == ' ') {
        $vlans_aggr = substr($vlans_aggr, 0, -2);
      }
      echo($vlans_aggr.'</strong>');
    }
  }
  echo('</div>">'.$port['ifTrunk'].'</a></p>');
}
else if ($port['ifVlan'])
{
  if (!isset($ports_vlan_cache))
  {
    $native_state = dbFetchCell('SELECT `state` FROM `ports_vlans` WHERE `device_id` = ? AND `port_id` = ?',    array($device['device_id'], $port['port_id']));
    $native_name  = dbFetchCell('SELECT `vlan_name` FROM vlans     WHERE `device_id` = ? AND `vlan_vlan` = ?;', array($device['device_id'], $port['ifVlan']));
  } else {
    $native_state = $ports_vlan_cache[$port['port_id']][$port['ifVlan']]['state'];
    $native_name  = $ports_vlan_cache[$port['port_id']][$port['ifVlan']]['vlan_name'];
  }
  switch ($vlan_state)
  {
    case 'blocking':   $class = 'text-error';   break;
    case 'forwarding': $class = 'text-success'; break;
    default:           $class = 'muted';
  }
  $rel = ($vlan_name) ? 'tooltip' : ''; // Hide tooltip for empty
  echo('<br /><span data-rel="'.$rel.'" class="small '.$class.'"  data-tooltip="<strong class=\'small '.$class.'\'>'.$port['ifVlan'].' ['.$vlan_name.']</strong>">VLAN ' . $port['ifVlan'] . '</span>');
}
else if ($port['ifVrf'])
{
  $vrf_name = dbFetchCell("SELECT `vrf_name` FROM `vrfs` WHERE `vrf_id` = ?", array($port['ifVrf']));
  echo('<span class="small text-warning" data-rel="tooltip" data-tooltip="VRF">'.$vrf_name.'</span>');
}

if ($port_adsl['adslLineCoding'])
{
  echo("</td><td style='width: 150px;'>");
  echo($port_adsl['adslLineCoding']."/" . rewrite_adslLineType($port_adsl['adslLineType']));
  echo("<br />");
  echo("Sync:".formatRates($port_adsl['adslAtucChanCurrTxRate']) . "/". formatRates($port_adsl['adslAturChanCurrTxRate']));
  echo("<br />");
  echo("Max:".formatRates($port_adsl['adslAtucCurrAttainableRate']) . "/". formatRates($port_adsl['adslAturCurrAttainableRate']));
  echo("</td><td style='width: 150px;'>");
  echo("Atten:".$port_adsl['adslAtucCurrAtn'] . "dB/". $port_adsl['adslAturCurrAtn'] . "dB");
  echo("<br />");
  echo("SNR:".$port_adsl['adslAtucCurrSnrMgn'] . "dB/". $port_adsl['adslAturCurrSnrMgn']. "dB");
} else {
  echo("</td><td style='width: 150px;'>");
  if ($port['ifType'] && $port['ifType'] != "") { echo("<span class=small>" . $port['human_type'] . "</span>"); } else { echo("-"); }
  echo("<br />");
  if ($ifHardType && $ifHardType != "") { echo("<span class=small>" . $ifHardType . "</span>"); } else { echo("-"); }
  echo("</td><td style='width: 150px;'>");
  if ($port['ifPhysAddress'] && $port['ifPhysAddress'] != "") { echo("<span class=small>" . $port['human_mac'] . "</span>"); } else { echo("-"); }
  echo("<br />");
  if ($port['ifMtu'] && $port['ifMtu'] != "") { echo("<span class=small>MTU " . $port['ifMtu'] . "</span>"); } else { echo("-"); }
}

echo("</td>");
echo("<td style='width: 375px' class=small>");

if ($port_details)
{
  if (strpos($port['label'], "oopback") === FALSE && !$graph_type)
  {
    unset($br);

    if (!isset($ports_has_ext['links']) || in_array($port['port_id'], $ports_has_ext['links']))
    {
      foreach (dbFetchColumn("SELECT I.`port_id` FROM `links` AS L, `ports` AS I, `devices` AS D WHERE L.`local_port_id` = ? AND L.`remote_port_id` = I.`port_id` AND I.`device_id` = D.`device_id`", array($port['port_id'])) as $link_id)
      {
        $int_links[$link_id] = $link_id;
        $int_links_phys[$link_id] = 1;
      }
    }

    // Show which other devices are on the same subnet as this interface
    if (!isset($ports_has_ext['ipv4_addresses']) || in_array($port['port_id'], $ports_has_ext['ipv4_addresses']))
    {
      foreach (dbFetchColumn("SELECT A4.`ipv4_network_id` FROM `ipv4_addresses` AS A4
        LEFT JOIN `ipv4_networks` AS N4 ON A4.`ipv4_network_id` = N4.`ipv4_network_id`
        WHERE `port_id` = ? AND `ipv4_network` NOT IN (?) GROUP BY A4.`ipv4_network_id`", array($port['port_id'], $config['ignore_common_subnet'])) as $network_id)
      {
        $sql = "SELECT N.*, P.`port_id`, P.`device_id` FROM `ipv4_addresses` AS A, `ipv4_networks` AS N, `ports` AS P
                WHERE A.`port_id` = P.`port_id` AND P.`device_id` != ?
                AND A.`ipv4_network_id` = ? AND N.`ipv4_network_id` = A.`ipv4_network_id`
                AND P.`ifAdminStatus` = 'up'";

        $params = array($device['device_id'], $network_id);

        foreach (dbFetchRows($sql, $params) AS $new)
        {
          if ($cache['devices']['id'][$new['device_id']]['disabled'] && !$config['web_show_disabled']) { continue; }
          $int_links[$new['port_id']] = $new['port_id'];
          $int_links_v4[$new['port_id']][] = $new['ipv4_network'];
        }
      }
    }

    if (!isset($ports_has_ext['ipv6_addresses']) || in_array($port['port_id'], $ports_has_ext['ipv6_addresses']))
    {
      foreach (dbFetchColumn("SELECT A6.`ipv6_network_id` FROM `ipv6_addresses` AS A6
         LEFT JOIN `ipv6_networks` AS N6 ON A6.`ipv6_network_id` = N6.`ipv6_network_id`
         WHERE `port_id` = ? AND `ipv6_network` NOT IN (?) GROUP BY A6.`ipv6_network_id`", array($port['port_id'], $config['ignore_common_subnet'])) as $network_id)
      {
        $ipv6_network_id = $net['ipv6_network_id'];
        $sql = "SELECT P.`port_id`, P.`device_id` FROM `ipv6_addresses` AS A, `ipv6_networks` AS N, `ports` AS P
                WHERE A.`port_id` = P.`port_id` AND P.device_id != ?
                AND A.`ipv6_network_id` = ? AND N.`ipv6_network_id` = A.`ipv6_network_id`
                AND P.`ifAdminStatus` = 'up' AND A.`ipv6_origin` != 'linklayer' AND A.`ipv6_origin` != 'wellknown'";

        $params = array($device['device_id'], $network_id);

        foreach (dbFetchRows($sql, $params) AS $new)
        {
          if ($cache['devices']['id'][$new['device_id']]['disabled'] && !$config['web_show_disabled']) { continue; }
          $int_links[$new['port_id']] = $new['port_id'];
          $int_links_v6[$new['port_id']][] = $new['port_id'];
        }
      }
    }

    foreach ($int_links as $int_link)
    {
      $link_if  = get_port_by_id_cache($int_link);
      $link_dev = device_by_id_cache($link_if['device_id']);
      echo($br);

      if ($int_links_phys[$int_link]) { echo('<a alt="直接连接" class="oicon-connect"></a> '); }
      else { echo('<a alt="Same subnet" class="oicon-network-hub"></a> '); }

      echo("<b>" . generate_port_link($link_if, short_ifname($link_if['label'])) . " on " . generate_device_link($link_dev, short_hostname($link_dev['hostname'])) . "</b>");

      ## FIXME -- do something fancy here.

      if ($int_links_v6[$int_link]) { echo ' ', overlib_link('', '<span class="label label-success">IPv6</span>', implode("<br />", $int_links_v6[$int_link]), NULL); }
      if ($int_links_v4[$int_link]) { echo ' ', overlib_link('', '<span class="label label-info">IPv4</span>', implode("<br />", $int_links_v4[$int_link]), NULL); }
      $br = "<br />";
    }
  }

  if (!isset($ports_has_ext['pseudowires']) || in_array($port['port_id'], $ports_has_ext['pseudowires']))
  {
    foreach (dbFetchRows("SELECT * FROM `pseudowires` WHERE `port_id` = ?", array($port['port_id'])) as $pseudowire)
    {
      //`port_id`,`peer_device_id`,`peer_ldp_id`,`cpwVcID`,`cpwOid`
  #    $pw_peer_dev = dbFetchRow("SELECT * FROM `devices` WHERE `device_id` = ?", array($pseudowire['peer_device_id']));
      $pw_peer_int = dbFetchRow("SELECT * FROM `ports` AS I, `pseudowires` AS P WHERE I.`device_id` = ? AND P.`cpwVcID` = ? AND P.`port_id` = I.`port_id`", array($pseudowire['peer_device_id'], $pseudowire['cpwVcID']));

  #    $pw_peer_int = get_port_by_id_cache($pseudowire['peer_device_id']);
      $pw_peer_dev = device_by_id_cache($pseudowire['peer_device_id']);

      if (is_array($pw_peer_int))
      {
        humanize_port($pw_peer_int);
        echo($br.'<i class="oicon-arrow-switch"></i> <strong>' . generate_port_link($pw_peer_int, short_ifname($pw_peer_int['label'])) .' on '. generate_device_link($pw_peer_dev, short_hostname($pw_peer_dev['hostname'])) . '</strong>');
      } else {
        echo($br.'<i class="oicon-arrow-switch"></i> <strong> VC ' . $pseudowire['cpwVcID'] .' on '. $pseudowire['peer_addr'] . '</strong>');
      }
      echo ' <span class="label">'.$pseudowire['pw_psntype'].'</span>';
      echo ' <span class="label">'.$pseudowire['pw_type'].'</span>';
      $br = "<br />";
    }
  }

  if (!isset($ports_has_ext['ports_pagp']) || in_array($port['ifIndex'], $ports_has_ext['ports_pagp']))
  {
    foreach (dbFetchRows("SELECT * FROM `ports` WHERE `pagpGroupIfIndex` = ? AND `device_id` = ?", array($port['ifIndex'], $device['device_id'])) as $member)
    {
      humanize_port($member);
      $pagp[$device['device_id']][$port['ifIndex']][$member['ifIndex']] = TRUE;
      echo($br.'<i class="oicon-arrow-join"></i> <strong>' . generate_port_link($member) . ' [PAgP]</strong>');
      $br = "<br />";
    }
  }

  if ($port['pagpGroupIfIndex'] && $port['pagpGroupIfIndex'] != $port['ifIndex'])
  {
    $pagp[$device['device_id']][$port['pagpGroupIfIndex']][$port['ifIndex']] = TRUE;
    $parent = dbFetchRow("SELECT * FROM `ports` WHERE `ifIndex` = ? and `device_id` = ?", array($port['pagpGroupIfIndex'], $device['device_id']));
    humanize_port($parent);
    echo($br.'<i class="oicon-arrow-split"></i> <strong>' . generate_port_link($parent) . ' [PAgP]</strong>');
    $br = "<br />";
  }

  if (!isset($ports_has_ext['ports_stack_low']) || in_array($port['ifIndex'], $ports_has_ext['ports_stack_low']))
  {
    foreach (dbFetchRows("SELECT * FROM `ports_stack` WHERE `port_id_low` = ? and `device_id` = ?", array($port['ifIndex'], $device['device_id'])) as $higher_if)
    {
      if ($higher_if['port_id_high'])
      {
        if ($pagp[$device['device_id']][$higher_if['port_id_high']][$port['ifIndex']]) { continue; } // Skip if same PAgP port
        $this_port = get_port_by_index_cache($device['device_id'], $higher_if['port_id_high']);
        if (is_array($this_port))
        {
          echo($br.'<i class="oicon-arrow-split"></i> <strong>' . generate_port_link($this_port) . '</strong>');
          $br = "<br />";
        }
      }
    }
  }

  if (!isset($ports_has_ext['ports_stack_high']) || in_array($port['ifIndex'], $ports_has_ext['ports_stack_high']))
  {
    foreach (dbFetchRows("SELECT * FROM `ports_stack` WHERE `port_id_high` = ? and `device_id` = ?", array($port['ifIndex'], $device['device_id'])) as $lower_if)
    {
      if ($lower_if['port_id_low'])
      {
        if ($pagp[$device['device_id']][$port['ifIndex']][$lower_if['port_id_low']]) { continue; } // Skip if same PAgP ports
        $this_port = get_port_by_index_cache($device['device_id'], $lower_if['port_id_low']);
        if (is_array($this_port))
        {
          echo($br.'<i class="oicon-arrow-join"></i> <strong>' . generate_port_link($this_port) . "</strong>");
          $br = "<br />";
        }
      }
    }
  }
}

unset($int_links, $int_links_v6, $int_links_v4, $int_links_phys, $br);

echo("</td></tr>");

// If we're showing graphs, generate the graph and print the img tags

if ($graph_type == "etherlike")
{
  $graph_file = get_port_rrdfilename($port, "dot3", TRUE);
} else {
  $graph_file = get_port_rrdfilename($port, NULL, TRUE);
}

if ($graph_type && is_file($graph_file))
{
  $type = $graph_type;

  echo("<tr><td colspan=9>");

  $graph_array['to']     = $config['time']['now'];
  $graph_array['id']     = $port['port_id'];
  $graph_array['type']   = $graph_type;

  print_graph_row($graph_array);

  echo("</td></tr>");
}

// EOF
