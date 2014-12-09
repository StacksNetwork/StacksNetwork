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

// Alert test display and editing page.

include($config['html_dir']."/includes/alerting-navbar.inc.php");

?>

<div class="row">
<div class="col-md-12">

<?php

unset($search, $devices_array, $priorities, $programs);

$where = ' WHERE 1 ';
$where .= generate_query_permitted();

//Device field
// Show devices only with syslog messages
foreach (dbFetchRows('SELECT `device_id` FROM `alert_log`' . $where .
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
                  'width'   => '150px',
                  'value'   => $vars['device_id'],
                  'values'  => $devices_array);

// Add device_id limit for other fields
if (isset($vars['device_id']))
{
  $where .= generate_query_values($vars['device_id'], 'device_id');
}

// Check Field
foreach (dbFetchRows('SELECT `alert_test_id` FROM `alert_log`' . $where .
                     'GROUP BY `alert_test_id`') as $data)
{
  $alert_test_id = $data['alert_test_id'];
  if (is_array($alert_rules[$alert_test_id]))
  {
    $alert_test_array[$alert_test_id] = $alert_rules[$alert_test_id]['alert_name'];
  }
}

natcasesort($alert_test_array);
$search[] = array('type'    => 'multiselect',
                  'name'    => '检测器',
                  'id'      => 'alert_test_id',
                  'width'   => '150px',
                  'value'   => $vars['alert_test_id'],
                  'values'  => $alert_test_array);

#ALERT_NOTIFY,FAIL,FAIL_DELAYED,FAIL_SUPPRESSED,OK,RECOVER_NOTIFY,RECOVER_SUPPRESSED

// Status Field
foreach (array('ALERT_NOTIFY','FAIL','FAIL_DELAYED','FAIL_SUPPRESSED','OK','RECOVER_NOTIFY') AS $status_type)
{
  $status_types[$status_type] = $status_type;
}
$search[] = array('type'    => 'multiselect',
                  'name'    => '状态类型',
                  'id'      => 'log_type',
                  'width'   => '150px',
//                  'subtext' => TRUE,
                  'value'   => $vars['log_type'],
                  'values'  => $status_types);

//Message field
#$search[] = array('type'    => 'text',
#                  'name'    => '信息',
#                  'id'      => 'message',
#                  'width'   => '130px',
#                  'value'   => $vars['message']);

print_search($search, '警报日志', 'search', 'alert_log/');

// Pagination
$vars['pagination'] = TRUE;

// Print Alert Log
print_alert_log($vars);

$pagetitle[] = '警报日志';

?>
  </div> <!-- col-md-12 -->

</div> <!-- row -->
<?php

// EOF
