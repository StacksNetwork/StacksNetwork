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
//  dbFetchCell("TRUNCATE TABLE `syslog`");
//  print_message('系统日志截断');
//}

unset($search, $devices_array, $priorities, $programs);

$where = ' WHERE 1 ';
$where .= generate_query_permitted();

//Device field
// Show devices only with syslog messages
foreach (dbFetchRows('SELECT `device_id` FROM `syslog`' . $where .
                     'GROUP BY `device_id`') as $data)
{
  $device_id = $data['device_id'];
  if ($cache['devices']['id'][$device_id]['hostname'])
  {
    $devices_array[$device_id] = $cache['devices']['id'][$device_id]['hostname'];
  }
}
natcasesort($devices_array);
$search[] = array('type'    => 'select',
                  'name'    => 'Devices',
                  'id'      => 'device_id',
                  'width'   => '150px',
                  'value'   => $vars['device_id'],
                  'values'  => $devices_array);
if (is_numeric($vars['device_id'])) { $where .= ' AND `device_id` = ' . $vars['device_id'] . ' '; } // Add device_id limit for other fields

//Message field
$search[] = array('type'    => 'text',
                  'name'    => 'Message',
                  'id'      => 'message',
                  'width'   => '130px',
                  'value'   => $vars['message']);
//Priority field
//$priorities[''] = '所有优先级';
foreach ($config['syslog']['priorities'] as $p => $priority)
{
  if ($p > 7) { continue; }
  $priorities[$p] = ucfirst($priority['name']);
}
$search[] = array('type'    => 'multiselect',
                  'name'    => 'Priorities',
                  'id'      => 'priority',
                  'width'   => '150px',
                  'subtext' => TRUE,
                  'value'   => $vars['priority'],
                  'values'  => $priorities);
//Program field
//$programs[''] = '所有程序';
foreach (dbFetchRows('SELECT `program` FROM `syslog`' . $where .
                     'GROUP BY `program` ORDER BY `program`') as $data)
{
  $program = ($data['program'] != '' ? $data['program'] : '[[EMPTY]]');
  $programs[$program] = $program;
}
$search[] = array('type'    => 'multiselect',
                  'name'    => 'Programs',
                  'id'      => 'program',
                  'width'   => '150px',
                  'size'    => '15',
                  'value'   => $vars['program'],
                  'values'  => $programs);
$search[] = array('type'    => 'newline');
$search[] = array('type'    => 'datetime',
                  'id'      => 'timestamp',
                  'presets' => TRUE,
                  'min'     => dbFetchCell('SELECT MIN(`timestamp`) FROM `syslog`' . $where),
                  'max'     => dbFetchCell('SELECT MAX(`timestamp`) FROM `syslog`' . $where),
                  'from'    => $vars['timestamp_from'],
                  'to'      => $vars['timestamp_to']);

print_search($search, '系统日志');

// Pagination
$vars['pagination'] = TRUE;
if(!$vars['pagesize']) { $vars['pagesize'] = 100; }
if(!$vars['pageno']) { $vars['pageno'] = 1; }

// Print syslog
print_syslogs($vars);

$pagetitle[] = '系统日志';

?>
  </div> <!-- col-md-12 -->

</div> <!-- row -->
<?php

// EOF
