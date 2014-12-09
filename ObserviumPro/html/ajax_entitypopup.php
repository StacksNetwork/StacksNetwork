<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage ajax
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

if (isset($_GET['debug']) && $_GET['debug'])
{
  ini_set('display_errors', 1);
  ini_set('display_startup_errors', 0);
  ini_set('log_errors', 0);
  ini_set('allow_url_fopen', 0);
  ini_set('error_reporting', E_ALL);
}

include_once("../includes/defaults.inc.php");
include_once("../config.php");
include_once("../includes/definitions.inc.php");
include($config['install_dir'] . "/includes/common.inc.php");
include($config['install_dir'] . "/includes/dbFacile.php");
include($config['install_dir'] . "/includes/rewrites.inc.php");
include($config['html_dir'] . "/includes/functions.inc.php");
include($config['html_dir'] . "/includes/authenticate.inc.php");

if (!$_SESSION['authenticated']) { echo('<li class="nav-header">会话已过期, 请重新登录!</li>'); exit; }

$vars = get_vars('POST');

switch($vars['entity_type'])
{
  case "port":
    if (is_numeric($vars['entity_id']) && (port_permitted($vars['entity_id'])))
    {
      $port   = get_port_by_id($vars['entity_id']);
      echo generate_port_popup($port);
    } else {
      print_warning("您未被授权查看该端口.");
    }
    exit;
    break;

  case "device":
    if (is_numeric($vars['entity_id']) && device_permitted($vars['entity_id']))
    {
      $device = device_by_id_cache($vars['entity_id']);
      echo generate_device_link_contents($device, $vars, $start, $end);
    } else {
      print_warning("您未被授权查看该端口.");
    }
    exit;
    break;

  default:
    print_error("未知的实体类型.");
    exit;
    break;
}

// EOF
