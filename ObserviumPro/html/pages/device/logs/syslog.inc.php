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
                    'name'    => '��Ϣ',
                    'id'      => 'message',
                    'width'   => '130px',
                    'value'   => $vars['message']);
  //Priority field
  //$priorities[''] = '�������ȼ�';
  foreach ($config['syslog']['priorities'] as $p => $priority)
  {
    if ($p > 7) { continue; }
    $priorities[$p] = ucfirst($priority['name']);
  }
  $search[] = array('type'    => 'multiselect',
                    'name'    => '���ȼ�',
                    'id'      => 'priority',
                    'width'   => '160px',
                    'subtext' => TRUE,
                    'value'   => $vars['priority'],
                    'values'  => $priorities);
  //Program field
  //$programs[''] = '���г���';
  foreach (dbFetchRows('SELECT `program` FROM `syslog` WHERE `device_id` = ? GROUP BY `program` ORDER BY `program`', array($vars['device'])) as $data)
  {
    $program = ($data['program']) ? $data['program'] : '[[EMPTY]]';
    $programs[$program] = $program;
  }
  $search[] = array('type'    => 'multiselect',
                    'name'    => '����',
                    'id'      => 'program',
                    'width'   => '160px',
                    'value'   => $vars['program'],
                    'values'  => $programs);
  $search[] = array('type'    => 'newline',
                    'hr'      => TRUE);
  $search[] = array('type'    => 'datetime',
                    'id'      => 'timestamp',
                    'presets' => TRUE,
                    'min'     => $timestamp_min,
                    'max'     => $timestamp_max,
                    'from'    => $vars['timestamp_from'],
                    'to'      => $vars['timestamp_to']);

  print_search($search, 'ϵͳ��־');

  // Pagination
  $vars['pagination'] = TRUE;

  // Print syslog
  print_syslogs($vars);
} else {
  print_warning('<h4>δ�ҵ�ϵͳ��־����!</h4>
���豸û���κ���־����.
����ϵͳ��־�ػ�������Observium����ѡ�������Ƿ���ȷ, ���豸������Ϊ����ϵͳ��־��Observium, ��û�б�����ǽ��������Ϣ.

See <a href="'.OBSERVIUM_URL.'/wiki/Category:Documentation" target="_blank">�ĵ�</a> �� <a href="'.OBSERVIUM_URL.'/wiki/Configuration_Options#Syslog_Settings" target="_blank">����ѡ��</a> �˽������Ϣ.');
}

$pagetitle[] = 'ϵͳ��־';

// EOF
