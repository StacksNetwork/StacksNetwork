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

// Page to display list of configured alert checks

$alert_check = cache_alert_rules($vars);
#$alert_assoc = cache_alert_assoc($vars);

// Build header menu

foreach (dbFetchRows("SELECT * FROM `alert_assoc` WHERE 1") as $entry)
{
  $alert_assoc[$entry['alert_test_id']][$entry['alert_assoc_id']]['entity_type'] = $entry['entity_type'];
  $alert_assoc[$entry['alert_test_id']][$entry['alert_assoc_id']]['entity_attribs'] = json_decode($entry['entity_attribs'], TRUE);
  $alert_assoc[$entry['alert_test_id']][$entry['alert_assoc_id']]['device_attribs'] = json_decode($entry['device_attribs'], TRUE);
}

$navbar['class'] = "navbar-narrow";
$navbar['brand'] = "警报检测";

$types = dbFetchRows("SELECT `entity_type` FROM `alert_table` GROUP BY `entity_type`");

$navbar['options']['all']['url'] = generate_url($vars, array('page' => 'alert_checks', 'entity_type' => NULL));
$navbar['options']['all']['text'] = escape_html(nicecase('所有'));
if (!isset($vars['entity_type'])) {
  $navbar['options']['all']['class'] = "active";
  $navbar['options']['all']['url'] = generate_url($vars, array('page' => 'alerts_checks', 'entity_type' => NULL));
}

foreach ($types as $thing)
{
  if ($vars['entity_type'] == $thing['entity_type'])
  {
    $navbar['options'][$thing['entity_type']]['class'] = "active";
    $navbar['options'][$thing['entity_type']]['url'] = generate_url($vars, array('page' => 'alert_checks', 'entity_type' => NULL));
  } else {
    $navbar['options'][$thing['entity_type']]['url'] = generate_url($vars, array('page' => 'alert_checks', 'entity_type' => $thing['entity_type']));
  }
  $navbar['options'][$thing['entity_type']]['text'] = escape_html(nicecase($thing['entity_type']));
}

// Print out the navbar defined above
print_navbar($navbar);

foreach (dbFetchRows("SELECT * FROM `alert_table` LEFT JOIN `alert_table-state` ON `alert_table`.`alert_table_id` = `alert_table-state`.`alert_table_id`") as $entry)
{
  $alert_table[$entry['alert_test_id']][$entry['alert_table_id']] = $entry;
}

  echo '<table class="table table-condensed table-bordered table-striped table-rounded table-hover">
  <thead>
    <tr>
    <th class="state-marker"></th><th></th>
    <th style="width: 25px">Id</th>
    <th style="width: 250px">名称</th>
    <th width="40"></th>
    <th style="width: 300px">测试</th>
    <th>Device 匹配/对象匹配</th>
    <th style="width: 40px">对像</th>
    </tr>
  </thead>
  <tbody>', PHP_EOL;

foreach ($alert_check as $check)
{

  // Process the alert checker to add classes and colours and count status.
  humanize_alert_check($check);

  echo('<tr class="'.$check['html_row_class'].'">');

  echo('
    <td class="state-marker"></td>
    <td style="width: 1px;"></td>');

  // Print the conditions applied by this alert

  echo '<td><strong>' . $check['alert_test_id'] . '</td>';

  echo '<td><strong>';
  echo '<a href="', generate_url(array('page' => 'alert_check', 'alert_test_id' => $check['alert_test_id'])), '">' . escape_html($check['alert_name']). '</a></strong><br />';
  echo '<small>',escape_html($check['alert_message']),'</small>';
  echo '</td>';

  echo '<td><i class="' . $config['entities'][$check['entity_type']]['icon'] . '"></i></td>';

  // Loop the tests used by this alert
  echo '<td>';
  $text_block = array();
  foreach ($check['conditions'] as $condition)
  {
    $text_block[] = $condition['metric'].' '.$condition['condition'].' '.$condition['value'];
  }
  echo('<code>'.implode($text_block,'<br />').'</code>');
  echo('</td>');

  echo('<td>');
  echo('<table class="table table-condensed-more table-bordered table-striped table-rounded" style="margin-bottom: 0px;">');

  // Loop the associations which link this alert to this device
  foreach ($alert_assoc[$check['alert_test_id']] as $assoc_id => $assoc)
  {

    echo('<tr>');
    echo('<td width="50%">');
    if (is_array($assoc['device_attribs']))
    {
      $text_block = array();
      foreach ($assoc['device_attribs'] as $attribute)
      {
        $text_block[] = ''.$attribute['attrib'].' '.$attribute['condition'].' '.$attribute['value'].'';
      }
      echo('<code>'.implode($text_block,'<br />').'</code>');
    } else {
      echo '<code>*</code>';
    }

    echo('</td>');

    echo('<td>');
    if (is_array($assoc['entity_attribs']))
    {
      $text_block = array();
      foreach ($assoc['entity_attribs'] as $attribute)
      {
        $text_block[] = ''.$attribute['attrib'].' '.$attribute['condition'].' '.$attribute['value'].'';
      }
      echo('<code>'.implode($text_block,'<br />').'</code>');
    } else {
      echo '<code>*</code>';
    }
    echo('</td>');

    echo('</tr>');

  }
  // End loop of associations

  echo '</table>';

  echo '</td>';

  // Print the count of entities this alert applies to and a popup containing a list and Print breakdown of entities by status.
  // We assume each row here is going to be two lines, so we just <br /> them.
  echo '<td>';
  #echo overlib_link('#', count($entities), $entities_content,  NULL));
  echo '<b>', $check['num_entities'], '</b>';
  echo '<br />';
  echo $check['status_numbers'];
  echo '</td>';

}

echo '</table>';

// EOF
