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

$alert_rules = cache_alert_rules();
$alert_assoc = cache_alert_assoc();
$alert_table = cache_device_alert_table($device['device_id']);

if (!isset($vars['status'])) { $vars['status'] = 'failed'; }
if (!$vars['entity_type']) { $vars['entity_type'] = 'all'; }

// Build Navbar

$navbar['class'] = "navbar-narrow";
$navbar['brand'] = "报警类型";

if ($vars['entity_type'] == 'all') { $navbar['options']['all']['class'] = "active"; }
$navbar['options']['all']['url'] = generate_url(array('page' => 'device', 'device' => $device['device_id'],
                                                'tab' => 'alerts', 'entity_type' => 'all'));
$navbar['options']['all']['text'] = "所有";

foreach ($alert_table as $entity_type => $thing)
{

  if (!$vars['entity_type']) { $vars['entity_type'] = $entity_type; }
  if ($vars['entity_type'] == $entity_type) { $navbar['options'][$entity_type]['class'] = "active"; }

  $navbar['options'][$entity_type]['url'] = generate_url(array('page' => 'device', 'device' => $device['device_id'],
                                                  'tab' => 'alerts', 'entity_type' => $entity_type));
  $navbar['options'][$entity_type]['text'] = escape_html(nicecase($entity_type));
}

$navbar['options_right']['update']['url']  = generate_url(array('page' => 'device', 'device' => $device['device_id'], 'tab' => 'alerts', 'action'=>'update'));
$navbar['options_right']['update']['text'] = '再生的';
$navbar['options_right']['update']['icon'] = 'oicon-arrow-circle';
if ($vars['action'] == 'update') { $navbar['options_right']['update']['class'] = 'active'; }

$navbar['options_right']['status']['url']  = generate_url($vars, array('page' => 'device', 'status' => 'failed'));
$navbar['options_right']['status']['text'] = '仅失败';
$navbar['options_right']['status']['icon'] = 'oicon-exclamation-red';

if ($vars['status'] == 'failed')
{
  $navbar['options_right']['status']['class'] = 'active';
  $navbar['options_right']['status']['url']  = generate_url($vars, array('page' => 'device', 'status' => 'all'));
}

print_navbar($navbar);

// Run actions

if($vars['action'] == 'update')
{
  echo '<div class="well">';
  update_device_alert_table($device);
  $alert_table = cache_device_alert_table($device['device_id']);
  echo '</div>';
}

$vars['pagination'] = TRUE;

print_alert_table($vars);

// EOF
