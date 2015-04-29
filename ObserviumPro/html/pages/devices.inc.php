<?php

/**
 * Observium Network Management and Monitoring System
 * Copyright (C) 2006-2014, Adam Armstrong - http://www.observium.org
 *
 * @package    observium
 * @subpackage webui
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2015 Adam Armstrong
 *
 */

// Set Defaults here

if (!isset($vars['format'])) { $vars['format'] = "detail"; }
if (!$config['web_show_disabled'] && !isset($vars['disabled'])) { $vars['disabled'] = '0'; }
if ($vars['format'] != 'graphs')
{
  // reset all from/to vars if not use graphs
  unset($vars['from'], $vars['to'], $vars['timestamp_from'], $vars['timestamp_to'], $vars['graph']);
}

$query_permitted = generate_query_permitted(array('device'), array('device_table' => 'devices'));

$where_array = build_devices_where_array($vars);

$where = ' WHERE 1 ';
$where .= implode('', $where_array);

$page_title[] = "设备";

if ($vars['searchbar'] != "hide")
{
  // Generate array with form elements
  $search_items = array();
  foreach (array('os', 'hardware', 'version', 'features', 'type') as $entry)
  {
    $query  = "SELECT `$entry` FROM `devices`";
    if (isset($where_array[$entry]))
    {
      $tmp = $where_array[$entry];
      unset($where_array[$entry]);
      $query .= ' WHERE 1 ' . implode('', $where_array);
      $where_array[$entry] = $tmp;
    } else {
      $query .= $where;
    }
    $query .= " AND `$entry` != '' $query_permitted GROUP BY `$entry` ORDER BY `$entry`";
    foreach (dbFetchColumn($query) as $item)
    {
      if ($entry == 'os')
      {
        $name = $config['os'][$item]['text'];
      } else {
        $name = nicecase($item);
      }
      $search_items[$entry][$item] = $name;
    }
  }

  foreach (get_locations() as $entry)
  {
    if ($entry === '') { $entry = OBS_VAR_UNSET; }
    $search_items['location'][$entry] = $entry;
  }

  foreach (get_type_groups('device') as $entry)
  {
    $search_items['group'][$entry['group_id']] = $entry['group_name'];
  }

  $search_items['sort'] = array('hostname' => '主机名',
                                'location' => '位置',
                                'os'       => '操作系统',
                                'uptime'   => '运行时间');

  $form = array('type'  => 'rows',
                'space' => '10px',
                //'brand' => NULL,
                //'class' => 'well',
                //'hr'    => FALSE,
                'url'   => generate_url($vars));
  // First row
  $form['row'][0]['hostname'] = array(
                                  'type'        => 'text',
                                  'name'        => '主机名',
                                  'value'       => $vars['hostname'],
                                  'width'       => '180px',
                                  'placeholder' => TRUE);
  $form['row'][0]['location'] = array(
                                  'type'        => 'multiselect',
                                  'name'        => '选择位置',
                                  'width'       => '180px',
                                  'encode'      => TRUE,
                                  'value'       => $vars['location'],
                                  'values'      => $search_items['location']);
  $form['row'][0]['os']       = array(
                                  'type'        => 'multiselect',
                                  'name'        => '选择OS',
                                  'width'       => '180px',
                                  'value'       => $vars['os'],
                                  'values'      => $search_items['os']);
  $form['row'][0]['hardware'] = array(
                                  'type'        => 'multiselect',
                                  'name'        => '选择硬件',
                                  'width'       => '180px',
                                  'value'       => $vars['hardware'],
                                  'values'      => $search_items['hardware']);
  $form['row'][0]['group']    = array(
                                  'type'        => 'multiselect',
                                  'name'        => '选择分组',
                                  'width'       => '180px',
                                  'value'       => $vars['group'],
                                  'values'      => $search_items['group']);
  // Select sort pull-rigth
  $form['row'][0]['sort']     = array(
                                  'type'        => 'select',
                                  'icon'        => 'oicon-sort-alphabet-column',
                                  'right'       => TRUE,
                                  'width'       => '150px',
                                  'value'       => $vars['sort'],
                                  'values'      => $search_items['sort']);

  // Second row
  $form['row'][1]['sysname']  = array(
                                  'type'        => 'text',
                                  'name'        => '系统名称',
                                  'value'       => $vars['sysname'],
                                  'width'       => '180px',
                                  'placeholder' => TRUE);
  $form['row'][1]['location_text'] = array(
                                  'type'        => 'text',
                                  'name'        => '位置',
                                  'value'       => $vars['location_text'],
                                  'width'       => '180px',
                                  'placeholder' => TRUE);
  $form['row'][1]['version']  = array(
                                  'type'        => 'multiselect',
                                  'name'        => '选择OS版本',
                                  'width'       => '180px',
                                  'value'       => $vars['version'],
                                  'values'      => $search_items['version']);
  $form['row'][1]['features'] = array(
                                  'type'        => 'multiselect',
                                  'name'        => '选择功能',
                                  'width'       => '180px',
                                  'value'       => $vars['features'],
                                  'values'      => $search_items['features']);
  $form['row'][1]['type']     = array(
                                  'type'        => 'multiselect',
                                  'name'        => '选择设备类型',
                                  'width'       => '180px',
                                  'value'       => $vars['type'],
                                  'values'      => $search_items['type']);
  // search button
  $form['row'][1]['search']   = array(
                                  'type'        => 'submit',
                                  //'name'        => '搜素',
                                  //'icon'        => 'icon-search',
                                  'right'       => TRUE,
                                  );

  print_form($form);

  unset($form, $search_items);
}

// Build Devices navbar

$navbar = array('brand' => "设备", 'class' => "navbar-narrow");

$navbar['options']['basic']['text']  = '基本';
$navbar['options']['detail']['text'] = '详情';
$navbar['options']['status']['text'] = '状态';
$navbar['options']['graphs']['text'] = '图像';

foreach ($navbar['options'] as $option => $array)
{
  //if (!isset($vars['format'])) { $vars['format'] = 'basic'; }
  if ($vars['format'] == $option) { $navbar['options'][$option]['class'] .= " active"; }
  $navbar['options'][$option]['url'] = generate_url($vars, array('format' => $option));
}

// Set graph period stuff
if ($vars['format'] == 'graphs')
{
  $timestamp_pattern = '/^(\d{4})-(\d{2})-(\d{2}) ([01][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$/';
  if (isset($vars['timestamp_from']) && preg_match($timestamp_pattern, $vars['timestamp_from']))
  {
    $vars['from'] = strtotime($vars['timestamp_from']);
    unset($vars['timestamp_from']);
  }
  if (isset($vars['timestamp_to'])   && preg_match($timestamp_pattern, $vars['timestamp_to']))
  {
    $vars['to'] = strtotime($vars['timestamp_to']);
    unset($vars['timestamp_to']);
  }

  if (!is_numeric($vars['from'])) { $vars['from'] = $config['time']['day']; }
  if (!is_numeric($vars['to']))   { $vars['to']   = $config['time']['now']; }
}

// Print options related to graphs.
//$menu_options = array('bits'      => 'Bits',
//                      'processor' => 'CPU',
//                      'mempool'   => '内存',
//                      'uptime'    => '运行时间',
//                      'storage'   => '存储',
//                      'diskio'    => '磁盘I/O',
//                      'poller_perf' => '轮询时间'
//                      );
foreach (array('graphs') as $type)
{
  /// FIXME. Weird graph menu, they too long and not actual for all devices,
  /// but here also not posible use sql query from `device_graphs` because here not stored all graphs
  /*
  $query  = 'SELECT `graph` FROM `device_graphs`
             LEFT JOIN `devices` ON `devices`.`device_id` = `device_graphs`.`device_id`';
  $query .= $where . $query_permitted . ' AND `device_graphs`.`enabled` = 1 GROUP BY `graph`';
  foreach (dbFetchColumn($query) as $option)
  {
    $data = $config['graph_types']['device'][$option];
  */
  foreach ($config['graph_types']['device'] as $option => $data)
  {
    if (!isset($data['descr'])) { $data['descr'] = nicecase($option);}

    if ($vars['format'] == $type && $vars['graph'] == $option)
    {
      $navbar['options'][$type]['suboptions'][$option]['class'] = 'active';
      $navbar['options'][$type]['text'] .= " (".$data['descr'].')';
    }
    $navbar['options'][$type]['suboptions'][$option]['text'] = $data['descr'];
    $navbar['options'][$type]['suboptions'][$option]['url'] = generate_url($vars, array('view' => NULL, 'format' => $type, 'graph' => $option));
  }
}

  if ($vars['searchbar'] == "hide")
  {
    $navbar['options_right']['searchbar']     = array('text' => '显示搜索栏', 'url' => generate_url($vars, array('searchbar' => NULL)));
  } else {
    $navbar['options_right']['searchbar']     = array('text' => '隐藏搜索栏' , 'url' => generate_url($vars, array('searchbar' => 'hide')));
  }

  if ($vars['bare'] == "yes")
  {
    $navbar['options_right']['header']     = array('text' => '显示头部', 'url' => generate_url($vars, array('bare' => NULL)));
  } else {
    $navbar['options_right']['header']     = array('text' => '隐藏头部', 'url' => generate_url($vars, array('bare' => 'yes')));
  }

  $navbar['options_right']['reset']        = array('text' => '重置', 'url' => generate_url(array('page' => 'devices', 'section' => $vars['section'], 'bare' => $vars['bare'])));

print_navbar($navbar);
unset($navbar);

// Print period options for graphs

if ($vars['format'] == 'graphs')
{
  $search = array();
  $search[] = array('type'    => 'datetime',
                    'id'      => 'timestamp',
                    'presets' => TRUE,
                    'min'     => '2007-04-03 16:06:59',  // Hehe, who will guess what this date/time means? --mike
                                                         // First commit! Though Observium was already 7 months old by that point. --adama
                    'max'     => date('Y-m-d 23:59:59'), // Today
                    'from'    => date('Y-m-d H:i:s', $vars['from']),
                    'to'      => date('Y-m-d H:i:s', $vars['to']));

  print_search($search, NULL, 'update'); //Do not use url here, because it discards all other vars from url
  unset($search);
}

switch ($vars['sort'])
{
  case 'uptime':
  case 'location':
  case 'os':
    $order = ' ORDER BY `'.$vars['sort'].'`';
  default:
    $order = ' ORDER BY `hostname`';
    break;
}

$query = "SELECT * FROM `devices` ";
if ($config['geocoding']['enable'])
{
  $query .= " LEFT JOIN `devices_locations` USING (`device_id`) ";
}
$query .= $where . $query_permitted . $order;

list($format, $subformat) = explode("_", $vars['format'], 2);

$devices = dbFetchRows($query);

if (count($devices))
{
  $include_file = $config['html_dir'].'/pages/devices/'.$format.'.inc.php';
  if (is_file($include_file))
  {
    include($include_file);
  } else {
    print_error("<h4>错误</h4>
                 这是不应该发生的. 请确保您使用的是最新的发布版本，如果继续下去, 请向Observium开发团队汇报.");
  }
} else {
  print_error("<h4>未发现设备</h4>
               请尝试修改您的搜索参数.");
}

// EOF
