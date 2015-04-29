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
                  'width'   => '160px',
                  'value'   => $vars['device_id'],
                  'values'  => $devices_array);
//Interface field
$search[] = array('type'    => 'select',
                  'name'    => '接口',
                  'id'      => 'interface',
                  'width'   => '160px',
                  'value'   => $vars['interface'],
                  'values'  => array('' => '所有接口', 'Loopback%' => 'Loopbacks', 'Vlan%' => 'Vlans'));
//MAC address field
$search[] = array('type'    => 'text',
                  'name'    => 'MAC地址',
                  'id'      => 'address',
                  'width'   => '160px',
                  'value'   => $vars['address']);

print_search($search, 'MAC地址', NULL, 'search/search=mac/');

// Pagination
$vars['pagination'] = TRUE;

// Print MAC addresses
print_mac_addresses($vars);

$page_title[] = 'MAC地址';

?>

  </div> <!-- col-md-12 -->

</div> <!-- row -->
