<?php

if (!empty($agent_data['app']['apache']))
{
  $rrd_filename = $config['rrd_dir'] . "/" . $device['hostname'] . "/app-apache-".$app['app_id'].".rrd";

  list ($total_access, $total_kbyte, $cpuload, $uptime, $reqpersec, $bytespersec, $bytesperreq, $busyworkers, $idleworkers,
        $score_wait, $score_start, $score_reading, $score_writing, $score_keepalive, $score_dns, $score_closing, $score_logging,
        $score_graceful, $score_idle, $score_open) = explode("\n", $agent_data['app']['apache']);

  if (!is_file($rrd_filename))
  {
    rrdtool_create($rrd_filename, " \
        DS:access:DERIVE:600:0:125000000000 \
        DS:kbyte:DERIVE:600:0:125000000000 \
        DS:cpu:GAUGE:600:0:125000000000 \
        DS:uptime:GAUGE:600:0:125000000000 \
        DS:reqpersec:GAUGE:600:0:125000000000 \
        DS:bytespersec:GAUGE:600:0:125000000000 \
        DS:byesperreq:GAUGE:600:0:125000000000 \
        DS:busyworkers:GAUGE:600:0:125000000000 \
        DS:idleworkers:GAUGE:600:0:125000000000 \
        DS:sb_wait:GAUGE:600:0:125000000000 \
        DS:sb_start:GAUGE:600:0:125000000000 \
        DS:sb_reading:GAUGE:600:0:125000000000 \
        DS:sb_writing:GAUGE:600:0:125000000000 \
        DS:sb_keepalive:GAUGE:600:0:125000000000 \
        DS:sb_dns:GAUGE:600:0:125000000000 \
        DS:sb_closing:GAUGE:600:0:125000000000 \
        DS:sb_logging:GAUGE:600:0:125000000000 \
        DS:sb_graceful:GAUGE:600:0:125000000000 \
        DS:sb_idle:GAUGE:600:0:125000000000 \
        DS:sb_open:GAUGE:600:0:125000000000 ");
  }

  rrdtool_update($rrd_filename,  "N:$total_access:$total_kbyte:$cpuload:$uptime:$reqpersec:$bytespersec:$bytesperreq:$busyworkers:$idleworkers:$score_wait:$score_start:$score_reading:$score_writing:$score_keepalive:$score_dns:$score_closing:$score_logging:$score_graceful:$score_idle:$score_open");
}

?>
