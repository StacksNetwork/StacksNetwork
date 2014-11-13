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

if (is_file($config['rrd_dir'] . "/" . $device['hostname'] ."/hrSystem.rrd"))
{
  $graph_title = "运行过程";
  $graph_type = "device_hrprocesses";

  include("includes/print-device-graph.php");
}

// EOF
