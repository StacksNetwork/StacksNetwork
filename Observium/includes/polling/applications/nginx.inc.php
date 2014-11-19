<?php

if (!empty($agent_data['app']['nginx']))
{
  $nginx = $agent_data['app']['nginx'];
} else {
  # Polls nginx statistics from script via SNMP
  $nginx = snmp_get($device, "nsExtendOutputFull.5.110.103.105.110.120", "-Ovq", "NET-SNMP-EXTEND-MIB");
}

$nginx_rrd  = $config['rrd_dir'] . "/" . $device['hostname'] . "/app-nginx-".$app['app_id'].".rrd";

echo(" nginx statistics\n");

list($active, $reading, $writing, $waiting, $req) = explode("\n", $nginx);
if (!is_file($nginx_rrd))
{
  rrdtool_create ($nginx_rrd, " \
        DS:Requests:DERIVE:600:0:125000000000 \
        DS:Active:GAUGE:600:0:125000000000 \
        DS:Reading:GAUGE:600:0:125000000000 \
        DS:Writing:GAUGE:600:0:125000000000 \
        DS:Waiting:GAUGE:600:0:125000000000 ");
}

print "active: $active reading: $reading writing: $writing waiting: $waiting Requests: $req";
rrdtool_update($nginx_rrd, "N:$req:$active:$reading:$writing:$waiting");

// Unset the variables we set here

unset($nginx);
unset($nginx_rrd);
unset($active);
unset($reading);
unset($writing);
unset($req);

?>
