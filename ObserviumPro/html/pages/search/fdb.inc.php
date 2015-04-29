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
unset($search, $devices_array, $vlans, $vlan_names);

$where = ' WHERE 1 ';
$where .= generate_query_permitted(array('device'), array('device_table' => 'F'));

// Select devices and vlans only with FDB tables
foreach (dbFetchRows('SELECT F.`device_id`, `vlan_vlan`, `vlan_name` FROM `vlans_fdb` AS F
                     LEFT JOIN `vlans` as V ON V.`vlan_vlan` = F.`vlan_id` AND V.`device_id` = F.`device_id`' .
                     $where . 'GROUP BY `device_id`, `vlan_vlan`;') as $data)
{
  $device_id = $data['device_id'];
  if ($cache['devices']['id'][$device_id]['hostname'])
  {
    $devices_array[$device_id] = $cache['devices']['id'][$device_id]['hostname'];
    if (is_numeric($data['vlan_vlan']))
    {
      $vlans[$data['vlan_vlan']] = 'Vlan' . $data['vlan_vlan'];
      $vlan_names[$data['vlan_name']] = $data['vlan_name'];
    }
  }
}
//Device field
natcasesort($devices_array);
$search[] = array('type'    => 'multiselect',
                  'width'   => '160px',
                  'name'    => '设备',
                  'id'      => 'device_id',
                  'value'   => $vars['device_id'],
                  'values'  => $devices_array);
//Vlans field
ksort($vlans);
$search[] = array('type'    => 'multiselect',
                  'name'    => 'VLANs',
                  'id'      => 'vlan_id',
                  'value'   => $vars['vlan_id'],
                  'values'  => $vlans);
//Vlan names field
natcasesort($vlan_names);
$search[] = array('type'    => 'multiselect',
                  'width'   => '160px',
                  'name'    => 'VLAN名称',
                  'id'      => 'vlan_name',
                  'value'   => $vars['vlan_name'],
                  'values'  => $vlan_names);
//MAC address field
$search[] = array('type'    => 'text',
                  'name'    => 'MAC地址',
                  'id'      => 'address',
                  'value'   => $vars['address']);

print_search($search, "FDB表", NULL, 'search/search=fdb/');

// Pagination
$vars['pagination'] = TRUE;

print_fdbtable($vars);

$page_title[] = "FDB搜索";

?>

  </div> <!-- col-md-12 -->
</div> <!-- row -->
