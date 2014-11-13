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

$rrdfile = get_port_rrdfilename($device, $port, "adsl");
if (file_exists($rrdfile))
{
  $iid = $id;
  echo("<div class=graphhead>ADSL线路速度</div>");
  $graph_type = "port_adsl_speed";

  include("includes/print-interface-graphs.inc.php");

  echo("<div class=graphhead>ADSL线路衰减</div>");
  $graph_type = "port_adsl_attenuation";

  include("includes/print-interface-graphs.inc.php");

  echo("<div class=graphhead>ADSL线路信噪比</div>");
  $graph_type = "port_adsl_snr";

  include("includes/print-interface-graphs.inc.php");

  echo("<div class=graphhead>ADSL输出功率</div>");
  $graph_type = "port_adsl_power";

  include("includes/print-interface-graphs.inc.php");
}

// EOF
