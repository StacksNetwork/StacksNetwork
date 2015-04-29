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

if ($vars['view'] == 'graphs' || $vars['view'] == 'minigraphs')
{
  if (isset($vars['graph'])) { $graph_type = "port_" . $vars['graph']; } else { $graph_type = "port_bits"; }
}

if (!$vars['view']) { $vars['view'] = trim($config['ports_page_default'],'/'); }

$link_array = array('page'    => 'device',
                    'device'  => $device['device_id'],
                    'tab' => 'ports');

$filters_array = (isset($vars['filters'])) ? $vars['filters'] : array('deleted' => TRUE);
$link_array['filters'] = $filters_array;

$navbar = array('brand' => "端口", 'class' => "navbar-narrow");

$navbar['options']['basic']['text']   = '基本';
$navbar['options']['details']['text'] = '详情';
$navbar['options']['arp']['text']     = 'ARP/NDP表';

if(dbFetchCell("SELECT COUNT(*) FROM `vlans_fdb` WHERE `device_id` = ?", array($device['device_id'])))
{
  $navbar['options']['fdb']['text'] = 'FDB表';
}

if(dbFetchCell("SELECT * FROM links AS L, ports AS I WHERE I.device_id = ? AND I.port_id = L.local_port_id", array($device['device_id'])))
{
  $navbar['options']['neighbours']['text'] = '邻居';
  $navbar['options']['map']['text']        = '拓扑图';
}
if(dbFetchCell("SELECT COUNT(*) FROM `ports` WHERE `ifType` = 'adsl' AND `device_id` = ?", array($device['device_id'])))
{
  $navbar['options']['adsl']['text'] = 'ADSL';
}

$navbar['options']['graphs']     = array('text' => '图像', 'class' => 'pull-right');
$navbar['options']['minigraphs'] = array('text' => '迷你视图', 'class' => 'pull-right');

foreach ($navbar['options'] as $option => $array)
{
  if ($vars['view'] == $option) { $navbar['options'][$option]['class'] .= " active"; }
  $navbar['options'][$option]['url'] = generate_url($link_array,array('view' => $option));
}

foreach (array('graphs', 'minigraphs') as $type)
{
  foreach ($config['graph_types']['port'] as $option => $data)
  {
    if ($vars['view'] == $type && $vars['graph'] == $option)
    {
      $navbar['options'][$type]['suboptions'][$option]['class'] = 'active';
      $navbar['options'][$type]['text'] .= ' ('.$data['name'].')';
    }
    $navbar['options'][$type]['suboptions'][$option]['text'] = $data['name'];
    $navbar['options'][$type]['suboptions'][$option]['url'] = generate_url($link_array, array('view' => $type, 'graph' => $option));
  }
}

// Quick filters
function is_filtered()
{
  global $filters_array, $port;

  return ($filters_array['up']       && $port['ifOperStatus'] == 'up' && $port['ifAdminStatus'] == 'up' && !$port['ignore'] && !$port['deleted']) ||
         ($filters_array['down']     && $port['ifOperStatus'] != 'up' && $port['ifAdminStatus'] == 'up') ||
         ($filters_array['shutdown'] && $port['ifAdminStatus'] == 'down') ||
         ($filters_array['ignored']  && $port['ignore']) ||
         ($filters_array['deleted']  && $port['deleted']);
}

if (isset($vars['view']) && ($vars['view'] == 'basic' || $vars['view'] == 'details' || $vars['view'] == 'graphs' || $vars['view'] == 'minigraphs'))
{
  // List filters
  $filter_options = array('up'       => '隐藏正常',
                          'down'     => '隐藏异常',
                          'shutdown' => '隐藏关闭',
                          'ignored'  => '隐藏已忽略',
                          'deleted'  => '隐藏已删除');
  // To be or not to be
  $filters_array['all'] = TRUE;
  foreach ($filter_options as $option => $text)
  {
    $filters_array['all'] = $filters_array['all'] && $filters_array[$option];
    $option_all[$option] = TRUE;
  }
  $filter_options['all'] = ($filters_array['all']) ? '全部重置' : '全部隐藏';

  // Generate filted links
  $navbar['options_right']['filters']['text'] = '快速过滤';
  foreach ($filter_options as $option => $text)
  {
    $option_array = array_merge($filters_array, array($option => TRUE));
    $navbar['options_right']['filters']['suboptions'][$option]['text'] = $text;
    if ($filters_array[$option])
    {
      $navbar['options_right']['filters']['class'] .= ' active';
      $navbar['options_right']['filters']['suboptions'][$option]['class'] = 'active';
      if ($option == 'all')
      {
        $option_array = array('disabled' => FALSE);
      } else {
        $option_array[$option] = FALSE;
      }
    } elseif ($option == 'all') {
      $option_array = $option_all;
    }
    $navbar['options_right']['filters']['suboptions'][$option]['url'] = generate_url($vars, array('filters' => $option_array));
  }
}

print_navbar($navbar);
unset($navbar);

if ($vars['view'] == 'minigraphs')
{
  $timeperiods = array('-1day','-1week','-1month','-1year');
  $from = '-1day';
  echo("<div style='display: block; clear: both; margin: auto; min-height: 500px;'>");
  unset ($seperator);

  // FIXME - FIX THIS. UGLY.
  foreach (dbFetchRows("SELECT * FROM ports WHERE device_id = ? ORDER BY ifIndex", array($device['device_id'])) as $port)
  {
    if (is_filtered()) { continue; }
    echo("<div style='display: block; padding: 3px; margin: 3px; min-width: 183px; max-width:183px; min-height:90px; max-height:90px; text-align: center; float: left; background-color: #e9e9e9;'>
    <div style='font-weight: bold;'>".short_ifname($port['ifDescr'])."</div>
    <a href=\"" . generate_port_url($port) . "\" onmouseover=\"return overlib('\
    <div style=\'font-size: 16px; padding:5px; font-weight: bold; color: #e5e5e5;\'>".$device['hostname']." - ".$port['ifDescr']."</div>\
    ".$port['ifAlias']." \
    <img src=\'graph.php?type=".$graph_type."&amp;id=".$port['port_id']."&amp;from=".$from."&amp;to=".$config['time']['now']."&amp;width=450&amp;height=150\'>\
    ', CENTER, LEFT, FGCOLOR, '#e5e5e5', BGCOLOR, '#e5e5e5', WIDTH, 400, HEIGHT, 150);\" onmouseout=\"return nd();\"  >".
    "<img src='graph.php?type=".$graph_type."&amp;id=".$port['port_id']."&amp;from=".$from."&amp;to=".$config['time']['now']."&amp;width=180&amp;height=45&amp;legend=no'>
    </a>
    <div style='font-size: 9px;'>".short_port_descr($port['ifAlias'])."</div>
    </div>");
  }
  echo("</div>");
} elseif ($vars['view'] == "arp" || $vars['view'] == "adsl" || $vars['view'] == "neighbours" || $vars['view'] == "fdb" || $vars['view'] == "map") {
  include("ports/".$vars['view'].".inc.php");
} else {
  if ($vars['view'] == "details") { $port_details = 1; }

  if ($vars['view'] == "graphs") { $table_class = "table-striped-two"; } else { $table_class = "table-striped"; }
  echo('<table class="table table-hover table-bordered table-condensed table-rounded '.$table_class.'">');

  echo('  <thead>');
  echo('<tr>');

  // Define column headers for the table
  $cols = array(
                'state' => NULL,
                'BLANK' => NULL,
                'port' => '端口',
                'graphs' => NULL,
                'traffic' => '流量',
                'speed' => '速率',
                'media' => '介质',
                'mac' => 'MAC地址',
                'details' => NULL);

  foreach ($cols as $sort => $col)
  {

    if ($sort == "state")
    {
        echo('<th class="state-marker"></th>');
    }
    elseif ($col == NULL)
    {
      echo('<th></th>');
    }
    elseif ($vars['sort'] == $sort)
    {
      echo('<th>'.$col.' *</th>');
    } else {
      echo('<th><a href="'. generate_url($vars, array('sort' => $sort)).'">'.$col.'</a></th>');
    }
  }

  echo('      </tr>');
  echo('  </thead>');

  $i = "1";

  // Make the port caches available easily to this code.
  global $port_cache, $port_index_cache;

  $sql  = "SELECT *, `ports`.`port_id` as `port_id`";
  $sql .= " FROM  `ports`";
  $sql .= " LEFT JOIN `ports-state` ON  `ports`.`port_id` =  `ports-state`.`port_id`";
  $sql .= " WHERE `device_id` = ? ORDER BY `ifIndex` ASC";
  $ports = dbFetchRows($sql, array($device['device_id']));

  // Sort ports, sharing code with global ports page.
  include("includes/port-sort.inc.php");

  // As we've dragged the whole database, lets pre-populate our caches :)
  foreach ($ports as $port)
  {
    $port_cache[$port['port_id']] = $port;
    $port_index_cache[$port['device_id']][$port['ifIndex']] = $port;
  }

  // Collect port IDs and ifIndexes who has adsl/cbqos/pagp/ip and other.
  $ports_has_ext = array();
  $ext_tables = array('ports_adsl', 'ports_cbqos', 'mac_accounting');
  if ($port_details)
  {
    $ext_tables = array_merge($ext_tables, array('ipv4_addresses', 'ipv6_addresses', 'pseudowires'));
    // Here stored ifIndex!
    $ports_has_ext['ports_pagp']       = dbFetchColumn("SELECT `pagpGroupIfIndex` FROM `ports`   WHERE `device_id` = ? GROUP BY `pagpGroupIfIndex`", array($device['device_id']));
    $ports_has_ext['ports_stack_low']  = dbFetchColumn("SELECT `port_id_low`  FROM `ports_stack` WHERE `device_id` = ? AND `port_id_high` != 0 GROUP BY `port_id_low`",  array($device['device_id']));
    $ports_has_ext['ports_stack_high'] = dbFetchColumn("SELECT `port_id_high` FROM `ports_stack` WHERE `device_id` = ? AND `port_id_low`  != 0 GROUP BY `port_id_high`", array($device['device_id']));
  }

  $where = ' IN ('.implode(',', array_keys($port_cache)).')';
  foreach ($ext_tables as $table)
  {
    // Here stored port_id!
    $ports_has_ext[$table] = dbFetchColumn("SELECT `port_id` FROM `$table` WHERE `port_id` $where GROUP BY `port_id`");
  }
  $ports_has_ext['links'] = dbFetchColumn("SELECT `local_port_id` FROM `links` WHERE `local_port_id` $where AND `remote_port_id` != 0 GROUP BY `local_port_id`");

  $ports_vlan_cache = array(); // Cache port vlans
  foreach (dbFetchRows('SELECT * FROM `ports_vlans` AS PV LEFT JOIN vlans AS V ON PV.`vlan` = V.`vlan_vlan` AND PV.`device_id` = V.`device_id`
                       WHERE PV.`device_id` = ? ORDER BY PV.`vlan`', array($device['device_id'])) as $entry)
  {
    $ports_vlan_cache[$entry['port_id']][$entry['vlan']] = $entry;
  }

  foreach ($ports as $port)
  {
    if (is_filtered()) { continue; }

    include("includes/print-interface.inc.php");

    $i++;
  }
  echo("</table>");
}

$page_title[] = "端口";

unset($ports_has_ext, $where, $ext_tables, $ports_vlan_cache);

// EOF
