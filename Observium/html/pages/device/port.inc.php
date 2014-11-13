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

// If we've been given a 'ifdescr' variable, try to work out the port_id from this

if (is_array($device) && empty($vars['port']) && !empty($vars['ifdescr']))
{
  $vars['port'] = get_port_id_by_ifDescr(
    $device['device_id'],
    base64_decode($vars['ifdescr'])
  );
}

$sql  = "SELECT *, `ports`.`port_id` as `port_id`";
$sql .= " FROM  `ports`";
$sql .= " LEFT JOIN  `ports-state` ON  `ports`.port_id =  `ports-state`.port_id";
$sql .= " WHERE `ports`.`port_id` = ?";

$port = dbFetchRow($sql, array($vars['port']));

$port_details = 1;

$hostname = $device['hostname'];
$hostid   = $device['port_id'];
$ifname   = $port['ifDescr'];
$ifIndex   = $port['ifIndex'];
$speed = humanspeed($port['ifSpeed']);

$ifalias = $port['name'];

if ($port['ifPhysAddress']) { $mac = (string)$port['ifPhysAddress']; }

$color = "black";
if ($port['ifAdminStatus'] == "down") { $status = "<span class='grey'>Disabled</span>"; }
if ($port['ifAdminStatus'] == "up" && $port['ifOperStatus'] == "down") { $status = "<span class='red'>Enabled / Disconnected</span>"; }
if ($port['ifAdminStatus'] == "up" && $port['ifOperStatus'] == "up") { $status = "<span class='green'>Enabled / Connected</span>"; }

$i = 1;
$inf = rewrite_ifname($ifname);
$show_all = 1;

echo('<table class="table table-hover table-striped table-bordered table-condensed table-rounded">');

include("includes/print-interface.inc.php");

echo("</table>");

if ( strpos(strtolower($ifname), "vlan") !== false ) {  $broke = yes; }
if ( strpos(strtolower($ifname), "loopback") !== false ) {  $broke = yes; }

// Start Navbar

$link_array = array('page'    => 'device',
                    'device'  => $device['device_id'],
                    'tab' => 'port',
                    'port'    => $port['port_id']);

$navbar['options']['graphs']['text']   = '流量图';

if(EDITION != 'community') {
  $navbar['options']['alerts']['text']   = '报警';
}

if (dbFetchCell("SELECT COUNT(*) FROM `sensors` WHERE `measured_class` = 'port' AND `measured_entity` = ? and `device_id` = ?", array($port['port_id'], $device['device_id'])))
{ $navbar['options']['sensors']['text'] = '传感器'; }

$navbar['options']['realtime']['text'] = '实时';   // FIXME CONDITIONAL

if(dbFetchCell('SELECT COUNT(*) FROM `ip_mac` WHERE `port_id` = ?', array($port['port_id'])))
{ $navbar['options']['arp']['text']    = 'ARP/NDP 表'; }

if (dbFetchCell("SELECT COUNT(*) FROM `vlans_fdb` WHERE `port_id` = ?", array($port['port_id'])))
{ $navbar['options']['fdb']['text']    = 'FDB 表'; }

$navbar['options']['events']['text']   = '事件日志';

if (dbFetchCell("SELECT COUNT(*) FROM `ports_adsl` WHERE `port_id` = ?", array($port['port_id'])))
{ $navbar['options']['adsl']['text'] = 'ADSL'; }

if (dbFetchCell('SELECT COUNT(*) FROM `ports` WHERE `pagpGroupIfIndex` = ? and `device_id` = ?', array($port['ifIndex'], $device['device_id'])))
{ $navbar['options']['pagp']['text'] = 'PAgP'; }

if (dbFetchCell('SELECT COUNT(*) FROM `ports_vlans` WHERE `port_id` = ? and `device_id` = ?', array($port['port_id'], $device['device_id'])))
{ $navbar['options']['vlans']['text'] = 'VLANs'; }

if (dbFetchCell('SELECT count(*) FROM mac_accounting WHERE port_id = ?', array($port['port_id'])) > '0')
{ $navbar['options']['macaccounting']['text'] = 'MAC Accounting'; }

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

if(EDITION != 'community' && $_SESSION['userlevel'] == '10' && $config['enable_billing'])
{
  $navbar['options_right']['bills'] = array('text' => '创建账单', 'icon' => 'oicon-money-coin', 'url' => generate_url(array('page' => 'bills', 'view' => 'add', 'port' => $port['port_id'])));
}

if ($_SESSION['userlevel'] == '10' )
{
  // This doesn't exist yet.
  $navbar['options_right']['data']['text'] = 'Data';
  $navbar['options_right']['data']['icon'] = 'oicon-application-list';
  $navbar['options_right']['data']['url'] = generate_url($link_array,array('view'=>'data'));

}

foreach ($navbar['options'] as $option => $array)
{
  if ($vars['view'] == $option) { $navbar['options'][$option]['class'] .= " active"; }
  $navbar['options'][$option]['url'] = generate_url($link_array,array('view'=>$option));
}

$navbar['class'] = "navbar-narrow";
$navbar['brand'] = "Port";

print_navbar($navbar);
unset($navbar);

include("pages/device/port/".mres($vars['view']).".inc.php");

// EOF
