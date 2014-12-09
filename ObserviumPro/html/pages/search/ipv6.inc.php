<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage webui
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

?>
<div class="row">
<div class="col-md-12">

<?php
unset($search, $devices_array);

//$devices_array[''] = '所有设备';
foreach ($cache['devices']['hostname'] as $hostname => $device_id)
{
  if ($cache['devices']['id'][$device_id]['disabled'] && !$config['web_show_disabled']) { continue; }
  $devices_array[$device_id] = $hostname;
}
//Device field
$search[] = array('type'    => 'multiselect',
                  'name'    => '设备',
                  'id'      => 'device_id',
                  'value'   => $vars['device_id'],
                  'values'  => $devices_array);
//Interface field
$search[] = array('type'    => 'select',
                  'name'    => '接口',
                  'id'      => 'interface',
                  'width'   => '130px',
                  'value'   => $vars['interface'],
                  'values'  => array('' => '所有接口', 'Lo' => 'Loopbacks', 'Vlan' => 'Vlans'));
////IP version field
//$search[] = array('type'    => 'select',
//                  'name'    => 'IP',
//                  'id'      => 'ip_version',
//                  'width'   => '120px',
//                  'value'   => $vars['ip_version'],
//                  'values'  => array('' => 'IPv4 & IPv6', '4' => '仅IPv4', '6' => '仅IPv6'));
//IP address field
$search[] = array('type'    => 'text',
                  'name'    => 'IP地址',
                  'id'      => 'address',
                  'value'   => $vars['address']);

print_search($search, 'IPv6', NULL, 'search/search=ipv6/');

// Pagination
$vars['pagination'] = TRUE;

// Print addresses
print_addresses($vars);

$pagetitle[] = "IPv6地址搜索";

?>

  </div> <!-- col-md-12 -->

</div> <!-- row -->
