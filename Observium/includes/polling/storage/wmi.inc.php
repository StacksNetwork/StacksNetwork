<?php

set_dev_attrib($device, 'poll_storage', 0);

echo(" Storage WMI: ");
foreach ($wmi['disk']['logical'] as $disk)
{
  echo(".");

  $storage_name = $disk['DeviceID'] . "\\ Label:" . $disk['VolumeName'] . "  Serial Number " . strtolower($disk['VolumeSerialNumber']);
  $storage_id = dbFetchCell("SELECT `storage_id` FROM `storage` WHERE `storage_descr`= ?", array($storage_name));
  $rrd_filename = $GLOBALS['config']['rrd_dir'] . "/" . $device['hostname'] . "/" . safename("storage-hrstorage-" . $storage_name) .".rrd";
  $used = $disk['Size'] - $disk['FreeSpace'];
  $percent = round($used / $disk['Size'] * 100);

  if (!is_file($rrd_filename))
  {
    rrdtool_create($rrd_filename, " DS:used:GAUGE:600:0:U DS:free:GAUGE:600:0:U ");
  }

  rrdtool_update($rrd_filename,"N:".$used.":".$disk['FreeSpace']);
  dbUpdate(array('storage_polled' => time(), 'storage_used' => $used, 'storage_free' => $disk['FreeSpace'], 'storage_size' => $disk['Size'],
    'storage_perc' => $percent), 'storage-state', '`storage_id` = ?', array($storage_id));
}

echo(PHP_EOL);

// EOF
