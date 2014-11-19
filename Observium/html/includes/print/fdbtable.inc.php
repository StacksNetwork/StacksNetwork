<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage web
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

/**
 * Display FDB table.
 *
 * @param array $vars
 * @return none
 *
 */
function print_fdbtable($vars)
{
  // With pagination? (display page numbers in header)
  $pagination = (isset($vars['pagination']) && $vars['pagination']);
  $pageno = (isset($vars['pageno']) && !empty($vars['pageno'])) ? $vars['pageno'] : 1;
  $pagesize = (isset($vars['pagesize']) && !empty($vars['pagesize'])) ? $vars['pagesize'] : 10;
  $start = $pagesize * $pageno - $pagesize;

  $param = array();
  $where = ' WHERE 1 ';
  foreach ($vars as $var => $value)
  {
    if ($value != '')
    {
      $cond = array();
      switch ($var)
      {
        case 'device':
        case 'device_id':
          $where .= ' AND I.`device_id` = ?';
          $param[] = $value;
          break;
        case 'port':
        case 'port_id':
          $where .= ' AND I.`port_id` = ?';
          $param[] = $value;
          break;
        case 'interface':
          $where .= ' AND I.`ifDescr` LIKE ?';
          $param[] = $value;
          break;
        case 'vlan_id':
          if (!is_array($value)) { $value = array($value); }
          foreach ($value as $v)
          {
            $cond[] = '?';
            $param[] = $v;
          }
          $where .= " AND F.`vlan_id` IN (";
          $where .= implode(', ', $cond);
          $where .= ')';
          break;
        case 'vlan_name':
          if (!is_array($value)) { $value = array($value); }
          foreach ($value as $v)
          {
            $cond[] = '?';
            $param[] = $v;
          }
          $where .= " AND V.`vlan_name` IN (";
          $where .= implode(', ', $cond);
          $where .= ')';
          break;
        case 'address':
          $where .= ' AND F.`mac_address` LIKE ?';
          $param[] = '%'.str_replace(array(':', ' ', '-', '.', '0x'),'',mres($value)).'%';
          break;
      }
    }
  }
  
  // Show FDB tables only for permitted ports
  $query_permitted = generate_query_permitted(array('port'), array('port_table' => 'I'));
  
  $query = 'FROM `vlans_fdb` AS F ';
  $query .= 'LEFT JOIN `vlans` as V ON V.`vlan_vlan` = F.`vlan_id` AND V.`device_id` = F.`device_id` ';
  $query .= 'LEFT JOIN `ports` AS I ON I.`port_id` = F.`port_id` ';
  $query .= $where . $query_permitted;
  $query_count = 'SELECT COUNT(*) ' . $query;
  $query =  'SELECT * ' . $query;
  $query .= ' ORDER BY F.`mac_address`';
  $query .= " LIMIT $start,$pagesize";

  // Query addresses
  $entries = dbFetchRows($query, $param);
  // Query address count
  if ($pagination) { $count = dbFetchCell($query_count, $param); }

  $list = array('device' => FALSE);
  if (!isset($vars['device']) || empty($vars['device']) || $vars['page'] == 'search') { $list['device'] = TRUE; }

  $string = '<table class="table table-bordered table-striped table-hover table-condensed">' . PHP_EOL;
  if (!$short)
  {
    $string .= '  <thead>' . PHP_EOL;
    $string .= '    <tr>' . PHP_EOL;
    $string .= '      <th>MAC Address</th>' . PHP_EOL;
    if ($list['device']) { $string .= '      <th>Device</th>' . PHP_EOL; }
    $string .= '      <th>Interface</th>' . PHP_EOL;
    $string .= '      <th>VLAN ID</th>' . PHP_EOL;
    $string .= '      <th>VLAN Name</th>' . PHP_EOL;
    $string .= '    </tr>' . PHP_EOL;
    $string .= '  </thead>' . PHP_EOL;
  }
  $string .= '  <tbody>' . PHP_EOL;

  foreach ($entries as $entry)
  {
    humanize_port($entry);
    
    $string .= '  <tr>' . PHP_EOL;
    $string .= '    <td width="160">' . formatMac($entry['mac_address']) . '</td>' . PHP_EOL;
    if ($list['device'])
    {
      $dev = device_by_id_cache($entry['device_id']);
      $string .= '    <td class="entity" nowrap>' . generate_device_link($dev) . '</td>' . PHP_EOL;
    }
    if ($entry['ifInErrors_delta'] > 0 || $entry['ifOutErrors_delta'] > 0)
    {
      $port_error = generate_port_link($entry, '<span class="label label-important">Errors</span>', 'port_errors');
    }
    $string .= '    <td class="entity">' . generate_port_link($entry, short_ifname($entry['label'])) . ' ' . $port_error . '</td>' . PHP_EOL;
    $string .= '    <td>Vlan' . $entry['vlan_vlan'] . '</td>' . PHP_EOL;
    $string .= '    <td>' . $entry['vlan_name'] . '</td>' . PHP_EOL;
    $string .= '  </tr>' . PHP_EOL;
  }

  $string .= '  </tbody>' . PHP_EOL;
  $string .= '</table>';

  // Print pagination header
  if ($pagination) { $string = pagination($vars, $count) . $string . pagination($vars, $count); }

  // Print FDB table
  echo $string;
}

// EOF
