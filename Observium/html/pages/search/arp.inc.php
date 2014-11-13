<div class="row">
<div class="col-md-12">

<?php
unset($search, $devices_array);

$where = ' WHERE 1 ';
$where .= generate_query_permitted(array('port'), array('port_table' => 'M'));

//$devices_array[''] = '所有设备';
// Select the devices only with ARP/NDP tables
foreach (dbFetchRows('SELECT `device_id` FROM `ip_mac` AS M
                     LEFT JOIN `ports` AS I ON I.`port_id` = M.`port_id`' .
                     $where . 'GROUP BY `device_id`;') as $data)
{
  $device_id = $data['device_id'];
  if ($cache['devices']['id'][$device_id]['hostname'])
  {
    $devices_array[$device_id] = $cache['devices']['id'][$device_id]['hostname'];
  }
}
natcasesort($devices_array);
//Device field
$search[] = array('type'    => 'select',
                  'name'    => '设备',
                  'id'      => 'device_id',
                  'width'   => '130px',
                  'value'   => $vars['device_id'],
                  'values'  => $devices_array);
//Search by field
$search[] = array('type'    => 'select',
                  'name'    => '搜索方式',
                  'id'      => 'searchby',
                  'width'   => '120px',
                  'value'   => $vars['searchby'],
                  'values'  => array('mac' => 'MAC地址', 'ip' => 'IP地址'));
//IP version field
$search[] = array('type'    => 'select',
                  'name'    => 'IP',
                  'id'      => 'ip_version',
                  'width'   => '120px',
                  'value'   => $vars['ip_version'],
                  'values'  => array('' => 'IPv4 & IPv6', '4' => '仅IPv4', '6' => '仅IPv6'));
//Address field
$search[] = array('type'    => 'text',
                  'name'    => '地址',
                  'id'      => 'address',
                  'width'   => '120px',
                  'value'   => $vars['address']);

print_search($search, 'ARP/NDP');

// Pagination
$vars['pagination'] = TRUE;
if(!$vars['pagesize']) { $vars['pagesize'] = 100; }
if(!$vars['pageno']) { $vars['pageno'] = 1; }

print_arptable($vars);

$pagetitle[] = 'ARP/NDP 搜索';

?>

  </div> <!-- col-md-12 -->
</div> <!-- row -->