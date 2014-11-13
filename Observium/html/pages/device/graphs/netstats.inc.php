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

if (is_file($config['rrd_dir'] . "/" . $device['hostname'] ."/ipSystemStats-ipv6.rrd"))
{
  $graph_title = "IPv6 IP数据包统计";
  $graph_type = "device_ipSystemStats_v6";

  include("includes/print-device-graph.php");

  $graph_title = "IPv6 零散IP统计";
  $graph_type = "device_ipSystemStats_v6_frag";

  include("includes/print-device-graph.php");
}

if (is_file($config['rrd_dir'] . "/" . $device['hostname'] ."/ipSystemStats-ipv4.rrd"))
{
  $graph_title = "IPv4 IP数据包统计";
  $graph_type = "device_ipSystemStats_v4";

  include("includes/print-device-graph.php");
}

if (is_file($config['rrd_dir'] . "/" . $device['hostname'] ."/netstats-ip.rrd"))
{
  $graph_title = "IP统计";
  $graph_type = "device_ip";

  include("includes/print-device-graph.php");

  $graph_title = "零散IP统计";
  $graph_type = "device_ip_fragmented";

  include("includes/print-device-graph.php");
}

if (is_file($config['rrd_dir'] . "/" . $device['hostname'] ."/netstats-tcp.rrd"))
{
  $graph_title = "TCP统计";
  $graph_type = "device_tcp";

  include("includes/print-device-graph.php");
}

if (is_file($config['rrd_dir'] . "/" . $device['hostname'] ."/netstats-udp.rrd"))
{
  $graph_title = "UDP统计";
  $graph_type = "device_udp";

  include("includes/print-device-graph.php");
}

if (is_file($config['rrd_dir'] . "/" . $device['hostname'] ."/netstats-snmp.rrd"))
{
  $graph_title = "SNMP数据包统计";
  $graph_type = "device_snmp_packets";

  include("includes/print-device-graph.php");

  $graph_title = "SNMP信息类型统计";
  $graph_type = "device_snmp_statistics";

  include("includes/print-device-graph.php");
}

if (is_file($config['rrd_dir'] . "/" . $device['hostname'] ."/netstats-icmp.rrd"))
{
  $graph_title = "ICMP统计";
  $graph_type = "device_icmp";

  include("includes/print-device-graph.php");

  $graph_title = "ICMP信息统计";
  $graph_type = "device_icmp_informational";

  include("includes/print-device-graph.php");
}

// EOF
