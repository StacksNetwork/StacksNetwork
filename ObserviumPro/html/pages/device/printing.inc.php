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

echo('<table class="table table-condensed table-striped">');

$graph_title = "硒鼓";
$graph_type = "device_toner";

include("includes/print-device-graph.php");

unset($graph_array);

if (get_dev_attrib($device, "pagecount_oid"))
{
  $graph_title = "Pagecounter";
  $graph_type = "device_pagecount";

  include("includes/print-device-graph.php");
}

unset($graph_array);

if (get_dev_attrib($device, "imagingdrum_c_oid"))
{
  $graph_title = "成像鼓";
  $graph_type = "device_imagingdrums";

  include("includes/print-device-graph.php");
}
elseif (get_dev_attrib($device, "imagingdrum_oid"))
{
  $graph_title = "成像鼓";
  $graph_type = "device_imagingdrum";

  include("includes/print-device-graph.php");
}

unset($graph_array);

if (get_dev_attrib($device, "fuser_oid"))
{
  $graph_title = "融合器";
  $graph_type = "device_fuser";

  include("includes/print-device-graph.php");
}

unset($graph_array);

if (get_dev_attrib($device, "transferroller_oid"))
{
  $graph_title = "传送辊";
  $graph_type = "device_transferroller";

  include("includes/print-device-graph.php");
}

unset($graph_array);

if (get_dev_attrib($device, "wastebox_oid"))
{
  $graph_title = "废碳粉盒";
  $graph_type = "device_wastebox";

  include("includes/print-device-graph.php");
}

echo('</table>');

$page_title[] = "打印";

?>
