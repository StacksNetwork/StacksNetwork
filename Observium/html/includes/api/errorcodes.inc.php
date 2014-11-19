<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    Simple Observium API
 * @subpackage errorcodes
 * @author     Dennis de Houx <dennis@aio.be>
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */


$errorcodes['100'] = array("code" => "100", "msg" => "启用Debug模式");
$errorcodes['101'] = array("code" => "101", "msg" => "用户认证成功");
$errorcodes['102'] = array("code" => "102", "msg" => "Demo模块成功加载");

$errorcodes['200'] = array("code" => "200", "msg" => "独立Observium API未启用");
$errorcodes['201'] = array("code" => "201", "msg" => "模块未找到");
$errorcodes['211'] = array("code" => "211", "msg" => "账单模块未启用");
$errorcodes['212'] = array("code" => "212", "msg" => "库存模块未启用");
$errorcodes['213'] = array("code" => "213", "msg" => "封包模块未启用");

$errorcodes['301'] = array("code" => "301", "msg" => "用户认证失败");
$errorcodes['303'] = array("code" => "302", "msg" => "该IP不可用于独立 Observium API");
$errorcodes['310'] = array("code" => "310", "msg" => "该用户被禁止访问该数据");

$errorcodes['401'] = array("code" => "401", "msg" => "返回错误代码不存在");
$errorcodes['402'] = array("code" => "402", "msg" => "返回的数据是不是一个数组, API终止");
$errorcodes['403'] = array("code" => "403", "msg" => "该类型未找到");

?>
