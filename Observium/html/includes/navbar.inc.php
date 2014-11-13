<?php

// FIXME - this could do with some performance improvements, i think. possible rearranging some tables and setting flags at poller time (nothing changes outside of then anyways)

$service_alerts = dbFetchCell("SELECT COUNT(*) FROM services WHERE service_status = '0'");

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
            <li class="divider-vertical" style="margin:0;"></li>
            <li class="dropdown">
              <a href="<?php echo(generate_url(array('page'=>'overview'))); ?>" class="dropdown-toggle" data-hover="dropdown" data-toggle="dropdown">
                <i class="oicon-globe-model"></i> <b class="caret"></b></a>
                <ul class="dropdown-menu">
                <li><a href="<?php echo(generate_url(array('page'=>'overview'))); ?>"><i class="oicon-globe-model"></i> 概述</a></li>
                <li class="divider"></li>

<?php
// Custom navbar entries.
if(is_file("includes/navbar-custom.inc.php"))
{
 include("includes/navbar-custom.inc.php");

 echo('<li class="divider"></li>');
}

if (isset($config['enable_map']) && $config['enable_map'])
{
  echo('<li><a href="'.generate_url(array('page'=>'overview')).'"><span class="menu-icon oicon-map"></span> 网络拓扑</a></li>');
}
?>
        <li><a href="<?php echo(generate_url(array('page'=>'eventlog'))); ?>"><i class="menu-icon oicon-clipboard-audit"></i> 事件日志</a></li>
<?php
if (isset($config['enable_syslog']) && $config['enable_syslog'])
{
          echo('<li><a href="'.generate_url(array('page'=>'syslog')).'"><i class="menu-icon oicon-clipboard-eye"></i> 系统日志</a></li>');
}
?>
        <li><a href="<?php echo(generate_url(array('page'=>'pollerlog'))); ?>"><i class="menu-icon oicon-clipboard-report-bar"></i> 轮询信息</a></li>

<?php if(EDITION != 'community') {  ?>

        <li class="divider"></li>

        <li><a href="<?php echo(generate_url(array('page'=>'alerts'))); ?>"><i class="menu-icon oicon-bell"></i> 报警</a></li>
        <li><a href="<?php echo(generate_url(array('page'=>'alert_checks'))); ?>"><i class="menu-icon oicon-eye"></i> 报警检测</a></li>

<?php } ?>


        <li class="divider"></li>

        <li><a href="<?php echo(generate_url(array('page'=>'inventory'))); ?>"><i class="menu-icon oicon-wooden-box"></i> 清单</a></li>

<?php

$packages = dbFetchCell("SELECT COUNT(*) from `packages`");

if ($packages)
{
  echo('<li><a href="'.generate_url(array('page'=>'packages')).'"><i class="oicon-box-zipper"></i> 软件包</a></li>');
}

?>
          <li class="divider"></li>
          <li class="dropdown-submenu">
            <a tabindex="-1" href="<?php echo(generate_url(array('page'=>'search'))); ?>"><i class="menu-icon oicon-magnifier-zoom-actual"></i> 搜索</a>
            <ul class="dropdown-menu">
<?php
foreach (array('ipv4' => 'IPv4 Address', 'ipv6' => 'IPv6 Address', 'mac' => 'MAC Address', 'arp' => 'ARP/NDP Tables', 'fdb' => 'FDB Tables') as $search_page => $search_name)
{
  echo('            <li><a href="' . generate_url(array('page'=>'search','search'=>$search_page)) . '"><i class="menu-icon  oicon-magnifier-zoom-actual"></i> ' . $search_name . ' </a></li>');
}
?>
            </ul>
          </li>

                </ul>
            </li>

            <li class="divider-vertical" style="margin:0;"></li>
            <li class="dropdown">
              <a class="hidden-sm hidden-xs dropdown-toggle" href="<?php echo(generate_url(array('page'=>'devices'))); ?>" data-hover="dropdown" data-toggle="dropdown"><i class="oicon-servers"></i> 设备 <b class="caret"></b></a>
              <a class="hidden-lg hidden-md dropdown-toggle" href="<?php echo(generate_url(array('page'=>'devices'))); ?>" data-hover="dropdown" data-toggle="dropdown"><i class="oicon-servers"></i> <b class="caret"></b></a>

              <ul class="dropdown-menu" style="width:200px;">

                <li><a href="<?php echo(generate_url(array('page'=>'devices'))); ?>"><i class="oicon-servers"></i> 所有设备</a></li>
                <li class="divider"></li>

<?php

if($config['geocoding']['enable'] && $config['location_menu_geocoded'])
{
  echo('
                 <li class="dropdown-submenu">
                    <a tabindex="-1" href="'.generate_url(array('page'=>'locations')).'"><i class="menu-icon oicon-building-hedge"></i> 地理位置</a>');

function location_menu($array)
{
  global $config;

  ksort($array['entries']);

  echo('<ul class="dropdown-menu">');

  if (count($array['entries']) > "3")
  {
    foreach($array['entries'] as $entry => $entry_data)
    {
      if ($entry_data['level'] == "location_country")
      {
        $code = $entry;
        $entry = country_from_code($entry);
        $image = '<i class="flag flag-'.$code.'" alt="'.$entry.'"></i>';
      }
      elseif ($entry_data['level'] == "location")
      {
        $name = ($entry == '' ? '[[UNKNOWN]]' : htmlspecialchars($entry));
        echo('            <li><a href="' . generate_location_url($entry) . '"><i class="menu-icon oicon-building-small"></i> ' . $name . '&nbsp['.$entry_data['count'].']</a></li>');
        continue;
      }

      echo('<li class="dropdown-submenu"><a href="' . generate_url(array('page'=>'devices', $entry_data['level'] => urlencode($entry))) .
           '"><i class="menu-icon oicon-building"></i> ' . $entry . '&nbsp['.$entry_data['count'].']</a>');

      location_menu($entry_data);
      echo('</li>');
    }
  } else {
    $new_entry_array = array();

    foreach($array['entries'] as $new_entry => $new_entry_data)
    {
      if ($new_entry_data['level'] == "location_country")
      {
        $code = $new_entry;
        $new_entry = country_from_code($new_entry);
        $image = '<i class="flag flag-'.$code.'" alt="'.$new_entry.'"></i> ';
      }
      elseif ($new_entry_data['level'] == "location")
      {
        $name = ($new_entry == '' ? '[[UNKNOWN]]' : htmlspecialchars($new_entry));
        echo('            <li><a href="' . generate_location_url($new_entry) . '"><i class="menu-icon oicon-building-small"></i> ' . $name . '&nbsp['.$new_entry_data['count'].']</a></li>');
        continue;
      }

      echo('<li class="nav-header">'.$image.$new_entry.'</li>');
      foreach($new_entry_data['entries'] as $sub_entry => $sub_entry_data)
      {
        if(is_array($sub_entry_data['entries']))
        {
          echo('<li class="dropdown-submenu"><a style="" href="' . generate_url(array('page'=>'devices', $sub_entry_data['level'] => urlencode($sub_entry))) . '">
                <i class="menu-icon oicon-building"></i> ' . $sub_entry . '&nbsp['.$sub_entry_data['count'].']</a>');
          location_menu($sub_entry_data);
        } else {
          $name = ($sub_entry == '' ? '[[UNKNOWN]]' : htmlspecialchars($sub_entry));
          echo('            <li><a href="' . generate_location_url($sub_entry) . '"><i class="menu-icon oicon-building-small"></i> ' . $name . '&nbsp['.$sub_entry_data['count'].']</a></li>');
        }
        echo('</li>');
      }
    }
  }
  echo('</ul>');
}

location_menu($cache['locations']);

?>
                </li>
<?php
}
else // Non-geocoded menu
{
  echo('
                  <li class="dropdown-submenu">
                    <a tabindex="-1" href="'.generate_url(array('page'=>'locations')).'"><i class="menu-icon oicon-building"></i> 地理位置</a>
                    <ul class="dropdown-menu">');

    foreach (get_locations() as $location)
    {
      $name = ($location == '' ? '[[UNKNOWN]]' : htmlspecialchars($location));
      echo('            <li><a href="' . generate_location_url($location) . '"><i class="menu-icon oicon-building-small"></i> ' . $name . ' </a></li>');
    }
?>
                  </ul>
                </li>
<?php
}

?>

                <li class="divider"></li>

<?php
foreach ($config['device_types'] as $devtype)
{
  if (in_array($devtype['type'],array_keys($cache['device_types'])))
  {
    echo('        <li><a href="devices/type=' . $devtype['type'] . '/"><i class="'.$devtype['icon'].'"></i> ' . $devtype['text'] . '&nbsp;<span class="right">('.$cache['device_types'][$devtype['type']].')</span></a></li>');
  }
}
?>
                <li class="divider"></li>
                <li><a href="addhost/"><i class="oicon-server--plus"></i> 添加设备</a></li>
                <li><a href="delhost/"><i class="oicon-server--minus"></i> 删除设备</a></li>
              </ul>
            </li>

            <li class="divider-vertical" style="margin:0;"></li>

            <li class="dropdown">
              <a class="hidden-sm hidden-xs dropdown-toggle" href="<?php echo(generate_url(array('page'=>'ports'))); ?>" data-hover="dropdown" data-toggle="dropdown"><i class="oicon-network-ethernet"></i> 端口 <b class="caret"></b></a>
              <a class="hidden-lg hidden-md dropdown-toggle" href="<?php echo(generate_url(array('page'=>'ports'))); ?>" data-hover="dropdown" data-toggle="dropdown"><i class="oicon-network-ethernet"></i> <b class="caret"></b></a>

              <ul class="dropdown-menu">
                <li><a href="<?php echo(generate_url(array('page'=>'ports'))); ?>"><i class="oicon-network-ethernet"></i> 所有端口&nbsp;<span class="right">(<?php echo($ports['count']); ?>)</span></a></li>
                <li class="divider"></li>

<?php

if (EDITION != 'community' && $config['enable_billing']) { echo('<li><a href="bills/"><i class="oicon-money-coin"></i> 流量账单</a></li>'); $ifbreak = 1; }

if ($config['enable_pseudowires']) { echo('<li><a href="pseudowires/"><i class="oicon-layer-shape-curve"></i> 伪流量</a></li>'); $ifbreak = 1; }

if ($ifbreak) { echo('<li class="divider"></li>'); }
?>

<?php

if ($_SESSION['userlevel'] >= '5')
{
  // FIXME new icons
  if ($config['int_customers']) { echo('<li><a href="customers/"><img src="images/16/group_link.png" alt="" /> 客户</a></li>'); $ifbreak = 1; }
  if ($config['int_l2tp']) { echo('<li><a href="iftype/type=l2tp/"><img src="images/16/user.png" alt="" /> L2TP</a></li>'); $ifbreak = 1; }
  if ($config['int_transit']) { echo('<li><a href="iftype/type=transit/"><img src="images/16/lorry_link.png" alt="" /> 透传</a></li>');  $ifbreak = 1; }
  if ($config['int_peering']) { echo('<li><a href="iftype/type=peering/"><img src="images/16/bug_link.png" alt="" /> 对等互联</a></li>'); $ifbreak = 1; }
  if ($config['int_peering'] && $config['int_transit']) { echo('<li><a href="iftype/type=peering,transit/"><img src="images/16/world_link.png" alt="" /> 对等互联 & 透传</a></li>'); $ifbreak = 1; }
  if ($config['int_core']) { echo('<li><a href="iftype/type=core/"><img src="images/16/brick_link.png" alt="" /> 核心</a></li>'); $ifbreak = 1; }
  // Custom interface groups can be set - see Interface Description Parsing
  foreach ($config['int_groups'] as $int_type)
  {
         echo('<li><a href="iftype/type=' . $int_type . '/"><img src="images/16/brick_link.png" alt="" /> ' . $int_type .'</a></li>'); $ifbreak = 1;
  }
}

if ($ifbreak) { echo('<li class="divider"></li>'); }

/// FIXME. Make Down/Ignored/Disabled ports as submenu. --mike
if (isset($ports['alerts']))
{
  echo('<li><a href="ports/alerted=yes/"><img src="images/16/link_error.png" alt="" /> 报警&nbsp;<span class="right">('.$ports['alerts'].')</span></a></li>');
}

if ($ports['errored'])
{
  echo('<li><a href="ports/errors=yes/"><img src="images/16/chart_curve_error.png" alt="" /> 错误&nbsp;<span class="right">('.$ports['errored'].')</span></a></li>');
}

if ($ports['down'])
{
  echo('<li><a href="ports/state=down/"><i class="oicon-network-status-busy"></i> 关闭</a></li>'); // &nbsp;<span class="right">('.$ports['down'].')</span></a></li>');
}

if ($ports['ignored'])
{
  echo('<li><a href="ports/ignore=1/"><img src="images/16/chart_curve_link.png" alt="" /> 忽略</a></li>'); // &nbsp;<span class="right">('.$ports['ignored'].')</span></a></li>');
}

if ($ports['disabled'])
{
  echo('<li><a href="ports/state=admindown/"><i class="oicon-network-status-offline"></i> 禁用</a></li>'); // &nbsp;<span class="right">('.$ports['disabled'].')</span></a></li>');
}

if ($ports['deleted']) { echo('<li><a href="deleted-ports/"><i class="oicon-badge-square-minus"></i> 删除&nbsp;<span class="right">('.$ports['deleted'].')</span></a></li>'); }
?>

              </ul>
            </li>
<?php

// This stuff is all very complex. It needs simplified into one or two loops, perhaps a function.

?>
            <li class="divider-vertical" style="margin:0;"></li>
            <li class="dropdown">
              <a class="hidden-sm hidden-xs dropdown-toggle" href="#" data-hover="dropdown" data-toggle="dropdown"><i class="oicon-system-monitor"></i> 网络健康 <b class="caret"></b></a>
              <a class="hidden-md hidden-lg dropdown-toggle" href="#" data-hover="dropdown" data-toggle="dropdown"><i class="oicon-system-monitor"></i> <b class="caret"></b></a>

              <ul class="dropdown-menu">

<?php
$items = array('mempool' => array('text' => "内存", 'icon' => 'oicon-memory'),
               'processor' => array('text' => "处理器", 'icon' => 'oicon-processor'),
               'storage' => array('text' => "存储", 'icon' => 'oicon-drive'));

if(dbFetchCell("SELECT count(*) FROM `toner`"))
{
  $items['toner'] = array('text' => "硒鼓", 'icon' => 'oicon-contrast');
  $toner_exists = TRUE;
}

foreach ($items as $item => $item_data)
{
  echo('<li><a href="'.generate_url(array('page'=>'health', 'metric' => $item)).'"><i class="'.$item_data['icon'].'"></i> '.$item_data['text'].'</a></li>');
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
        echo('<li class="divider"></li>');
        $sep = 0;
      }
      $alert_icon = ($cache['sensor_types'][$item]['alert'] ? '<i class="oicon-exclamation-red"></i>' : '');
      echo('<li><a href="'.generate_url(array('page'=>'health', 'metric' => $item)).'"><i class="'.$config['sensor_types'][$item]['icon'].'"></i> '.nicecase($item)." $alert_icon</a></li>");
    }
  }
  $sep++;
}

?>
              </ul>
            </li>

<?php

$app_count = dbFetchCell("SELECT COUNT(`app_id`) FROM `applications`");

if ($_SESSION['userlevel'] >= '5' && ($app_count) > "0")
{
?>
            <li class="divider-vertical" style="margin:0;"></li>
    <li class="dropdown">
      <a class="hidden-sm hidden-xs dropdown-toggle" href="#" data-hover="dropdown" data-toggle="dropdown"><i class="oicon-application-icon-large"></i> 应用 <b class="caret"></b></a>
      <a class="hidden-lg hidden-md dropdown-toggle" href="#" data-hover="dropdown" data-toggle="dropdown"><i class="oicon-application-icon-large"></i> <b class="caret"></b></a>

      <ul class="dropdown-menu">
<?php

  $app_list = dbFetchRows("SELECT `app_type` FROM `applications` GROUP BY `app_type` ORDER BY `app_type`");
  foreach ($app_list as $app)
  {
    $image = $config['html_dir']."/images/icons/".$app['app_type'].".png";
    $icon = (file_exists($image) ? $app['app_type'] : "apps");
    //$icon = $image;
    echo('<li><a href="apps/app='.$app['app_type'].'/"><img src="images/icons/'.$icon.'.png" alt="" /> '.nicecase($app['app_type']).' </a></li>');
  }

?>

              </ul>
            </li>

<?php
}

if ($_SESSION['userlevel'] >= '5' && ($routing['bgp']['count']+$routing['ospf']['count']+$routing['cef']['count']+$routing['vrf']['count']) > 0)
{
?>
     <li class="divider-vertical" style="margin:0;"></li>
     <li class="dropdown">
       <a class="hidden-sm hidden-xs dropdown-toggle" href="#" data-hover="dropdown" data-toggle="dropdown"><i class="oicon-arrow-branch-000-left"></i> 路由 <b class="caret"></b></a>
       <a class="hidden-lg hidden-md dropdown-toggle" href="#" data-hover="dropdown" data-toggle="dropdown"><i class="oicon-arrow-branch-000-left"></i> <b class="caret"></b></a>
       <ul class="dropdown-menu" style="width:200px;">

<?php
  $separator = 0;

  if ($_SESSION['userlevel'] >= '5' && $routing['vrf']['count'])
  {
    echo('<li><a href="routing/protocol=vrf/"><i class="oicon-arrow-branch-byr"></i> VRFs&nbsp;<span class="right">(' . $routing['vrf']['count'] . ')</span></a></li>');
    $separator++;
  }

  if ($_SESSION['userlevel'] >= '5' && $routing['ospf']['up'])
  {
    if ($separator)
    {
      echo('<li class="divider"></li>');
      $separator = 0;
    }
    echo('
        <li><a href="routing/protocol=ospf/"><img src="images/16/text_letter_omega.png" border="0" align="absmiddle" /> OSPF Instances&nbsp;<span class="right">(' . $routing['ospf']['up'] . ')</span></a></li>');
    $separator++;
  }
  // BGP Sessions
  if ($_SESSION['userlevel'] >= '5' && $routing['bgp']['count'])
  {
    if ($separator)
    {
      echo('<li class="divider"></li>');
      $separator = 0;
    }
    echo('
        <li><a href="routing/protocol=bgp/type=all/graph=NULL/"><img src="images/16/link.png" alt="" /> BGP所有会话&nbsp;<span class="right">(' . $routing['bgp']['count'] . ')</span></a></li>

        <li><a href="routing/protocol=bgp/type=external/graph=NULL/"><img src="images/16/world_link.png" alt="" /> BGP出口</a></li>
        <li><a href="routing/protocol=bgp/type=internal/graph=NULL/"><img src="images/16/brick_link.png" alt="" /> BGP内网</a></li>');
  }

  // Do Alerts at the bottom
  if ($routing['bgp']['alerts'])
  {
    echo('
        <li class="divider"></li>
        <li><a href="routing/protocol=bgp/adminstatus=start/state=down/"><img src="images/16/link_error.png" alt="" /> BGP Alerts&nbsp;<span class="right">(' . $routing['bgp']['alerts'] . ')</span></a></li>
   ');
  }

  echo('      </ul></li>');

}
?>
</ul>
          <ul class="nav pull-right">
          <li class="dropdown hidden-xs">
            <form id="searchform" class="navbar-search" action="#" style="margin-left: 10px; margin-right: 10px;  margin-top: 5px; margin-bottom: -5px;">
              <input style="width: 145px;" onkeyup="lookup(this.value);" type="text" value="" class="dropdown-toggle" placeholder="搜索" />
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
  
  echo '<li><a href="', $url, '"> <i class="', $icon, '"></i></a></li>';

?>


            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-hover="dropdown" data-toggle="dropdown"><i class="oicon-gear"></i> <b class="caret"></b></a>
              <ul class="dropdown-menu">
                <li><a href="http://www.observium.org/wiki/Documentation" title="帮助"><i class="oicon-question"></i> 帮助</a></li>
                <li class="divider"></li>

<?php

if($_SESSION['widescreen'] == 1)
{
  echo('<li><a href="'.generate_url($vars, array('widescreen' => 'no')).'" title="切换为标准屏幕宽度视图"><i class="oicon-arrow-in" style="font-size: 16px; color: #555;"></i> 标准屏幕</a></li>');
} else {
  echo('<li><a href="'.generate_url($vars, array('widescreen' => 'yes')).'" title="切换为宽屏视图"><i class="oicon-arrow-move" style="font-size: 16px; color: #555;"></i> 宽屏</a></li>');
}

if($_SESSION['big_graphs'] == 1)
{
  echo('<li><a href="'.generate_url($vars, array('big_graphs' => 'no')).'" title="切换为标准视图"><i class="oicon-layout-6" style="font-size: 16px; color: #555;"></i> 标准流量图</a></li>');
} else {
  echo('<li><a href="'.generate_url($vars, array('big_graphs' => 'yes')).'" title="切换为大视图"><i class="oicon-layout-4" style="font-size: 16px; color: #555;"></i> 大流量图</a></li>');
}

if ($config['api']['enabled'])
{
  echo('<li class="divider"></li>');
  echo('<li class="dropdown-submenu">');
  echo('  <a tabindex="-1" href="'.generate_url(array('page'=>'simpleapi')).'"><i class="oicon-application-block"></i> 独立API</a>');
  echo('  <ul class="dropdown-menu">');
  echo('    <li><a href="'.generate_url(array('page'=>'simpleapi')).'"><i class="oicon-application-block"></i> API手册</a></li>');
  echo('    <li><a href="'.generate_url(array('page'=>'simpleapi','api'=>'errorcodes')).'"><i class="oicon-application--exclamation"></i> 错误代码</a></li>');
  echo('  </ul>');
  echo('</li>');
}

if ($_SESSION['userlevel'] >= 10)
{
  echo('<li class="divider"></li>');
  echo('<li class="dropdown-submenu">');
  echo('  <a tabindex="-1" href="'.generate_url(array('page'=>'adduser')).'"><i class="oicon-users"></i> 用户</a>');
  echo('  <ul class="dropdown-menu">');
  if (auth_usermanagement())
  {
    echo('    <li><a href="'.generate_url(array('page'=>'adduser')).'"><i class="oicon-user--plus"></i> 添加用户</a></li>');
  }
  echo('    <li><a href="'.generate_url(array('page'=>'edituser')).'"><i class="oicon-user--pencil"></i> 编辑用户</a></li>');
  if (auth_usermanagement())
  {
    echo('    <li><a href="'.generate_url(array('page'=>'edituser')).'"><i class="oicon-user--minus"></i> 删除用户</a></li>');
  }
  echo('    <li><a href="'.generate_url(array('page'=>'authlog')).'"><i class="oicon-user-detective"></i> 认证日志</a></li>');
  echo('  </ul>');
  echo('</li>');
}
?>
                <li class="divider"></li>
                <li><a href="<?php echo generate_url(array('page'=>'settings')); ?>" title="全局设置"><i class="oicon-wrench"></i> 全局设置</a></li>
                <li><a href="<?php echo generate_url(array('page'=>'preferences')); ?>" title="我的设置 "><i class="oicon-wrench-screwdriver"></i> 我的设置</a></li>
<?php
if (auth_can_logout())
{
?>
                <li class="divider"></li>
                <li><a href="<?php echo generate_url(array('page'=>'logout')); ?>" title="注销"><i class="oicon-door-open-out"></i> 注销</a></li>
<?php
}
?>
                <li class="divider"></li>
                <li><a href="<?php echo generate_url(array('page'=>'about')); ?>" title="关于我们"><i class="oicon-information"></i> 关于我们</a></li>
              </ul>
            </li>
          </ul>
        </div><!-- /.nav-collapse -->
      </div>
    </div><!-- /navbar-inner -->
  </header>

<script>

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

</script>
