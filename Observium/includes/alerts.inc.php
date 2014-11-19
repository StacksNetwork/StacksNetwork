<?php

/**
 * Observium Network Management and Monitoring System
 * Copyright (C) 2006-2014, Adam Armstrong - http://www.observium.org
 *
 * @package    observium
 * @subpackage alerter
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

/**
 * Check an entity against all relevant alerts
 *
 * @param string type
 * @param array entity
 * @param array data
 * @return NULL
 */

function check_entity($type, $entity, $data)
{
  global $config, $alert_rules, $alert_table, $device;

  echo("\nChecking alerts\n");

  if ($GLOBALS['debug']) { print_vars($data); }

  list($entity_table, $entity_id_field, $entity_name_field, $entity_ignore_field) = entity_type_translate($type);

  foreach ($alert_table[$type][$entity[$entity_id_field]] as $alert_test_id => $alert_args)
  {
    if ($alert_rules[$alert_test_id]['and']) { $alert = TRUE; } else { $alert = FALSE; }

    $update_array = array();

    if (is_array($alert_rules[$alert_test_id]))
    {
      echo("Checking alert ".$alert_test_id." associated by ".$alert_args['alert_assocs']."\n");

      foreach ($alert_rules[$alert_test_id]['conditions'] as $test_key => $test)
      {
        if (substr($test['value'],0,1)=="@")
        {
          $ent_val = substr($test['value'],1); $test['value'] = $entity[$ent_val];
          echo(" replaced @".$ent_val." with ". $test['value'] ." from entity. ");
        }

        echo("Testing: " . $test['metric']. " ". $test['condition'] . " " .$test['value']);
        $update_array['state']['metrics'][$test['metric']] = $data[$test['metric']];

        if (isset($data[$test['metric']]))
        {
          echo(" (value: ".$data[$test['metric']].")");
          if (test_condition($data[$test['metric']], $test['condition'], $test['value']))
          {
            // A test has failed. Set the alert variable and make a note of what failed.
            echo(" FAIL ");
            $update_array['state']['failed'][] = $test;

            if ($alert_rules[$alert_test_id]['and']) { $alert = ($alert && TRUE);
                                              } else { $alert = ($alert || TRUE); }
          } else {
            if ($alert_rules[$alert_test_id]['and']) { $alert = ($alert && FALSE);
                                              } else { $alert = ($alert || FALSE); }
            echo(" OK ");
          }
        } else {
          echo("  Metric is not present on entity.\n");
          if ($alert_rules[$alert_test_id]['and']) { $alert = ($alert && FALSE);
                                            } else { $alert = ($alert || FALSE); }
        }
      }

      if ($alert)
      {
        // Check to see if this alert has been suppressed by anything
        ## FIXME -- not all of this is implemented

        // Have all alerts on the device been suppressed?
        if ($device['ignore']) { $alert_suppressed = TRUE; $suppressed[] = "DEV"; }
        if (is_numeric($device['ignore_until']) && $device['ignore_until'] > time() ) { $alert_suppressed = TRUE; $suppressed[] = "DEV_UNTIL"; }

        // Have all alerts on the entity been suppressed?
        if ($entity[$entity_ignore_field]) { $alert_suppressed = TRUE; $suppressed[] = "ENTITY"; }
        if (is_numeric($entity['ignore_until']) && $entity['ignore_until'] > time() ) { $alert_suppressed = TRUE; $suppressed[] = "ENTITY_UNTIL"; }

        // Have alerts from this alerter been suppressed?
        if ($alert_rules[$alert_test_id]['ignore']) { $alert_suppressed = TRUE; $suppressed[] = "CHECK"; }
        if (is_numeric($alert_rules[$alert_test_id]['ignore_until']) && $alert_rules[$alert_test_id]['ignore_until'] > time() ) { $alert_suppressed = TRUE; $suppressed[] = "CHECK_UNTIL"; }

        // Has this specific alert been suppressed?
        if ($alert_args['ignore']) { $alert_suppressed = TRUE; $suppressed[] = "ENTRY"; }
        if (is_numeric($alert_args['ignore_until']) && $alert_args['ignore_until'] > time() ) { $alert_suppressed = TRUE; $suppressed[] = "ENTRY_UNTIL"; }
        if (is_numeric($alert_args['ignore_until_ok']) && $alert_args['ignore_until_ok'] == '1' ) { $alert_suppressed = TRUE; $suppressed[] = "ENTRY_UNTIL_OK"; }

        $update_array['count'] = $alert_args['count']+1;

        // Check against the alert test's delay
        if ($update_array['count'] >= $alert_rules[$alert_test_id]['delay'] && $alert_suppressed)
        {
          // This alert is valid, but has been suppressed.
          echo(" Checks failed. Alert suppressed (".implode(', ', $suppressed).").\n");
          $update_array['alert_status'] = '3';
          $update_array['last_message'] = 'Checks failed (Suppressed: '.implode(', ', $suppressed).')';
          $update_array['last_checked'] = time();
          if ($alert_args['alert_status'] != '3' || $alert_args['last_changed'] == '0') { $update_array['last_changed'] = time(); }
          if (!isset($alert_args['last_failed']) || $alert_args['last_failed'] == '0') { $update_array['last_failed'] = time(); }
        }
        elseif($update_array['count'] >= $alert_rules[$alert_test_id]['delay'])
        {
          // This is a real alert.
          echo(" Checks failed. Generate alert.\n");
          $update_array['alert_status'] = '0';
          $update_array['last_message'] = 'Checks failed';
          $update_array['last_checked'] = time();
          if ($alert_args['alert_status'] != '0'  || $alert_args['last_changed'] == '0') { $update_array['last_changed'] = time(); $update_array['last_alerted'] = '0'; }
          if (!isset($alert_args['last_failed']) || $alert_args['last_failed'] == '0') { $update_array['last_failed'] = time(); }
        } else {
          // This is alert needs to exist for longer.
          echo(" Checks failed. Delaying alert.\n");
          $update_array['alert_status'] = '2';
          $update_array['last_message'] = 'Checks failed (delayed)';
          $update_array['last_checked'] = time();
          if ($alert_args['alert_status'] != '2'  || $alert_args['last_changed'] == '0') { $update_array['last_changed'] = time(); }
          if (!isset($alert_args['last_failed']) || $alert_args['last_failed'] == '0') { $update_array['last_failed'] = time(); }
        }
      } else {
        $update_array['count'] = 0;
        // Alert conditions passed. Record that we tested it and update status and other data.
        echo(" Checks OK.\n");
        $update_array['alert_status'] = '1';
        $update_array['last_message'] = 'Checks OK';
        $update_array['last_checked'] = time();
        #$update_array['count'] = 0;
        if ($alert_args['alert_status'] != '1' || $alert_args['last_changed'] == '0') { $update_array['last_changed'] = time(); }

        // Status is OK, so disable ignore_until_ok if it has been enabled
        if ($alert_args['ignore_until_ok'] != '0') { $update_array['ignore_until_ok'] = '0'; }
      }

      unset($suppressed); unset($alert_suppressed);

      // json_encode the state array before we put it into MySQL.
      $update_array['state'] = json_encode($update_array['state']);
      #$update_array['alert_table_id'] = $alert_args['alert_table_id'];

      /// Perhaps this is better done with SQL replace?
      #print_vars($alert_args);
      if (!$alert_args['state_entry'])
      {
        // State entry seems to be missing. Insert it before we update it.
        dbInsert(array('alert_table_id' => $alert_args['alert_table_id']), 'alert_table-state');
        echo("INSERTING");
      }
      dbUpdate($update_array, 'alert_table-state', '`alert_table_id` = ?', array($alert_args['alert_table_id']));
    } else {
      echo("Alert missing!");
    }
  }
}

/**
 * Build an array of conditions that apply to a supplied device
 *
 * This takes the array of global conditions and removes associations that don't match the supplied device array
 *
 * @param  array device
 * @return array
*/

function cache_device_conditions($device)
{
  // Return no conditions if the device is ignored or disabled.

  if ($device['ignore'] == 1 || $device['disabled'] == 1) { return array(); }

  $conditions = cache_conditions();

  foreach ($conditions['assoc'] as $assoc_key => $assoc)
  {
    if (match_device($device, $assoc['device_attributes']))
    {
      $assoc['alert_test_id'];
      $conditions['cond'][$assoc['alert_test_id']]['assoc'][$assoc_key] = $conditions['assoc'][$assoc_key];
      $cond_new['cond'][$assoc['alert_test_id']] = $conditions['cond'][$assoc['alert_test_id']];
    } else {
      unset($conditions['assoc'][$assoc_key]);
    }
  }

#  foreach ($cond_new['cond'] as $test_id => $test)
#  {
    #print_vars($test);
#    echo('<span class="label label-info">Matched '.$test['alert_name'].'</span> ');
#  }

  return $cond_new;
}

/**
 * Fetch array of alerts to a supplied device from `alert_table`
 *
 * This takes device_id as argument and returns an array.
 *
 * @param device_id
 * @return array
*/

function cache_device_alert_table($device_id)
{
  $alert_table = array();

  $sql  = "SELECT *,`alert_table`.`alert_table_id` AS `alert_table_id` FROM  `alert_table`";
  $sql .= " LEFT JOIN  `alert_table-state` ON  `alert_table`.`alert_table_id` =  `alert_table-state`.`alert_table_id`";
  $sql .= " WHERE  `device_id` =  ?";

  foreach (dbFetchRows($sql, array($device_id)) as $entry)
  {
    $alert_table[$entry['entity_type']][$entry['entity_id']][$entry['alert_test_id']] = $entry;
  }

  return $alert_table;
}

/**
 * Build an array of all alert rules
 *
 * @return array
*/

function cache_alert_rules($vars = array())
{
  global $debug;

  $alert_rules = array();
  $rules_count = 0;
  $where = 'WHERE 1';
  $args = array();

  if (isset($vars['entity_type'])) { $where .= ' AND `entity_type` = ?'; $args[] = $vars['entity_type']; }

  foreach (dbFetchRows("SELECT * FROM `alert_tests` ". $where, $args) as $entry)
  {
    if ($entry['alerter'] == '') {$entry['alerter'] = "default"; }
    $alert_rules[$entry['alert_test_id']] = $entry;
    $alert_rules[$entry['alert_test_id']]['conditions'] = json_decode($entry['conditions'], TRUE);
    $rules_count++;
  }

  if ($debug) { echo("Cached $rules_count alert rules.\n"); }

  return $alert_rules;
}

/// FIXME. Never used, deprecated?
function generate_alerter_info($alerter)
{
  global $config;

  if (is_array($config['alerts']['alerter'][$alerter]))
  {
    $a = $config['alerts']['alerter'][$alerter];
    $output  = "<strong>".$a['descr']."</strong><hr />";
    $output .= $a['type'].": ".$a['contact']."<br />";
    if ($a['enable']) { $output .= "Enabled"; } else { $output .= "Disabled"; }
    return $output;
  } else {
    return "Unknown alerter.";
  }
}

function cache_alert_assoc()
{
  $alert_assoc = array();

  foreach (dbFetchRows("SELECT * FROM `alert_assoc`") as $entry)
  {
    $attributes = json_decode($entry['attributes'], TRUE);
    $dev_attrib = json_decode($entry['device_attributes'], TRUE);
    $alert_assoc[$entry['alert_assoc_id']]['entity_type'] = $entry['entity_type'];
    $alert_assoc[$entry['alert_assoc_id']]['attributes'] = $attributes;
    $alert_assoc[$entry['alert_assoc_id']]['device_attributes'] = $dev_attrib;
    $alert_assoc[$entry['alert_assoc_id']]['alert_test_id']      = $entry['alert_test_id'];
  }

  return $alert_assoc;
}

/**
 * Build an array of all conditions
 *
 * @return array
*/

function cache_conditions()
{
  $cache = array();

  foreach (dbFetchRows("SELECT * FROM `alert_tests`") as $entry)
  {
    $cache['cond'][$entry['alert_test_id']] = $entry;
    $conditions = json_decode($entry['conditions'], TRUE);
    $cache['cond'][$entry['alert_test_id']]['entity_type'] = $entry['entity_type'];
    $cache['cond'][$entry['alert_test_id']]['conditions'] = $conditions;
  }

  foreach (dbFetchRows("SELECT * FROM `alert_assoc`") as $entry)
  {
    $attributes = json_decode($entry['attributes'], TRUE);
    $dev_attrib = json_decode($entry['device_attributes'], TRUE);
    $cache['assoc'][$entry['alert_assoc_id']]                      = $entry;
    $cache['assoc'][$entry['alert_assoc_id']]['attributes']        = $attributes;
    $cache['assoc'][$entry['alert_assoc_id']]['device_attributes'] = $dev_attrib;
  }

  return $cache;
}

/**
 * Compare two values
 *
 * @param value_a
 * @param condition
 * @param value_b
 * @return integer
*/

function test_condition($value_a, $condition, $value_b)
{
  $value_a = trim($value_a);
  $value_b = trim($value_b);

  switch($condition)
  {
    case 'ge':
    case '>=':
      if ($value_a >= $value_b) { $alert = TRUE; } else { $alert = FALSE; }
      break;
    case 'le':
    case '<=':
      if ($value_a <= $value_b) { $alert = TRUE; } else { $alert = FALSE; }
      break;
    case 'gt':
    case 'greater':
    case 'gt':
    case '>':
      if ($value_a > $value_b) { $alert = TRUE; } else { $alert = FALSE; }
      break;
    case 'lt':
    case 'less':
    case 'lt':
    case '<':
      if ($value_a < $value_b) { $alert = TRUE; } else { $alert = FALSE; }
      break;
    case 'notequals':
    case 'isnot':
    case 'ne':
    case '!=':
      if ($value_a != $value_b) { $alert = TRUE; } else { $alert = FALSE; }
      break;
    case 'equals':
    case 'eq':
    case 'is':
    case '==':
    case '=':
      if ($value_a == $value_b) { $alert = TRUE; } else { $alert = FALSE; }
      break;
    case 'match':
      $value_b = str_replace('*', '.*', $value_b);
      $value_b = str_replace('?', '.', $value_b);
      if (preg_match('/^'.$value_b.'$/', $value_a)) { $alert = TRUE; } else { $alert = FALSE; }
      break;
    case 'notmatch':
    case '!match':
      $value_b = str_replace('*', '.*', $value_b);
      $value_b = str_replace('?', '.', $value_b);
      if (preg_match('/^'.$value_b.'$/', $value_a)) { $alert = FALSE; } else { $alert = TRUE; }
      break;
    case 'regexp':
    case 'regex':
      if (preg_match('/'.$value_b.'/', $value_a)) { $alert = TRUE; } else { $alert = FALSE; }
      break;
    case 'notregexp':
    case 'notregex':
    case '!regexp':
    case '!regex':
      if (preg_match('/'.$value_b.'/', $value_a)) { $alert = FALSE; } else { $alert = TRUE; }
      break;
    default:
      $alert = FALSE;
      break;
  }

  return $alert;
}

/**
 * Test if a device matches a set of attributes
 * Matches using the database entry for the supplied device_id
 *
 * @param array device
 * @param array attributes
 * @return boolean
*/

function match_device($device, $attributes)
{
  // Short circuit this check if the device is either disabled or ignored.
  if ($device['disable'] == 1 || $device['ignore'] == 1) { return FALSE; }

  $sql   = "SELECT count(*) FROM `devices`";
  $sql  .= " WHERE device_id = ?";
  $param[] = $device['device_id'];

  foreach ($attributes as $attrib)
  {
    switch ($attrib['condition'])
    {
      case "equals":
      case "eq":
      case "is":
      case "==":
      case "=":
        $sql .= " AND `".$attrib['attrib']."` = ?";
        $param[] = $attrib['value'];
        break;
      case "notequals":
      case "isnot":
      case "ne":
      case "!=":
        $sql .= " AND `".$attrib['attrib']."` != ?";
        $param[] = $attrib['value'];
        break;
      case "lt":
      case "less":
      case "<":
        $sql .= " AND `".$attrib['attrib']."` < ?";
        $param[] = $attrib['value'];
        break;
      case "gt":
      case "greater":
      case ">":
        $sql .= " AND `".$attrib['attrib']."` > ?";
        $param[] = $attrib['value'];
        break;
      case "match":
        $attrib['value'] = str_replace("*", "%", $attrib['value']);
        $sql .= " AND `".$attrib['attrib']."` LIKE ?";
        $param[] = $attrib['value'];
        break;
      case "regexp":
        $sql .= " AND `".$attrib['attrib']."` REGEXP ?";
        $param[] = $attrib['value'];
        break;
      case "notmatch":
        $attrib['value'] = str_replace("*", "%", $attrib['value']);
        $sql .= " AND `".$attrib['attrib']."` NOT LIKE ?";
        $param[] = $attrib['value'];
        break;
      case "notregexp":
        $sql .= " AND `".$attrib['attrib']."` NOT REGEXP ?";
        $param[] = $attrib['value'];
        break;
    }
  }

  $device_count = dbFetchCell($sql, $param);

  if ($device_count == 0)
  {
    return FALSE;
  } else {
    return TRUE;
  }
}

/**
 * Return an array of entities of a certain type which match device_id and entity attribute rules.
 *
 * @param integer device_id
 * @param array attributes
 * @param string entity_type
 * @return array
*/

/// FIXME - this is going to be horribly slow.
function match_device_entities($device_id, $attributes, $entity_type)
{
  $param = array();

  list($entity_table, $entity_id_field, $entity_name_field) = entity_type_translate ($entity_type);

  $entity_type = entity_type_translate_array($entity_type);

  $sql   = "SELECT * FROM `".mres($entity_table)."`";
  $sql  .= " WHERE device_id = ?";
  $param[] = $device_id;

  if (isset($entity_type['deleted_field']))
  {
    $sql .= " AND `".$entity_type['deleted_field']."` != ?";
    $param[] = '1';
  }

  foreach ($attributes as $attrib)
  {
    switch ($attrib['condition'])
    {
      case '==':
      case 'is':
      case 'eq':
      case 'equals':
      case '=':
        $sql .= " AND `".$attrib['attrib']."` = ?";
        $param[] = $attrib['value'];
        break;
      case 'ne':
      case 'notequals':
      case 'isnot':
      case '!=':
        $sql .= " AND `".$attrib['attrib']."` != ?";
        $param[] = $attrib['value'];
        break;
      case 'le':
      case '<=':
        $sql .= " AND `".$attrib['attrib']."` < ?";
        $param[] = $attrib['value'];
        break;
      case 'ge':
      case '>=':
        $sql .= " AND `".$attrib['attrib']."` > ?";
        $param[] = $attrib['value'];
        break;
      case 'lt':
      case 'less':
      case '<':
        $sql .= " AND `".$attrib['attrib']."` < ?";
        $param[] = $attrib['value'];
        break;
      case 'gt':
      case 'greater':
      case '>':
        $sql .= " AND `".$attrib['attrib']."` > ?";
        $param[] = $attrib['value'];
        break;
      case 'match':
        $attrib['value'] = str_replace("*", "%", $attrib['value']);
        $sql .= " AND `".$attrib['attrib']."` LIKE ?";
        $param[] = $attrib['value'];
        break;
      case 'regexp':
        $sql .= " AND `".$attrib['attrib']."` REGEXP ?";
        $param[] = $attrib['value'];
        break;
      case 'notmatch':
        $attrib['value'] = str_replace("*", "%", $attrib['value']);
        $sql .= " AND `".$attrib['attrib']."` NOT LIKE ?";
        $param[] = $attrib['value'];
        break;
      case 'notregexp':
        $sql .= " AND `".$attrib['attrib']."` NOT REGEXP ?";
        $param[] = $attrib['value'];
        break;
    }
  }

  $entities = dbFetchRows($sql, $param);

  return $entities;
}

/**
 * Test if an entity matches a set of attributes
 * Uses a supplied device array for matching.
 *
 * @param array entity
 * @param array attributes
 * @return boolean
*/

/// FIXME. Never used, deprecated?
function match_entity($entity, $attributes)
{
  #print_vars($entity);
  #print_vars($attributes);

  $failed  = 0;
  $success = 0;

  foreach ($attributes as $attrib)
  {
    switch ($attrib['condition'])
    {
      case 'equals':
        if ( mb_strtolower($entity[$attrib['attrib']]) ==  mb_strtolower($attrib['value'])) { $success++; } else { $failed++; }
        break;
      case 'match':
        $attrib['value'] = str_replace('*', '.*', $attrib['value']);
        $attrib['value'] = str_replace('?', '.',  $attrib['value']);
        if (preg_match('/^'.$attrib['value'].'$/i', $entity[$attrib['attrib']])) { $success++; } else { $failed++; }
        break;
    }
  }

  if ($failed)
  {
    return FALSE;
  } else {
    return TRUE;
  }
}

function update_device_alert_table($device)
{
  $dbc = array();
  $alert_table = array();

  $msg = "<h4>Building alerts for device ".$device['hostname'].'</h4>';
  $msg_class = '';
  $conditions = cache_device_conditions($device);

  //foreach ($conditions['cond'] as $test_id => $test)
  //{
  //  #print_vars($test);
  //  #echo('<span class="label label-info">Matched '.$test['alert_name'].'</span> ');
  //}

  $db_cs = dbFetchRows("SELECT * FROM `alert_table` WHERE `device_id` = ?", array($device['device_id']));
  foreach ($db_cs as $db_c)
  {
    $dbc[$db_c['entity_type']][$db_c['entity_id']][$db_c['alert_test_id']] = $db_c;
  }

  $msg .= '<br /><h5>Checkers matching this device:</h5> ';

  foreach ($conditions['cond'] as $alert_test_id => $alert_test)
  {
    $msg .= '<span class="label label-info">'.$alert_test['alert_name'].'</span> ';
    foreach ($alert_test['assoc'] as $assoc_id => $assoc)
    {
      // Check that the entity_type matches the one we're interested in.
      // echo("Matching $assoc_id (".$assoc['entity_type'].")");

      list($entity_table, $entity_id_field, $entity_name_field) = entity_type_translate ($assoc['entity_type']);
      $alert = $conditions['cond'][$assoc['alert_test_id']];
      $entities = match_device_entities($device['device_id'], $assoc['attributes'], $assoc['entity_type']);

      foreach ($entities AS $id => $entity)
      {
        $alert_table[$assoc['entity_type']][$entity[$entity_id_field]][$assoc['alert_test_id']][] = $assoc_id;
      }

      // echo(count($entities)." matched".PHP_EOL);
      $msg .= '<br />';
    }
  }

  $msg .= '<h5>Matching entities:</h5>';

  foreach ($alert_table AS $entity_type => $entities)
  {
    foreach ($entities AS $entity_id => $entity)
    {
      $entity_name = entity_name($entity_type, $entity_id);
      $msg .= '<span class="label label-ok">'.$entity_name.'</span> ';

      foreach ($entity AS $alert_test_id => $b)
      {
#        echo(str_pad($entity_type, "20").str_pad($entity_id, "20").str_pad($alert_test_id, "20"));
#        echo(str_pad(implode($b,","), "20"));
        $msg .= '<span class="label label-info">'.$conditions['cond'][$alert_test_id]['alert_name'].'</span><br >';
        $msg_class = 'success';
        if (isset($dbc[$entity_type][$entity_id][$alert_test_id]))
        {
          if ($dbc[$entity_type][$entity_id][$alert_test_id]['alert_assocs'] != implode($b,",")) { $update_array = array('alert_assocs' => implode($b,","));  }
          #echo("[".$dbc[$entity_type][$entity_id][$alert_test_id]['alert_assocs']."][".implode($b,",")."]");
          if (is_array($update_array))
          {
            dbUpdate($update_array, 'alert_table', '`alert_table_id` = ?', array($dbc[$entity_type][$entity_id][$alert_test_id]['alert_table_id']));
            unset($update_array);
          }
          unset($dbc[$entity_type][$entity_id][$alert_test_id]);
        } else {
          $alert_table_id = dbInsert(array('device_id' => $device['device_id'], 'entity_type' => $entity_type, 'entity_id' => $entity_id, 'alert_test_id' => $alert_test_id, 'alert_assocs' => implode($b,",")), 'alert_table');
          dbInsert(array('alert_table_id' => $alert_table_id), 'alert_table-state');
        }
      }
    }
  }

  $msg .= "Checking for stale entries: ";

  foreach ($dbc AS $type => $entity)
  {
    foreach ($entity AS $entity_id => $alert)
    {
      foreach ($alert AS $alert_test_id => $data)
      {
        dbDelete('alert_table', "`alert_table_id` =  ?", array($data['alert_table_id']));
        dbDelete('alert_table-state', "`alert_table_id` =  ?", array($data['alert_table_id']));
        $msg .= "-";
      }
    }
  }

  print_message($msg, $msg_class);
}

/**
 * Check all alerts for a device to see if they should be notified or not
 *
 * @param array device
 * @return NULL
 */

function process_alerts($device)
{
  global $config, $alert_rules, $alert_assoc;

  echo("Processing alerts for ".$device['hostname'].PHP_EOL);

  $alert_table = cache_device_alert_table($device['device_id']);

  $sql  = "SELECT * FROM  `alert_table`";
  $sql .= " LEFT JOIN  `alert_table-state` ON  `alert_table`.`alert_table_id` =  `alert_table-state`.`alert_table_id`";
  $sql .= " WHERE  `device_id` =  ?";

  foreach (dbFetchRows($sql, array($device['device_id'])) as $entry)
  {
    echo('Alert: '.$entry['alert_table_id'].' Status: '.$entry['alert_status'].' ');

    // If the alerter is now OK and has previously alerted, send an recovery notice.
    if ($entry['alert_status'] == '1' && $entry['has_alerted'] == '1')
    {
      $alert = $alert_rules[$entry['alert_test_id']];
      $state      = json_decode($entry['state'], TRUE);
      $conditions = json_decode($alert['conditions'], TRUE);
      $entity = get_entity_by_id_cache($entry['entity_type'], $entry['entity_id']);

      $graphs = ""; $metric_text = "";
      foreach ($state['metrics'] AS $metric => $value)
      {
        $metric_text .= $metric ." = ".$value.PHP_EOL."<br />";
      }

      // FIXME De-dup this shit soon.
      // - adama
      $message = '
<head>
    <title>Observium Alert</title>
<style>
.observium{ width:100%; max-width: 500px; -webkit-border-radius: 5px; -moz-border-radius: 5px; border-radius: 5px; border:1px solid #DDDDDD; background-color:#FAFAFA;
 font-size: 13px; color: #777777; }
.header{ font-weight: bold; font-size: 16px; padding: 5px; color: #555555; }
.red { color: #cc0000; }
#deviceinfo tr:nth-child(odd) { background: #ffffff; }
</style>
<style type="text/css"></style></head>
<body>
<table class="observium">
  <tbody>
    <tr>
      <td>
        <table class="observium" id="deviceinfo">
  <tbody>
    <tr><td class="header">RECOVERY</td><td><a style="float: right;" href="'.generate_url(array('page' => 'device', 'device' => $device['device_id'], 'tab' => 'alert', 'alert_entry' => $entry['alert_table_id'])).'">Modify</a></td></tr>
    <tr><td><b>Alert</b></font></td><td class="red">'.$alert['alert_message'].'</font></td></tr>
    <tr><td><b>Entity</b></font></td><td>'.generate_entity_link($entry['entity_type'], $entry['entity_id'], $entity['entity_name']).'</font></td></tr>';
      if(strlen($entity['entity_descr']) > 0)
      {
        $message .= '<tr><td><b>Descr</b></font></td><td>'.$entity['entity_descr'].'</font>';
      }
      $message .= '
    <tr><td><b>Metrics</b></font></td><td>'.$metric_text.'</font></td></tr>
    <tr><td><b>Duration</b></font></td><td>'.formatUptime(time() - $entry['last_failed']).'</font></td></tr>
    <tr><td colspan="2" class="header">Device</td></tr>
    <tr><td><b>Device</b></font></td><td>'.generate_device_link($device).'</font></td></tr>
    <tr><td><b>Hardware</b></font></td><td>'.$device['hardware'].'</font></td></tr>
    <tr><td><b>Operating System</b></font></td><td>' . $device['os_text'] . ' ' . $device['version'] . ' ' . $device['features'] .'</font></td></tr>
    <tr><td><b>Location</b></font></td><td>'.htmlspecialchars($device['location']).'</font></td></tr>
    <tr><td><b>Uptime</b></font></td><td>'.deviceUptime($device).'</font></td></tr>
  </tbody></table>
</td></tr>
<tr><td>
<center>'.$graphs.'</center></td></tr>
</tbody></table>
</body>
</html>';

      alert_notify($device, "RECOVER: [".$device['hostname']."] [".$alert['entity_type']."] [".$entity['entity_name']."] ".$alert['alert_message'],  $message);

      $update_array['last_recovered'] = time();
      $update_array['has_alerted'] = 0;
      dbUpdate($update_array, 'alert_table-state', '`alert_table_id` = ?', array($entry['alert_table_id']));
    }

    if ($entry['alert_status'] == '0')
    {
      echo('Alert tripped. ');

      // Has this been alerted more frequently than the alert interval in the config?
      /// FIXME -- this should be configurable per-entity or per-checker
      if ((time() - $entry['last_alerted']) < $config['alerts']['interval'] && !isset($GLOBALS['spam'])) { $entry['suppress_alert'] = TRUE; }

      // Check if alert has ignore_until set.
      if (is_numeric($entry['ignore_until']) && $entry['ignore_until'] > time()) { $entry['suppress_alert'] = TRUE; }

      if ($entry['suppress_alert'] != TRUE)
      {
        echo('Requires notification. ');
        $alert = $alert_rules[$entry['alert_test_id']];

        $state      = json_decode($entry['state'], TRUE);
        $conditions = json_decode($alert['conditions'], TRUE);

        $entity = get_entity_by_id_cache($entry['entity_type'], $entry['entity_id']);

        $condition_text = "";
        foreach ($state['failed'] AS $failed)
        {
          $condition_text .= $failed['metric'] . " " . $failed['condition'] . " ". $failed['value'] ." (". $state['metrics'][$failed['metric']].")<br />";
        }

        $graphs = ""; $metric_text = "";
        foreach ($state['metrics'] AS $metric => $value)
        {
          $metric_text .= $metric ." = ".$value.PHP_EOL."<br />";
        }

        if (is_array($config['entities'][$entry['entity_type']]['graph']))
        {
          // We can draw a graph for this type/metric pair!

          $graph_array = $config['entities'][$entry['entity_type']]['graph'];
          foreach ($graph_array as $key => $val)
          {
            // Check to see if we need to do any substitution
            if (substr($val,0,1)=="@")
            {
              $nval = substr($val,1);
              echo(" replaced ".$val." with ". $entity[$nval] ." from entity. ".PHP_EOL."<br />");
              $graph_array[$key] = $entity[$nval];
            }
          }
          print_r($graph_array);
          $image_data_uri = generate_alert_graph($graph_array);
          print_r(strlen($image_data_uri));
          $graphs .= '<img src="'.$image_data_uri.'">'."<br />";
          unset($graph_array);
        }

#$css = data_uri($config['html_dir'].'/css/bootstrap-mini.css' ,'text/css');

        $message = '
<head>
    <title>Observium Alert</title>
<style>
.observium{ width:100%; max-width: 500px; -webkit-border-radius: 5px; -moz-border-radius: 5px; border-radius: 5px; border:1px solid #DDDDDD; background-color:#FAFAFA;
 font-size: 13px; color: #777777; }
.header{ font-weight: bold; font-size: 16px; padding: 5px; color: #555555; }
.red { color: #cc0000; }
#deviceinfo tr:nth-child(odd) { background: #ffffff; }
</style>
<style type="text/css"></style></head>
<body>
<table class="observium">
  <tbody>
    <tr>
      <td>
        <table class="observium" id="deviceinfo">
  <tbody>
    <tr><td class="header">ALERT</td><td><a style="float: right;" href="'.generate_url(array('page' => 'device', 'device' => $device['device_id'], 'tab' => 'alert', 'alert_entry' => $entry['alert_table_id'])).'">Modify</a></td></tr>
    <tr><td><b>Alert</b></font></td><td class="red">'.$alert['alert_message'].'</font></td></tr>
    <tr><td><b>Entity</b></font></td><td>'.generate_entity_link($entry['entity_type'], $entry['entity_id'], $entity['entity_name']).'</font></td></tr>';
        if(strlen($entity['entity_descr']) > 0)
        {
          $message .= '<tr><td><b>Descr</b></font></td><td>'.$entity['entity_descr'].'</font>';
        }
        $message .= '
    <tr><td><b>Conditions</b></font></td><td>'.$condition_text.'</font></td></tr>
    <tr><td><b>Metrics</b></font></td><td>'.$metric_text.'</font></td></tr>
    <tr><td><b>Duration</b></font></td><td>'.formatUptime(time() - $entry['last_failed']).'</font></td></tr>
    <tr><td colspan="2" class="header">Device</td></tr>
    <tr><td><b>Device</b></font></td><td>'.generate_device_link($device).'</font></td></tr>
    <tr><td><b>Hardware</b></font></td><td>'.$device['hardware'].'</font></td></tr>
    <tr><td><b>Operating System</b></font></td><td>' . $device['os_text'] . ' ' . $device['version'] . ' ' . $device['features'] .'</font></td></tr>
    <tr><td><b>Location</b></font></td><td>'.htmlspecialchars($device['location']).'</font></td></tr>
    <tr><td><b>Uptime</b></font></td><td>'.deviceUptime($device).'</font></td></tr>
  </tbody></table>
</td></tr>
<tr><td>
<center>'.$graphs.'</center></td></tr>
</tbody></table>
</body>
</html>';

        alert_notify($device, "ALERT: [".$device['hostname']."] [".$alert['entity_type']."] [".$entity['entity_name']."] ".$alert['alert_message'],  $message);

        $update_array['last_alerted'] = time();
        $update_array['has_alerted'] = 1;
        dbUpdate($update_array, 'alert_table-state', '`alert_table_id` = ?', array($entry['alert_table_id']));

      } else { echo("No notification required. ".(time() - $entry['last_alerted'])); }
    } elseif($entry['alert_status'] == '1') { echo("Status: OK. "); } else { echo("Unknown status."); }
      echo(PHP_EOL);
  }
}

function alert_notify($device,$title,$message)
{
  /// NOTE. Need full rewrite to universal function with message queues and multi-protocol (email,jabber,twitter)
  global $config, $debug;

  if (!$device['ignore'])
  {
    if (!get_dev_attrib($device,'disable_notify'))
    {
      if ($config['alerts']['email']['default_only'])
      {
        $email = $config['alerts']['email']['default'];
      } else {
        if (get_dev_attrib($device,'override_sysContact_bool'))
        {
          $email = get_dev_attrib($device,'override_sysContact_string');
        }
        elseif ($device['sysContact'])
        {
          $email = $device['sysContact'];
        } else {
          $email = $config['alerts']['email']['default'];
        }
      }
      $emails = parse_email($email);

      // Find local hostname (could also use gethostname() on 5.3+)
      $localhost = php_uname('n');

      if ($emails)
      {
        // Mail backend params
        $backend = strtolower(trim($config['email_backend']));
        switch ($backend)
        {
          case 'sendmail':
            $params['sendmail_path'] = $config['email_sendmail_path'];
            break;
          case 'smtp':
            $params['host']      = $config['email_smtp_host'];
            $params['port']      = $config['email_smtp_port'];
            if ($config['email_smtp_secure'] == 'ssl')
            {
              $params['host']    = 'ssl://'.$config['email_smtp_host'];
              if ($config['email_smtp_port'] == 25)
              {
                $params['port']  = 465; // Default port for SSL
              }
            }
            $params['timeout']   = $config['email_smtp_timeout'];
            $params['auth']      = $config['email_smtp_auth'];
            $params['username']  = $config['email_smtp_username'];
            $params['password']  = $config['email_smtp_password'];
            $params['localhost'] = $localhost;
            if ($debug) { $params['debug'] = TRUE; }
            break;
          case 'mail':
          default:
            $backend = 'mail'; // Default mailer backend
        }

        // Mail headers
        $headers = array();
        if (empty($config['email_from']))
        {
          $headers['From']   = '"Observium" <observium@'.$localhost.'>'; // Default "From:"
        } else {
          foreach (parse_email($config['email_from']) as $from => $from_name)
          {
            $headers['From'] = (empty($from_name)) ? $from : '"'.$from_name.'" <'.$from.'>'; // From:
          }
        }
        $rcpts_full = '';
        $rcpts = '';
        foreach ($emails as $to => $to_name)
        {
          $rcpts_full .= (empty($to_name)) ? $to.', ' : '"'.trim($to_name).'" <'.$to.'>, ';
          $rcpts .= $to.', ';
        }
        $rcpts_full = substr($rcpts_full, 0, -2); // To:
        $rcpts = substr($rcpts, 0, -2);
        $headers['Subject']      = $title; // Subject:
        $headers['X-Priority']   = 3; // Mail priority
        $headers['X-Mailer']     = 'Observium ' . $config['version']; // X-Mailer:
        $headers['Content-type'] = 'text/html';
        $headers['Message-ID']   = '<' . md5(uniqid(time())) . '@' . $params['localhost'] . '>';
        $headers['Date']         = date('r', time());

        // Mail body
        // $message_header = $config['page_title_prefix']."\n\n"; // Seems useless now.
        $message_footer = "\n\nE-mail sent to: ".$rcpts."\n";
        $message_footer .= "E-mail sent at: " . date($config['timestamp_format']) . "\n";
        $body = $message . $message_footer;

        // Create mailer instance
        $mail =& Mail::factory($backend, $params);
        // Sending email
        $status = $mail->send($rcpts_full, $headers, $body);
        if (PEAR::isError($status)) { echo 'Mailer Error: ' . $status->getMessage() . PHP_EOL; }
      }
    }
  }
}

// EOF
