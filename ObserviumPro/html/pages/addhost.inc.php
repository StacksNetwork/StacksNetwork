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

if ($_SESSION['userlevel'] < 10)
{
  include("includes/error-no-perm.inc.php");

  exit;
}

echo("<h2>添加设备</h2>");

echo('<div class="well well-white">');

if ($_POST['hostname'])
{
  if ($_SESSION['userlevel'] > '5')
  {
    $hostname = $_POST['hostname'];

    if ($_POST['port'] && is_numeric($_POST['port'])) { $port = (int) $_POST['port']; } else { $port = 161; }

    if ($_POST['snmpver'] === "v2c" or $_POST['snmpver'] === "v1")
    {
      if ($_POST['community'])
      {
        $config['snmp']['community'] = array($_POST['community']);
      }

      $snmpver = $_POST['snmpver'];
      print_message("添加主机 $hostname communit" . (count($config['snmp']['community']) == 1 ? "y" : "ies") . " "  . implode(', ',$config['snmp']['community']) . " port $port");
    }
    elseif ($_POST['snmpver'] === "v3")
    {
      $v3 = array (
        'authlevel' => $_POST['authlevel'],
        'authname' => $_POST['authname'],
        'authpass' => $_POST['authpass'],
        'authalgo' => $_POST['authalgo'],
        'cryptopass' => $_POST['cryptopass'],
        'cryptoalgo' => $_POST['cryptoalgo'],
      );

      array_push($config['snmp']['v3'], $v3);

      $snmpver = "v3";

      print_message("添加 SNMPv3 主机 $hostname 端口 $port");
    }
    else
    {
      print_error("不支持的 SNMP 版本. 有一个下拉菜单, 你是怎么达到这个错误 ?"); // We have a hacker!
    }

    if ($_POST['ignorerrd'] == 'confirm') { $config['rrd_override'] = TRUE; }

    $result = add_device($hostname, $snmpver, $port);
    if ($result)
    {
      print_success("设备添加 (id = $result)");
    }
  } else {
    print_error("您不必添加主机的必要权限.");
  }
}

$pagetitle[] = "添加主机";

?>

<form name="form1" method="post" action="" class="form-horizontal">

  <p>设备将被前检查ping和SNMP的可达性探讨. 只有在确认操作系统的设备将增加.</p>

  <fieldset>
    <legend>设备属性</legend>
    <div class="control-group">
      <label class="control-label" for="hostname">主机名</label>
      <div class="controls">
         <input type="text" name="hostname" size="32" value="<?php echo($vars['hostname']); ?>"/>
      </div>
      <label class="control-label" for="ignorerrd">忽略RRD存在</label>
      <div class="controls">
        <label class="checkbox">
          <input type="checkbox" name="ignorerrd" value="confirm" <?php if ($config['rrd_override']) { echo('disabled checked'); } ?> />添加设备如果RRDS目录已经存在
        </label>
      </div>
    </div>

  <input type="hidden" name="editing" value="yes">
  <fieldset>
    <legend>SNMP属性</legend>
    <div class="control-group">
      <label class="control-label" for="snmpver">SNMP版本</label>
      <div class="controls">
        <select name="snmpver">
          <option value="v1"  <?php echo($vars['snmpver'] == 'v1'  || ($vars['snmpver'] == '' && $config['snmp']['version'] == 'v1')  ? 'selected' : ''); ?> >v1</option>
          <option value="v2c" <?php echo($vars['snmpver'] == 'v2c' || ($vars['snmpver'] == '' && $config['snmp']['version'] == 'v2c') ? 'selected' : ''); ?> >v2c</option>
          <option value="v3"  <?php echo($vars['snmpver'] == 'v3'  || ($vars['snmpver'] == '' && $config['snmp']['version'] == 'v3')  ? 'selected' : ''); ?> >v3</option>
        </select>
      </div>
    </div>

    <div class="control-group">
       <label class="control-label" for="port">SNMP端口</label>
       <div class="controls">
         <input type="text" name="port" size="32" value="161"/>
       </div>
     </div>
  </fieldset>

  <!-- To be able to hide it -->
  <div id="snmpv12">
    <fieldset>
      <legend>SNMPv1/v2c设置</legend>
      <div class="control-group">
        <label class="control-label" for="community">SNMP Community</label>
        <div class="controls">
          <input type="text" name="community" size="32" value="<?php echo $vars['community']; ?>"/>
        </div>
      </div>
    </fieldset>
  </div>

  <!-- To be able to hide it -->
  <div id='snmpv3'>
    <fieldset>
      <legend>SNMPv3设置</legend>
      <div class="control-group">
        <label class="control-label" for="authlevel">认证等级</label>
        <div class="controls">
          <select name="authlevel">
            <option value="noAuthNoPriv" <?php echo($vars['authlevel'] == 'noAuthNoPriv' ? 'selected' : ''); ?> >noAuthNoPriv</option>
            <option value="authNoPriv"   <?php echo($vars['authlevel'] == 'authNoPriv' ? 'selected' : ''); ?> >authNoPriv</option>
            <option value="authPriv"     <?php echo($vars['authlevel'] == 'authPriv' ? 'selected' : ''); ?> >authPriv</option>
          </select>
        </div>
      </div>

      <div class="control-group">
        <label class="control-label" for="authname">认证用户名</label>
        <div class="controls">
          <input type="text" name="authname" size="32" value="<?php echo $vars['authname']; ?>"/>
        </div>
      </div>

      <div class="control-group">
        <label class="control-label" for="authpass">认证密码</label>
        <div class="controls">
          <input type="text" name="authpass" size="32" value=""/>
        </div>
      </div>

      <div class="control-group">
        <label class="control-label" for="authalgo">认证算法</label>
        <div class="controls">
          <select name="authalgo">
            <option value='MD5'>MD5</option>
            <option value='SHA' <?php echo($vars['authalgo'] === "SHA" ? 'selected' : ''); ?>>SHA</option>
          </select>
        </div>
      </div>

      <div class="control-group">
        <label class="control-label" for="cryptopass">加密密码</label>
        <div class="controls">
          <input type="text" name="cryptopass" size="32" value=""/>
        </div>
      </div>

      <div class="control-group">
        <label class="control-label" for="cryptoalgo">加密算法</label>
        <div class="controls">
          <select name="cryptoalgo">
            <option value='AES'>AES</option>
            <option value='DES' <?php echo($vars['authalgo'] === "DES" ? 'selected' : ''); ?>>DES</option>
          </select>
        </div>
      </div>

    </fieldset>
  </div>

  <div class="form-actions">
    <button type="submit" class="btn btn-success" name="submit" value="save"><i class="oicon-plus oicon-white"></i> 添加设备</button>
  </div>

</form>

</div> <?php /* FIXME there is no opening div for this, can probably go? */ ?>
