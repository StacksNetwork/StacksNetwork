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

$navbar['class'] = 'navbar-narrow';
$navbar['brand'] = '分组';

// Build header menu

foreach (dbFetchRows("SELECT * FROM `groups_assoc` WHERE 1") as $entry)
{
  $group_assoc[$entry['group_id']][$entry['group_assoc_id']]['entity_type'] = $entry['entity_type'];
  $group_assoc[$entry['group_id']][$entry['group_assoc_id']]['entity_attribs'] = json_decode($entry['entity_attribs'], TRUE);
  $group_assoc[$entry['group_id']][$entry['group_assoc_id']]['device_attribs'] = json_decode($entry['device_attribs'], TRUE);
}

$types = dbFetchRows("SELECT `entity_type` FROM `group_table` GROUP BY `entity_type`");

$navbar['options']['all']['url'] = generate_url($vars, array('page' => 'groups', 'entity_type' => NULL));
$navbar['options']['all']['text'] = escape_html(nicecase('all'));
if (!isset($vars['entity_type'])) {
  $navbar['options']['all']['class'] = "active";
  $navbar['options']['all']['url'] = generate_url($vars, array('page' => 'groups', 'entity_type' => NULL));
}

foreach ($types as $thing)
{
  if ($vars['entity_type'] == $thing['entity_type'])
  {
    $navbar['options'][$thing['entity_type']]['class'] = "active";
    $navbar['options'][$thing['entity_type']]['url'] = generate_url($vars, array('page' => 'groups', 'entity_type' => NULL));
  } else {
    $navbar['options'][$thing['entity_type']]['url'] = generate_url($vars, array('page' => 'groups', 'entity_type' => $thing['entity_type']));
  }
  $navbar['options'][$thing['entity_type']]['text'] = escape_html(nicecase($thing['entity_type']));
}

$navbar['options_right']['update']['url']  = generate_url(array('page' => 'groups_regenerate', 'action'=>'update'));
$navbar['options_right']['update']['text'] = '再生';
$navbar['options_right']['update']['icon'] = 'oicon-arrow-circle';
// We don't really need to highlight Regenerate, as it's not a display option, but an action.
// if ($vars['action'] == 'update') { $navbar['options_right']['update']['class'] = 'active'; }

$navbar['options_right']['add']['url']  = generate_url(array('page' => 'group_add'));
$navbar['options_right']['add']['text'] = '添加分组';
$navbar['options_right']['add']['icon'] = 'oicon-plus-circle';

// Print out the navbar defined above
print_navbar($navbar);
unset($navbar);

// Run Actions

if ($_SESSION['userlevel'] == 10 || FALSE)
{
  if ($vars['submit'] == "delete_group" && $vars['confirm'] == "confirm")
  {
    // Maybe expand this to output more info.

    dbDelete('groups',       '`group_id` = ?', array($vars['group_id']));
    dbDelete('group_table',  '`group_id` = ?', array($vars['group_id']));
    dbDelete('groups_assoc', '`group_id` = ?', array($vars['group_id']));
    print_message("已删除分组 ".$vars['group_id']);
  }
} else {
  include("includes/error-no-perm.inc.php");
}

// EOF

