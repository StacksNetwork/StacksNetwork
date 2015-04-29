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
//  print_message('Syslog truncated');
//}

unset($search, $devices_array, $priorities, $programs);

$where = ' WHERE 1 ' . generate_query_permitted();

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
                  'placeholder' => 'Message',
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
                  'name'    => '优先级',
                  'id'      => 'priority',
                  'width'   => '125px',
                  'subtext' => TRUE,
                  'value'   => $vars['priority'],
                  'values'  => $priorities);
//Program field
//$programs[''] = '所有程序';
foreach (dbFetchColumn('SELECT `program` FROM `syslog` IGNORE INDEX (`program`)' . // Use index 'program_device' for speedup
                       $where . 'GROUP BY `program`;') as $program)
{
  $program = ($program != '' ? $program : OBS_VAR_UNSET);
  $programs[$program] = $program;
}
$search[] = array('type'    => 'multiselect',
                  'name'    => '程序',
                  'id'      => 'program',
                  'width'   => '125px',
                  'size'    => '15',
                  'value'   => $vars['program'],
                  'values'  => $programs);

//$search[] = array('type'    => 'newline',
//                  'hr'      => TRUE);

$search[] = array('type'    => 'datetime',
                  'id'      => 'timestamp',
                  'presets' => TRUE,
                  'min'     => dbFetchCell('SELECT `timestamp` FROM `syslog`' . $where . ' ORDER BY `timestamp` LIMIT 0,1;'),
                  'max'     => dbFetchCell('SELECT `timestamp` FROM `syslog`' . $where . ' ORDER BY `timestamp` DESC LIMIT 0,1;'),
                  'from'    => $vars['timestamp_from'],
                  'to'      => $vars['timestamp_to']);

print_search($search, '系统日志', 'search', 'syslog/');

// Pagination
$vars['pagination'] = TRUE;

// Print syslog
print_syslogs($vars);

$page_title[] = '系统日志';

?>
  </div> <!-- col-md-12 -->

</div> <!-- row -->
<?php

// EOF
