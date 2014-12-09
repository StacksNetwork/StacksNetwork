<?php

/// FIXME THIS FILE IS NO LONGER USED! CAN BE REMOVED?

// FIXME - this could do with some performance improvements, i think. possible rearranging some tables and setting flags at poller time (nothing changes outside of then anyways)

$service_alerts = dbFetchCell("SELECT COUNT(service_id) FROM services WHERE service_status = '0'");
$if_alerts      = dbFetchCell("SELECT COUNT(port_id) FROM `ports` WHERE `ifOperStatus` = 'down' AND `ifAdminStatus` = 'up' AND `ignore` = '0'");

if (isset($config['enable_bgp']) && $config['enable_bgp'])
{
  $bgp_alerts = dbFetchCell("SELECT COUNT(bgpPeer_id) FROM bgpPeers AS B where (bgpPeerAdminStatus = 'start' OR bgpPeerAdminStatus = 'running') AND bgpPeerState != 'established'");
}

?>

<ul id="menium">

    <li><a href="<?php echo(generate_url(array('page'=>'overview'))); ?>" class="drop"><img src="images/16/lightbulb.png" border="0" align="absmiddle" /> 概述</a>
        <div class="dropdown_1column">
            <div class="col_1">
        <ul>
        <?php if (isset($config['enable_map']) && $config['enable_map']) {
          echo('<li><a href="'.generate_url(array('page'=>'overview')).'"><img src="images/16/map.png" border="0" align="absmiddle" /> 网络拓扑</a></li>');
        } ?>
        <li><a href="<?php echo(generate_url(array('page'=>'eventlog'))); ?>"><img src="images/16/report.png" border="0" align="absmiddle" /> 事件日志</a></li>
        <?php if (isset($config['enable_syslog']) && $config['enable_syslog']) {
          echo('<li><a href="'.generate_url(array('page'=>'syslog')).'"><img src="images/16/report_key.png" border="0" align="absmiddle" /> 系统日志</a></li>');
        } ?>
<!--        <li><a href="<?php echo(generate_url(array('page'=>'alerts'))); ?>"><img src="images/16/exclamation.png" border="0" align="absmiddle" /> 警报</a></li> -->
        <li><a href="<?php echo(generate_url(array('page'=>'inventory'))); ?>"><img src="images/16/bricks.png" border="0" align="absmiddle" /> 清单</a></li>
        </ul>
            </div>

            <div class="col_1">
              <h3>搜索</h3>
            </div>

            <div class="col_1">
        <ul>
          <li><a href="<?php echo(generate_url(array('page'=>'search','search'=>'ipv4'))); ?>"><img src="images/icons/ipv4.png" border="0" align="absmiddle" /> IPv4搜索</a></li>
          <li><a href="<?php echo(generate_url(array('page'=>'search','search'=>'ipv6'))); ?>"><img src="images/icons/ipv6.png" border="0" align="absmiddle" /> IPv6搜索</a></li>
          <li><a href="<?php echo(generate_url(array('page'=>'search','search'=>'mac'))); ?>"><img src="images/16/email_link.png" border="0" align="absmiddle" /> MAC搜索</a></li>
          <li><a href="<?php echo(generate_url(array('page'=>'search','search'=>'arp'))); ?>"><img src="images/16/email_link.png" border="0" align="absmiddle" /> ARP表</a></li>
        </ul>
            </div>

        </div>

    </li>

    <li><a href="devices/" class="drop"><img src="images/16/server.png" border="0" align="absmiddle" /> 设备</a>

     <div class="dropdown_4columns"><!-- Begin 4 columns container -->
      <div class="col_1">
        <ul>
          <li><a href="devices/"><img src="images/16/server.png" border="0" align="absmiddle" /> 所有设备</a></li>
          <li><hr width="140" /></li>

<?php

foreach ($config['device_types'] as $devtype)
{
  if (in_array($devtype['type'],array_keys($cache['device_types'])))
  {
    echo('        <li><a href="devices/type=' . $devtype['type'] . '/"><img src="images/icons/' . $devtype['icon'] . '" border="0" align="absmiddle" /> ' . $devtype['text'] . '</a></li>');
  }
}

if ($_SESSION['userlevel'] >= '10')
{
  if (count($cache['device_types']))
  {
    echo('
        <li><hr width="140" /></li>');
  }
  echo('
        <li><a href="addhost/"><img src="images/16/server_add.png" border="0" align="absmiddle" /> 所有设备</a></li>
        <li><a href="delhost/"><img src="images/16/server_delete.png" border="0" align="absmiddle" /> 删除设备</a></li>');
}
?>

          </ul>

       </div>

       <div id="devices_chart" class="col_3" style="height: 300px">
       </div>

<script class="code" type="text/javascript">
$(document).ready(function() {
  var data = [
    ['Up', <?php echo($devices['up']); ?>],
    ['Down', <?php echo($devices['down']); ?>],
    ['Ignored', <?php echo($devices['ignored']); ?>],
    ['Disabled', <?php echo($devices['disabled']); ?>]
  ];
  var plot1 = jQuery.jqplot ('devices_chart', [data],
    {
      seriesDefaults: {
        renderer: jQuery.jqplot.PieRenderer,
        rendererOptions: {
          // Turn off filling of slices.
          fill: true,
          showDataLabels: true,
          // Add a margin to seperate the slices.
          sliceMargin: 0,
          // stroke the slices with a little thicker line.
          lineWidth: 5
        }
      },
      legend: { show:true, location: 'e' }
    }
  );
}
);
</script>
      </div>

    </li><!-- End 5 columns Item -->

<?php

if ($config['show_services'])
{
?>

    <li><a href="services/" class="drop"><img src="images/16/cog.png" border="0" align="absmiddle" /> 服务</a><!-- Begin 4 columns Item -->

        <div class="dropdown_4columns"><!-- Begin 4 columns container -->

            <div class="col_1">
<ul>
        <li><a href="services/"><img src="images/16/cog.png" border="0" align="absmiddle" /> 所有服务 </a></li>

<?php

if ($service_alerts)
{
  echo('  <li><hr width=140 /></li>
        <li><a href="services/status=0/"><img src="images/16/cog_error.png" border="0" align="absmiddle" /> 警报 ('.$service_alerts.')</a></li>');
}

if ($_SESSION['userlevel'] >= '10')
{
  echo('
        <li><hr width="140" /></li>
        <li><a href="addsrv/"><img src="images/16/cog_add.png" border="0" align="absmiddle" /> 添加服务</a></li>
        <li><a href="delsrv/"><img src="images/16/cog_delete.png" border="0" align="absmiddle" /> 删除服务</a></li>');
}
?>
        </ul>
        </div>

       <div id="services_chart" class="col_3" style="height: 300px">
       </div>

<script class="code" type="text/javascript">
$(document).ready(function() {
  var data = [
    ['正常', <?php echo($services['up']); ?>],
    ['异常', <?php echo($services['down']); ?>],
  ];
  var plot2 = jQuery.jqplot ('services_chart', [data],
    {
      seriesDefaults: {
        renderer: jQuery.jqplot.PieRenderer,
        rendererOptions: {
          // Turn off filling of slices.
          fill: true,
          showDataLabels: true,
          // Add a margin to seperate the slices.
          sliceMargin: 0,
          // stroke the slices with a little thicker line.
          lineWidth: 5
        }
      },
      legend: { show:true, location: 'e' }
    }
  );
});
</script>

        </div><!-- End 4 columns container -->

    </li><!-- End 4 columns Item -->

<?php
}

if ($config['show_locations'])
{
?>
    <li><a href="locations/" class="drop"><img src="images/16/building.png" border="0" align="absmiddle" /> Locations</a><!-- Begin Home Item -->

<?php
  if ($config['show_locations_dropdown'])
  {
?>
        <div class="dropdown_2columns"><!-- Begin 2 columns container -->
          <div class="col_2">
            <ul>
<?php
    foreach (getlocations() as $location)
    {
      echo('            <li><a href="devices/location=' . urlencode($location) . '/"><img src="images/16/building.png" border="0" align="absmiddle" /> ' . $location . ' </a></li>');
    }
?>
            </ul>
          </div>
        </div><!-- End 4 columns container -->
<?php
  }
?>
    </li><!-- End 4 columns Item -->

<?php
}
?>

    <!-- PORTS -->

    <li><a href="ports/" class="drop"><img src="images/16/connect.png" border="0" align="absmiddle" /> 端口</a><!-- Begin Home Item -->

        <div class="dropdown_4columns"><!-- Begin 2 columns container -->

          <div class="col_1">
             <ul>
<li><a href="ports/"><img src="images/16/connect.png" border="0" align="absmiddle" /> 所有端口</a></li>

<?php

if ($ports['errored'])
{
  echo('<li><a href="ports/errors=1/"><img src="images/16/chart_curve_error.png" border="0" align="absmiddle" /> 错误 ('.$ports['errored'].')</a></li>');
}

if ($ports['ignored'])
{
  echo('<li><a href="ports/ignore=1/"><img src="images/16/chart_curve_link.png" border="0" align="absmiddle" /> 忽略 ('.$ports['ignored'].')</a></li>');
}

if ($config['enable_billing']) { echo('<li><a href="bills/"><img src="images/16/money.png" border="0" align="absmiddle" /> 流量账单</a></li>'); $ifbreak = 1; }

if ($config['enable_pseudowires']) { echo('<li><a href="pseudowires/"><img src="images/16/arrow_switch.png" border="0" align="absmiddle" /> 伪流量</a></li>'); $ifbreak = 1; }

?>
<?php

if ($_SESSION['userlevel'] >= '5')
{
  echo('<li><hr width="140" /></li>');
  if ($config['int_customers']) { echo('<li><a href="customers/"><img src="images/16/group_link.png" border="0" align="absmiddle" /> 客户</a></li>'); $ifbreak = 1; }
  if ($config['int_l2tp']) { echo('<li><a href="iftype/type=l2tp/"><img src="images/16/user.png" border="0" align="absmiddle" /> L2TP</a></li>'); $ifbreak = 1; }
  if ($config['int_transit']) { echo('<li><a href="iftype/type=transit/"><img src="images/16/lorry_link.png" border="0" align="absmiddle" /> 透传</a></li>');  $ifbreak = 1; }
  if ($config['int_peering']) { echo('<li><a href="iftype/type=peering/"><img src="images/16/bug_link.png" border="0" align="absmiddle" /> 对等互联</a></li>'); $ifbreak = 1; }
  if ($config['int_peering'] && $config['int_transit']) { echo('<li><a href="iftype/type=peering,transit/"><img src="images/16/world_link.png" border="0" align="absmiddle" /> 对等互联 + 透传</a></li>'); $ifbreak = 1; }
  if ($config['int_core']) { echo('<li><a href="iftype/type=core/"><img src="images/16/brick_link.png" border="0" align="absmiddle" /> 核心</a></li>'); $ifbreak = 1; }
}

if ($ifbreak) { echo('<li><hr width="140" /></li>'); }

if (isset($interface_alerts))
{
  echo('<li><a href="ports/alerted=yes/"><img src="images/16/link_error.png" border="0" align="absmiddle" /> 警报 ('.$interface_alerts.')</a></li>');
}

$deleted_ports = 0;
foreach (dbFetchRows("SELECT * FROM `ports` AS P, `devices` as D WHERE P.`deleted` = '1' AND D.device_id = P.device_id") as $interface)
{
  if (port_permitted($interface['port_id'], $interface['device_id']))
  {
    $deleted_ports++;
  }
}
?>

<li><a href="ports/state=down/"><img src="images/16/if-disconnect.png" border="0" align="absmiddle" /> 异常</a></li>
<li><a href="ports/state=admindown/"><img src="images/16/if-disable.png" border="0" align="absmiddle" /> 禁用</a></li>
<?php

if ($deleted_ports) { echo('<li><a href="deleted-ports/"><img src="images/16/cross.png" border="0" align="absmiddle" /> 已删除 ('.$deleted_ports.')</a></li>'); }

?>
</ul>
          </div>

          <div id="ports_chart" class="col_3" style="height: 300px">
          </div>

<script class="code" type="text/javascript">
$(document).ready(function() {
  var data = [
    ['正常', <?php echo($ports['up']); ?>],
    ['异常', <?php echo($ports['down']); ?>],
    ['关闭', <?php echo($ports['admindown']); ?>],
    ['忽略', <?php echo($ports['ignored']); ?>],
    ['删除', <?php echo($ports['deleted']); ?>]
  ];
  var plot3 = jQuery.jqplot ('ports_chart', [data],
    {
      seriesDefaults: {
        renderer: jQuery.jqplot.PieRenderer,
        rendererOptions: {
          // Turn off filling of slices.
          fill: true,
          showDataLabels: true,
          // Add a margin to seperate the slices.
          sliceMargin: 0,
          // stroke the slices with a little thicker line.
          lineWidth: 5
        }
      },
      legend: { show:true, location: 'e' }
    }
  );
});
</script>

        </div><!-- End 4 columns container -->

    </li><!-- End 4 columns Item -->

<?php

// FIXME does not check user permissions...
foreach (dbFetchRows("SELECT sensor_class,COUNT(sensor_id) AS c FROM sensors GROUP BY sensor_class ORDER BY sensor_class ") as $row)
{
  $used_sensors[$row['sensor_class']] = $row['c'];
}

# Copy the variable so we can use $used_sensors later in other parts of the code
$menu_sensors = $used_sensors;

?>

    <li><a href="health/" class="drop"><img src="images/icons/sensors.png" border="0" align="absmiddle" /> 设备健康</a><!-- Begin Home Item -->

        <div class="dropdown_1column"><!-- Begin 2 columns container -->
            <div class="col_1">

<ul>
        <li><a href="health/metric=mempool/"><img src="images/icons/memory.png" border="0" align="absmiddle" /> 内存</a></li>
        <li><a href="health/metric=processor/"><img src="images/icons/processor.png" border="0" align="absmiddle" /> 处理器</a></li>
        <li><a href="health/metric=storage/"><img src="images/icons/storage.png" border="0" align="absmiddle" /> 存储</a></li>
<?php
if ($menu_sensors)
{
  $sep = 0;
  echo('<li><hr width="97%" /></li>');
}

foreach (array('fanspeed','humidity','temperature') as $item)
{
  if ($menu_sensors[$item])
  {
    echo('<li><a href="health/metric='.$item.'/"><img src="images/icons/'.$item.'.png" border="0" align="absmiddle" /> '.nicecase($item).'</a></li>');
    unset($menu_sensors[$item]);$sep++;
  }
}

if ($sep)
{
  echo('<li><hr width="97%" /></li>');
  $sep = 0;
}

foreach (array('current','frequency','power','voltage') as $item)
{
  if ($menu_sensors[$item])
  {
    echo('<li><a href="health/metric='.$item.'/"><img src="images/icons/'.$item.'.png" border="0" align="absmiddle" /> '.nicecase($item).'</a></li>');
    unset($menu_sensors[$item]);$sep++;
  }
}

if ($sep && array_keys($menu_sensors))
{
  echo('<li><hr width="97%" /></li>');
  $sep = 0;
}

foreach (array_keys($menu_sensors) as $item)
{
  echo('<li><a href="health/metric='.$item.'/"><img src="images/icons/'.$item.'.png" border="0" align="absmiddle" /> '.nicecase($item).'</a></li>');
  unset($menu_sensors[$item]);$sep++;
}

?>
        </ul>

            </div>

        </div><!-- End 4 columns container -->

    </li><!-- End 4 columns Item -->

<?php

$app_count = dbFetchCell("SELECT COUNT(`app_id`) FROM `applications`");

if ($_SESSION['userlevel'] >= '5' && ($app_count) > "0")
{
?>

    <li><a href="apps/" class="drop"><img src="images/icons/apps.png" border="0" align="absmiddle" /> 应用</a><!-- Begin Home Item -->
        <div class="dropdown_2columns"><!-- Begin 2 columns container -->
          <div class="col_2">
            <ul>
<?php

  $app_list = dbFetchRows("SELECT `app_type` FROM `applications` GROUP BY `app_type` ORDER BY `app_type`");
  foreach ($app_list as $app)
  {
    $image = $config['html_dir']."/images/icons/".$app['app_type'].".png";
    $icon = (file_exists($image) ? $app['app_type'] : "apps");
    //$icon = $image;
echo('
        <li><a href="apps/app='.$app['app_type'].'/"><img src="images/icons/'.$icon.'.png" border="0" align="absmiddle" /> '.nicecase($app['app_type']).' </a></li>');
  }

?>
          </ul>
        </div>
      </div>
    </li>

<?php
}

$routing_count['bgp']  = dbFetchCell("SELECT COUNT(bgpPeer_id) from `bgpPeers`");
$routing_count['ospf'] = dbFetchCell("SELECT COUNT(ospf_instance_id) FROM `ospf_instances` WHERE `ospfAdminStat` = 'enabled'");
$routing_count['cef']  = dbFetchCell("SELECT COUNT(cef_switching_id) from `cef_switching`");
$routing_count['vrf']  = dbFetchCell("SELECT COUNT(vrf_id) from `vrfs`");

if ($_SESSION['userlevel'] >= '5' && ($routing_count['bgp']+$routing_count['ospf']+$routing_count['cef']+$routing_count['vrf']) > "0")
{

?>

    <li><a href="routing/" class="drop"><img src="images/16/arrow_branch.png" border="0" align="absmiddle" /> 路由</a><!-- Begin Home Item -->
        <div class="dropdown_1column"><!-- Begin 1 column container -->
          <ul>

<?php
  $separator = 0;

  if ($_SESSION['userlevel'] >= '5' && $routing_count['vrf'])
  {
    echo('<li><a href="routing/protocol=vrf/"><img src="images/16/layers.png" border="0" align="absmiddle" /> VRFs</a></li>');
    $separator++;
  }

  if ($_SESSION['userlevel'] >= '5' && $routing_count['ospf'])
  {
    if ($separator)
    {
      echo('
        <li><hr width=140></li>');
      $separator = 0;
    }
    echo('
        <li><a href="routing/protocol=ospf/"><img src="images/16/text_letter_omega.png" border="0" align="absmiddle" /> OSPF设备 </a></li>');
    $separator++;
  }

  // BGP Sessions
  if ($_SESSION['userlevel'] >= '5' && $routing_count['bgp'])
  {
    if ($separator)
    {
      echo('
        <li><hr width=140></li>');
      $separator = 0;
    }
    echo('
        <li><a href="routing/protocol=bgp/type=all/graph=NULL/"><img src="images/16/link.png" border="0" align="absmiddle" /> BGP所有会话 </a></li>

        <li><a href="routing/protocol=bgp/type=external/graph=NULL/"><img src="images/16/world_link.png" border="0" align="absmiddle" /> BGP外部流量</a></li>
        <li><a href="routing/protocol=bgp/type=internal/graph=NULL/"><img src="images/16/brick_link.png" border="0" align="absmiddle" /> BGP内部流量</a></li>');
  }

  // Do Alerts at the bottom
  if ($bgp_alerts)
  {
    echo('
        <li><hr width=140></li>
        <li><a href="routing/protocol=bgp/adminstatus=start/state=down/"><img src="images/16/link_error.png" border="0" align="absmiddle" /> BGP报警 (' . $bgp_alerts . ')</a></li>
   ');
  }

  echo('      </ul>');
?>

        </div><!-- End 4 columns container -->

    </li><!-- End 4 columns Item -->

<?php
}

$packages = dbFetchCell("SELECT COUNT(pkg_id) from `packages`");

if ($packages)
{
?>

    <li><a href="<?php echo(generate_url(array('page'=>'packages'))); ?>" class="drop"><img src="images/16/box.png" border="0" align="absmiddle" /> 软件包</a>
      <div class="dropdown_1column">
        <div class="col_1">
          <ul>
            <li><a href="<?php echo(generate_url(array('page'=>'packages'))); ?>"><img src="images/16/box.png" border="0" align="absmiddle" /> 所有软件包</a></li>
          </ul>
        </div>
      </div>
    </li>
<?php
} # if ($packages)

if ($config['api']['enabled'])
{
?>

    <li><a href="<?php echo(generate_url(array('page'=>'simpleapi'))); ?>" class="drop"><img src="images/16/page_white_code.png" border="0" align="absmiddle" /> 独立API</a>
      <div class="dropdown_1column">
        <div class="col_1">
          <ul>
            <li><a href="<?php echo(generate_url(array('page'=>'simpleapi'))); ?>"><img src="images/16/page_white_code.png" border="0" align="absmiddle" /> API手册</a></li>
            <li><a href="<?php echo(generate_url(array('page'=>'simpleapi','api'=>'errorcodes'))); ?>"><img src="images/16/page_white_error.png" border="0" align="absmiddle" /> 错误代码</a></li>
          </ul>
        </div>
      </div>
    </li>
<?php
} # if ($packages)

// Custom menubar entries.
if(is_file("includes/print-menubar-custom.inc.php"))
{
  include("includes/print-menubar-custom.inc.php");
}

?>
    <li class="menu_right"><a href="#" class="drop"><img src="images/16/wrench.png" border="0" align="absmiddle" /> 系统</a><!-- Begin Home Item -->

        <div class="dropdown_3columns align_right"><!-- Begin 2 columns container -->

            <div class="col_3">
                <h2>Observium <?php echo($config['version']); ?> </h2>
            </div>

            <div class="col_2">
                <p>网络管理和监控<br />
                Copyright (C) 2006-<?php echo date("Y"); ?> Adam Armstrong</p>
            </div>

            <div class="col_1">
              <p>
                <a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&amp;hosted_button_id=W2ZJ3JRZR72Z6" class="external text" rel="nofollow">
                <img src="images/btn_donate_LG.gif" alt="btn_donateCC_LG.gif" />
                </a>
              </p>
            </div>

            <div class="col_3">
              <a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&amp;hosted_button_id=W2ZJ3JRZR72Z6" class="external text" rel="nofollow">
                请捐款支持持续发展!
              </a>
            </div>

            <div class="col_2">
                <h2>团队</h2>
                <p>
                  <img src="images/icons/flags/gb.png"> <strong>Adam Armstrong</strong> 项目的创始人<br />
                  <img src="images/icons/flags/be.png"> <strong>Tom Laermans</strong> 开发者/委员会<br />
                  <img src="images/icons/flags/be.png"> <strong>Geert Hauwaerts</strong> 开发者<br />
                  <img src="images/icons/flags/be.png"> <strong>Dennis de Houx</strong> 开发者<br />
                </p>
            </div>
            <div class="col_1">
                <h2>设置</h2>
<ul>
<?php
if ($_SESSION['userlevel'] >= '10')
{
  echo('
        <li><a href="settings/"><img src="images/16/wrench.png" border="0" align="absmiddle" /> 全局设置</a></li>');
}
?>
      <li><a href="preferences/"><img src="images/16/wrench_orange.png" border="0" align="absmiddle" /> 我的设置</a></li>
        </ul>
            </div>

<?php
$apache_version = str_replace("Apache/", "", $_SERVER['SERVER_SOFTWARE']);
$php_version = phpversion();
$mysql_version = dbFetchCell("SELECT version()");
$netsnmp_version = shell_exec($config['snmpget'] . " --version 2>&1");
$rrdtool_version = implode(" ",array_slice(explode(" ",shell_exec($config['rrdtool'] . " --version |head -n1")),1,1));
?>

            <div class="col_2">
                <h2>Versions</h2>
                  <table width=100% cellpadding=3 cellspacing=0 border=0>
                    <tr valign=top><td><b>Apache</b></td><td><?php echo($apache_version); ?></td></tr>
                    <tr valign=top><td><b>PHP</b></td><td><?php echo($php_version); ?></td></tr>
                    <tr valign=top><td><b>MySQL</b></td><td><?php echo($mysql_version); ?></td></tr>
                    <tr valign=top><td><b>RRDtool</b></td><td><?php echo($rrdtool_version); ?></td></tr>
                  </table>
                <ul>
                  <li><a href="about/"><img src="images/16/information.png" border="0" align="absmiddle" /> 关于 Observium</a></li>
                </ul>
            </div>

<div class="col_1">
                <h2>用户</h2>
<ul>

    <?php if ($_SESSION['userlevel'] >= '10')
    {
      if (auth_usermanagement())
      {
      echo('
        <li><a href="adduser/"><img src="images/16/user_add.png" border="0" align="absmiddle" /> 添加用户</a></li>
        ');
      }
      echo('
        <li><a href="edituser/"><img src="images/16/user_edit.png" border="0" align="absmiddle" /> 编辑用户</a></li>
        <li><a href="authlog/"><img src="images/16/lock.png" border="0" align="absmiddle" /> 认证记录</a></li>');
    } ?>

        </ul>
            </div>

        </div><!-- End 2 columns container -->

    </li><!-- End Home Item -->

</ul>
