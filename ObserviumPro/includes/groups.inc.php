<?php

/**
 * Observium Network Management and Monitoring System
 * Copyright (C) 2006-2014, Adam Armstrong - http://www.observium.org
 *
 * @package    observium
 * @subpackage groups
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

// DOCME needs phpdoc block
// TESTME needs unit testing
function update_device_group_table($device)
{
  $groups_table_db = array();
  $group_table     = array();

  $msg         = '<h4 style="">构建组成员资格 ' . generate_device_link($device) . ':</h4>';
  $msg_class   = '';
  $msg_enable  = FALSE;
  $groups      = cache_device_groups($device);

  $g_t_dbs = dbFetchRows("SELECT * FROM `group_table` WHERE `device_id` = ?", array($device['device_id']));
  foreach ($g_t_dbs as $g_t_db)
  {
    $groups_table_db[$g_t_db['entity_type']][$g_t_db['entity_id']][$g_t_db['group_id']] = $g_t_db;
  }

  $msg .= PHP_EOL;
  $msg .= '  <h4 style="">匹配这个设备组:</h4> ';

  foreach ($groups['group'] as $group_id => $group_test)
  {
    $msg .= '<span class="label label-info">'.$group_test['group_name'].'</span> ';
    $msg_enable = TRUE;

    foreach ($group_test['assoc'] as $assoc_id => $assoc)
    {
      // Check that the entity_type matches the one we're interested in.
      // echo("匹配 $assoc_id (".$assoc['entity_type'].")");

      list($entity_table, $entity_id_field, $entity_name_field) = entity_type_translate ($assoc['entity_type']);
      $group = $groups['group'][$assoc['group_id']];
      $entities = match_device_entities($device['device_id'], $assoc['entity_attribs'], $assoc['entity_type']);

      foreach ($entities AS $id => $entity)
      {
        $group_table[$assoc['entity_type']][$entity[$entity_id_field]][$assoc['group_id']][] = $assoc_id;
      }

      // echo(count($entities)." matched".PHP_EOL);
    }
  }

  $msg .= PHP_EOL;
  $msg .= '  <h4>匹配实体:</h4> ';

  foreach ($group_table as $entity_type => $entities)
  {
    foreach ($entities as $entity_id => $entity)
    {
      $entity_name = entity_name($entity_type, $entity_id);
      $msg .= '<span class="label label-ok">'.$entity_name.'</span> ';
      $msg_enable = TRUE;

      foreach ($entity as $group_id => $b)
      {
#        echo(str_pad($entity_type, "20").str_pad($entity_id, "20").str_pad($group_id, "20"));
#        echo(str_pad(implode($b,","), "20"));
        $msg .= '<span class="label label-info">'.$groups['group'][$group_id]['group_name'].'</span><br >';
        $msg_class = 'success';
        if (isset($groups_table_db[$entity_type][$entity_id][$group_id]))
        {
          if ($groups_table_db[$entity_type][$entity_id][$group_id]['group_assocs'] != implode($b,",")) { $update_array = array('group_assocs' => implode($b,","));  }
          #echo("[".$groups_table_db[$entity_type][$entity_id][$group_id]['group_assocs']."][".implode($b,",")."]");
          if (is_array($update_array))
          {
            dbUpdate($update_array, 'group_table', '`group_table_id` = ?', array($groups_table_db[$entity_type][$entity_id][$group_id]['group_table_id']));
            unset($update_array);
          }
          unset($groups_table_db[$entity_type][$entity_id][$group_id]);
        } else {
          $group_table_id = dbInsert(array('device_id' => $device['device_id'], 'entity_type' => $entity_type, 'entity_id' => $entity_id, 'group_id' => $group_id, 'group_assocs' => implode($b,",")), 'group_table');
        }
      }
    }
  }

  $msg .= PHP_EOL;
  $msg .= "  <h4>检测过时的内容:</h4> ";

  foreach ($groups_table_db as $type => $entity)
  {
    foreach ($entity as $entity_id => $alert)
    {
      foreach ($alert as $group_id => $data)
      {
        dbDelete('group_table', "`group_table_id` =  ?", array($data['group_table_id']));
        //dbDelete('group_table-state', "`group_table_id` =  ?", array($data['group_table_id']));
        $msg .= "-";
        $msg_enable = TRUE;
      }
    }
  }

  if ($msg_enable) { print_message($msg, $msg_class); }
}

/**
 * Build an array of groups that apply to a supplied device
 *
 * This takes the array of global conditions and removes associations that don't match the supplied device array
 *
 * @param  array device
 * @return array
*/
// TESTME needs unit testing
function cache_device_groups($device)
{
  // Return no conditions if the device is ignored or disabled.

  if ($device['ignore'] == 1 || $device['disabled'] == 1) { return array(); }

  $groups = cache_groups();

  foreach ($groups['assoc'] as $assoc_key => $assoc)
  {
    if (match_device($device, $assoc['device_attribs']))
    {
      $assoc['group_id'];
      $groups['group'][$assoc['group_id']]['assoc'][$assoc_key] = $groups['assoc'][$assoc_key];
      $groups_new['group'][$assoc['group_id']] = $groups['group'][$assoc['group_id']];
    } else {
      unset($groups['assoc'][$assoc_key]);
    }
  }

  return $groups_new;
}

// DOCME needs phpdoc block
// TESTME needs unit testing
function group_id_by_name($group_name)
{

}

// DOCME needs phpdoc block
// TESTME needs unit testing
function group_entity_ids($group_id)
{

  if (!is_numeric($group_id)) { $group_id = group_id_by_name($group_id); }

  $array = array();

  foreach (dbFetchRows("SELECT * FROM `group_table` WHERE `group_id` = ?", array($group_id)) as $entry)
  {
    $array[$entry['entity_id']] = $entry['entity_id'];
  }

  return $array;

}

/**
 * Build an array of all groups for a specific entity type
 *
 * @return array
*/
// TESTME needs unit testing
function get_type_groups($type = NULL)
{
  $array = array();

  if ($type == NULL)
  {
    $groups = dbFetchRows("SELECT * FROM `groups`");
  } else {
    $groups = dbFetchRows("SELECT * FROM `groups` WHERE `entity_type` = ?", array($type));
  }

  foreach ($groups as $entry)
  {
    $array[$entry['group_id']] = $entry;
  }

  return $array;
}

/**
 * Build an array of all entities matching a group or groups
 *
 * @return array
*/
// TESTME needs unit testing
function get_group_entities($group_ids)
{
  $array = array();
  if (!is_array($group_ids)) { $group_ids = array($group_ids); }

  foreach ($group_ids as $group_id)
  {
    foreach (dbFetchRows("SELECT * FROM `group_table` WHERE `group_id` = ?", array($group_id)) as $entry)
    {
      $array[$entry['entity_id']] = $entry['entity_id'];
    }
  }

  return $array;
}

/**
 * Build an array of all groups
 *
 * @return array
*/
// TESTME needs unit testing
function cache_groups()
{
  $cache = array();

  foreach (dbFetchRows("SELECT * FROM `groups`") as $entry)
  {
    $cache['group'][$entry['group_id']] = $entry;
  }

  foreach (dbFetchRows("SELECT * FROM `groups_assoc`") as $entry)
  {
    $entity_attribs = json_decode($entry['entity_attribs'], TRUE);
    $device_attribs = json_decode($entry['device_attribs'], TRUE);
    $cache['assoc'][$entry['group_assoc_id']]                   = $entry;
    $cache['assoc'][$entry['group_assoc_id']]['entity_attribs'] = $entity_attribs;
    $cache['assoc'][$entry['group_assoc_id']]['device_attribs'] = $device_attribs;
  }

  return $cache;
}

// Return an array of group associations
// DOCME needs phpdoc block
// TESTME needs unit testing
function cache_group_assoc()
{
  $group_assoc = array();

  foreach (dbFetchRows("SELECT * FROM `groups_assoc`") as $entry)
  {
    $entity_attribs = json_decode($entry['entity_attribs'], TRUE);
    $device_attribs = json_decode($entry['device_attribs'], TRUE);

    $group_assoc[$entry['group_assoc_id']]                   = $entry;
    $group_assoc[$entry['group_assoc_id']]['entity_attribs'] = $entity_attribs;
    $group_assoc[$entry['group_assoc_id']]['device_attribs'] = $device_attribs;
  }

  return $group_assoc;
}

// EOF
