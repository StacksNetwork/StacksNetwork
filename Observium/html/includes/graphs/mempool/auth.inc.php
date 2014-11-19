<?php

if (is_numeric($vars['id']))
{
  $mempool = dbFetchRow("SELECT * FROM `mempools` AS C, `devices` AS D where C.`mempool_id` = ? AND C.device_id = D.device_id", array($vars['id']));

  if (is_numeric($mempool['device_id']) && ($auth || device_permitted($mempool['device_id'])))
  {
    $device = device_by_id_cache($mempool['device_id']);
    if (isset($mempool['mempool_type'])) { $mempool['mempool_mib'] = $mempool['mempool_type']; }
    $rrd_filename = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("mempool-".$mempool['mempool_mib']."-".$mempool['mempool_index'].".rrd");
    $title  = generate_device_link($device);
    $title .= " :: Memory Pool :: " . htmlentities($mempool['mempool_descr']);
    $auth = TRUE;
  }
}

// EOF
