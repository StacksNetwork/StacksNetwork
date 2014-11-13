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

if (!isset($vars['section'])) { $vars['section'] = 'eventlog'; }

$sections = array('eventlog', 'syslog');

$navbar['brand'] = "日志";
$navbar['class'] = "navbar-narrow";

foreach ($sections as $section)
{
  $type = strtolower($section);
  if (!isset($vars['section'])) { $vars['section'] = $section; }

  if ($vars['section'] == $section) { $navbar['options'][$section]['class'] = "active"; }
  $navbar['options'][$section]['url'] = generate_url(array('page' => 'device', 'device' => $device['device_id'], 'tab' => 'logs',  'section' => $section));
  $navbar['options'][$section]['text'] = nicecase($section);
}

print_navbar($navbar);

switch ($vars['section'])
{
  case 'syslog':
  case 'eventlog':
    include('pages/device/logs/'.$vars['section'].'.inc.php');
    break;
  default:
    echo('<h2>错误. 没有任何部分 '.$vars['section'].'.<br /> 请报告此错误至Observium开发人员.</h2>');
    break;
}

// EOF
