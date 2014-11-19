<?php

// Generate a list of svcs and build an rrd_list array using arguments passed from parent

foreach (dbFetchRows("SELECT * FROM `netscaler_services` WHERE `device_id` = ?", array($device['device_id'])) as $svc)
{

  $rrd_filename = $config['rrd_dir'] . "/" . $device['hostname'] . "/" . safename("nscaler-svc-".$svc['svc_name'].".rrd");

  if (is_file($rrd_filename))
  {
    $rrd_list[$i]['filename']  = $rrd_filename;
    $rrd_list[$i]['descr']     = $svc['svc_name'];
    $rrd_list[$i]['descr_in']  = $svc['svc_name'];
    $rrd_list[$i]['descr_out'] = $svc['svc_ip'] . ":" . $svc['svc_port'];
    $rrd_list[$i]['ds_in']     = $ds_in;
    $rrd_list[$i]['ds_out']    = $ds_out;
    $i++;
  }

  unset($ignore);
}

?>
