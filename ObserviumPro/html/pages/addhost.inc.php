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

if ($_SESSION['userlevel'] < 10)
{
  include("includes/error-no-perm.inc.php");

  exit;
}

echo '<div class="row">';

echo("<h2>添加设备</h2>");

if ($vars['hostname'])
{
  if ($_SESSION['userlevel'] >= '10')
  {
    $hostname = strip_tags($vars['hostname']);
    $snmp_community = strip_tags($vars['snmp_community']);

    if ($vars['snmp_port'] && is_numeric($vars['snmp_port'])) { $snmp_port = (int)$vars['snmp_port']; } else { $snmp_port = 161; }

    if ($vars['snmp_version'] === "v2c" || $vars['snmp_version'] === "v1")
    {
      if ($vars['snmp_community'])
      {
        $config['snmp']['community'] = array($snmp_community);
      }

      $snmp_version = $vars['snmp_version'];
      print_message("添加主机 $hostname communit" . (count($config['snmp']['community']) == 1 ? "y" : "ies") . " "  . implode(', ',$config['snmp']['community']) . " port $snmp_port");
    }
    else if ($vars['snmp_version'] === "v3")
    {
      $snmp_v3 = array (
        'authlevel'  => $vars['snmp_authlevel'],
        'authname'   => $vars['snmp_authname'],
        'authpass'   => $vars['snmp_authpass'],
        'authalgo'   => $vars['snmp_authalgo'],
        'cryptopass' => $vars['snmp_cryptopass'],
        'cryptoalgo' => $vars['snmp_cryptoalgo'],
      );

      array_unshift($config['snmp']['v3'], $snmp_v3);

      $snmp_version = "v3";

      print_message("添加 SNMPv3 主机 $hostname 端口 $snmp_port");
    } else {
      print_error("不支持的 SNMP 版本. 有一个下拉菜单, 你是怎么达到这个错误 ?"); // We have a hacker!
    }

    if ($vars['ignorerrd'] == 'confirm') { $config['rrd_override'] = TRUE; }

    $result = add_device($hostname, $snmp_version, $snmp_port, strip_tags($vars['snmp_transport']));
    if ($result)
    {
      print_success("设备添加 (id = $result)");
    }
  } else {
    print_error("您不必添加主机的必要权限.");
  }
} else {
  // Defaults
  switch ($vars['snmp_version'])
  {
    case 'v1':
    case 'v2c':
    case 'v3':
      $snmp_version = $vars['snmp_version'];
      break;
    default:
      $snmp_version = $config['snmp']['version'];
  }
  if (in_array($vars['snmp_transport'], $config['snmp']['transports']))
  {
    $snmp_transport = $vars['snmp_transport'];
  } else {
    $snmp_transport = $config['snmp']['transports'][0];
  }
}

$page_title[] = "添加主机";

?>

<form id="edit" name="edit" method="post" class="form-horizontal" action="">
  <input type="hidden" name="editing" value="yes">

  <div class="row">
    <div class="col-md-6">

      <div class="widget widget-table">
        <div class="widget-header">
          <i class="oicon-gear"></i><h3>基础设置</h3>
        </div>
        <div class="widget-content"  style="padding-top: 10px;">

          <fieldset>

            <div class="control-group">
              <label class="control-label" for="hostname">主机名</label>
              <div class="controls">
                <input type=text name="hostname" size="32" value="<?php echo(escape_html($vars['hostname'])); ?>" />
              </div>
            </div>

            <div class="control-group">
              <label class="control-label" for="snmp_version">协议版本</label>
              <div class="controls">
                <select class="selectpicker" name="snmp_version" id="snmp_version">
                  <option value="v1"  <?php echo($snmp_version == 'v1'  ? 'selected' : ''); ?> >v1</option>
                  <option value="v2c" <?php echo($snmp_version == 'v2c' ? 'selected' : ''); ?> >v2c</option>
                  <option value="v3"  <?php echo($snmp_version == 'v3'  ? 'selected' : ''); ?> >v3</option>
                </select>
              </div>
            </div>

            <div class="control-group">
              <label class="control-label" for="snmp_transport">协议</label>
              <div class="controls">
                <select class="selectpicker" name="snmp_transport">
                  <?php
                  foreach ($config['snmp']['transports'] as $transport)
                  {
                    echo("<option value='".$transport."'");
                    if ($transport == $snmp_transport) { echo(" selected='selected'"); }
                    echo(">".$transport."</option>");
                  }
                  ?>
                </select>
              </div>
            </div>

            <div class="control-group">
              <label class="control-label" for="snmp_port">端口</label>
              <div class="controls">
                <input type=text name="snmp_port" size="32" value="<?php echo(escape_html($vars['snmp_port'])); ?>"/>
              </div>
            </div>

            <div class="control-group">
              <label class="control-label" for="snmp_timeout">超时</label>
              <div class="controls">
                <input type=text name="snmp_timeout" size="32" value="<?php echo(escape_html($vars['snmp_timeout'])); ?>"/>
              </div>
            </div>

            <div class="control-group">
              <label class="control-label" for="snmp_retries">重试</label>
              <div class="controls">
                <input type=text name="snmp_retries" size="32" value="<?php echo(escape_html($vars['snmp_retries'])); ?>"/>
              </div>
            </div>

            <div class="control-group">
              <label class="control-label" for="ignorerrd">忽略RRD存在</label>
              <div class="controls">
                <label class="checkbox">
                <input type="checkbox" name="ignorerrd" value="confirm" <?php if ($config['rrd_override']) { echo('disabled checked'); } ?> />添加设备如果RRDS目录已经存在
                </label>
              </div>
            </div>
          </fieldset>
        </div>
      </div>
    </div>

    <div class="col-lg-6 pull-right">
      <div class="widget widget-table">
        <div class="widget-header">
          <i class="oicon-lock-warning"></i><h3>认证设置</h3>
        </div>
        <div class="widget-content" style="padding-top: 10px;">

          <!-- To be able to hide it -->
          <div id="snmpv2">
            <fieldset>
              <div class="control-group">
                <label class="control-label" for="snmp_community">SNMP社区标识</label>
                <div class="controls">
                  <input type=text name="snmp_community" size="32" value="<?php echo(escape_html($vars['snmp_community'])); // FIXME. For passwords we should use filter instead escape! ?>"/>
                </div>
              </div>
            </fieldset>
          </div>

          <!-- To be able to hide it -->
          <div id="snmpv3">
            <fieldset>
              <div class="control-group">
                <label class="control-label" for="snmp_authlevel">认证等级</label>
                <div class="controls">
                  <select class="selectpicker" name="snmp_authlevel" id="snmp_authlevel">
                    <option value="noAuthNoPriv" <?php echo($vars['snmp_authlevel'] == 'noAuthNoPriv' ? 'selected' : ''); ?> >noAuthNoPriv</option>
                    <option value="authNoPriv"   <?php echo($vars['snmp_authlevel'] == 'authNoPriv' ? 'selected' : ''); ?> >authNoPriv</option>
                    <option value="authPriv"     <?php echo($vars['snmp_authlevel'] == 'authPriv' ? 'selected' : ''); ?> >authPriv</option>
                  </select>
                </div>
              </div>

              <div class="control-group">
                <label class="control-label" for="snmp_authname">认证用户名</label>
                <div class="controls">
                  <input type=text name="snmp_authname" size="32" value="<?php echo(escape_html($vars['snmp_authname'])); ?>"/>
                </div>
              </div>

              <div class="control-group">
                <label class="control-label" for="snmp_authpass">认证密码</label>
                <div class="controls">
                  <input type="password" name="snmp_authpass" size="32" value="<?php echo(escape_html($vars['snmp_authpass'])); // FIXME. For passwords we should use filter instead escape! ?>"/>
                </div>
              </div>

              <div class="control-group">
                <label class="control-label" for="snmp_authalgo">认证加密</label>
                <div class="controls">
                  <select class="selectpicker" name="snmp_authalgo">
                    <option value="MD5" <?php echo($vars['snmp_authalgo'] == 'MD5' ? 'selected' : ''); ?> >MD5</option>
                    <option value="SHA" <?php echo($vars['snmp_authalgo'] == 'SHA' ? 'selected' : ''); ?> >SHA</option>
                  </select>
                </div>
              </div>
              <div id="authPriv"> <!-- only show this when auth level = authPriv -->
                <div class="control-group">
                  <label class="control-label" for="snmp_cryptopass">加密密码</label>
                  <div class="controls">
                    <input type="password" name="snmp_cryptopass" size="32" value="<?php echo(escape_html($vars['snmp_cryptopass'])); // FIXME. For passwords we should use filter instead escape! ?>"/>
                  </div>
                </div>

                <div class="control-group">
                  <label class="control-label" for="snmp_cryptoalgo">加密算法</label>
                  <div class="controls">
                    <select class="selectpicker" name="snmp_cryptoalgo">
                      <option value="AES" <?php echo($vars['snmp_cryptoalgo'] == "AES" ? 'selected' : ''); ?> >AES</option>
                      <option value="DES" <?php echo($vars['snmp_cryptoalgo'] == "DES" ? 'selected' : ''); ?> >DES</option>
                    </select>
                  </div>
                </div>
              </div>
            </fieldset>
          </div> <!-- end col -->
        </div>
      </div>
    </div>
  </div>
  <div class="col-md-12">
    <div class="form-actions">
      <button type="submit" class="btn btn-primary" name="submit" value="save"><i class="icon-plus icon-white"></i> 添加设备</button>
    </div>
  </div>
</form>

<script>

  // Show/hide SNMPv1/2c or SNMPv3 authentication settings pane based on setting of protocol version.
  //$("#snmpv2").hide();
  //$("#snmpv3").hide();

  $("#snmp_version").change(function() {
    var select = this.value;
    if (select === 'v3') {
      $('#snmpv3').show();
      $("#snmpv2").hide();
    } else {
      $('#snmpv2').show();
      $('#snmpv3').hide();
    }
  }).change();

  $("#snmp_authlevel").change(function() {
    var select = this.value;
    if (select === 'authPriv') {
      $('#authPriv').show();
    } else {
      $('#authPriv').hide();
    }
  }).change();

</script>

</div>
