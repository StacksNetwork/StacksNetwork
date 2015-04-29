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

$page_title[] = "搜索";

$sections = array('ipv4' => 'IPv4地址', 'ipv6' => 'IPv6地址', 'mac' => 'MAC地址', 'arp' => 'ARP/NDP表', 'fdb' => 'FDB表');

if (dbFetchCell("SELECT COUNT(wifi_session_id) FROM wifi_sessions") > '0')
  $sections['dot1x'] = '.1x Sessions'; //Can be extended to include all dot1x sessions

$navbar['brand'] = "搜索";
$navbar['class'] = "navbar-narrow";

foreach ($sections as $section => $text)
{
  $type = strtolower($section);
  if (!isset($vars['search'])) { $vars['search'] = $section; }

  if ($vars['search'] == $section) { $navbar['options'][$section]['class'] = "active"; }
  $navbar['options'][$section]['url'] = generate_url(array('page' => 'search', 'search' => $section));
  $navbar['options'][$section]['text'] = $text;
}

print_navbar($navbar);

/// Little switch to provide some sanity checking.
switch ($vars['search'])
{
  case 'ipv4':
  case 'ipv6':
  case 'mac':
  case 'arp':
  case 'fdb':
  case 'dot1x':
    include('pages/search/'.$vars['search'].'.inc.php');
    break;
  default:
    echo("<h2>错误. 请汇报至Observium开发团队.</h2>");
    break;
}

// EOF
