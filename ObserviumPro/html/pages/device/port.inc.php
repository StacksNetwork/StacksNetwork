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

if (!isset($vars['view']) ) { $vars['view'] = "graphs"; }

if ($permit_ports)
{
  $sql  = "SELECT *, `ports`.`port_id` AS `port_id`";
  $sql .= " FROM  `ports`";
  $sql .= " LEFT JOIN  `ports-state` ON  `ports`.port_id = `ports-state`.port_id";
  $sql .= " WHERE `ports`.`port_id` = ?";

  $port = dbFetchRow($sql, array($vars['port']));

  $port_details = 1;

  if ($port['ifPhysAddress']) { $mac = (string)$port['ifPhysAddress']; }

  $color = "black";
  if      ($port['ifAdminStatus'] == "down") { $status = "<span class='grey'>禁用</span>"; }
  else if ($port['ifAdminStatus'] == "up")
  {
    if ($port['ifOperStatus'] == "down" || $port['ifOperStatus'] == "lowerLayerDown") { $status = "<span class='red'>启用 / 已断开</span>"; }
    else                                                                              { $status = "<span class='green'>启用 / 已连接</span>"; }
  }

  $i = 1;
  $show_all = 1;

  echo('<table class="table table-hover table-striped table-bordered table-condensed table-rounded">');

  include("includes/print-interface.inc.php");

  echo("</table>");

  // Start Navbar

  $link_array = array('page'    => 'device',
                      'device'  => $device['device_id'],
                      'tab'     => 'port',
                      'port'    => $port['port_id']);

  $navbar['options']['graphs']['text']   = '图像';

  if (OBSERVIUM_EDITION != 'community')
  {
    $navbar['options']['alerts']['text']   = '警报';
    $navbar['options']['alertlog']['text']   = '警报日志';
  }

  if (dbFetchCell("SELECT COUNT(*) FROM `sensors` WHERE `measured_class` = 'port' AND `measured_entity` = ? and `device_id` = ?", array($port['port_id'], $device['device_id'])))
  {
    $navbar['options']['sensors']['text'] = '传感器';
  }

  $navbar['options']['realtime']['text'] = '实时';   // FIXME CONDITIONAL

  if (dbFetchCell('SELECT COUNT(*) FROM `ip_mac` WHERE `port_id` = ?', array($port['port_id'])))
  {
    $navbar['options']['arp']['text']    = 'ARP/NDP表';
  }

  if (dbFetchCell("SELECT COUNT(*) FROM `vlans_fdb` WHERE `port_id` = ?", array($port['port_id'])))
  {
    $navbar['options']['fdb']['text']    = 'FDB表';
  }

  if (dbFetchCell("SELECT COUNT(*) FROM `ports_cbqos` WHERE `port_id` = ?", array($port['port_id'])))
  {
    $navbar['options']['cbqos']['text']    = 'CBQoS';
  }

  $navbar['options']['events']['text']   = '事件日志';

  if (dbFetchCell("SELECT COUNT(*) FROM `ports_adsl` WHERE `port_id` = ?", array($port['port_id'])))
  {
    $navbar['options']['adsl']['text'] = 'ADSL';
  }

  if (dbFetchCell('SELECT COUNT(*) FROM `ports` WHERE `pagpGroupIfIndex` = ? and `device_id` = ?', array($port['ifIndex'], $device['device_id'])))
  {
    $navbar['options']['pagp']['text'] = 'PAgP';
  }

  if (dbFetchCell('SELECT COUNT(*) FROM `ports_vlans` WHERE `port_id` = ? and `device_id` = ?', array($port['port_id'], $device['device_id'])))
  {
    $navbar['options']['vlans']['text'] = 'VLANs';
  }

  if (dbFetchCell('SELECT count(*) FROM mac_accounting WHERE port_id = ?', array($port['port_id'])) > '0')
  {
    $navbar['options']['macaccounting']['text'] = 'MAC核算';
  }

  if (dbFetchCell('SELECT COUNT(*) FROM juniAtmVp WHERE port_id = ?', array($port['port_id'])) > '0')
  {

    // FIXME ATM VPs
    // FIXME URLs BROKEN

    $navbar['options']['atm-vp']['text'] = 'ATM VPs';

    $graphs = array('bits', 'packets', 'cells', 'errors');
    foreach ($graphs as $type)
    {
      if ($vars['view'] == "atm-vp" && $vars['graph'] == $type) { $navbar['options']['atm-vp']['suboptions'][$type]['class'] = "active"; }
      $navbar['options']['atm-vp']['suboptions'][$type]['text'] = ucfirst($type);
      $navbar['options']['atm-vp']['suboptions'][$type]['url']  = generate_url($link_array,array('view'=>'atm-vc','graph'=>$type));
    }
  }

  if (OBSERVIUM_EDITION != 'community' && $_SESSION['userlevel'] == '10' && $config['enable_billing'])
  {
    $navbar['options_right']['bills'] = array('text' => '新建账单', 'icon' => 'oicon-money-coin', 'url' => generate_url(array('page' => 'bills', 'view' => 'add', 'port' => $port['port_id'])));
  }

  if ($_SESSION['userlevel'] == '10' )
  {
    // This doesn't exist yet.
    $navbar['options_right']['data']['text'] = '数据';
    $navbar['options_right']['data']['icon'] = 'oicon-application-list';
    $navbar['options_right']['data']['url'] = generate_url($link_array,array('view'=>'data'));
  }

  foreach ($navbar['options'] as $option => $array)
  {
    if ($vars['view'] == $option) { $navbar['options'][$option]['class'] .= " active"; }
    $navbar['options'][$option]['url'] = generate_url($link_array,array('view'=>$option));
  }

  $navbar['class'] = "navbar-narrow";
  $navbar['brand'] = "端口";

  print_navbar($navbar);
  unset($navbar);

  include($config['html_dir'] . '/pages/device/port/'.$vars['view'].'.inc.php');
} else {
  print_error('<h3>无效的设备/端口的组合</h3>
               端口/设备组合是无效的. 请重新键入并再试一次.');
}

// EOF
