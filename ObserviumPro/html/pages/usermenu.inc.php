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

$isUserlist = (isset($vars['user_id']) ? true : false);

$navbar['class'] = 'navbar-narrow';
$navbar['brand'] = '用户';

if (auth_usermanagement())
{
  $navbar['options']['add']['url']  = generate_url(array('page' => 'adduser'));
  $navbar['options']['add']['text'] = '添加用户';
  $navbar['options']['add']['icon'] = 'oicon-user--plus';
  if ($vars['page'] == 'adduser') { $navbar['options']['add']['class'] = 'active'; };
}

$navbar['options']['edit']['url']  = generate_url(array('page' => 'edituser'));
$navbar['options']['edit']['text'] = '编辑用户';
$navbar['options']['edit']['icon'] = 'oicon-user--pencil';
if ($vars['page'] == 'edituser') { $navbar['options']['edit']['class'] = 'active'; };

$navbar['options']['log']['url']  = generate_url(array('page' => 'authlog'));
$navbar['options']['log']['text'] = '认证记录';
$navbar['options']['log']['icon'] = 'oicon-clipboard-eye';
if ($vars['page'] == 'authlog') { $navbar['options']['log']['class'] = 'active'; };

if ($isUserlist)
{
  $navbar['options_right']['edit']['url']  = generate_url(array('page' => 'edituser'));
  $navbar['options_right']['edit']['text'] = '返回用户列表';
  $navbar['options_right']['edit']['icon'] = 'icon-chevron-left';
}

print_navbar($navbar);
unset($navbar);

// EOF
