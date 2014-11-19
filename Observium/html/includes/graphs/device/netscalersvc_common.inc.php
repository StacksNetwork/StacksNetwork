<?php

$i = 1;

foreach (dbFetchRows("SELECT * FROM `netscaler_services` AS NS, `devices` AS D WHERE D.device_id = ? AND NS.device_id = D.device_id", array($device['device_id'])) as $svc)
{

  $rrd_filename = $config['rrd_dir'] . "/" . $device['hostname'] . "/nscaler-svc-".safename($svc['svc_name']).".rrd";


  if (is_file($rrd_filename))
  {
    $rrd_list[$i]['filename'] = $rrd_filename;
    $rrd_list[$i]['descr'] = $svc['svc_label'];
    $rrd_list[$i]['ds'] = $ds;
    $i++;
  }
}

?>
