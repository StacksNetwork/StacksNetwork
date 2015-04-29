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

include($config['html_dir']."/includes/alerting-navbar.inc.php");

if (!isset($vars['status'])) { $vars['status'] = 'failed'; }
if (!$vars['entity_type']) { $vars['entity_type'] = "all"; }

$navbar['class'] = "navbar-narrow";
$navbar['brand'] = "警报类型";

$types = dbFetchRows("SELECT `entity_type` FROM `alert_table` GROUP BY `entity_type`");

$navbar['options']['all']['url'] = generate_url($vars, array('page' => 'alerts', 'entity_type' => 'all'));
$navbar['options']['all']['text'] = escape_html(nicecase('全部'));
if ($vars['entity_type'] == 'all') {
  $navbar['options']['all']['class'] = "active";
  $navbar['options']['all']['url'] = generate_url($vars, array('page' => 'alerts', 'entity_type' => NULL));
}

foreach ($types as $thing)
{
  if ($vars['entity_type'] == $thing['entity_type'])
  {
    $navbar['options'][$thing['entity_type']]['class'] = "active";
    $navbar['options'][$thing['entity_type']]['url'] = generate_url($vars, array('page' => 'alerts', 'entity_type' => NULL));
  } else {
    $navbar['options'][$thing['entity_type']]['url'] = generate_url($vars, array('page' => 'alerts', 'entity_type' => $thing['entity_type']));
  }
  $navbar['options'][$thing['entity_type']]['text'] = escape_html(nicecase($thing['entity_type']));
}

$navbar['options_right']['status']['url']  = generate_url($vars, array('page' => 'alerts', 'status' => 'failed'));
$navbar['options_right']['status']['text'] = '仅显示失败报警';
$navbar['options_right']['status']['icon'] = 'oicon-exclamation-red';

if ($vars['status'] == 'failed')
{
  $navbar['options_right']['status']['class'] = 'active';
  $navbar['options_right']['status']['url']  = generate_url($vars, array('page' => 'alerts', 'status' => 'all'));
}

// Print out the navbar defined above
print_navbar($navbar);

// Cache the alert_tests table for use later
$alert_rules = cache_alert_rules($vars);

// Print out a table of alerts matching $vars
if ($vars['status'] != 'failed')
{
  $vars['pagination'] = TRUE;
}
print_alert_table($vars);

// EOF
