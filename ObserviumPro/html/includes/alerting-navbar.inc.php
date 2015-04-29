<?php

/**
 * Observium Network Management and Monitoring System
 * Copyright (C) 2006-2014, Adam Armstrong - http://www.observium.org
 *
 * @package    observium
 * @subpackage webui
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2015 Adam Armstrong
 *
 */

if (!is_array($alert_rules)) { $alert_rules = cache_alert_rules(); }

$navbar['class'] = 'navbar-narrow';
$navbar['brand'] = '报警';

$pages = array('alerts' => '报警', 'alert_checks' => '报警检测', 'alert_log' => '报警日志', 'alert_contacts' => '报警联系人');

foreach ($pages as $page_name => $page_desc)
{
  if ($vars['page'] == $page_name)
  {
    $navbar['options'][$page_name]['class'] = "active";
  }

  $navbar['options'][$page_name]['url'] = generate_url(array('page' => $page_name));
  $navbar['options'][$page_name]['text'] = escape_html($page_desc);
}

$navbar['options_right']['update']['url']  = generate_url(array('page' => 'alert_regenerate', 'action'=>'update'));
$navbar['options_right']['update']['text'] = '再生';
$navbar['options_right']['update']['icon'] = 'oicon-arrow-circle';
// We don't really need to highlight Regenerate, as it's not a display option, but an action.
// if ($vars['action'] == 'update') { $navbar['options_right']['update']['class'] = 'active'; }

$navbar['options_right']['add']['url']  = generate_url(array('page' => 'add_alert_check'));
$navbar['options_right']['add']['text'] = '添加检测';
$navbar['options_right']['add']['icon'] = 'oicon-plus-circle';

// Print out the navbar defined above
print_navbar($navbar);
unset($navbar);

// Run Actions

if ($_SESSION['userlevel'] == 10)
{
  if ($vars['submit'] == "delete_alert_checker" && $vars['confirm'] == "confirm")
  {
    // Maybe expand this to output more info.

    dbDelete('alert_tests', '`alert_test_id` = ?', array($vars['alert_test_id']));
    dbDelete('alert_table', '`alert_test_id` = ?', array($vars['alert_test_id']));
    dbDelete('alert_table-state', '`alert_test_id` = ?', array($vars['alert_test_id']));
    dbDelete('alert_assoc', '`alert_test_id` = ?', array($vars['alert_test_id']));
    print_message("删除所有警报检查追溯 ".$vars['alert_test_id']);
  }
}

// EOF
