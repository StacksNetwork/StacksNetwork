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

// Print common global groups navbar
include($config['html_dir']."/includes/group-navbar.inc.php");

echo '<table class="table table-condensed table-bordered table-striped table-rounded table-hover">
  <thead>
    <tr>
    <th style="width: 0px"></th>
    <th style="width: 0px"></th>
    <th style="width: 25px">Id</th>
    <th style="">分组</th>
    <th style="width: 125px">成员 / 类型</th>
    <th style="width: 560px">成员规则</th>
    </tr>
  </thead>
  <tbody>', PHP_EOL;

foreach (get_type_groups($vars['entity_type']) as $group)
{

  $group['member_count'] = dbFetchCell("SELECT COUNT(*) FROM `group_table` WHERE `group_id` = ?", array($group['group_id']));
  $entity_type           = $config['entities'][$group['entity_type']];

  echo('<tr class="'.$group['html_row_class'].'">');

  echo('
    <td style="width: 1px; background-color: #194b7f; margin: 0px; padding: 0px"></td>
    <td style="width: 1px;"></td>');

  // Print the conditions applied by this alert

  echo '<td><strong>';
  echo $group['group_id'];
  echo '</strong></td>';

  echo '<td><strong>';
  echo '<a href="', generate_url(array('page' => 'group', 'group_id' => $group['group_id'])), '">' . $group['group_name']. '</a></strong><br />';
  echo '<i>',$group['group_descr'],'</i>';
  echo '</td>';

  // Print the count of entities this alert applies to and a popup containing a list and Print breakdown of entities by status.
  // We assume each row here is going to be two lines, so we just <br /> them.
  echo '<td>';
  echo '<i>' . $group['member_count'] . '</i><br />';

  echo '<i class="' . $entity_type['icon'], '"></i> ', nicecase($group['entity_type']);

  echo '</td>';

  echo('<td>');
  echo('<table class="table table-condensed-more table-bordered table-striped table-rounded" style="margin-bottom: 0px;">');

  // Loop the associations which link this alert to this device
  foreach ($group_assoc[$group['group_id']] as $assoc_id => $assoc)
  {
    echo('<tr>');
    echo('<td style="width: 50%;">');
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

}

echo '</table>';

//EOF
