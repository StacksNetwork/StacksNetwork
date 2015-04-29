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

?>
<h2>Observium用户关联: 添加用户</h2>
<?php

include("usermenu.inc.php");

if ($_SESSION['userlevel'] == '10')
{
  $page_title[] = "添加用户";
  $errors = array();

  if (auth_usermanagement())
  {
    if ($vars['action'] == "add")
    {
      if ($vars['new_username'])
      {
        $vars['new_username'] = strip_tags($vars['new_username']);
        if (!auth_user_exists($vars['new_username']))
        {
          if (isset($vars['can_modify_passwd']))
          {
            $vars['can_modify_passwd'] = 1;
          } else {
            $vars['can_modify_passwd'] = 0;
          }

          if (adduser($vars['new_username'], $vars['new_password'], $vars['new_level'], $vars['new_email'], $vars['new_realname'], $vars['can_modify_passwd'], $vars['new_description']))
          {
            print_success('用户 ' . escape_html($vars['new_username']) . ' 已添加!');
          }
        } else {
          print_error('该名称的用户已经存在!');
        }
      } else {
        $errors["username"] = "<span class=\"help-inline\">请输入一个用户名!</span>";
      }

      if (!$vars['new_password'])
      {
        $errors["passwd"] = "<span class=\"help-inline\">请输入一个密码</span>";
      }
    }

?>
<!--  <ul class="nav nav-tabs" id="addBillTab">
    <li class="active"><a href="#properties" data-toggle="tab">用户属性</a></li>
  </ul> -->

  <div class="tabcontent tab-content" id="addUserTabContent" style="min-height: 50px; padding-bottom: 18px;">
    <div class="tab-pane fade active in" id="properties">
      <form name="form1" method="post" action="adduser/" class="form-horizontal">
        <input type="hidden" name="action" value="add">
        <fieldset>
          <legend>用户属性</legend>
          <div class="control-group<?php if (isset($errors["username"])) { echo " error"; } ?>">
            <label class="control-label" for="new_username"><strong>用户名</strong></label>
            <div class="controls">
              <input class="col-lg-4" type="text" name="new_username" value="<?php echo $vars['new_username']; ?>">
              <?php if (isset($errors["username"])) { echo $errors["username"]; } ?>
            </div>
          </div>
          <div class="control-group<?php if (isset($errors["passwd"])) { echo " error"; } ?>">
            <label class="control-label" for="new_password"><strong>密码</strong></label>
            <div class="controls">
              <input class="col-lg-4" type="password" name="new_password" value="<?php echo $vars['new_password']; ?>">
              <?php if (isset($errors["passwd"])) { echo $errors["passwd"]; } ?>
              &nbsp;<input type="checkbox" checked="checked" name="can_modify_passwd"> 允许用户自行修改密码.
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="new_realname"><strong>真实名称</strong></label>
            <div class="controls">
              <input class="col-lg-4" type="text" name="new_realname" value="<?php echo $vars['new_realname']; ?>">
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="new_level"><strong>用户等级</strong></label>
            <div class="controls">
              <select name="new_level" class="col-lg-2">
                <option <?php if ($vars['new_level'] == "1") { echo "selected"; } ?> value="1">普通用户</option>
                <option <?php if ($vars['new_level'] == "5") { echo "selected"; } ?> value="5">全局读取</option>
                <option <?php if ($vars['new_level'] == "10") { echo "selected"; } ?> value="10">管理员</option>
              </select>
            </div>
          </div>
        </fieldset>
        <fieldset>
          <legend>可选信息</legend>
          <div class="control-group">
            <label class="control-label" for="new_email"><strong>E-mail</strong></label>
            <div class="controls">
              <input class="col-lg-4" type="text" name="new_email" value="<?php echo $vars['new_email']; ?>">
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="new_description"><strong>说明</strong></label>
            <div class="controls">
              <input class="col-lg-4" type="text" name="new_description" value="<?php echo $vars['new_description']; ?>">
            </div>
          </div>
        </fieldset>
        <div class="form-actions">
          <button type="submit" class="btn btn-primary"><i class="icon-ok-sign icon-white"></i> <strong>添加用户</strong></button>
        </div>
      </form>
    </div>
  </div>
<?php
  } else {
    print_error('认证模块不允许用户管理!');
  }
} else {
  include("includes/error-no-perm.inc.php");
}

// EOF
