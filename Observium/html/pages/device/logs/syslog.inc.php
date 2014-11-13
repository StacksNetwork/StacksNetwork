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

unset($search, $priorities, $programs, $timestamp_min, $timestamp_max);

$timestamp_min = dbFetchCell('SELECT MIN(`timestamp`) FROM `syslog` WHERE `device_id` = ?', array($vars['device']));
if ($timestamp_min)
{
  $timestamp_max = dbFetchCell('SELECT MAX(`timestamp`) FROM `syslog` WHERE `device_id` = ?', array($vars['device']));

  //Message field
  $search[] = array('type'    => 'text',
                    'name'    => '信息',
                    'id'      => 'message',
                    'width'   => '130px',
                    'value'   => $vars['message']);
  //Priority field
  //$priorities[''] = '所有属性';
  foreach ($config['syslog']['priorities'] as $p => $priority)
  {
    if ($p > 7) { continue; }
    $priorities[$p] = ucfirst($priority['name']);
  }
  $search[] = array('type'    => 'multiselect',
                    'name'    => 'Priorities',
                    'id'      => 'priority',
                    'width'   => '160px',
                    'subtext' => TRUE,
                    'value'   => $vars['priority'],
                    'values'  => $priorities);
  //Program field
  //$programs[''] = '所有程序';
  foreach (dbFetchRows('SELECT `program` FROM `syslog` WHERE `device_id` = ? GROUP BY `program` ORDER BY `program`', array($vars['device'])) as $data)
  {
    $program = ($data['program']) ? $data['program'] : '[[EMPTY]]';
    $programs[$program] = $program;
  }
  $search[] = array('type'    => 'multiselect',
                    'name'    => 'Programs',
                    'id'      => 'program',
                    'width'   => '160px',
                    'value'   => $vars['program'],
                    'values'  => $programs);
  $search[] = array('type'    => 'newline');
  $search[] = array('type'    => 'datetime',
                    'id'      => 'timestamp',
                    'presets' => TRUE,
                    'min'     => $timestamp_min,
                    'max'     => $timestamp_max,
                    'from'    => $vars['timestamp_from'],
                    'to'      => $vars['timestamp_to']);

  print_search($search, '系统日志');

  // Pagination
  $vars['pagination'] = TRUE;
  if (!$vars['pagesize']) { $vars['pagesize'] = 100; }
  if (!$vars['pageno']) { $vars['pageno'] = 1; }

  // Print syslog
  print_syslogs($vars);
} else {
  print_warning('<h4>没有发现任何日志条目!</h4>
This device does not have any syslog entries.
Check that the syslog daemon and Observium configuration options are set correctly, that this device is configured to send syslog to Observium and that there are no firewalls blocking the messages.

See <a href="http://www.observium.org/wiki/Category:Documentation" target="_blank">documentation</a> and <a href="http://www.observium.org/wiki/Configuration_Options#Syslog_Settings" target="_blank">configuration options</a> for more information.');
}

$pagetitle[] = '系统日志';

// EOF
