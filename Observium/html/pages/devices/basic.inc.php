<?php

echo('<table class="table table-hover table-striped table-bordered table-condensed table-rounded" style="margin-top: 10px;">');

foreach ($devices as $device)
{
  if (device_permitted($device['device_id']))
  {
    if (!$location_filter || $device['location'] == $location_filter)
    {
      include("includes/hostbox-basic.inc.php");
    }
  }
}

echo("</table>");

// EOF
