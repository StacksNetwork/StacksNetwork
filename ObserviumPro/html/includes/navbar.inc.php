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

// FIXME - this could do with some performance improvements, i think. possible rearranging some tables and setting flags at poller time (nothing changes outside of then anyways)

$packages = dbFetchCell("SELECT COUNT(*) from `packages`");
?>

<header class="navbar navbar-fixed-top">
    <div class="navbar-inner">
      <div class="container">
        <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target="#main-nav">
          <span class="oicon-bar"></span>
          <span class="oicon-bar"></span>
          <span class="oicon-bar"></span>
        </button>
        <a class="brand brand-observium" href="<?php generate_url(''); ?>">&nbsp;</a>
        <div class="nav-collapse" id="main-nav">
          <ul class="nav">
<?php

//////////// Build main "globe" menu
$navbar['observium'] = array('url' => generate_url(array('page' => 'overview')), 'icon' => 'oicon-globe-model');

$navbar['observium']['entries'][] = array('title' => '概述', 'url' => generate_url(array('page' => 'overview')), 'icon' => 'oicon-globe-model');
$navbar['observium']['entries'][] = array('divider' => TRUE);

if (isset($config['enable_map']) && $config['enable_map'])
{ // FIXME link is wrong. Is this a supported feature?
  $navbar['observium']['entries'][] = array('title' => '网络拓扑', 'url' => generate_url(array('page' => 'overview')), 'icon' => 'oicon-map');
}

$navbar['observium']['entries'][] = array('title' => '事件日志', 'url' => generate_url(array('page' => 'eventlog')), 'icon' => 'oicon-clipboard-audit');

if (isset($config['enable_syslog']) && $config['enable_syslog'])
{
  $navbar['observium']['entries'][] = array('title' => '系统日志', 'url' => generate_url(array('page' => 'syslog')), 'icon' => 'oicon-clipboard-eye');
}

$navbar['observium']['entries'][] = array('title' => '轮询信息', 'url' => generate_url(array('page' => 'pollerlog')), 'icon' => 'oicon-clipboard-report-bar');
$navbar['observium']['entries'][] = array('divider' => TRUE);

if (OBSERVIUM_EDITION != 'community')
{
  $navbar['observium']['entries'][] = array('title' => '警报', 'url' => generate_url(array('page' => 'alerts')), 'icon' => 'oicon-bell');
  $navbar['observium']['entries'][] = array('title' => '警报检测', 'url' => generate_url(array('page' => 'alert_checks')), 'icon' => 'oicon-eye');
  $navbar['observium']['entries'][] = array('title' => '警报日志', 'url' => generate_url(array('page' => 'alert_log')), 'icon' => 'oicon-bell--exclamation');
  $navbar['observium']['entries'][] = array('divider' => TRUE);
  $navbar['observium']['entries'][] = array('title' => '分组', 'url' => generate_url(array('page' => 'groups')), 'icon' => 'oicon-category');
  $navbar['observium']['entries'][] = array('divider' => TRUE);
}

$navbar['observium']['entries'][] = array('title' => '清单', 'url' => generate_url(array('page' => 'inventory')), 'icon' => 'oicon-wooden-box');
$navbar['observium']['entries'][] = array('divider' => TRUE);

if ($packages)
{
  $navbar['observium']['entries'][] = array('title' => '软件包', 'url' => generate_url(array('page' => 'packages')), 'icon' => 'oicon-box-zipper');
  $navbar['observium']['entries'][] = array('divider' => TRUE);
}

// Build search submenu
$search_sections = array('ipv4' => 'IPv4地址', 'ipv6' => 'IPv6地址', 'mac' => 'MAC地址', 'arp' => 'ARP/NDP表', 'fdb' => 'FDB表');
if (dbFetchCell("SELECT COUNT(wifi_session_id) FROM wifi_sessions") > '0') { $search_sections['dot1x'] = '.1x Sessions'; }

foreach ($search_sections as $search_page => $search_name)
{
  $search_menu[] = array('title' => $search_name, 'url' => generate_url(array('page' => 'search', 'search' => $search_page)), 'icon' => 'oicon-magnifier-zoom-actual');
}

$navbar['observium']['entries'][] = array('title' => '搜索', 'url' => generate_url(array('page' => 'search')), 'icon' => 'oicon-magnifier-zoom-actual', 'entries' => $search_menu);

//////////// Build devices menu
$navbar['devices'] = array('url' => generate_url(array('page' => 'devices')), 'icon' => 'oicon-servers', 'title' => '设备');

// FIXME In the old code the menu width was 200px specifically - we don't do this now but doesn't seem to be a problem?

$navbar['devices']['entries'][] = array('title' => '所有设备', 'url' => generate_url(array('page' => 'devices')), 'icon' => 'oicon-servers');
$navbar['devices']['entries'][] = array('divider' => TRUE);

// Build location submenu
if ($config['geocoding']['enable'] && $config['location_menu_geocoded'])
{
  $navbar['devices']['entries'][] = array('locations' => TRUE); // Pretty complicated recursive function, workaround not having it converted to returning an array
} else {
  // Non-geocoded menu
  foreach (get_locations() as $location)
  {
    $name = ($location === '' ? OBS_VAR_UNSET : htmlspecialchars($location));
    $location_menu[] = array('url' => generate_location_url($location), 'icon' => 'oicon-building-small', 'title' => $name);
  }

  $navbar['devices']['entries'][] = array('title' => '位置', 'url' => generate_url(array('page' => 'locations')), 'icon' => 'oicon-building', 'entries' => $location_menu);
}

$navbar['devices']['entries'][] = array('divider' => TRUE);

// Build list per device type
foreach ($config['device_types'] as $devtype)
{
  if (in_array($devtype['type'], array_keys($cache['device_types'])))
  {
    $navbar['devices']['entries'][] = array('title' => $devtype['text'],'icon' => $devtype['icon'], 'count' => $cache['device_types'][$devtype['type']], 'url' => generate_url(array('page' => 'devices', 'type' => $devtype['type'])));
  }
}

if ($devices['down']+$devices['ignored']+$devices['disabled'])
{
  $navbar['devices']['entries'][] = array('divider' => TRUE);
  if ($devices['down'])
  {
    $navbar['devices']['entries'][] = array('url' => generate_url(array('page' => 'devices', 'status' => '0')), 'icon' => 'oicon-circle-red', 'title' => '异常');
  }
  if ($devices['ignored'])
  {
    $navbar['devices']['entries'][] = array('url' => generate_url(array('page' => 'devices', 'ignore' => '1')), 'icon' => 'oicon-circle-yellow', 'title' => '忽略');
  }
  if ($devices['disabled'])
  {
    $navbar['devices']['entries'][] = array('url' => generate_url(array('page' => 'devices', 'disabled' => '1')), 'icon' => 'oicon-circle-metal', 'title' => '禁用');
  }
}

if ($_SESSION['userlevel'] >= '5')
{
  $navbar['devices']['entries'][] = array('divider' => TRUE);
  $navbar['devices']['entries'][] = array('url' => generate_url(array('page' => 'addhost')), 'icon' => 'oicon-server--plus', 'title' => '添加设备');
  $navbar['devices']['entries'][] = array('url' => generate_url(array('page' => 'delhost')), 'icon' => 'oicon-server--minus', 'title' => '删除设备');
}

//////////// Build ports menu
$navbar['ports'] = array('url' => generate_url(array('page' => 'ports')), 'icon' => 'oicon-network-ethernet', 'title' => '端口');

$navbar['ports']['entries'][] = array('title' => '所有端口', 'count' => $ports['count'], 'url' => generate_url(array('page' => 'ports')), 'icon' => 'oicon-network-ethernet');
$navbar['ports']['entries'][] = array('divider' => TRUE);

if ($config['enable_billing'])
{
  $navbar['ports']['entries'][] = array('title' => '流量账单', 'url' => generate_url(array('page' => 'bills')), 'icon' => 'oicon-money-coin');
  $ifbreak = 1;
}

if ($config['enable_pseudowires'])
{
  $navbar['ports']['entries'][] = array('title' => '伪流量', 'url' => generate_url(array('page' => 'pseudowires')), 'icon' => 'oicon-layer-shape-curve');
  $ifbreak = 1;
}

if ($ifbreak)
{
  $navbar['ports']['entries'][] = array('divider' => TRUE);
  $ifbreak = 0;
}

if ($_SESSION['userlevel'] >= '5')
{
  // FIXME new icons
  if ($config['int_customers']) { $navbar['ports']['entries'][] = array('url' => generate_url(array('page' => 'customers')), 'image' => "images/16/group_link.png", 'title' => '客户'); $ifbreak = 1; }
  if ($config['int_l2tp'])      { $navbar['ports']['entries'][] = array('url' => generate_url(array('page' => 'iftype', 'type' => 'l2tp')), 'image' => "images/16/user.png", 'title' => 'L2TP'); $ifbreak = 1; }
  if ($config['int_transit'])   { $navbar['ports']['entries'][] = array('url' => generate_url(array('page' => 'iftype', 'type' => 'transit')), 'image' => "images/16/lorry_link.png", 'title' => '透传');  $ifbreak = 1; }
  if ($config['int_peering'])   { $navbar['ports']['entries'][] = array('url' => generate_url(array('page' => 'iftype', 'type' => 'peering')), 'image' => "images/16/bug_link.png", 'title' => '对等互联'); $ifbreak = 1; }
  if ($config['int_peering'] && $config['int_transit']) { $navbar['ports']['entries'][] = array('url' => generate_url(array('page' => 'iftype', 'type' => 'peering,transit')), 'image' => "images/16/world_link.png", 'title' => '对等互联 & 透传'); $ifbreak = 1; }
  if ($config['int_core']) { $navbar['ports']['entries'][] = array('url' => generate_url(array('page' => 'iftype', 'type' => 'core')), 'image' => "images/16/brick_link.png", 'title' => '核心'); $ifbreak = 1; }

  // Custom interface groups can be set - see Interface Description Parsing
  foreach ($config['int_groups'] as $int_type)
  {
    $navbar['ports']['entries'][] = array('url' => generate_url(array('page' => 'iftype', 'type' => $int_type)), 'image' => "images/16/brick_link.png", 'title' => $int_type); $ifbreak = 1;
  }
}

if ($ifbreak) { $navbar['ports']['entries'][] = array('divider' => TRUE); }

/// FIXME. Make Down/Ignored/Disabled ports as submenu. --mike
if (isset($ports['alerts']))
{
  $navbar['ports']['entries'][] = array('url' => generate_url(array('page' => 'ports', 'alerted' => 'yes')), 'icon' => 'oicon-chain--exclamation', 'title' => '警报', 'count' => $ports['alerts']);
}

if ($ports['errored'])
{
  $navbar['ports']['entries'][] = array('url' => generate_url(array('page' => 'ports', 'errors' => 'yes')), 'icon' => 'oicon-exclamation-button', 'title' => '错误', 'count' => $ports['errored']);
}

if ($ports['down'])
{
  $navbar['ports']['entries'][] = array('url' => generate_url(array('page' => 'ports', 'state' => 'down')), 'icon' => 'oicon-network-status-busy', 'title' => '异常');
}

if ($ports['ignored'])
{
  $navbar['ports']['entries'][] = array('url' => generate_url(array('page' => 'ports', 'ignore' => '1')), 'icon' => 'oicon-network-status-away', 'title' => '忽略');
}

if ($ports['disabled'])
{
  $navbar['ports']['entries'][] = array('url' => generate_url(array('page' => 'ports', 'state' => 'admindown')), 'icon' => 'oicon-network-status-offline', 'title' => '禁用');
}

if ($ports['deleted'])
{
  $navbar['ports']['entries'][] = array('url' => generate_url(array('page' => 'deleted-ports')), 'icon' => 'oicon-badge-square-minus', 'title' => '已删除', 'count' => $ports['deleted']);
}

//////////// Build health menu
$navbar['health'] = array('url' => '#', 'icon' => 'oicon-system-monitor', 'title' => '系统健康');

$health_items = array('processor' => array('text' => "处理器", 'icon' => 'oicon-processor'),
               'mempool'   => array('text' => "内存", 'icon' => 'oicon-memory'),
               'storage'   => array('text' => "存储", 'icon' => 'oicon-drive'));

if (dbFetchCell("SELECT count(*) FROM `toner`"))
{
  $health_items['toner'] = array('text' => "硒鼓", 'icon' => 'oicon-contrast');
}

foreach ($health_items as $item => $item_data)
{
  $navbar['health']['entries'][] = array('url' => generate_url(array('page' => 'health', 'metric' => $item)), 'icon' => $item_data['icon'], 'title' => $item_data['text']);
  unset($menu_sensors[$item]);$sep++;
}

$menu_items[0] = array('fanspeed','humidity','temperature','airflow');
$menu_items[1] = array('current','voltage','power','apower','frequency');
$menu_items[2] = array_diff(array_keys($cache['sensor_types']), $menu_items[0], $menu_items[1]);
foreach ($menu_items as $items)
{
  foreach ($items as $item)
  {
    if ($cache['sensor_types'][$item])
    {
      if ($sep)
      {
        $navbar['health']['entries'][] = array('divider' => TRUE);
        $sep = 0;
      }
      $alert_icon = ($cache['sensor_types'][$item]['alert'] ? '<i class="oicon-exclamation-red"></i>' : '');
      $navbar['health']['entries'][] = array('url' => generate_url(array('page' => 'health', 'metric' => $item)), 'icon' => $config['sensor_types'][$item]['icon'], 'title' => nicecase($item) . ' ' . $alert_icon);
    }
  }
  $sep++;
}

//////////// Build applications menu
$app_count = dbFetchCell("SELECT COUNT(`app_id`) FROM `applications`");

if ($_SESSION['userlevel'] >= '5' && ($app_count) > "0")
{
  $navbar['apps'] = array('url' => '#', 'icon' => 'oicon-application-icon-large', 'title' => '应用');

  $app_list = dbFetchRows("SELECT `app_type` FROM `applications` GROUP BY `app_type` ORDER BY `app_type`");
  foreach ($app_list as $app)
  {
    $image = $config['html_dir']."/images/icons/".$app['app_type'].".png";
    $icon = (file_exists($image) ? $app['app_type'] : "apps");
    $navbar['apps']['entries'][] = array('url' => generate_url(array('page' => 'apps', 'app' => $app['app_type'])), 'image' => 'images/icons/'.$icon.'.png', 'title' => nicecase($app['app_type']));
  }
}

//////////// Build routing menu
if ($_SESSION['userlevel'] >= '5' && ($routing['bgp']['count']+$routing['ospf']['count']+$routing['cef']['count']+$routing['vrf']['count']) > 0)
{
  $navbar['routing'] = array('url' => '#', 'icon' => 'oicon-arrow-branch-000-left', 'title' => '路由');

  $separator = 0;

  if ($_SESSION['userlevel'] >= '5' && $routing['vrf']['count'])
  {
    $navbar['routing']['entries'][] = array('url' => generate_url(array('page' => 'routing', 'protocol' => 'vrf')), 'icon' => 'oicon-arrow-branch-byr', 'title' => 'VRFs', 'count' => $routing['vrf']['count']);
    $separator++;
  }

  if ($_SESSION['userlevel'] >= '5' && $routing['ospf']['up'])
  {
    if ($separator)
    {
      $navbar['routing']['entries'][] = array('divider' => TRUE);
      $separator = 0;
    }

    $navbar['routing']['entries'][] = array('url' => generate_url(array('page' => 'routing', 'protocol' => 'ospf')), 'image' => 'images/16/text_letter_omega.png', 'title' => 'OSPF', 'count' => $routing['ospf']['up']);
    $separator++;
  }

  // BGP Sessions
  if ($_SESSION['userlevel'] >= '5' && $routing['bgp']['count'])
  {
    if ($separator)
    {
      $navbar['routing']['entries'][] = array('divider' => TRUE);
      $separator = 0;
    }

    $navbar['routing']['entries'][] = array('url' => generate_url(array('page' => 'routing', 'protocol' => 'bgp', 'type' => 'all', 'graph' => 'NULL')), 'image' => "images/16/link.png", 'title' => 'BGP所有会话', 'count' => $routing['bgp']['count']);
    $navbar['routing']['entries'][] = array('url' => generate_url(array('page' => 'routing', 'protocol' => 'bgp', 'type' => 'external', 'graph' => 'NULL')), 'image' => "images/16/world_link.png", 'title' => 'BGP外部流量');
    $navbar['routing']['entries'][] = array('url' => generate_url(array('page' => 'routing', 'protocol' => 'bgp', 'type' => 'internal', 'graph' => 'NULL')), 'image' => "images/16/brick_link.png", 'title' => 'BGP内部流量');
  }

  // Do Alerts at the bottom
  if ($routing['bgp']['alerts'])
  {
    $navbar['routing']['entries'][] = array('divider' => TRUE);
    $navbar['routing']['entries'][] = array('url' => generate_url(array('page' => 'routing', 'protocol' => 'bgp', 'adminstatus' => 'start', 'state' => 'down')), 'image' => "images/16/link_error.png", 'title' => 'BGP警报', 'count' => $routing['bgp']['alerts']);
  }
}

// Custom navbar entries.
if (is_file("includes/navbar-custom.inc.php"))
{
  include("includes/navbar-custom.inc.php");
}

// DOCME needs phpdoc block
function navbar_location_menu($array)
{
  global $config;

  ksort($array['entries']);

  echo('<ul class="dropdown-menu">');

  if (count($array['entries']) > "3")
  {
    foreach ($array['entries'] as $entry => $entry_data)
    {
      $image = '<i class="menu-icon oicon-building"></i>';
      if ($entry_data['level'] == "location_country")
      {
        $code = $entry;
        $entry = country_from_code($entry);
        $image = '<i class="flag flag-'.$code.'"></i>';
      }
      elseif ($entry_data['level'] == "location")
      {
        $name = ($entry === '' ? OBS_VAR_UNSET : htmlspecialchars($entry));
        echo('            <li><a href="' . generate_location_url($entry) . '"><i class="menu-icon oicon-building-small"></i> ' . $name . '&nbsp;['.$entry_data['count'].']</a></li>');
        continue;
      }

      echo('<li class="dropdown-submenu"><a href="' . generate_url(array('page'=>'devices', $entry_data['level'] => urlencode($entry))) .
           '">' . $image . ' ' . $entry . '&nbsp;['.$entry_data['count'].']</a>');

      navbar_location_menu($entry_data);
      echo('</li>');
    }
  } else {
    $new_entry_array = array();

    foreach ($array['entries'] as $new_entry => $new_entry_data)
    {
      if ($new_entry_data['level'] == "location_country")
      {
        $code = $new_entry;
        $new_entry = country_from_code($new_entry);
        $image = '<i class="flag flag-'.$code.'"></i> ';
      }
      elseif ($new_entry_data['level'] == "location")
      {
        $name = ($new_entry === '' ? OBS_VAR_UNSET : htmlspecialchars($new_entry));
        echo('            <li><a href="' . generate_location_url($new_entry) . '"><i class="menu-icon oicon-building-small"></i> ' . $name . '&nbsp;['.$new_entry_data['count'].']</a></li>');
        continue;
      }

      echo('<li class="nav-header">'.$image.$new_entry.'</li>');
      foreach ($new_entry_data['entries'] as $sub_entry => $sub_entry_data)
      {
        if (is_array($sub_entry_data['entries']))
        {
          echo('<li class="dropdown-submenu"><a style="" href="' . generate_url(array('page'=>'devices', $sub_entry_data['level'] => urlencode($sub_entry))) . '">
                <i class="menu-icon oicon-building"></i> ' . $sub_entry . '&nbsp;['.$sub_entry_data['count'].']</a>');
          navbar_location_menu($sub_entry_data);
        } else {
          $name = ($sub_entry === '' ? OBS_VAR_UNSET : htmlspecialchars($sub_entry));
          echo('            <li><a href="' . generate_location_url($sub_entry) . '"><i class="menu-icon oicon-building-small"></i> ' . $name . '&nbsp;['.$sub_entry_data['count'].']</a></li>');
        }
      }
    }
  }
  echo('</ul>');
}

// DOCME needs phpdoc block
function navbar_submenu($entry, $level = 1)
{
  echo(str_pad('',($level-1)*2) . '                <li class="dropdown-submenu"><a href="' . $entry['url'] . '"><i class="menu-icon ' . $entry['icon'] . '"></i> ' . $entry['title'] . '</a>' . PHP_EOL);
  echo(str_pad('',($level-1)*2) . '                  <ul class="dropdown-menu">' . PHP_EOL);

  foreach ($entry['entries'] as $subentry)
  {
    if (count($subentry['entries']))
    {
      navbar_submenu($subentry, $level+1);
    } else {
      navbar_entry($subentry, $level+2);
    }
  }

  echo(str_pad('',($level-1)*2) . '                  </ul>' . PHP_EOL);
  echo(str_pad('',($level-1)*2) . '                <li>' . PHP_EOL);
}

// DOCME needs phpdoc block
function navbar_entry($entry, $level = 1)
{
  global $cache;

  if ($entry['divider'])
  {
    echo(str_pad('',($level-1)*2) . '                <li class="divider"></li>' . PHP_EOL);
  } elseif ($entry['locations']) { // Workaround until the menu builder returns an array instead of echo()
    echo(str_pad('',($level-1)*2) . '                <li class="dropdown-submenu">' . PHP_EOL);
    echo(str_pad('',($level-1)*2) . '                  <a href="'.generate_url(array('page'=>'locations')).'"><i class="menu-icon oicon-building-hedge"></i> 位置</a>' . PHP_EOL);
    navbar_location_menu($cache['locations']);
    echo(str_pad('',($level-1)*2) . '                </li>' . PHP_EOL);
  } else {
    echo(str_pad('',($level-1)*2) . '                <li><a href="' . $entry['url'] . '"><i class="menu-icon ' . $entry['icon'] . '"></i> ');
    if (isset($entry['image'])) { echo('<img src="' . $entry['image'] . '" alt="" /> '); }
    echo($entry['title']);
    if (isset($entry['count'])) { echo('&nbsp;<span class="right">(' . $entry['count'] . ')</span>'); }
    echo(str_pad('',($level-1)*2) . '</a></li>' . PHP_EOL);
  }
}

// Build navbar from $navbar array
foreach ($navbar as $dropdown)
{
  echo('            <li class="divider-vertical" style="margin: 0;"></li>' . PHP_EOL);
  echo('            <li class="dropdown">' . PHP_EOL);
  echo('              <a href="' . $dropdown['url'] . '" class="hidden-sm dropdown-toggle" data-hover="dropdown" data-toggle="dropdown">' . PHP_EOL);
  echo('                <i class="' . $dropdown['icon'] . '"></i> ' . $dropdown['title'] . ' <b class="caret"></b></a>' . PHP_EOL);
  echo('              <a href="' . $dropdown['url'] . '" class="visible-sm dropdown-toggle" data-hover="dropdown" data-toggle="dropdown">' . PHP_EOL);
  echo('                <i class="' . $dropdown['icon'] . '"></i> <b class="caret"></b></a>' . PHP_EOL);
  echo('              <ul class="dropdown-menu">' . PHP_EOL);

  foreach ($dropdown['entries'] as $entry)
  {
    if (count($entry['entries']))
    {
      navbar_submenu($entry);
    } else {
      navbar_entry($entry);
    }
  }

  echo('              </ul>' . PHP_EOL);
  echo('            </li>' . PHP_EOL);
}

unset($navbar);

// The menus on the right are not handled by the navbar array code yet.

?>
          </ul>
          <ul class="nav pull-right">
          <li class="dropdown hidden-xs">
            <form id="searchform" class="navbar-search" action="#" style="margin-left: 5px; margin-right: 10px;  margin-top: 5px; margin-bottom: -5px;">
              <input style="width: 100px;" onkeyup="lookup(this.value);" onblur="$('#suggestions').fadeOut()" type="text" value="" class="dropdown-toggle" placeholder="搜索" />
            </form>
            <div id="suggestions" class="typeahead dropdown-menu"></div>
          </li>
<?php

if ($_SESSION['touch'] == "yes")
{
  $url = generate_url($vars, array('touch' => 'no'));
} else {
  $url = generate_url($vars, array('touch' => 'yes'));
}

$browser = detect_browser();
if ($vars['touch'] == 'yes')  { $icon = 'oicon-hand-point-090'; }
elseif ($browser == 'mobile') { $icon = 'icon-mobile-phone'; }
elseif ($browser == 'tablet') { $icon = 'icon-tablet'; }
else                          { $icon = 'icon-laptop'; }

echo('<li><a href="' . $url . '"> <i class="' . $icon . '"></i></a></li>');

?>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-hover="dropdown" data-toggle="dropdown"><i class="oicon-gear"></i> <b class="caret"></b></a>
              <ul class="dropdown-menu">
<?php
  // Refresh menu
  echo('<li class="dropdown-submenu">');
  echo('  <a tabindex="-1" href="'.generate_url($vars).'"><i class="oicon-arrow-circle"></i> 刷新 <span id="countrefresh"></span></a>');
  echo('  <ul class="dropdown-menu">');
  foreach ($page_refresh['list'] as $refresh_time)
  {
    $refresh_class = ($refresh_time == $page_refresh['current'] ? 'active' : '');
    if (!$page_refresh['allowed']) { $refresh_class = 'disabled'; }
    if ($refresh_time == 0)
    {
      echo('    <li class="'.$refresh_class.'"><a href="'.generate_url($vars, array('refresh' => '0')).'"><i class="icon-ban-circle"></i> 手动</a></li>');
    } else {
      echo('    <li class="'.$refresh_class.'"><a href="'.generate_url($vars, array('refresh' => $refresh_time)).'"><i class="icon-refresh"></i> 平均每 '.formatUptime($refresh_time, 'longest').'</a></li>');
    }
  }
  echo('  </ul>');
  echo('</li>');
  echo('<li class="divider"></li>');

if ($_SESSION['widescreen'] == 1)
{
  echo('<li><a href="'.generate_url($vars, array('widescreen' => 'no')).'" title="切换到标准宽度"><i class="oicon-arrow-in" style="font-size: 16px; color: #555;"></i> 标准宽度</a></li>');
} else {
  echo('<li><a href="'.generate_url($vars, array('widescreen' => 'yes')).'" title="切换到宽屏显示"><i class="oicon-arrow-move" style="font-size: 16px; color: #555;"></i> 宽屏</a></li>');
}

if ($_SESSION['big_graphs'] == 1)
{
  echo('<li><a href="'.generate_url($vars, array('big_graphs' => 'no')).'" title="切换为普通图像"><i class="oicon-layout-6" style="font-size: 16px; color: #555;"></i> 普通图像</a></li>');
} else {
  echo('<li><a href="'.generate_url($vars, array('big_graphs' => 'yes')).'" title="切换到大图"><i class="oicon-layout-4" style="font-size: 16px; color: #555;"></i> 大图</a></li>');
}

if ($config['api']['enabled'])
{
  echo('<li class="divider"></li>');
  echo('<li class="dropdown-submenu">');
  echo('  <a tabindex="-1" href="'.generate_url(array('page' => 'simpleapi')).'"><i class="oicon-application-block"></i> 独立API</a>');
  echo('  <ul class="dropdown-menu">');
  echo('    <li><a href="'.generate_url(array('page' => 'simpleapi')).'"><i class="oicon-application-block"></i> API手册</a></li>');
  echo('    <li><a href="'.generate_url(array('page' => 'simpleapi','api' => 'errorcodes')).'"><i class="oicon-application--exclamation"></i> 错误代码</a></li>');
  echo('  </ul>');
  echo('</li>');
}

if ($_SESSION['userlevel'] >= 10)
{
  echo('<li class="divider"></li>');
  echo('<li class="dropdown-submenu">');
  echo('  <a tabindex="-1" href="'.generate_url(array('page' => 'adduser')).'"><i class="oicon-users"></i> 用户</a>');
  echo('  <ul class="dropdown-menu">');
  if (auth_usermanagement())
  {
    echo('    <li><a href="'.generate_url(array('page' => 'adduser')).'"><i class="oicon-user--plus"></i> 添加用户</a></li>');
  }
  echo('    <li><a href="'.generate_url(array('page' => 'edituser')).'"><i class="oicon-user--pencil"></i> 编辑用户</a></li>');
  if (auth_usermanagement())
  {
    echo('    <li><a href="'.generate_url(array('page' => 'edituser')).'"><i class="oicon-user--minus"></i> 删除用户</a></li>');
  }
  echo('    <li><a href="'.generate_url(array('page' => 'authlog')).'"><i class="oicon-user-detective"></i> 认证日志</a></li>');
  echo('  </ul>');
  echo('</li>');
}
?>
                <li class="divider"></li>
                <li><a href="<?php echo(generate_url(array('page' => 'settings'))); ?>" title="全局设置"><i class="oicon-wrench"></i> 全局设置</a></li>
                <li><a href="<?php echo(generate_url(array('page' => 'preferences'))); ?>" title="我的设置 "><i class="oicon-wrench-screwdriver"></i> 我的设置</a></li>
<?php
if (auth_can_logout())
{
?>
                <li class="divider"></li>
                <li><a href="<?php echo(generate_url(array('page' => 'logout'))); ?>" title="注销"><i class="oicon-door-open-out"></i> 注销</a></li>
<?php
}
?>
                <li class="divider"></li>
                <li><a href="<?php echo OBSERVIUM_URL; ?>/wiki/Documentation" title="帮助"><i class="oicon-question"></i> 帮助</a></li>
                <li><?php echo(generate_link('<i class="oicon-information"></i> 关于 '.OBSERVIUM_PRODUCT, array('page' => 'about'), array(), FALSE)); ?></li>
              </ul>
            </li>
          </ul>
        </div><!-- /.nav-collapse -->
      </div>
    </div><!-- /navbar-inner -->
  </header>

<script type="text/javascript">

function lookup(inputString) {
   if (inputString.length == 0) {
      $('#suggestions').fadeOut(); // Hide the suggestions box
   } else {
      $.post("ajax_search.php", {queryString: ""+inputString+""}, function(data) { // Do an AJAX call
         $('#suggestions').fadeIn(); // Show the suggestions box
         $('#suggestions').html(data); // Fill the suggestions box
      });
   }
}

<?php
if (isset($page_refresh['nexttime'])) // Begin Refresh JS
{
?>

// set initial seconds left we're counting down to
var seconds_left = <?php echo($page_refresh['nexttime'] - time()); ?>;
// get tag element
var countrefresh = document.getElementById('countrefresh');

// update the tag with id "countdown" every 1 second
setInterval(function () {
    // do some time calculations
    var minutes = parseInt(seconds_left / 60);
    var seconds = parseInt(seconds_left % 60);

    // format countdown string + set tag value
    if (minutes > 0) {
      minutes = minutes + '分&nbsp;';
      seconds = seconds + '秒';
    } else {
      minutes = '';
      if (seconds > 0) {
        seconds = seconds + '秒';
      } else {
        seconds = '0秒';
      }
    }

    countrefresh.innerHTML = '<span class="label">' + minutes + seconds + '</span>';

    seconds_left = seconds_left - 1;

}, 1000);

<?php
} // End Refresh JS
?>

</script>
