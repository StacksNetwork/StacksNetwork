<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage web
 * @copyright  (C) 2006-2015 Adam Armstrong
 *
 */

/**
 * Build alert table query from $vars
 * Returns queries for data, an array of parameters and a query to get a count for use in paging
 *
 * @param array $vars
 * @return array ($query, $param, $query_count)
 *
 */
// TESTME needs unit testing
function build_alert_table_query($vars)
{
  $args = array();
  $where = ' WHERE 1 ';

  // Loop through the vars building a sql query from relevant values
  foreach ($vars as $var => $value)
  {
    if ($value != '')
    {
      switch ($var)
      {
        // Search by device_id if we have a device or device_id
        case 'device_id':
          $where .= ' AND `device_id` = ?';
          $param[] = $value;
          break;
        case 'entity_type':
          if ($value != 'all')
          {
            $where .= ' AND `entity_type` = ?';
            $param[] = $value;
          }
          break;
        case 'entity_id':
          $where .= ' AND `entity_id` = ?';
          $param[] = $value;
          break;
        case 'alert_test_id':
          $where .= ' AND `alert_test_id` = ?';
          $param[] = $value;
          break;
        case 'status':
          if ($value == 'failed')
          {
            $where .= " AND `alert_status` IN (0,2,3)";
          }
          break;
      }
    }
  }

  // Permissions query
  $query_permitted = generate_query_permitted(array('device'), array('hide_ignored' => TRUE));

  // Base query
  $query = 'FROM `alert_table` ';
  $query .= 'LEFT JOIN `alert_table-state` USING(`alert_table_id`) ';
  $query .= $where . $query_permitted;

  // Build the query to get a count of entries
  $query_count = 'SELECT COUNT(`alert_table_id`) '.$query;

  // Build the query to get the list of entries
  $query = 'SELECT * '.$query;
  $query .= ' ORDER BY `device_id`, `alert_test_id`, `entity_type`, `entity_id` DESC ';

  if (isset($vars['pagination']) && $vars['pagination'])
  {
    pagination($vars, 0, TRUE); // Get default pagesize/pageno
    $vars['start'] = $vars['pagesize'] * $vars['pageno'] - $vars['pagesize'];
    $query .= 'LIMIT '.$vars['start'].','.$vars['pagesize'];
  }

  return array($query, $param, $query_count);
}

/**
 * Display alert_table entries.
 *
 * @param array $vars
 * @return none
 *
 */
function print_alert_table($vars)
{
  global $alert_rules; global $config;

  // This should be set outside, but do it here if it isn't
  if (!is_array($alert_rules)) { $alert_rules = cache_alert_rules(); }
  /// WARN HERE

  if (isset($vars['device']) && !isset($vars['device_id'])) { $vars['device_id'] = $vars['device']; }
  if (isset($vars['entity']) && !isset($vars['entity_id'])) { $vars['entity_id'] = $vars['entity']; }

  // Short? (no pagination, small out)
  $short = (isset($vars['short']) && $vars['short']);

  list($query, $param, $query_count) = build_alert_table_query($vars);

  // Fetch alerts
  $count  = dbFetchCell($query_count, $param);
  $alerts = dbFetchRows($query, $param);

  // Set which columns we're going to show.
  // We hide the columns that have been given as search options via $vars
  $list = array('device_id' => FALSE, 'entity_id' => FALSE, 'entity_type' => FALSE, 'alert_test_id' => FALSE);
  foreach ($list as $argument => $nope)
  {
    if (!isset($vars[$argument]) || empty($vars[$argument]) || $vars[$argument] == "all") { $list[$argument] = TRUE; }
  }

  // Hide device if we know entity_id
  if (isset($vars['entity_id'])) { $list['device_id'] = FALSE; }
  // Hide entity_type if we know the alert_test_id
  if (isset($vars['alert_test_id']) || TRUE) { $list['entity_type'] = FALSE; } // Hide entity types in favour of icons to save space

  if ($vars['pagination'] && !$short)
  {
    $pagination_html = pagination($vars, $count);
    echo $pagination_html;
  }

echo('<table class="table table-condensed table-bordered table-striped table-rounded table-hover">
  <thead>
    <tr>
      <th class="state-marker"></th>
      <th style="width: 1px;"></th>');
      // No table id
      //<th style="width: 5%;">Id</th>');

if ($list['device_id'])     { echo('      <th style="width: 15%">设备</th>'); }
if ($list['alert_test_id']) { echo('      <th style="min-width: 15%;">警报</th>'); }
if ($list['entity_type'])   { echo('      <th style="width: 10%">类型</th>'); }
if ($list['entity_id'])     { echo('      <th style="">实体</th>'); }

echo '
      <th style="width: 20px">状态</th>
      <th style="width: 100px;">信息</th>
      <th style="width: 90px;">已检测</th>
      <th style="width: 90px;">已更改</th>
      <th style="width: 90px;">警告</th>
      <th style="width: 20px;"></th>
    </tr>
  </thead>
  <tbody>'.PHP_EOL;

  foreach ($alerts as $alert)
  {
    // Process the alert entry, generating colours and classes from the data
    humanize_alert_entry($alert);

    // Get the entity array using the cache
    $entity = get_entity_by_id_cache($alert['entity_type'], $alert['entity_id']);

    // Get the device array using the cache
    $device = device_by_id_cache($alert['device_id']);

    // Get the entity_name.
    ### FIXME - This is probably duplicated effort from above. We should pass it $entity
    $entity_name = entity_name($alert['entity_type'], $entity);

    // Set the alert_rule from the prebuilt cache array
    $alert_rule = $alert_rules[$alert['alert_test_id']];

    echo('<tr class="'.$alert['html_row_class'].'" style="cursor: pointer;" onclick="location.href=\''.generate_url(array('page' => 'device', 'device' => $device['device_id'], 'tab' => 'alert', 'alert_entry' => $alert['alert_table_id'])).'\'">');

    echo('<td class="state-marker"></td>');
    echo('<td style="width: 1px;"></td>');

    // If we know the device, don't show the device
    if ($list['device_id'])
    {
      echo('<td><span class="entity-title">'.generate_device_link($device).'</span></td>');
    }

    // Print link to the alert rule page
    if ($list['alert_test_id'])
    {
      echo '<td><a href="', generate_url(array('page' => 'alert_check', 'alert_test_id' => $alert_rule['alert_test_id'])), '">', $alert_rule['alert_name'], '</a></td>';
    }

    // If we're showing all entity types, print the entity type here
    if ($list['entity_type']) { echo('<td>'.nicecase($alert['entity_type']).'</td>'); }

    // Print a link to the entity
    if ($list['entity_id'])
    {
      echo('<td><span class="entity-title"><i class="' . $config['entities'][$alert['entity_type']]['icon'] . '"></i> '.generate_entity_link($alert['entity_type'], $alert['entity_id']).'</span></td>');
    }

    echo('<td>');
    ## FIXME -- generate a nice popup with parsed information from the state array
    echo(overlib_link("", '<i class="icon-info-sign"></i>', "<pre>".print_r(json_decode($alert['state'], TRUE), TRUE)."</pre>", NULL));
    echo('</td>');

    echo('<td class="'.$alert['class'].'">'.$alert['last_message'].'</td>');

    echo('<td>'.overlib_link('', $alert['checked'], format_unixtime($alert['last_checked'], 'r'), NULL).'</td>');
    echo('<td>'.overlib_link('', $alert['changed'], format_unixtime($alert['last_changed'], 'r'), NULL).'</td>');
    echo('<td>'.overlib_link('', $alert['alerted'], format_unixtime($alert['last_alerted'], 'r'), NULL).'</td>');
    echo('<td><a href="'.generate_url(array('page' => 'device', 'device' => $device['device_id'], 'tab' => 'alert', 'alert_entry' => $alert['alert_table_id'])).'"><i class="oicon-gear" /></a></td>');
    echo('</tr>');

  }

  echo '  </tbody>'.PHP_EOL;
  echo '</table>'.PHP_EOL;

  if ($vars['pagination'] && !$short)
  {
    echo $pagination_html;
  }
}

// EOF
