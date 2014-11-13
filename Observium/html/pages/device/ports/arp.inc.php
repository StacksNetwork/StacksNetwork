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

unset($search, $devices);

//Search by field
$search[] = array('type'    => 'select',
                  'name'    => '搜索条件',
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
                  'value'   => $vars['address']);

print_search($search, 'ARP/NDP 搜索');

// Pagination
$vars['pagination'] = TRUE;
if(!$vars['pagesize']) { $vars['pagesize'] = 100; }
if(!$vars['pageno']) { $vars['pageno'] = 1; }

print_arptable($vars);

?>

  </div> <!-- col-md-12 -->

</div> <!-- row -->
<?php

// EOF
