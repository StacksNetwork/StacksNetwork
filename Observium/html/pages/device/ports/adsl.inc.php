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

echo('<table class="table-striped table-rounded table-bordered table-condensed">');

echo("<thead><tr><th>端口</th><th>流量</th><th>同步速度</th><th>可达速度</th><th>衰减</th><th>信噪比</th><th>输出功率</th></tr></thead>");
$i = "0";
$ports = dbFetchRows("select * from `ports` AS P, `ports_adsl` AS A WHERE P.device_id = ? AND A.port_id = P.port_id AND P.deleted = '0' ORDER BY `ifIndex` ASC", array($device['device_id']));
foreach ($ports as $port)
{
  include("includes/print-interface-adsl.inc.php");

  $i++;
}

echo("</table>");

// EOF
