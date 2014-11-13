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

$links['add']      = generate_url(array('page' => 'adduser'));
$links['edit']     = generate_url(array('page' => 'edituser'));
$links['log']      = generate_url(array('page' => 'authlog'));
$active['add']     = (($vars['page'] == "adduser") ? "active" : "");
$active['edit']    = (($vars['page'] == "edituser") ? "active" : "");
$active['log']     = (($vars['page'] == "authlog") ? "active" : "");
$isUserlist        = (isset($vars['user_id']) ? true : false);

echo('
      <div class="navbar navbar-narrow" style="margin-top: 10px;">
        <div class="navbar-inner">
          <a class="brand">用户:</a>
          <ul class="nav">');

if (auth_usermanagement())
{
  echo('            <li class="'.$active['add'].' first"><a href="'.$links['add'].'"><i class="oicon-user--plus"></i> 添加用户</a></li>');
}

echo('
            <li class="'.$active['edit'].'"><a href="'.$links['edit'].'"><i class="oicon-user--pencil"></i> 编辑用户</a></li>
            <li class="'.$active['log'].'"><a href="'.$links['log'].'"><i class="oicon-clipboard-eye"></i> 认证日志</a></li>
          </ul>');

if ($isUserlist)
{
  echo('
          <ul class="nav pull-right">
            <li class="first"><a href="'.$links['edit'].'"><i class="icon-chevron-left"></i> <strong>返回用户列表</strong></a></li>
          </ul>');
}

echo('
        </div>
      </div>');

// EOF
