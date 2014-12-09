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

echo('<div style="margin: 10px;">');

if ($_SESSION['userlevel'] < '10')
{
  include("includes/error-no-perm.inc.php");
} else {
  if (auth_usermanagement())
  {
    if ($vars['action'] == "deleteuser")
    {
      $delete_username = dbFetchCell("SELECT `username` FROM `users` WHERE `user_id` = ?", array($vars['user_id']));

      if ($vars['confirm'] == "yes")
      {
        if (deluser($delete_username))
        {
          print_success('用户 "' . $delete_username . '" 已删除!');
        } else {
          print_error('错误删除用户 "' . $delete_username . '"!');
        }
      } else {
        print_error('您已经请求的用户删除 "' . $delete_username . '". 这一操作不能逆转.<br /><a href="edituser/action=deleteuser/user_id=' . $vars['user_id'] . '/confirm=yes/">单击确定</a>');
      }
    }
  } else {
    print_error("认证模块不允许用户管理!");
  }
}

echo('</div>');

// EOF
