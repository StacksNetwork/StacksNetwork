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

if (is_file($config['rrd_dir'] . "/" . $device['hostname'] ."/ucd_cpu.rrd"))
{
  $graph_title = "处理器利用率";
  $graph_type = "device_cpu";

  include("includes/print-device-graph.php");
}

// EOF
