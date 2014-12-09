<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage webui
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

// Display devices as a list in detailed format
?>
<table class="table table-hover table-striped table-bordered table-condensed table-rounded" style="margin-top: 10px;">
  <thead>
    <tr>
      <th></th>
      <th></th>
      <th>设备/位置</th>
      <th></th>
      <th>网络平台</th>
      <th>操作系统</th>
      <th>运行时间/系统名称</th>
    </tr>
  </thead>

<?php
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
