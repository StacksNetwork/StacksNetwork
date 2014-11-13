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

unset($search, $types);

//Message field
$search[] = array('type'    => 'text',
                  'name'    => '信息',
                  'id'      => 'message',
                  'value'   => $vars['message']);
//Type field
//$types[''] = '所有类型';
$types['system'] = '系统';
foreach (dbFetchRows('SELECT `type` FROM `eventlog` WHERE `device_id` = ? GROUP BY `type` ORDER BY `type`', array($vars['device'])) as $data)
{
  $type = $data['type'];
  $types[$type] = ucfirst($type);
}
$search[] = array('type'    => 'multiselect',
                  'name'    => '类型',
                  'id'      => 'type',
                  //'width'   => '130px',
                  'value'   => $vars['type'],
                  'values'  => $types);
$search[] = array('type'    => 'newline');
$search[] = array('type'    => 'datetime',
                  'id'      => 'timestamp',
                  'presets' => TRUE,
                  'min'     => dbFetchCell('SELECT MIN(`timestamp`) FROM `eventlog` WHERE `device_id` = ?', array($vars['device'])),
                  'max'     => dbFetchCell('SELECT MAX(`timestamp`) FROM `eventlog` WHERE `device_id` = ?', array($vars['device'])),
                  'from'    => $vars['timestamp_from'],
                  'to'      => $vars['timestamp_to']);

print_search($search, '事件日志');

/// Pagination
$vars['pagination'] = TRUE;
if(!$vars['pagesize']) { $vars['pagesize'] = "100"; }
if(!$vars['pageno']) { $vars['pageno'] = "1"; }

print_events($vars);

$pagetitle[] = "日志";

// EOF
