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

$page_title[] = "用户喜好";

// Change password
if ($vars['password'] == "save")
{
  if (authenticate($_SESSION['username'], $vars['old_pass']))
  {
    if ($vars['new_pass'] == "" || $vars['new_pass2'] == "")
    {
      print_warning("密码不能是空的.");
    }
    elseif ($vars['new_pass'] == $vars['new_pass2'])
    {
      auth_change_password($_SESSION['username'], $vars['new_pass']);
      print_success("密码更改.");
    }
    else
    {
      print_warning("密码不匹配.");
    }
  } else {
    print_warning("不正确的密码");
  }
}

unset($prefs);
if (is_numeric($_SESSION['user_id']))
{
  $user_id = $_SESSION['user_id'];
  $prefs = get_user_prefs($user_id);

  // Reset RSS/Atom key
  if ($vars['atom_key'] == "toggle")
  {
    if (set_user_pref($user_id, 'atom_key', md5(strgen())))
    {
      print_success('RSS/Atomm 密钥重置.');
      $prefs = get_user_prefs($user_id);
    } else {
      print_error('错误生成 RSS/Atom 密钥.');
    }
  }

  // Reset API key
  if ($vars['api_key'] == "toggle")
  {
    if (set_user_pref($user_id, 'api_key', md5(strgen())))
    {
      print_success('API 密钥重置.');
      $prefs = get_user_prefs($user_id);
    } else {
      print_error('错误生成 API 密钥.');
    }
  }
}
$atom_key_updated = (isset($prefs['atom_key']['updated']) ? formatUptime(time() - strtotime($prefs['atom_key']['updated']), 'shorter').' ago' : 'Never');
$api_key_updated  = (isset($prefs['api_key']['updated'])  ? formatUptime(time() - strtotime($prefs['api_key']['updated']),  'shorter').' ago' : 'Never');
?>

<form id="edit" name="edit" method="post" class="form-horizontal" action="">
<fieldset>
  <legend>用户喜好</legend>
</fieldset>
<div class="row">
<?php
if (auth_can_change_password($_SESSION['username']))
{
  ?>
  <div class="col-md-6">
  <div class="well info_box">
    <div class="title"><i class="oicon-gear"></i> 更改密码</div>
    <fieldset>

      <div class="control-group">
        <label class="control-label" for="old_pass">旧密码</label>
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
        <label class="control-label" for="new_pass2">新密码(重复)</label>
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

if     ($_SESSION['userlevel'] == 10) { $user_device = '<strong class="text text-success">管理全局访问</strong>'; }
elseif ($_SESSION['userlevel'] < 10 && $_SESSION['userlevel'] >= 5) { $user_device = '<strong class="text text-info">全局浏览访问</strong>'; }
elseif ($_SESSION['userlevel'] < 5)
{
  $user_device = '';
  foreach (dbFetchRows("SELECT * FROM `entity_permissions` AS P, `devices` AS D WHERE `user_id` = ? AND P.entity_id = D.device_id", array($_SESSION['user_id'])) as $perm)
  {
    $user_device .= generate_device_link($perm).'<br />'.PHP_EOL;
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
      <th style="width: 60px;">设备权限等级</th>
      <th style="width: 120px;"><?php echo($user_device); ?></th>
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
    echo('<th colspan="2"><span class="text text-danger">使用 RSS/Atom PHP 模块是必需的.</span></th>');
  }
  elseif (!check_extension_exists('SimpleXML'))
  {
    echo('<th colspan="2"><span class="text text-danger">使用 RSS/Atom PHP SimpleXML 模块是必需的.</span></th>');
  } else {
    echo("      <th>RSS/Atom 访问密钥生成 $atom_key_updated.</th>");
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
      <th>API 访问密钥生成 <?php echo($api_key_updated); ?>.</th>
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
