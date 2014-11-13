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

$pagetitle[] = "用户习惯";

// Change password
if ($_POST['password'] == "save")
{
  if (authenticate($_SESSION['username'],$_POST['old_pass']))
  {
    if ($_POST['new_pass'] == "" || $_POST['new_pass2'] == "")
    {
      print_warning("密码不能为空.");
    }
    elseif ($_POST['new_pass'] == $_POST['new_pass2'])
    {
      auth_change_password($_SESSION['username'], $_POST['new_pass']);
      print_success("密码已修改.");
    }
    else
    {
      print_warning("密码不匹配.");
    }
  } else {
    print_warning("错误的密码");
  }
}

unset($prefs);
if (is_numeric($_SESSION['user_id']))
{
  $user_id = $_SESSION['user_id'];
  $prefs = get_user_prefs($user_id);

  // Reset RSS/Atom key
  if ($_POST['atom_key'] == "toggle")
  {
    if (set_user_pref($user_id, 'atom_key', md5(strgen())))
    {
      print_success('RSS/Atom 密钥重置.');
      $prefs = get_user_prefs($user_id);
    } else {
      print_error('生成 RSS/Atom 密钥错误.');
    }
  }

  // Reset API key
  if ($_POST['api_key'] == "toggle")
  {
    if (set_user_pref($user_id, 'api_key', md5(strgen())))
    {
      print_success('API key reset.');
      $prefs = get_user_prefs($user_id);
    } else {
      print_error('生成 API 密钥错误.');
    }
  }
}
$atom_key_updated = (isset($prefs['atom_key']['updated']) ? formatUptime(time() - strtotime($prefs['atom_key']['updated']), 'shorter').' ago' : '从未');
$api_key_updated  = (isset($prefs['api_key']['updated'])  ? formatUptime(time() - strtotime($prefs['api_key']['updated']),  'shorter').' ago' : '从未');
?>

<form id="edit" name="edit" method="post" class="form-horizontal" action="">
  <legend>用户习惯</legend>

<div class="row">
<?php
if (auth_can_change_password($_SESSION['username']))
{
  ?>
  <div class="col-md-6">
  <div class="well info_box">
    <div class="title"><i class="oicon-gear"></i> 修改密码</div>
    <fieldset>

      <div class="control-group">
        <label class="control-label" for="old_pass">原密码</label>
        <div class="controls">
          <input type="password" name="old_pass" autocomplete="off" size="32" />
        </div>
      </div>
      <div class="control-group">
        <label class="control-label" for="new_pass">新密码</label>
        <div class="controls">
          <input type="password" name="new_pass" autocomplete="off" size="32" />
        </div>
      </div>
      <div class="control-group">
        <label class="control-label" for="new_pass2">新密码 (重复)</label>
        <div class="controls">
          <input type="password" name="new_pass2" autocomplete="off" size="32" />
        </div>
      </div>
    <div class="form-actions">
      <button type="submit" class="btn btn-primary" name="password" value="save"><i class="icon-ok icon-white"></i> 保存密码</button>
    </div>
    </fieldset>
 </div>
</div>

<?php
}

if     ($_SESSION['userlevel'] == 10) { $user_device = '<strong class="text text-success">全局管理权限</strong>'; }
elseif ($_SESSION['userlevel'] < 10 && $_SESSION['userlevel'] >= 5) { $user_device = '<strong class="text text-info">全局浏览权限</strong>'; }
elseif ($_SESSION['userlevel'] < 5)
{
  $user_device = '';
  foreach (dbFetchRows("SELECT * FROM `devices_perms` AS P, `devices` AS D WHERE `user_id` = ? AND P.device_id = D.device_id", array($_SESSION['user_id'])) as $perm)
  {
    /// FIXME generatedevicelink?
    $user_device .= "<a href='device/device" . $perm['device_id'] . "'>" . $perm['hostname'] . "</a><br />\n";
    $dev_access = 1;
  }

  if (!$dev_access) { $user_device = "无法访问!"; }
}

?>

  <div class="col-lg-6 pull-right">
  <div class="well info_box">
  <div class="title"><i class="oicon-key"></i> 权限</div>
  <table class="table table-bordered table-striped table-condensed">
    <tr>
      <th width="60">设备权限等级</th>
      <th width="120"><?php echo($user_device); ?></th>
    </tr>
  </table>
  </div>
  </div>

  <div class="col-lg-6 pull-right">
  <div class="well info_box">
  <div class="title"><i class="oicon-key"></i> 加密密钥</div>
  <table class="table table-bordered table-striped table-condensed">
    <tr>
      <th>RSS/Atom 访问密钥</th>
<?php
  // Warn about lack of mcrypt unless told not to.
  if (!check_extension_exists('mcrypt'))
  {
    echo('<th colspan=2><span class="text text-danger">使用 RSS/Atom 功能需要开启 PHP mcrypt 模块.</span></th>');
  }
  elseif (!check_extension_exists('SimpleXML'))
  {
    echo('<th colspan=2><span class="text text-danger">使用 RSS/Atom 功能需要开启 PHP SimpleXML 模块.</span></th>');
  } else {
    echo("      <th>RSS/Atom 访问密钥建立 $atom_key_updated.</th>");
    echo <<<RSS
      <th><form id="atom_key" method="post" action="">
          <button type="submit" class="btn btn-mini btn-success" name="atom_key" value="toggle">重置</button>
          </form>
      </th>
RSS;
  }
?>
    </tr>
    <tr>
      <th colspan=3></th>
    </tr>
    <tr>
      <th>API 访问密钥</th>
      <th>API 访问密钥建立 <?php echo($api_key_updated); ?>.</th>
      <th><form id="api_key" method="post" action="">
          <button type="submit" class="btn btn-mini btn-success" name="api_key" value="toggle" disabled="disabled">重置</button>
          </form>
      </th>
    </tr>
  </table>
  </div>
  </div>

</div>

</form>

<?php

// EOF
