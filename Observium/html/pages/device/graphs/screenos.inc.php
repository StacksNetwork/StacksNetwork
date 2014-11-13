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
 
if ($device['os'] == "screenos" && is_file($config['rrd_dir'] . "/" . $device['hostname'] ."/screenos-sessions.rrd"))
{
  $graph_title = "防火墙会话";
  $graph_type = "screenos_sessions";

  include("includes/print-device-graph.php");
}

// EOF
