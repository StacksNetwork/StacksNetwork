<?php

/**
 * Observium Network Management and Monitoring System
 * Copyright (C) 2006-2014, Adam Armstrong - http://www.observium.org
 *
 * @package    observium
 * @subpackage alerter
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2015 Adam Armstrong
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
// TESTME needs unit testing
function check_entity($type, $entity, $data)
{
  global $config, $alert_rules, $alert_table, $device;

  print_message("\n检测警报");

  if (OBS_DEBUG) { print_vars($data); }

  list($entity_table, $entity_id_field, $entity_name_field, $entity_ignore_field) = entity_type_translate($type);

  if (!isset($alert_table[$type][$entity[$entity_id_field]])) { return; } // Just return to avoid PHP warnings

  $alert_info = array('entity_type' => $type, 'entity_id' => $entity[$entity_id_field]);

  foreach ($alert_table[$type][$entity[$entity_id_field]] as $alert_test_id => $alert_args)
  {
    if ($alert_rules[$alert_test_id]['and']) { $alert = TRUE; } else { $alert = FALSE; }

    $alert_info['alert_test_id'] = $alert_test_id;

    $update_array = array();

    if (is_array($alert_rules[$alert_test_id]))
    {
      echo("测试中警报 ".$alert_test_id." associated by ".$alert_args['alert_assocs']."\n");

      foreach ($alert_rules[$alert_test_id]['conditions'] as $test_key => $test)
      {
        if (substr($test['value'],0,1)=="@")
        {
          $ent_val = substr($test['value'],1); $test['value'] = $entity[$ent_val];
          echo(" replaced @".$ent_val." with ". $test['value'] ." from entity. ");
        }

        echo("测试中: " . $test['metric']. " ". $test['condition'] . " " .$test['value']);
        $update_array['state']['metrics'][$test['metric']] = $data[$test['metric']];

        if (isset($data[$test['metric']]))
        {
          echo(" (值: ".$data[$test['metric']].")");
          if (test_condition($data[$test['metric']], $test['condition'], $test['value']))
          {
            // A test has failed. Set the alert variable and make a note of what failed.
            echo(" 失败 ");
            $update_array['state']['failed'][] = $test;

            if ($alert_rules[$alert_test_id]['and']) { $alert = ($alert && TRUE);
                                              } else { $alert = ($alert || TRUE); }
          } else {
            if ($alert_rules[$alert_test_id]['and']) { $alert = ($alert && FALSE);
                                              } else { $alert = ($alert || FALSE); }
            echo(" OK ");
          }
        } else {
          echo("  测量单位不存在.\n");
          if ($alert_rules[$alert_test_id]['and']) { $alert = ($alert && FALSE);
                                            } else { $alert = ($alert || FALSE); }
        }
      }

      if ($alert)
      {
        // Check to see if this alert has been suppressed by anything
        ## FIXME -- not all of this is implemented

        // Have all alerts been suppressed?
        if ($config['alerts']['suppress']) { $alert_suppressed = TRUE; $suppressed[] = "GLOBAL"; }

        // Have all alerts on the device been suppressed?
        if ($device['ignore']) { $alert_suppressed = TRUE; $suppressed[] = "DEV"; }
        if ($device['ignore_until'])
        {
          $device['ignore_until_time'] = strtotime($device['ignore_until']);
          if ($device['ignore_until_time'] > time() ) { $alert_suppressed = TRUE; $suppressed[] = "DEV_UNTIL"; echo(' DEVSUPP '); }
        }

        // Have all alerts on the entity been suppressed?
        if ($entity[$entity_ignore_field]) { $alert_suppressed = TRUE; $suppressed[] = "ENTITY"; }
        if (is_numeric($entity['ignore_until']) && $entity['ignore_until'] > time() ) { $alert_suppressed = TRUE; $suppressed[] = "ENTITY_UNTIL"; }

        // Have alerts from this alerter been suppressed?
        if ($alert_rules[$alert_test_id]['ignore']) { $alert_suppressed = TRUE; $suppressed[] = "CHECK"; }
        if ($alert_rules[$alert_test_id]['ignore_until'])
        {
          $alert_rules[$alert_test_id]['ignore_until_time'] = strtotime($alert_rules[$alert_test_id]['ignore_until']);
          if ($alert_rules[$alert_test_id]['ignore_until_time'] > time()) { $alert_suppressed = TRUE; $suppressed[] = "CHECK_UNTIL"; }
        }

        // Has this specific alert been suppressed?
        if ($alert_args['ignore']) { $alert_suppressed = TRUE; $suppressed[] = "ENTRY"; }
        if ($alert_args['ignore_until'])
        {
          $alert_args['ignore_until_time'] = strtotime($alert_args['ignore_until']);
          if ($alert_args['ignore_until_time'] > time()) { $alert_suppressed = TRUE; $suppressed[] = "ENTRY_UNTIL"; }
        }

        if (is_numeric($alert_args['ignore_until_ok']) && $alert_args['ignore_until_ok'] == '1' ) { $alert_suppressed = TRUE; $suppressed[] = "ENTRY_UNTIL_OK"; }

        $update_array['count'] = $alert_args['count']+1;

        // Check against the alert test's delay
        if ($alert_args['count'] >= $alert_rules[$alert_test_id]['delay'] && $alert_suppressed)
        {
          // This alert is valid, but has been suppressed.
          echo(" Checks failed. Alert suppressed (".implode(', ', $suppressed).").\n");
          $update_array['alert_status'] = '3';
          $update_array['last_message'] = '检测失败(限制: '.implode(', ', $suppressed).')';
          $update_array['last_checked'] = time();
          if ($alert_args['alert_status'] != '3' || $alert_args['last_changed'] == '0')
          {
            $update_array['last_changed'] = time();
            log_alert('检测错误但是报警被 ['.implode($suppressed, ',').']', $device, $alert_info, 'FAIL_SUPPRESSED');
          }
          if (!isset($alert_args['last_failed']) || $alert_args['last_failed'] == '0') { $update_array['last_failed'] = time(); }
        }
        elseif($alert_args['count'] >= $alert_rules[$alert_test_id]['delay'])
        {
          // This is a real alert.
          echo(" 检查失败. 生成警报.\n");
          $update_array['alert_status'] = '0';
          $update_array['last_message'] = '检测失败';
          $update_array['last_checked'] = time();
          if ($alert_args['alert_status'] != '0'  || $alert_args['last_changed'] == '0')
          {
            $update_array['last_changed'] = time(); $update_array['last_alerted'] = '0';
            log_alert('检测错误', $device, $alert_info, 'FAIL');
          }
          if (!isset($alert_args['last_failed']) || $alert_args['last_failed'] == '0') { $update_array['last_failed'] = time(); }
        } else {
          // This is alert needs to exist for longer.
          echo(" Checks failed. Delaying alert.\n");
          $update_array['alert_status'] = '2';
          $update_array['last_message'] = '检测失败(延迟)';
          $update_array['last_checked'] = time();
          if ($alert_args['alert_status'] != '2'  || $alert_args['last_changed'] == '0')
          {
            $update_array['last_changed'] = time();
            log_alert('检查失败但警报延迟', $device, $alert_info, 'FAIL_DELAYED');
          }
          if (!isset($alert_args['last_failed']) || $alert_args['last_failed'] == '0') { $update_array['last_failed'] = time(); }
        }
      } else {
        $update_array['count'] = 0;
        // Alert conditions passed. Record that we tested it and update status and other data.
        echo(" Checks OK.\n");
        $update_array['alert_status'] = '1';
        $update_array['last_message'] = '检测OK';
        $update_array['last_checked'] = time();
        #$update_array['count'] = 0;
        if ($alert_args['alert_status'] != '1' || $alert_args['last_changed'] == '0')
        {
          $update_array['last_changed'] = time();
          log_alert('Checks succeeded', $device, $alert_info, 'OK');
        }

        // Status is OK, so disable ignore_until_ok if it has been enabled
        if ($alert_args['ignore_until_ok'] != '0') { $update_entry_array['ignore_until_ok'] = '0'; }
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
      if (is_array($update_entry_array)) { dbUpdate($update_entry_array, 'alert_table', '`alert_table_id` = ?', array($alert_args['alert_table_id']));  }

      if (TRUE)
      {
        // Write RRD data
        $rrd = "alert-" . $alert_args['alert_table_id'] . ".rrd";

        rrdtool_create ($device, $rrd, "DS:status:GAUGE:600:0:1 DS:code:GAUGE:600:-7:7");

        if ($update_array['alert_status'] == "1")
        {
          // Status is up
          rrdtool_update($device, $rrd, "N:1:".$update_array['alert_status']);
        } else {
          rrdtool_update($device, $rrd, "N:0:".$update_array['alert_status']);
        }
      }

    } else {
      echo("报警错误!");
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
// TESTME needs unit testing
function cache_device_conditions($device)
{
  // Return no conditions if the device is ignored or disabled.

  if ($device['ignore'] == 1 || $device['disabled'] == 1) { return array(); }

  $conditions = cache_conditions();

  foreach ($conditions['assoc'] as $assoc_key => $assoc)
  {
    if (match_device($device, $assoc['device_attribs']))
    {
      $assoc['alert_test_id'];
      $conditions['cond'][$assoc['alert_test_id']]['assoc'][$assoc_key] = $conditions['assoc'][$assoc_key];
      $cond_new['cond'][$assoc['alert_test_id']] = $conditions['cond'][$assoc['alert_test_id']];
    } else {
      unset($conditions['assoc'][$assoc_key]);
    }
  }

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
// TESTME needs unit testing
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
// TESTME needs unit testing
function cache_alert_rules($vars = array())
{
  $alert_rules = array();
  $rules_count = 0;
  $where = 'WHERE 1';
  $args = array();

  if (isset($vars['entity_type']) && $vars['entity_type'] !== "all") { $where .= ' AND `entity_type` = ?'; $args[] = $vars['entity_type']; }

  foreach (dbFetchRows("SELECT * FROM `alert_tests` ". $where, $args) as $entry)
  {
    if ($entry['alerter'] == '') {$entry['alerter'] = "default"; }
    $alert_rules[$entry['alert_test_id']] = $entry;
    $alert_rules[$entry['alert_test_id']]['conditions'] = json_decode($entry['conditions'], TRUE);
    $rules_count++;
  }

  print_debug("已缓存 $rules_count 报警规则.");

  return $alert_rules;
}

// FIXME. Never used, deprecated?
// DOCME needs phpdoc block
// TESTME needs unit testing
function generate_alerter_info($alerter)
{
  global $config;

  if (is_array($config['alerts']['alerter'][$alerter]))
  {
    $a = $config['alerts']['alerter'][$alerter];
    $output  = "<strong>".$a['descr']."</strong><hr />";
    $output .= $a['type'].": ".$a['contact']."<br />";
    if ($a['enable']) { $output .= "启用"; } else { $output .= "禁用"; }
    return $output;
  } else {
    return "Unknown alerter.";
  }
}

// DOCME needs phpdoc block
// TESTME needs unit testing
function cache_alert_assoc()
{
  $alert_assoc = array();

  foreach (dbFetchRows("SELECT * FROM `alert_assoc`") as $entry)
  {
    $entity_attribs = json_decode($entry['entity_attribs'], TRUE);
    $device_attribs = json_decode($entry['device_attribs'], TRUE);
    $alert_assoc[$entry['alert_assoc_id']]['entity_type'] = $entry['entity_type'];
    $alert_assoc[$entry['alert_assoc_id']]['entity_attribs'] = $entity_attribs;
    $alert_assoc[$entry['alert_assoc_id']]['device_attribs'] = $device_attribs;
    $alert_assoc[$entry['alert_assoc_id']]['alert_test_id']      = $entry['alert_test_id'];
  }

  return $alert_assoc;
}

/**
 * Build an array of all conditions
 *
 * @return array
*/
// TESTME needs unit testing
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
    $entity_attribs = json_decode($entry['entity_attribs'], TRUE);
    $device_attribs = json_decode($entry['device_attribs'], TRUE);
    $cache['assoc'][$entry['alert_assoc_id']]                      = $entry;
    $cache['assoc'][$entry['alert_assoc_id']]['entity_attribs']        = $entity_attribs;
    $cache['assoc'][$entry['alert_assoc_id']]['device_attribs'] = $device_attribs;
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
// TESTME needs unit testing
function test_condition($value_a, $condition, $value_b)
{
  $value_a = trim($value_a);
  $value_b = trim($value_b);

  switch($condition)
  {
    case 'ge':
    case '>=':
      if ($value_a >= unit_string_to_numeric($value_b)) { $alert = TRUE; } else { $alert = FALSE; }
      break;
    case 'le':
    case '<=':
      if ($value_a <= unit_string_to_numeric($value_b)) { $alert = TRUE; } else { $alert = FALSE; }
      break;
    case 'gt':
    case 'greater':
    case '>':
      if ($value_a > unit_string_to_numeric($value_b)) { $alert = TRUE; } else { $alert = FALSE; }
      break;
    case 'lt':
    case 'less':
    case '<':
      if ($value_a < unit_string_to_numeric($value_b)) { $alert = TRUE; } else { $alert = FALSE; }
      break;
    case 'notequals':
    case 'isnot':
    case 'ne':
    case '!=':
      if ($value_a != unit_string_to_numeric($value_b)) { $alert = TRUE; } else { $alert = FALSE; }
      break;
    case 'equals':
    case 'eq':
    case 'is':
    case '==':
    case '=':
      if ($value_a == unit_string_to_numeric($value_b)) { $alert = TRUE; } else { $alert = FALSE; }
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
// TESTME needs unit testing
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
      case "le":
      case "<=":
        $sql .= " AND `".$attrib['attrib']."` <= ?";
        $param[] = $attrib['value'];
        break;
      case "gt":
      case "greater":
      case ">":
        $sql .= " AND `".$attrib['attrib']."` > ?";
        $param[] = $attrib['value'];
        break;
      case "ge":
      case ">=":
        $sql .= " AND `".$attrib['attrib']."` >= ?";
        $param[] = $attrib['value'];
        break;
      case "match":
        $attrib['value'] = str_replace("*", "%", $attrib['value']);
        $sql .= 'AND ifnull(`'.$attrib['attrib'].'`,"") LIKE ?';
        $param[] = $attrib['value'];
        break;
      case "regex":
      case "regexp":
        $sql .= 'AND ifnull(`'.$attrib['attrib'].'`,"") REGEXP ?';
        $param[] = $attrib['value'];
        break;
      case "notmatch":
      case "!match":
        $attrib['value'] = str_replace("*", "%", $attrib['value']);
        $sql .= 'AND ifnull(`'.$attrib['attrib'].'`,"") NOT LIKE ?';
        $param[] = $attrib['value'];
        break;
      case 'notregexp':
      case 'notregex':
      case '!regexp':
      case '!regex':
        $sql .= 'AND ifnull(`'.$attrib['attrib'].'`,"") NOT REGEXP ?';
        $param[] = $attrib['value'];
        break;
      case 'include':
        switch($attrib['attrib'])
        {
          case 'group':

          break;
        }
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
// TESTME needs unit testing
function match_device_entities($device_id, $entity_attribs, $entity_type)
{
  // FIXME - this is going to be horribly slow.

  list($entity_table, $entity_id_field, $entity_name_field) = entity_type_translate($entity_type);
  $entity_type = entity_type_translate_array($entity_type);
  if (!is_array($entity_type)) { return NULL; } // Do nothing if entity type unknown

  $param = array();
  $sql   = "SELECT * FROM `" . mysql_real_escape_string($entity_table) . "`";
  $sql  .= " WHERE device_id = ?";

  #print_vars($entity_type);

  if (isset($entity_type['where'])) { $sql .= ' AND '.$entity_type['where']; }

  $param[] = $device_id;

  if (isset($entity_type['deleted_field']))
  {
    $sql .= " AND `".$entity_type['deleted_field']."` != ?";
    $param[] = '1';
  }

  foreach ($entity_attribs as $attrib)
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
        $sql .= 'AND ifnull(`'.$attrib['attrib'].'`,"") LIKE ?';
        $param[] = $attrib['value'];
        break;
      case 'regexp':
        $sql .= 'AND ifnull(`'.$attrib['attrib'].'`,"") REGEXP ?';
        $param[] = $attrib['value'];
        break;
      case 'notmatch':
        $attrib['value'] = str_replace("*", "%", $attrib['value']);
        $sql .= 'AND ifnull(`'.$attrib['attrib'].'`,"") NOT LIKE ?';
        $param[] = $attrib['value'];
        break;
      case 'notregexp':
        $sql .= 'AND ifnull(`'.$attrib['attrib'].'`,"") NOT REGEXP ?';
        $param[] = $attrib['value'];
        break;
    }
  }

  // print_vars(array($sql, $param));

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
// TESTME needs unit testing
function match_entity($entity, $entity_attribs)
{
  // FIXME. Never used, deprecated?
  #print_vars($entity);
  #print_vars($entity_attribs);

  $failed  = 0;
  $success = 0;

  foreach ($entity_attribs as $attrib)
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

// DOCME needs phpdoc block
// TESTME needs unit testing
function update_device_alert_table($device)
{
  $dbc = array();
  $alert_table = array();

  $msg        = "<h4>Building alerts for device ".$device['hostname'].':</h4>';
  $msg_class  = '';
  $msg_enable = FALSE;
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

  $msg .= PHP_EOL;
  $msg .= '  <h5>匹配该设备检测器:</h5> ';

  foreach ($conditions['cond'] as $alert_test_id => $alert_test)
  {
    $msg .= '<span class="label label-info">'.$alert_test['alert_name'].'</span> ';
    $msg_enable = TRUE;
    foreach ($alert_test['assoc'] as $assoc_id => $assoc)
    {
      // Check that the entity_type matches the one we're interested in.
      // echo("Matching $assoc_id (".$assoc['entity_type'].")");

      list($entity_table, $entity_id_field, $entity_name_field) = entity_type_translate ($assoc['entity_type']);
      $alert = $conditions['cond'][$assoc['alert_test_id']];
      $entities = match_device_entities($device['device_id'], $assoc['entity_attribs'], $assoc['entity_type']);

      foreach ($entities AS $id => $entity)
      {
        $alert_table[$assoc['entity_type']][$entity[$entity_id_field]][$assoc['alert_test_id']][] = $assoc_id;
      }

      // echo(count($entities)." matched".PHP_EOL);
    }
  }

  $msg .= PHP_EOL;
  $msg .= '  <h5>Matching entities:</h5> ';

  foreach ($alert_table as $entity_type => $entities)
  {
    foreach ($entities as $entity_id => $entity)
    {
      $entity_name = entity_name($entity_type, $entity_id);
      $msg .= '<span class="label label-ok">'.htmlentities($entity_name).'</span> ';
      $msg_enable = TRUE;

      foreach ($entity as $alert_test_id => $b)
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

  $msg .= PHP_EOL;
  $msg .= "  <h5>检查过于陈旧的内容:</h5> ";

  foreach ($dbc as $type => $entity)
  {
    foreach ($entity as $entity_id => $alert)
    {
      foreach ($alert as $alert_test_id => $data)
      {
        dbDelete('alert_table', "`alert_table_id` =  ?", array($data['alert_table_id']));
        dbDelete('alert_table-state', "`alert_table_id` =  ?", array($data['alert_table_id']));
        $msg .= "-";
        $msg_enable = TRUE;
      }
    }
  }

  if ($msg_enable) { return(array('message' => $msg, 'class' => $msg_class)); }
}

/**
 * Check all alerts for a device to see if they should be notified or not
 *
 * @param array device
 * @return NULL
 */
// TESTME needs unit testing
function process_alerts($device)
{
  global $config, $alert_rules, $alert_assoc;

  echo("处理警报 ".$device['hostname'].PHP_EOL);

  $alert_table = cache_device_alert_table($device['device_id']);

  $sql  = "SELECT * FROM `alert_table`";
  $sql .= " LEFT JOIN `alert_table-state` ON `alert_table`.`alert_table_id` = `alert_table-state`.`alert_table_id`";
  $sql .= " WHERE `device_id` = ? AND `alert_status` IS NOT NULL;";

  foreach (dbFetchRows($sql, array($device['device_id'])) as $entry)
  {
    echo('Alert: '.$entry['alert_table_id'].' Status: '.$entry['alert_status'].' ');

    // If the alerter is now OK and has previously alerted, send an recovery notice.
    if ($entry['alert_status'] == '1' && $entry['has_alerted'] == '1')
    {
      $alert = $alert_rules[$entry['alert_test_id']];

      if (!$alert['suppress_recovery'])
      {
        $state      = json_decode($entry['state'], TRUE);
        $conditions = json_decode($alert['conditions'], TRUE);
        $entity = get_entity_by_id_cache($entry['entity_type'], $entry['entity_id']);

        $metric_array = array();
        foreach ($state['metrics'] as $metric => $value)
        {
          $metric_array[] = $metric.' = '.$value;
        }

        $message_tags = array(
          'ALERT_STATE'     => 'RECOVERY',
          'ALERT_URL'       => generate_url(array('page' => 'device', 'device' => $device['device_id'],
                                                  'tab' => 'alert', 'alert_entry' => $entry['alert_table_id'])),
          'ALERT_MESSAGE'   => $alert['alert_message'],
          //'CONDITIONS'      => '',
          'METRICS'         => implode(PHP_EOL.'             ', $metric_array),
          'DURATION'        => formatUptime(time() - $entry['last_failed']),
          'ENTITY_LINK'     => generate_entity_link($entry['entity_type'], $entry['entity_id'], $entity['entity_name']),
          'ENTITY_NAME'     => $entity['entity_name'],
          'ENTITY_DESCRIPTION' => $entity['entity_descr'],
          //'ENTITY_GRAPHS'   => '',
          'DEVICE_HOSTNAME' => $device['hostname'],
          'DEVICE_LINK'     => generate_device_link($device),
          'DEVICE_HARDWARE' => $device['hardware'],
          'DEVICE_OS'       => $device['os_text'] . ' ' . $device['version'] . ' ' . $device['features'],
          'DEVICE_LOCATION' => $device['location'],
          'DEVICE_UPTIME'   => deviceUptime($device)
        );
        $message['text'] = simple_template('alert/email_text.tpl', $message_tags, array('is_file' => TRUE));
        //$message_tags['CONDITIONS'] = nl2br($message_tags['CONDITIONS']);
        $message_tags['METRICS']    = nl2br($message_tags['METRICS']);
        $message['html'] = simple_template('alert/email_html.tpl', $message_tags, array('is_file' => TRUE));
        //logfile('debug.log', var_export($message, TRUE));

        alert_notify($device, alert_generate_subject('RECOVER', $device, $alert, $entity), $message, $entry['alert_test_id']);
        log_alert('恢复发送的通知', $device, $entry, 'RECOVER_NOTIFY');
      } else {
        echo('已限制恢复.');
        log_alert('限制恢复通知', $device, $entry, 'RECOVER_SUPPRESSED');
      }

      $update_array['last_recovered'] = time();
      $update_array['has_alerted'] = 0;
      dbUpdate($update_array, 'alert_table-state', '`alert_table_id` = ?', array($entry['alert_table_id']));
    }

    if ($entry['alert_status'] == '0')
    {
      echo('警报已停止. ');

      // Has this been alerted more frequently than the alert interval in the config?
      /// FIXME -- this should be configurable per-entity or per-checker
      if ((time() - $entry['last_alerted']) < $config['alerts']['interval'] && !isset($GLOBALS['spam'])) { $entry['suppress_alert'] = TRUE; }

      // Check if alert has ignore_until set.
      if (is_numeric($entry['ignore_until']) && $entry['ignore_until'] > time()) { $entry['suppress_alert'] = TRUE; }
      // Check if alert has ignore_until_ok set.
      if (is_numeric($entry['ignore_until_ok']) && $entry['ignore_until_ok'] == '1' ) { $entry['suppress_alert'] = TRUE; }

      if ($entry['suppress_alert'] != TRUE)
      {
        echo('Requires notification. ');
        $alert = $alert_rules[$entry['alert_test_id']];

        $state      = json_decode($entry['state'], TRUE);
        $conditions = json_decode($alert['conditions'], TRUE);

        $entity = get_entity_by_id_cache($entry['entity_type'], $entry['entity_id']);

        $condition_array = array();
        foreach ($state['failed'] as $failed)
        {
          $condition_array[] = $failed['metric'] . " " . $failed['condition'] . " ". $failed['value'] ." (". $state['metrics'][$failed['metric']].")";
        }

        $graphs = "";
        $metric_array = array();
        foreach ($state['metrics'] as $metric => $value)
        {
          $metric_array[] = $metric.' = '.$value;
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
          //print_r($graph_array);
          //logfile('debug.log', var_export($graph_array, TRUE));
          $image_data_uri = generate_alert_graph($graph_array);
          //print_r($image_data_uri);
          //logfile('debug.log', var_export($image_data_uri, TRUE));
          $graphs .= '<img src="'.$image_data_uri.'"><br />';
          unset($graph_array);
        }

        $message_tags = array(
          'ALERT_STATE'     => 'ALERT',
          'ALERT_URL'       => generate_url(array('page' => 'device', 'device' => $device['device_id'],
                                                  'tab' => 'alert', 'alert_entry' => $entry['alert_table_id'])),
          'ALERT_MESSAGE'   => $alert['alert_message'],
          'CONDITIONS'      => implode(PHP_EOL.'             ', $condition_array),
          'METRICS'         => implode(PHP_EOL.'             ', $metric_array),
          'DURATION'        => formatUptime(time() - $entry['last_failed']),
          'ENTITY_LINK'     => generate_entity_link($entry['entity_type'], $entry['entity_id'], $entity['entity_name']),
          'ENTITY_NAME'     => $entity['entity_name'],
          'ENTITY_DESCRIPTION' => $entity['entity_descr'],
          'ENTITY_GRAPHS'   => $graphs,
          'DEVICE_HOSTNAME' => $device['hostname'],
          'DEVICE_LINK'     => generate_device_link($device),
          'DEVICE_HARDWARE' => $device['hardware'],
          'DEVICE_OS'       => $device['os_text'] . ' ' . $device['version'] . ' ' . $device['features'],
          'DEVICE_LOCATION' => $device['location'],
          'DEVICE_UPTIME'   => deviceUptime($device)
        );
        $message['text'] = simple_template('alert/email_text.tpl', $message_tags, array('is_file' => TRUE));
        $message_tags['CONDITIONS'] = nl2br($message_tags['CONDITIONS']);
        $message_tags['METRICS']    = nl2br($message_tags['METRICS']);
        $message['html'] = simple_template('alert/email_html.tpl', $message_tags, array('is_file' => TRUE));
        //logfile('debug.log', var_export($message, TRUE));

        alert_notify($device, alert_generate_subject('ALERT', $device, $alert, $entity), $message, $entry['alert_test_id']);
        log_alert('Alert notification sent', $device, $entry, 'ALERT_NOTIFY');

        $update_array['last_alerted'] = time();
        $update_array['has_alerted'] = 1;
        dbUpdate($update_array, 'alert_table-state', '`alert_table_id` = ?', array($entry['alert_table_id']));

      } else {
        echo("没有通知要求. ".(time() - $entry['last_alerted']));
      }
    }
    else if ($entry['alert_status'] == '1')
    {
      echo("状态: OK. ");
    }
    else if ($entry['alert_status'] == '2')
    {
      echo("Status: Notification Delayed. ");
    }
    else if ($entry['alert_status'] == '3')
    {
      echo("Status: Notification Suppressed. ");
    } else {
      echo("未知的状态.");
    }
    echo(PHP_EOL);
  }
}

// DOCME needs phpdoc block
// TESTME needs unit testing
function alert_generate_subject($prefix, $device, $alert, $entity)
{
  $subject = "$prefix: [" . $device['hostname'] . '] [' . $alert['entity_type'] . '] ';
  if ($entity['entity_name'] != $device['hostname'])
  {
    // Don't add entity name if equal to hostname
    $subject .= '[' . $entity['entity_name'].'] ';
  }
  $subject .= $alert['alert_message'];

  return $subject;
}

// DOCME needs phpdoc block
// TESTME needs unit testing
function alert_notify($device, $title, $message, $alert_id = FALSE)
{
  /// NOTE. Need full rewrite to universal function with message queues and multi-protocol (email,jabber,twitter)

  global $config;

  $notify_status = FALSE; // Set alert notify status to FALSE by default

  // do not send alerts when the device is in either:
  // ignore mode, disable_notify
  if (!$device['ignore'] && !get_dev_attrib($device, 'disable_notify'))
  {
    // figure out which transport methods apply to an alert
    $transports = array();
    $sql = "SELECT DISTINCT `contact_method` FROM `alert_contacts`";
    $sql .= " WHERE `contact_disabled` = 0 AND `contact_id` IN";
    $sql .= " (SELECT `alert_contact_id` FROM `alert_contacts_assoc` WHERE `alert_checker_id` = ?);";

    foreach (dbFetchRows($sql, array($alert_id)) as $entry)
    {
      $transports[] = $entry['contact_method'];
    }

    // if alert_contacts table is not in use, fall back to default
    if (empty($transports)) $transports = array('email');

    foreach ($transports as $method)
    {
      if (isset($config[$method]['enable']) && !$config[$method]['enable']) { continue; } // Skip if method disabled globally
      switch ($method)
      {
        case "email":
          include('includes/alerting/email.inc.php');
          break;
          // case "sms":
          // case "jabber":
          // case "etc..."
      }
    }
  }

  return $notify_status; // return notify status
}

// Use this function to write to the alert_log table
// Fix me - quite basic.
// DOCME needs phpdoc block
// TESTME needs unit testing
function log_alert($text, $device, $alert, $log_type)
{
  $insert = array( 'alert_test_id' => $alert['alert_test_id'],
                   'device_id'     => $device['device_id'],
                   'entity_type'   => $alert['entity_type'],
                   'entity_id'     => $alert['entity_id'],
                   'timestamp'     => array("NOW()"),
                   //'status'        => $alert['alert_status'],
                   'log_type'      => $log_type,
                   'message'       => $text );

  $id = dbInsert($insert, 'alert_log');

  return $id;
}

// EOF
