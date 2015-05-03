<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage poller
 * @copyright  (C) 2006-2015 Adam Armstrong
 *
 */

if (!isset($cache_storage)) { $cache_storage = array(); } // This cache used also in mempool module

$sql  = "SELECT `storage`.*, `storage-state`.storage_polled";
$sql .= " FROM  `storage`";
$sql .= " LEFT JOIN `storage-state` ON `storage`.storage_id = `storage-state`.storage_id";
$sql .= " WHERE `device_id` = ?";

foreach (dbFetchRows($sql, array($device['device_id'])) as $storage)
{
  $storage_rrd  = "storage-" . $storage['storage_mib'] . "-" . $storage['storage_descr'] . ".rrd";
  $storage_size = $storage['storage_size']; // Memo old size

  rrdtool_create($device, $storage_rrd, " DS:used:GAUGE:600:0:U DS:free:GAUGE:600:0:U ");

  $file = $config['install_dir']."/includes/polling/storage/".$storage['storage_mib'].".inc.php";
  if (is_file($file))
  {
    include($file);
  } else {
    continue;
  }

  if (OBS_DEBUG && count($storage)) { print_vars($storage); }

  if ($storage['size'])
  {
    $percent = round($storage['used'] / $storage['size'] * 100, 2);
  } else {
    $percent = 0;
  }

  $hc = ($storage['storage_hc'] ? ' (HC)' : '');

  print_message("存储 ". $storage['storage_descr'] . ': '.$percent.'%%'.$hc);

  // Update StatsD/Carbon
  if ($config['statsd']['enable'] == TRUE)
  {
    StatsD::gauge(str_replace(".", "_", $device['hostname']).'.'.'storage'.'.' .$storage['storage_mib'] . "-" . safename($storage['storage_descr']).".used", $storage['used']);
    StatsD::gauge(str_replace(".", "_", $device['hostname']).'.'.'storage'.'.' .$storage['storage_mib'] . "-" . safename($storage['storage_descr']).".free", $storage['free']);
  }

  // Update RRD
  rrdtool_update($device, $storage_rrd,"N:".$storage['used'].":".$storage['free']);

  if (!is_numeric($storage['storage_polled']))
  {
    dbInsert(array('storage_id'     => $storage['storage_id'],
                   'storage_polled' => time(),
                   'storage_used'   => $storage['used'],
                   'storage_free'   => $storage['free'],
                   'storage_size'   => $storage['size'],
                   'storage_units'  => $storage['units'],
                   'storage_perc'   => $percent), 'storage-state');
  } else {
    $update = dbUpdate(array('storage_polled' => time(),
                             'storage_used'   => $storage['used'],
                             'storage_free'   => $storage['free'],
                             'storage_size'   => $storage['size'],
                             'storage_units'  => $storage['units'],
                             'storage_perc'   => $percent), 'storage-state', '`storage_id` = ?', array($storage['storage_id']));
    if ($storage_size != $storage['storage_size'])
    {
      log_event('存储容量变更: '.formatStorage($storage_size).' -> '.formatStorage($storage['storage_size']).' ('.$storage['storage_descr'].')', $device, 'storage', $storage['storage_id']);
    }
  }
  $graphs['storage'] = TRUE;

  // Check alerts
  check_entity('storage', $storage, array('storage_perc' => $percent, 'storage_free' => $storage['free'], 'storage_used' => $storage['used']));

  echo(PHP_EOL);
}

unset($storage);

// EOF
