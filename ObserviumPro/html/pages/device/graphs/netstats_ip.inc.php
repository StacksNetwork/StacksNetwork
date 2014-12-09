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

if (is_file(get_rrd_path($device, "netstats-ip.rrd")))
{
  $graph_title = "IP统计";
  $graph_type = "device_ip";

  include("includes/print-device-graph.php");

  $graph_title = "IP碎片统计";
  $graph_type = "device_ip_fragmented";

  include("includes/print-device-graph.php");
}

// EOF
