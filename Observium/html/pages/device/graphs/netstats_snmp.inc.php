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

if (is_file($config['rrd_dir'] . "/" . $device['hostname'] ."/netstats-snmp.rrd"))
{
  $graph_title = "SNMP数据包统计";
  $graph_type = "device_snmp_packets";

  include("includes/print-device-graph.php");

  $graph_title = "SNMP信息类型统计";
  $graph_type = "device_snmp_statistics";

  include("includes/print-device-graph.php");
}

// EOF
