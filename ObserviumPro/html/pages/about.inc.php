<?php

/**
 * Observium Network Management and Monitoring System
 * Copyright (C) 2006-2014, Adam Armstrong - http://www.observium.org
 *
 * @package    observium
 * @subpackage webui
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2015 Adam Armstrong
 *
 */

?>

<h2 style="margin-top:0;">关于 <?php echo OBSERVIUM_PRODUCT_LONG; ?></h2>
<div class="row">
  <div class="col-md-6">
<?php

if (is_executable($config['install_dir'].'/scripts/distro'))
{
  $os = explode('|', external_exec($config['install_dir'].'/scripts/distro'), 5);
  $os_version = $os[0].' '.$os[1].' ['.$os[2].'] ('.$os[3].' '.$os[4].')';
  unset($os);
}
$apache_version  = str_replace("Apache/", "", $_SERVER['SERVER_SOFTWARE']);
$php_version     = phpversion();
$mysql_version   = dbFetchCell("SELECT version()");
$snmp_version    = str_replace(" version:", "", external_exec($config['snmpget'] . " --version 2>&1"));
$rrdtool_version = implode(" ",array_slice(explode(" ",external_exec($config['rrdtool'] . " --version |head -n1")),1,1));

?>
  <div class="well info_box">
    <div class="title"><i class="oicon-information"></i> 版本信息</div>
    <div class="content">
        <table class="table table-bordered table-striped table-condensed-more">
          <tbody>
            <tr><td><b><?php echo(escape_html(OBSERVIUM_PRODUCT)); ?></b></td><td><?php echo(escape_html(OBSERVIUM_VERSION)); ?></td></tr>
            <tr><td><b>OS</b></td><td><?php echo(escape_html($os_version)); ?></td></tr>
            <tr><td><b>Apache</b></td><td><?php echo(escape_html($apache_version)); ?></td></tr>
            <tr><td><b>PHP</b></td><td><?php echo(escape_html($php_version)); ?></td></tr>
            <tr><td><b>MySQL</b></td><td><?php echo(escape_html($mysql_version)); ?></td></tr>
            <tr><td><b>SNMP</b></td><td><?php echo(escape_html($snmp_version)); ?></td></tr>
            <tr><td><b>RRDtool</b></td><td><?php echo(escape_html($rrdtool_version)); ?></td></tr>
          </tbody>
        </table>
    </div>
  </div>

  <div style="margin-bottom: 20px; margin-top: 10px;">
  <table style="width: 100%; background: transparent;">
    <tr>
      <td style="width: 20%; text-align: center;"><a class="btn btn-small" target="_blank" href="<?php echo OBSERVIUM_URL; ?>"><i style="font-size: small;" class="icon-globe"></i> Web</a></td>
      <td style="width: 20%; text-align: center;"><a class="btn btn-small" target="_blank" href="http://jira.observium.org/"><i style="font-size: small;" class="icon-bug"></i> Bugtracker</a></td>
      <td style="width: 20%; text-align: center;"><a class="btn btn-small" target="_blank" href="<?php echo OBSERVIUM_URL; ?>/wiki/Mailing_Lists"><i style="font-size: small;" class="icon-envelope"></i> Mailing List</a></td>
      <td style="width: 20%; text-align: center;"><a class="btn btn-small" target="_blank" href="http://twitter.com/observium"><i style="font-size: small;" class="icon-twitter-sign"></i> Twitter</a></td>
      <!--<td><a class="btn btn-small" target="_blank" href="http://twitter.com/observium_svn"><i class="icon-twitter-sign"></i> SVN Twitter</a></td>-->
      <td style="width: 20%; text-align: center;"><a class="btn btn-small" target="_blank" href="http://www.facebook.com/pages/Observium/128354461353"><i style="font-size: small;" class="icon-facebook-sign"></i> Facebook</a></td>
    </tr>
  </table>
  </div>

  <div class="well info_box">
    <div class="title"><i class="oicon-user-detective"></i> 开发团队</div>
    <div class="content">
        <dl class="dl-horizontal" style="margin: 0px 0px 5px 0px;">
          <dt style="text-align: left;"><i class="icon-user"></i> Adam Armstrong</dt><dd>项目经理</dd>
          <dt style="text-align: left;"><i class="icon-user"></i> Tom Laermans</dt><dd>提交者 & 开发者</dd>
          <dt style="text-align: left;"><i class="icon-user"></i> Mike Stupalov</dt><dd>提交者 & 开发者</dd>
        </dl>
    </div>
  </div>

  <div class="well info_box">
    <div class="title"><i class="oicon-users"></i> 鸣谢</div>
    <div class="content">
        <dl class="dl-horizontal" style="margin: 0px 0px 5px 0px;">
          <dt style="text-align: left;"><i class="icon-user"></i> Twitter</dt><dd>Bootstrap的CSS框架</dd>
          <dt style="text-align: left;"><i class="icon-user"></i> <a href="mailto:p@yusukekamiyamane.com" alt="p@yusukekamiyamane.com">Yusuke Kamiyamane</a></dt><dd>Fugue Iconset</dd>
          <dt style="text-align: left;"><i class="icon-user"></i> Mark James</dt><dd>Silk Iconset</dd>
          <dt style="text-align: left;"><i class="icon-user"></i> Jonathan De Graeve</dt><dd>SNMP代码改进.</dd>
          <dt style="text-align: left;"><i class="icon-user"></i> Xiaochi Jin</dt><dd>Logo设计.</dd>
          <dt style="text-align: left;"><i class="icon-user"></i> Akichi Ren</dt><dd>Post-steampunk observational hamster</dd>
          <dt style="text-align: left;"><i class="icon-user"></i> Bruno Pramont</dt><dd>汇总代码.</dd>
          <dt style="text-align: left;"><i class="icon-user"></i> <a href="mailto:DavidPFarrell@gmail.com" alt="DavidPFarrell@gmail.com">David Farrell</a></dt><dd>帮助在PHP解析net-SNMP输出PHP.</dd>
          <dt style="text-align: left;"><i class="icon-user"></i> Job Snijders</dt><dd>基于多实例Poller包装Python</dd>
          <dt style="text-align: left;"><i class="icon-user"></i> Dennis de Houx</dt><dd>代码贡献</dd>
          <dt style="text-align: left;"><i class="icon-user"></i> Geert Hauwaerts</dt><dd>代码贡献</dd>
        </dl>
        </div>
      </div>

  <div class="well info_box">
    <div class="title"><i class="oicon-chart"></i> 统计数据</div>
    <div class="content">

<?php
$stat_devices   = dbFetchCell("SELECT COUNT(*) FROM `devices`;");
$stat_ports     = dbFetchCell("SELECT COUNT(*) FROM `ports`;");
$stat_syslog    = dbFetchCell("SELECT COUNT(*) FROM `syslog`;");
$stat_events    = dbFetchCell("SELECT COUNT(*) FROM `eventlog`;");
$stat_apps      = dbFetchCell("SELECT COUNT(*) FROM `applications`;");
$stat_services  = dbFetchCell("SELECT COUNT(*) FROM `services`;");
$stat_storage   = dbFetchCell("SELECT COUNT(*) FROM `storage`;");
$stat_diskio    = dbFetchCell("SELECT COUNT(*) FROM `ucd_diskio`;");
$stat_processors = dbFetchCell("SELECT COUNT(*) FROM `processors`;");
$stat_memory    = dbFetchCell("SELECT COUNT(*) FROM `mempools`;");
$stat_sensors   = dbFetchCell("SELECT COUNT(*) FROM `sensors`;");
$stat_sensors  += dbFetchCell("SELECT COUNT(*) FROM `status`;");
$stat_toner     = dbFetchCell("SELECT COUNT(*) FROM `toner`;");
$stat_hrdev     = dbFetchCell("SELECT COUNT(*) FROM `hrDevice`;");
$stat_entphys   = dbFetchCell("SELECT COUNT(*) FROM `entPhysical`;");

$stat_ipv4_addy = dbFetchCell("SELECT COUNT(*) FROM `ipv4_addresses`;");
$stat_ipv4_nets = dbFetchCell("SELECT COUNT(*) FROM `ipv4_networks`;");
$stat_ipv6_addy = dbFetchCell("SELECT COUNT(*) FROM `ipv6_addresses`;");
$stat_ipv6_nets = dbFetchCell("SELECT COUNT(*) FROM `ipv6_networks`;");

$stat_pw    = dbFetchCell("SELECT COUNT(*) FROM `pseudowires`;");
$stat_vrf   = dbFetchCell("SELECT COUNT(*) FROM `vrfs`;");
$stat_vlans = dbFetchCell("SELECT COUNT(*) FROM `vlans`;");

$stat_db    = get_db_size();
$stat_rrd   = get_dir_size($config['rrd_dir']);

?>
      <table class="table table-bordered table-striped table-condensed">
        <tbody>
          <tr>
            <td style='width: 45%;'><i class='oicon-database'></i> <strong>DB大小</strong></td><td><span class='pull-right'><?php echo(formatStorage($stat_db)); ?></span></td>
            <td style='width: 45%;'><i class='oicon-box-zipper'></i> <strong>RRD大小</strong></td><td><span class='pull-right'><?php echo(formatStorage($stat_rrd)); ?></span></td>
          </tr>
          <tr>
            <td><i class='oicon-servers'></i> <strong>设备</strong></td><td><span class='pull-right'><?php echo($stat_devices); ?></span></td>
            <td><i class='oicon-network-ethernet'></i> <strong>端口</strong></td><td><span class='pull-right'><?php echo($stat_ports); ?></span></td>
          </tr>
          <tr>
            <td><i class='oicon-ipv4'></i> <strong>IPv4地址</strong></td><td><span class='pull-right'><?php echo($stat_ipv4_addy); ?></span></td>
            <td><i class='oicon-ipv4'></i> <strong>IPv4网络</strong></td><td><span class='pull-right'><?php echo($stat_ipv4_nets); ?></span></td>
          </tr>
          <tr>
            <td><i class='oicon-ipv6'></i> <strong>IPv6 Addresses</strong></td><td><span class='pull-right'><?php echo($stat_ipv6_addy); ?></span></td>
            <td><i class='oicon-ipv6'></i> <strong>IPv6 Networks</strong></td><td><span class='pull-right'><?php echo($stat_ipv6_nets); ?></span></td>
           </tr>
         <tr>
            <td><i class='oicon-gear'></i> <strong>服务</strong></td><td><span class='pull-right'><?php echo($stat_services); ?></span></td>
            <td><i class='oicon-application-icon-large'></i> <strong>应用程序</strong></td><td><span class='pull-right'><?php echo($stat_apps); ?></span></td>
          </tr>
          <tr>
            <td><i class='oicon-processor'></i> <strong>处理器</strong></td><td><span class='pull-right'><?php echo($stat_processors); ?></span></td>
            <td><i class='oicon-memory'></i> <strong>内存</strong></td><td><span class='pull-right'><?php echo($stat_memory); ?></span></td>
          </tr>
          <tr>
            <td><i class='oicon-drive'></i> <strong>存储</strong></td><td><span class='pull-right'><?php echo($stat_storage); ?></span></td>
            <td><i class='oicon-drive--arrow'></i> <strong>磁盘I/O</strong></td><td><span class='pull-right'><?php echo($stat_diskio); ?></span></td>
          </tr>
          <tr>
            <td><i class='oicon-wooden-box'></i> <strong>HR-MIB</strong></td><td><span class='pull-right'><?php echo($stat_hrdev); ?></span></td>
            <td><i class='oicon-wooden-box'></i> <strong>Entity-MIB</strong></td><td><span class='pull-right'><?php echo($stat_entphys); ?></span></td>
          </tr>
          <tr>
            <td><i class='oicon-clipboard-eye'></i> <strong>系统日志</strong></td><td><span class='pull-right'><?php echo($stat_syslog); ?></span></td>
            <td><i class='oicon-clipboard-audit'></i> <strong>事件日志</strong></td><td><span class='pull-right'><?php echo($stat_events); ?></span></td>
          </tr>
          <tr>
            <td><i class='oicon-system-monitor'></i> <strong>传感器</strong></td><td><span class='pull-right'><?php echo($stat_sensors); ?></span></td>
            <td><i class='oicon-printer-color'></i> <strong>硒鼓</strong></td><td><span class='pull-right'><?php echo($stat_toner); ?></span></td>
          </tr>
        </tbody>
      </table>

      </div>
    </div>
  </div>
  <div class="col-md-6">

  <div class="well info_box">
    <div class="title"><i class="oicon-notebook"></i> 许可证</div>
    <div class="content">
      <pre class="small">
        <?php include($config['install_dir']."/LICENSE"); ?>
      </pre>
    </div>
  </div>
  </div>
</div>

<?php

// EOF
