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

?>
<div class="row">
<div class="col-md-12">

<?php

///FIXME. Mike: should be more checks, at least a confirmation click.
//if ($vars['action'] == "expunge" && $_SESSION['userlevel'] >= '10')
//{
//  dbFetchCell('TRUNCATE TABLE `eventlog`');
//  print_message('Event log truncated');
//}

unset($search, $devices_array, $types);

$where = ' WHERE 1 ' . generate_query_permitted();

//Device field
foreach ($cache['devices']['hostname'] as $hostname => $device_id)
{
  if ($cache['devices']['id'][$device_id]['disabled'] && !$config['web_show_disabled']) { continue; }
  $devices_array[$device_id] = $hostname;
}
$search[] = array('type'    => 'multiselect',
                  'name'    => '设备',
                  'id'      => 'device_id',
                  'width'   => '125px',
                  'value'   => $vars['device_id'],
                  'values'  => $devices_array);

// Add device_id limit for other fields
if (isset($vars['device_id']))
{
  $where .= generate_query_values($vars['device_id'], 'device_id');
}

//Message field
$search[] = array('type'    => 'text',
                  'name'    => '信息',
                  'id'      => 'message',
                  'width'   => '150px',
                  'placeholder' => 'Message',
                  'value'   => $vars['message']);

//Severity field
foreach (dbFetchColumn('SELECT DISTINCT `severity` FROM `eventlog`' . $where) as $severity)
{
  $severities[$severity] = ucfirst($config['syslog']['priorities'][$severity]['name']);
}
krsort($severities);
$search[] = array('type'    => 'multiselect',
                  'name'    => '严重程度',
                  'id'      => 'severity',
                  'width'   => '110px',
                  'subtext' => TRUE,
                  'value'   => $vars['severity'],
                  'values'  => $severities);

//Types field
$types['device'] = '设备';
foreach (dbFetchColumn('SELECT DISTINCT `entity_type` FROM `eventlog` IGNORE INDEX (`type`)' . // Use index 'type_device' for speedup
                       $where) as $type)
{
  //$type = $data['type'];
  $types[$type] = ucfirst($type);
}
$search[] = array('type'    => 'multiselect',
                  'name'    => '类型',
                  'id'      => 'type',
                  'width'   => '100px',
                  'value'   => $vars['type'],
                  'values'  => $types);

// Newline
//$search[] = array('type'    => 'newline',
//                  'hr'      => TRUE);

// Datetime field
$search[] = array('type'    => 'datetime',
                  'id'      => 'timestamp',
                  'presets' => TRUE,
                  'min'     => dbFetchCell('SELECT `timestamp` FROM `eventlog`' . $where . ' ORDER BY `timestamp` LIMIT 0,1;'),
                  'max'     => dbFetchCell('SELECT `timestamp` FROM `eventlog`' . $where . ' ORDER BY `timestamp` DESC LIMIT 0,1;'),
                  'from'    => $vars['timestamp_from'],
                  'to'      => $vars['timestamp_to']);

print_search($search, '事件日志', 'search', 'eventlog/');

// Pagination
$vars['pagination'] = TRUE;

// Print events
print_events($vars);

$page_title[] = '事件日志';

?>

  </div> <!-- col-md-12 -->

</div> <!-- row -->

<?php

// EOF
