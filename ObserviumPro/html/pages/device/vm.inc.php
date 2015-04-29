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

echo('<table class="table table-hover table-bordered table-striped table-condensed table-rounded">');
echo('<thead><tr>
        <th>服务器名称</th>
        <th>状态</th>
        <th>操作系统</th>
        <th>内存</th>
        <th>CPU</th>
      </tr></thead>');

foreach (dbFetchRows("SELECT * FROM vminfo WHERE device_id = ? ORDER BY vmwVmDisplayName", array($device['device_id'])) as $vm)
{
  print_vm_row($vm, $device);
}

echo("</table>");

$page_title[] = "虚拟机";

// EOF
