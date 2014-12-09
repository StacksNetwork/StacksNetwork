#!/usr/bin/env php
<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage cli
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

chdir(dirname($argv[0]));

include("includes/defaults.inc.php");
include("config.php");
include("includes/definitions.inc.php");
include("includes/functions.inc.php");

$scriptname = basename($argv[0]);

print_message("%g".OBSERVIUM_PRODUCT." ".OBSERVIUM_VERSION."\n%W添加用户%n\n", 'color');

$auth_file = $config['html_dir'].'/includes/authentication/' . $config['auth_mechanism'] . '.inc.php';
if (is_file($auth_file))
{
  include($auth_file);

  // Include base auth functions calls
  include($config['html_dir'].'/includes/authenticate-functions.inc.php');
} else {
  print_error("错误: 没有设置有效的 auth_mechanism 定义.");
  exit();
}

if (auth_usermanagement())
{
  if (isset($argv[1]) && isset($argv[2]) && isset($argv[3]))
  {
    if (!auth_user_exists($argv[1]))
    {
      if (adduser($argv[1], $argv[2], $argv[3], @$argv[4]))
      {
        print_success("用户 ".$argv[1]." 成功添加.");
      } else {
        print_error("用户 ".$argv[1]." 新建错误!");
      }
    } else {
      print_warning("用户 ".$argv[1]." 已经存在!");
    }
  } else {
    print_message("%n
使用方法:
$scriptname <用户名> <密码> <等级 1-10> [email]

范例:
%WADMIN%n:   $scriptname <username> <password> 10 [email]
%WRW user%n: $scriptname <username> <password> 7  [email]
%WRO user%n: $scriptname <username> <password> 1  [email]

%r无效的参数!%n", 'color');
  }
} else {
  print_error("不允许添加用户认证模块!");
}

// EOF
