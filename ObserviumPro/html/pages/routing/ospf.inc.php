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

$i_i = "0";

echo('<table class="table table-hover table-bordered table-striped table-condensed table-rounded">');
echo('<thead><tr><th>设备</th><th>路由Id</th><th>状态</th><th>ABR</th><th>ASBR</th><th>区域</th><th>端口</th><th>邻居</th></tr></thead>');

// Loop Instances

foreach (dbFetchRows("SELECT * FROM `ospf_instances` WHERE `ospfAdminStat` = 'enabled'") as $instance)
{
  $device = device_by_id_cache($instance['device_id']);

  $area_count = dbFetchCell('SELECT COUNT(*) FROM `ospf_areas` WHERE `device_id` = ?', array($device['device_id']));
  $port_count = dbFetchCell('SELECT COUNT(*) FROM `ospf_ports` WHERE `device_id` = ?', array($device['device_id']));
  $port_count_enabled = dbFetchCell("SELECT COUNT(*) FROM `ospf_ports` WHERE `ospfIfAdminStat` = 'enabled' AND `device_id` = ?", array($device['device_id']));
  $neighbour_count = dbFetchCell('SELECT COUNT(*) FROM `ospf_nbrs` WHERE `device_id` = ?', array($device['device_id']));

  $ip_query = "SELECT * FROM ipv4_addresses AS A, ports AS I WHERE ";
  $ip_query .= "(A.ipv4_address = ? AND I.port_id = A.port_id)";
  $ip_query .= " AND I.device_id = ?";

  $ipv4_host = dbFetchRow($ip_query, array($peer['bgpPeerIdentifier'], $device['device_id']));

  if ($instance['ospfAdminStat'] == "enabled") { $enabled = '<span style="color: #00aa00">启用</span>'; } else { $enabled = '<span style="color: #aaaaaa">禁用</span>'; }
  if ($instance['ospfAreaBdrRtrStatus'] == "true") { $abr = '<span style="color: #00aa00">是</span>'; } else { $abr = '<span style="color: #aaaaaa">否</span>'; }
  if ($instance['ospfASBdrRtrStatus'] == "true") { $asbr = '<span style="color: #00aa00">是</span>'; } else { $asbr = '<span style="color: #aaaaaa">否</span>'; }

  echo('<tr>');
  echo('  <td class="entity-title">'.generate_device_link($device, 0, array('tab' => 'routing', 'proto' => 'ospf')). '</td>');
  echo('  <td class="entity-title">'.$instance['ospfRouterId'] . '</td>');
  echo('  <td>' . $enabled . '</td>');
  echo('  <td>' . $abr . '</td>');
  echo('  <td>' . $asbr . '</td>');
  echo('  <td>' . $area_count . '</td>');
  echo('  <td>' . $port_count . '('.$port_count_enabled.')</td>');
  echo('  <td>' . $neighbour_count . '</td>');
  echo('</tr>');

  $i_i++;
} // End loop instances

echo('</table>');

// EOF
