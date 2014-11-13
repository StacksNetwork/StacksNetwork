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

if (is_file($config['rrd_dir'] . "/" . $device['hostname'] ."/netstats-icmp.rrd"))
{
  $graph_title = "ICMP统计";
  $graph_type = "device_icmp";

  include("includes/print-device-graph.php");
}

// EOF
