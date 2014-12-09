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

echo('<tr class="list">');

echo('<td class="list">');

if (getidbyname($vm['vmwVmDisplayName']))
{
  echo(generate_device_link(device_by_name($vm['vmwVmDisplayName'])));
} else {
  echo $vm['vmwVmDisplayName'];
}

echo("</td>");
echo('<td class="list">' . $vm['vmwVmState'] . "</td>");

if ($vm['vmwVmGuestOS'] == "E: 工具未安装")
{
  echo('<td class="small">未知 (VMware Tools 未安装)</td>');
}
else if ($vm['vmwVmGuestOS'] == "")
{
  echo('<td class="small"><i>(未知)</i></td>');
}
elseif (isset($config['vmware_guestid'][$vm['vmwVmGuestOS']]))
{
  echo('<td class="list">' . $config['vmware_guestid'][$vm['vmwVmGuestOS']] . "</td>");
}
else
{
  echo('<td class="list">' . $vm['vmwVmGuestOS'] . "</td>");
}

if ($vm['vmwVmMemSize'] >= 1024)
{
  echo("<td class=list>" . sprintf("%.2f",$vm['vmwVmMemSize']/1024) . " GB</td>");
} else {
  echo("<td class=list>" . sprintf("%.2f",$vm['vmwVmMemSize']) . " MB</td>");
}

echo('<td class="list">' . $vm['vmwVmCpus'] . " CPU</td>");

?>
