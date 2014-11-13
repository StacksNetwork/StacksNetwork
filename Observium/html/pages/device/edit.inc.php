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

$link_array = array('page'    => 'device',
                    'device'  => $device['device_id'],
                    'tab'     => 'edit');

if ($_SESSION['userlevel'] < '7')
{
  print_error("Insufficient Privileges");
} else {
  $panes['device']   = '设备设置';
  $panes['snmp']     = 'SNMP';
  $panes['alerts']   = '报警';
  if ($config['enable_libvirt'] && $device['os'] == 'linux')
  {
    $panes['ssh']    = 'SSH'; // For now this option used only by 'libvirt-vminfo' discovery module
  }
  $panes['ports']    = '端口';
  $panes['sensors']  = '传感器';

  if (count($config['os'][$device['os']]['icons']))
  {
    $panes['icon']   = 'Icon';
  }

  $panes['modules']  = '模块';

  if ($config['enable_services'])
  {
    $panes['services'] = '服务';
  }

  if ($device_loadbalancer_count['netscaler_vsvr'])    { $panes['netscaler_vsvrs'] = 'NS vServers'; }
  if ($device_loadbalancer_count['netscaler_services']) { $panes['netscaler_svcs'] = 'NS Services'; }

  if ($device['os_group'] == 'unix' || $device['os'] == 'windows' || $device['os'] == 'generic')
  {
    $panes['ipmi']     = 'IPMI';
  }

  if ($device['os'] == 'windows')
  {
    $panes['wmi']    = 'WMI';
  }

  if ($device['os_group'] == 'unix' || $device['os'] == 'generic')
  {
    $panes['agent']  = '代理';
  }
  if ($device['os_group'] == 'unix' || $device['os'] == 'windows')
  {
    $panes['apps']   = '应用程序'; /// FIXME. Deprecated?
  }

  $navbar['brand'] = "编辑";
  $navbar['class'] = "navbar-narrow";

  foreach ($panes as $type => $text)
  {
    if (!isset($vars['section'])) { $vars['section'] = $type; }

    if ($vars['section'] == $type) { $navbar['options'][$type]['class'] = "active"; }
    $navbar['options'][$type]['url']  = generate_url($link_array,array('section'=>$type));
    $navbar['options'][$type]['text'] = $text;
  }
  $navbar['options_right']['delete']['url']  = generate_url($link_array,array('section'=>'delete'));
  $navbar['options_right']['delete']['text'] = 'Delete';
  $navbar['options_right']['delete']['icon'] = 'oicon-server--minus';
  if ($vars['section'] == 'delete') { $navbar['options_right']['delete']['class'] = 'active'; }
  print_navbar($navbar);

  $filename = $config['html_dir'] . '/pages/device/edit/' . mres($vars['section']) . '.inc.php';
  if (is_file($filename))
  {
    include($filename);
  }
}
unset($filename, $navbar, $panes, $link_array);

$pagetitle[] = "设置";

// EOF
