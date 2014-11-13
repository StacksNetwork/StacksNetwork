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

// EOF

