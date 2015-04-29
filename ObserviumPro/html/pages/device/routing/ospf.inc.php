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

$page_title[] = "OSPF";

$navbar = array();
$navbar['brand'] = "OSPF";
$navbar['class'] = "navbar-narrow";

$ospf_instances = dbFetchRows("SELECT * FROM `ospf_instances` WHERE `device_id` = ?", array($device['device_id']));

echo('<table class="table table-hover table-bordered table-striped table-condensed">');

// Loop Instances (There can only ever really be once instance at the moment, thanks to douchebags who decided we should use undiscoverable context names instead of just making tables.)

foreach ($ospf_instances as $instance)
{

  $area_count = dbFetchCell("SELECT COUNT(*) FROM `ospf_areas` WHERE `device_id` = ?", array($device['device_id']));
  $port_count = dbFetchCell("SELECT COUNT(*) FROM `ospf_ports` WHERE `device_id` = ?", array($device['device_id']));
  $port_count_enabled = dbFetchCell("SELECT COUNT(*) FROM `ospf_ports` WHERE `ospfIfAdminStat` = 'enabled' AND `device_id` = ?", array($device['device_id']));
  $nbr_count = dbFetchCell("SELECT COUNT(*) FROM `ospf_nbrs` WHERE `device_id` = ?", array($device['device_id']));

  $query = "SELECT * FROM ipv4_addresses AS A, ports AS I WHERE ";
  $query .= "(A.ipv4_address = ? AND I.port_id = A.port_id)";
  $query .= " AND I.device_id = ?";
  $ipv4_host = dbFetchRow($query, array($peer['bgpPeerIdentifier'], $device['device_id']));

  if ($instance['ospfAdminStat']        == "enabled") { $enabled = '<span class="green">enabled</span>';
                                                        $row_class = 'up';                               } else { $enabled = '<span class="grey">disabled</span>';
                                                                                                                  $row_class = "disabled"; }
  if ($instance['ospfAreaBdrRtrStatus'] == "true")    { $abr     = '<span class="green">yes</span>';     } else { $abr     = '<span class="grey">no</span>'; }
  if ($instance['ospfASBdrRtrStatus']   == "true")    { $asbr    = '<span class="green">yes</span>';     } else { $asbr    = '<span class="grey">no</span>'; }

  echo('<thead><tr><th class="state-marker"></th></th><th>路由Id</th><th>状态</th><th>ABR</th><th>ASBR</th><th>区域</th><th>端口</th><th>邻居</th></tr></thead>');
  echo('<tr class="'.$row_class.'">');
  echo('  <td class="state-marker"></td>');
  echo('  <td class="entity-title">'.$instance['ospfRouterId'] . '</td>');
  echo('  <td>' . $enabled . '</td>');
  echo('  <td>' . $abr . '</td>');
  echo('  <td>' . $asbr . '</td>');
  echo('  <td>' . $area_count . '</td>');
  echo('  <td>' . $port_count . '('.$port_count_enabled.')</td>');
  echo('  <td>' . $nbr_count . '</td>');
  echo('</tr>');

  echo '</table>';

  /// Global Areas Table
  /// FIXME -- humanize_ospf_area()

  echo('<table class="table table-hover table-bordered table-striped table-condensed">');
  echo('<thead><tr><th class="state-marker"></th><th>区域Id</th><th>状态</th><th>验证类型</th><th>AS对外</th><th>区域LSAs</th><th>区域概述</th><th>端口</th></tr></thead>');

  /// Loop Areas
  $i_a = 0;
  foreach (dbFetchRows("SELECT * FROM `ospf_areas` WHERE `device_id` = ?", array($device['device_id'])) as $area)
  {

    $area_port_count = dbFetchCell("SELECT COUNT(*) FROM `ospf_ports` WHERE `device_id` = ? AND `ospfIfAreaId` = ?", array($device['device_id'], $area['ospfAreaId']));
    $area_port_count_enabled = dbFetchCell("SELECT COUNT(*) FROM `ospf_ports` WHERE `ospfIfAdminStat` = 'enabled' AND `device_id` = ? AND `ospfIfAreaId` = ?", array($device['device_id'], $area['ospfAreaId']));

    echo('<tr class="'.$area_row_class.'">');
    echo('  <td class="state-marker"></td>');
    echo('  <td class="entity-title">'.$area['ospfAreaId'] . '</td>');
    echo('  <td>' . $enabled . '</td>');
    echo '  <td>' . $area['ospfAuthType'] . '</td>';
    echo '  <td>' . $area['ospfImportAsExtern'] . '</td>';
    echo '  <td>' . $area['ospfAreaLsaCount'] . '</td>';
    echo '  <td>' . $area['ospfAreaSummary'] . '</td>';
    echo('  <td>' . $area_port_count . '('.$area_port_count_enabled.')</td>');
    echo('</tr>');

    echo('<tr>');
    echo('<td colspan=8>');

    /// Per-Area Ports Table
    /// FIXME -- humanize_ospf_port()

    echo('<table class="table table-hover table-bordered table-striped table-condensed table-rounded">');
    echo('<thead><tr><th class="state-marker"></th><th>端口</th><th>状态</th><th>端口类型</th><th>端口状态</th></tr></thead>');

    ///# Loop Ports
    $i_p = $i_a + 1;
    $p_sql   = "SELECT * FROM `ospf_ports` AS O, `ports` AS P WHERE O.`ospfIfAdminStat` = 'enabled' AND O.`device_id` = ? AND O.`ospfIfAreaId` = ? AND P.port_id = O.port_id";
    foreach (dbFetchRows($p_sql, array($device['device_id'], $area['ospfAreaId'])) as $ospfport)
    {

      if ($ospfport['ospfIfAdminStat'] == "enabled")
      {
        $port_enabled      = '<span class="green">enabled</span>';
        $port_row_class    = 'up';
      } else {
        $port_enabled      = '<span class="green">disabled</span>';
        $port_row_class    = 'disabled';
      }

      // Fix label
      $ospfport['label'] = $ospfport['ifDescr'];

      echo('<tr class="'.$port_row_class.'">');
      echo('  <td class="state-marker"></td>');
      echo('  <td><strong>'. generate_port_link($ospfport) . '</strong></td>');
      echo('  <td>' . $port_enabled . '</td>');
      echo('  <td>' . $ospfport['ospfIfType'] . '</td>');
      echo('  <td>' . $ospfport['ospfIfState'] . '</td>');
      echo('</tr>');

      $i_p++;
    } // End loop Ports

    echo('</table>');

    $i_a++;
  } // End loop areas
  echo '</table>';

  /// Global Neighbour Table
  /// FIXME -- humanize_ospf_neighbour()

  echo '<table class="table table-condensed table-bordered table-hover table-striped">';
  echo '<thead><tr><th class="state-marker"></th><th>路由Id</th><th>设备</th><th>IP地址</th><th>状态</th></tr></thead>';

  // Loop Neigbours
  $i_n = 1;
  foreach (dbFetchRows("SELECT * FROM `ospf_nbrs` WHERE `device_id` = ?", array($device['device_id'])) as $nbr)
  {

    $host = @dbFetchRow("SELECT * FROM ipv4_addresses AS A, ports AS I, devices AS D WHERE A.ipv4_address = ?
                         AND I.port_id = A.port_id AND D.device_id = I.device_id", array($nbr['ospfNbrRtrId']));

    if (is_array($host)) { $rtr_id = generate_device_link($host); } else { $rtr_id = "unknown"; }

    echo('<tr class="' . $port_row_class . '">');
    echo('  <td class="state-marker"></td>');
    echo('  <td><span class="entity-title">' . $nbr['ospfNbrRtrId'] . '</span></td>');
    echo('  <td>' . $rtr_id . '</td>');
    echo('  <td>' . $nbr['ospfNbrIpAddr'] . '</td>');
    echo('  <td>');
    switch ($nbr['ospfNbrState'])
    {
      case 'full':
        echo('<span class="green">'.$nbr['ospfNbrState'].'</span>');
        break;
      case 'down':
        echo('<span class="red">'.$nbr['ospfNbrState'].'</span>');
        break;
      default:
        echo('<span class="blue">'.$nbr['ospfNbrState'].'</span>');
        break;
    }
    echo('</td>');
    echo('</tr>');

    $i_n++;

  }

  echo('</table>');
  echo('</td>');
  echo('</tr>');

  $i_i++;
} // End loop instances

echo('</table>');

// EOF
