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

$link_array = array('page'    => 'device',
                    'device'  => $device['device_id'],
                    'tab' => 'wifi');

$navbar = array('brand' => "WiFi", 'class' => "navbar-narrow");

$navbar['options']['overview']['text']       = '概述';
if ($device_ap_count > 0) { $navbar['options']['accesspoints']['text'] = '接入点'; }
if ($device_radio_count > 0) { $navbar['options']['radios']['text']       = '广播'; }
if ($device_wlan_count > 0) { $navbar['options']['wlans']['text']        = 'WLANs'; }
$navbar['options']['clients']['text']      = '客户端';

foreach ($navbar['options'] as $option => $array)
{
  if (!isset($vars['view'])) { $vars['view'] = "overview"; }
  if ($vars['view'] == $option) { $navbar['options'][$option]['class'] .= " active"; }
  $navbar['options'][$option]['url'] = generate_url($link_array,array('view' => $option));
}

if ($vars['view'] == "accesspoint") { $navbar['options']['accesspoints']['class'] .= " active"; }

print_navbar($navbar);
unset($navbar);

$page_title[] = "Wifi";

print_warning("请注意, WiFi部分是目前正在开发中, 随时更改和终止开发.");

switch ($vars['view'])
{
  case 'overview':
  case 'accesspoints':
  case 'radios':
  case 'wlans':
  case 'clients':
    include("wifi/".$vars['view'].".inc.php");
    break;
  default:
    echo('<h2>错误. 无章节 '.$vars['view'].'.<br /> 请告知Observium开发团队.</h2>');
    break;
}

// EOF
