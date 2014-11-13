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
if (is_numeric($vars['device_id'])) { $where .= ' AND `device_id` = ' . $vars['device_id']; }
$where .= generate_query_permitted();

//Device field
foreach ($cache['devices']['hostname'] as $hostname => $device_id)
{
  if ($cache['devices']['id'][$device_id]['disabled'] && !$config['web_show_disabled']) { continue; }
  $devices_array[$device_id] = $hostname;
}
$search[] = array('type'    => 'select',
                  'name'    => 'Devices',
                  'id'      => 'device_id',
                  'width'   => '160px',
                  'value'   => $vars['device_id'],
                  'values'  => $devices_array);

//Message field
$search[] = array('type'    => 'text',
                  'name'    => 'Message',
                  'id'      => 'message',
                  'value'   => $vars['message']);

//Types field
$types['system'] = 'System';
foreach (dbFetchRows('SELECT `type` FROM `eventlog` ' . $where . ' GROUP BY `type` ORDER BY `type`') as $data)
{
  $type = $data['type'];
  $types[$type] = ucfirst($type);
}
$search[] = array('type'    => 'multiselect',
                  'name'    => 'Types',
                  'id'      => 'type',
                  'width'   => '160px',
                  'value'   => $vars['type'],
                  'values'  => $types);

// Newline
$search[] = array('type'    => 'newline');

// Datetime field
$search[] = array('type'    => 'datetime',
                  'id'      => 'timestamp',
                  'presets' => TRUE,
                  'min'     => dbFetchCell('SELECT MIN(`timestamp`) FROM `eventlog` '. $where),
                  'max'     => dbFetchCell('SELECT MAX(`timestamp`) FROM `eventlog` '. $where),
                  'from'    => $vars['timestamp_from'],
                  'to'      => $vars['timestamp_to']);

print_search($search, '事件日志');

// Pagination
$vars['pagination'] = TRUE;
if(!$vars['pagesize']) { $vars['pagesize'] = "100"; }
if(!$vars['pageno']) { $vars['pageno'] = "1"; }

// Print events
print_events($vars);

$pagetitle[] = 'Eventlog';

?>

  </div> <!-- col-md-12 -->

</div> <!-- row -->

<?php

// EOF
