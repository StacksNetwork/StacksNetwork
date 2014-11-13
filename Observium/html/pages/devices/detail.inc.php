<?php

// Display devices as a list in detailed format

echo('<table class="table table-hover table-striped table-bordered table-condensed table-rounded" style="margin-top: 10px;">');
echo("  <thead>\n");
echo("    <tr>\n");
echo("      <th></th>\n");
echo("      <th></th>\n");
echo("      <th>设备/物理位置</th>\n");
echo("      <th></th>\n");
echo("      <th>平台</th>\n");
echo("      <th>操作系统</th>\n");
echo("      <th>运行时间/系统名称</th>\n");
echo("    </tr>\n");
echo("  </thead>\n");

foreach ($devices as $device)
{
  if (device_permitted($device['device_id']))
  {
    if (!$location_filter || $device['location'] == $location_filter)
    {
      include("includes/hostbox.inc.php");
    }
  }
}

echo("</table>");

// EOF
