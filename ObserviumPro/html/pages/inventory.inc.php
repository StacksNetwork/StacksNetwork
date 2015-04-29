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
unset($search, $devices_array, $parts);

$where = ' WHERE 1 ';
$where .= generate_query_permitted(array('device'), array('device_table' => 'E'));

// Select devices only with Inventory parts
foreach (dbFetchRows('SELECT E.`device_id` AS `device_id`, `hostname`, `entPhysicalModelName`
                     FROM `entPhysical` AS E
                     INNER JOIN `devices` AS D ON D.`device_id` = E.`device_id`' . $where .
                    'GROUP BY `device_id`, `entPhysicalModelName`;') as $data)
{
  $device_id = $data['device_id'];
  $devices_array[$device_id] = $data['hostname'];
  if ($data['entPhysicalModelName'] != '')
  {
    $parts[$data['entPhysicalModelName']] = $data['entPhysicalModelName'];
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
//Parts field
ksort($parts);
$search[] = array('type'    => 'multiselect',
                  'width'   => '160px',
                  'name'    => '部分',
                  'id'      => 'parts',
                  'value'   => $vars['parts'],
                  'values'  => $parts);
//Serial field
$search[] = array('type'    => 'text',
                  'width'   => '160px',
                  'name'    => '序列号',
                  'id'      => 'serial',
                  'value'   => $vars['serial']);
//Description field
$search[] = array('type'    => 'text',
                  'width'   => '160px',
                  'name'    => '说明',
                  'id'      => 'description',
                  'value'   => $vars['description']);

print_search($search, '清单', 'search', 'inventory/');

// Pagination
$vars['pagination'] = TRUE;

print_inventory($vars);

$page_title[] = '清单';

?>

  </div> <!-- col-md-12 -->
</div> <!-- row -->

<?php

// EOF
