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

$ok = FALSE;
if ($_POST['editing'])
{
  if ($_SESSION['userlevel'] > "7")
  {
    $update = array();
    switch ($_POST['snmpver'])
    {
      case 'v3':
        switch ($_POST['authlevel'])
        {
          case 'authPriv':
            if ($_POST['cryptoalgo'] == 'DES' || $_POST['cryptoalgo'] == 'AES')
            {
              $ok = TRUE;
              $update['cryptoalgo'] = $_POST['cryptoalgo'];
              $update['cryptopass'] = $_POST['cryptopass'];
            }
            // no break here
          case 'authNoPriv':
            if ($_POST['authalgo'] == 'MD5' || $_POST['authalgo'] == 'SHA')
            {
              $ok = TRUE;
              $update['authalgo']   = $_POST['authalgo'];
              $update['authname']   = $_POST['authname'];
              $update['authpass']   = $_POST['authpass'];
            } else {
              $ok = FALSE;
            }
            break;
          case 'noAuthNoPriv':
            $ok = TRUE;
            break;
        }
        if ($ok) { $update['authlevel'] = $_POST['authlevel']; }
        break;
      case 'v2c':
      case 'v1':
        if (is_string($_POST['community']))
        {
          $ok = TRUE;
          $update['community'] = $_POST['community'];
        }
        break;
    }
    if ($ok)
    {
      $update['snmpver'] = $_POST['snmpver'];
      if (in_array($_POST['transport'], $config['snmp']['transports']))
      {
        $update['transport'] = $_POST['transport'];
      } else {
        $update['transport'] = 'udp';
      }
      if (is_numeric($_POST['port']) && $_POST['port'] > 0 && $_POST['port'] <= 65535)
      {
        $update['port'] = (int)$_POST['port'];
      } else {
        $update['port'] = 161;
      }
      if (is_numeric($_POST['timeout']) && $_POST['timeout'] > 0 && $_POST['timeout'] <= 120)
      {
        $update['timeout'] = (int)$_POST['timeout'];
      } else {
        $update['timeout'] = array('NULL');
      }
      if (is_numeric($_POST['retries']) && $_POST['retries'] > 0 && $_POST['retries'] <= 10)
      {
        $update['retries'] = (int)$_POST['retries'];
      } else {
        $update['retries'] = array('NULL');
      }

      if (dbUpdate($update, 'devices', '`device_id` = ?', array($device['device_id'])))
      {
        print_success("设备的SNMP配置更新");
        log_event('设备的SNMP配置改变.', $device['device_id'], 'device');
      } else {
        print_warning("SNMP配置装置不需要更新");
      }
    }
    if (!$ok) { print_error("设备的SNMP配置没有更新"); }

    unset($update);
  }
}

$device = device_by_id_cache($device['device_id'], $ok);

?>

<form id="edit" name="edit" method="post" class="form-horizontal" action="">
  <input type="hidden" name="editing" value="yes">
<fieldset>
  <legend>SNMP设置</legend>
</fieldset>
<div class="row">
  <div class="col-md-6">
  <div class="well info_box">
  <div class="title"><i class="oicon-gear"></i> 基本配置</div>
    <fieldset>
      <div class="control-group">
      <label class="control-label" for="snmpver">协议版本</label>
      <div class="controls">
        <select class="selectpicker" name="snmpver" id="snmpver">
          <option value="v1"  <?php echo($device['snmpver'] == 'v1' ? 'selected' : ''); ?> >v1</option>
          <option value="v2c" <?php echo($device['snmpver'] == 'v2c' ? 'selected' : ''); ?> >v2c</option>
          <option value="v3"  <?php echo($device['snmpver'] == 'v3' ? 'selected' : ''); ?> >v3</option>
        </select>
      </div>
     </div>

      <div class="control-group">
      <label class="control-label" for="snmpver">传输</label>
        <div class="controls">
          <select class="selectpicker" name="transport">
            <?php
            foreach ($config['snmp']['transports'] as $transport)
            {
              echo("<option value='".$transport."'");
              if ($transport == $device['transport']) { echo(" selected='selected'"); }
              echo(">".$transport."</option>");
            }
            ?>
          </select>
        </div>
      </div>

      <div class="control-group">
        <label class="control-label" for="port">端口</label>
        <div class="controls">
          <input type=text name="port" size="32" value="<?php echo(htmlspecialchars($device['port'])); ?>"/>
        </div>
      </div>

      <div class="control-group">
        <label class="control-label" for="timeout">超时</label>
        <div class="controls">
          <input type=text name="timeout" size="32" value="<?php echo(htmlspecialchars($device['timeout'])); ?>"/>
        </div>
      </div>

      <div class="control-group">
        <label class="control-label" for="retries">重试次数</label>
        <div class="controls">
          <input type=text name="retries" size="32" value="<?php echo(htmlspecialchars($device['retries'])); ?>"/>
        </div>
      </div>
    </fieldset>
  </div>
  </div>

<div class="col-lg-6 pull-right">
  <div class="well info_box">
  <div class="title"><i class="oicon-lock-warning"></i> 验证配置</div>

  <!-- To be able to hide it -->
   <div id="snmpv2">
    <fieldset>
      <div class="control-group">
        <label class="control-label" for="community">SNMP Community</label>
        <div class="controls">
          <input type=text name="community" size="32" value="<?php echo(htmlspecialchars($device['community'])); ?>"/>
        </div>
      </div>
     </fieldset>
  </div>

  <!-- To be able to hide it -->
  <div id="snmpv3">
    <fieldset>
      <div class="control-group">
        <label class="control-label" for="authlevel">验证级别</label>
        <div class="controls">
          <select class="selectpicker" name="authlevel">
            <option value="noAuthNoPriv" <?php echo($device['authlevel'] == 'noAuthNoPriv' ? 'selected' : ''); ?> >noAuthNoPriv</option>
            <option value="authNoPriv"   <?php echo($device['authlevel'] == 'authNoPriv' ? 'selected' : ''); ?> >authNoPriv</option>
            <option value="authPriv"     <?php echo($device['authlevel'] == 'authPriv' ? 'selected' : ''); ?> >authPriv</option>
          </select>
        </div>
      </div>

      <div class="control-group">
        <label class="control-label" for="authname">验证用户名称</label>
        <div class="controls">
          <input type=text name="authname" size="32" value="<?php echo(htmlspecialchars($device['authname'])); ?>"/>
        </div>
      </div>

      <div class="control-group">
        <label class="control-label" for="authpass">验证密码</label>
        <div class="controls">
          <input type="password" name="authpass" size="32" value="<?php echo(htmlspecialchars($device['authpass'])); ?>"/>
        </div>
      </div>

      <div class="control-group">
        <label class="control-label" for="authalgo">认证算法</label>
        <div class="controls">
          <select class="selectpicker" name="authalgo">
            <option value="MD5">MD5</option>
            <option value="SHA" <?php echo($device['authalgo'] == 'SHA' ? 'selected' : ''); ?> >SHA</option>
          </select>
        </div>
      </div>

      <div class="control-group">
        <label class="control-label" for="cryptopass">加密密码</label>
        <div class="controls">
          <input type="password" name="cryptopass" size="32" value="<?php echo(htmlspecialchars($device['cryptopass'])); ?>"/>
        </div>
      </div>

      <div class="control-group">
        <label class="control-label" for="cryptoalgo">密码算法</label>
        <div class="controls">
          <select class="selectpicker" name="cryptoalgo">
            <option value="AES">AES</option>
            <option value="DES" <?php echo($device['cryptoalgo'] == "DES" ? 'selected' : ''); ?> >DES</option>
          </select>
        </div>
      </div>

    </fieldset>
  </div> <!-- end col -->
 </div>
</div>
</div>
  <div class="col-md-12">
    <div class="form-actions">
      <button type="submit" class="btn btn-primary" name="submit" value="save"><i class="icon-ok icon-white"></i> 保存变化</button>
    </div>
  </div>
</form>

<script>

// Show/hide SNMPv1/2c or SNMPv3 authentication settings pane based on setting of protocol version.
//$("#snmpv2").hide();
//$("#snmpv3").hide();
$("#snmpver").change(function() {
   var select = this.value;
        if (select === 'v3') {
            $('#snmpv3').show();
            $("#snmpv2").hide();
        } else {
            $('#snmpv2').show();
            $('#snmpv3').hide();
        }
}).change();

</script>
<?php

// EOF
