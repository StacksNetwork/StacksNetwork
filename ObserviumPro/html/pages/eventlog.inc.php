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

$where = ' WHERE 1 ';
$where .= generate_query_permitted();

//Device field
foreach ($cache['devices']['hostname'] as $hostname => $device_id)
{
  if ($cache['devices']['id'][$device_id]['disabled'] && !$config['web_show_disabled']) { continue; }
  $devices_array[$device_id] = $hostname;
}
$search[] = array('type'    => 'multiselect',
                  'name'    => '设备',
                  'id'      => 'device_id',
                  'width'   => '160px',
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
                  'value'   => $vars['message']);

//Types field
$types['system'] = '系统';
foreach (dbFetchRows('SELECT `type` FROM `eventlog` ' . $where . ' GROUP BY `type` ORDER BY `type`') as $data)
{
  $type = $data['type'];
  $types[$type] = ucfirst($type);
}
$search[] = array('type'    => 'multiselect',
                  'name'    => '类型',
                  'id'      => 'type',
                  'width'   => '160px',
                  'value'   => $vars['type'],
                  'values'  => $types);

// Newline
$search[] = array('type'    => 'newline',
                  'hr'      => TRUE);

// Datetime field
$search[] = array('type'    => 'datetime',
                  'id'      => 'timestamp',
                  'presets' => TRUE,
                  'min'     => dbFetchCell('SELECT MIN(`timestamp`) FROM `eventlog` '. $where),
                  'max'     => dbFetchCell('SELECT MAX(`timestamp`) FROM `eventlog` '. $where),
                  'from'    => $vars['timestamp_from'],
                  'to'      => $vars['timestamp_to']);

print_search($search, '事件日志', 'search', 'eventlog/');

// Pagination
$vars['pagination'] = TRUE;

// Print events
print_events($vars);

$pagetitle[] = '事件日志';

?>

  </div> <!-- col-md-12 -->

</div> <!-- row -->

<?php

// EOF
