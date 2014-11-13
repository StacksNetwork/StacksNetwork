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

$pagetitle[] = "物理位置";

if (!$vars['view']) { $vars['view'] = "basic"; }

$navbar['brand'] = '物理位置';
$navbar['class'] = 'navbar-narrow';

foreach (array('basic', 'traffic') as $type)
{
  if ($vars['view'] == $type) { $navbar['options'][$type]['class'] = 'active'; }
  $navbar['options'][$type]['url'] = generate_url(array('page' => 'locations', 'view' => $type));
  $navbar['options'][$type]['text'] = ucfirst($type);
}
print_navbar($navbar);
unset($navbar);

echo('<table cellpadding="7" cellspacing="0" class="devicetable" width="100%">');

foreach (get_locations() as $location)
{
  if ($_SESSION['userlevel'] == '10')
  {
    $num = dbFetchCell("SELECT COUNT(device_id) FROM devices WHERE location = ?", array($location));
    $net = dbFetchCell("SELECT COUNT(device_id) FROM devices WHERE location = ? AND type = 'network'", array($location));
    $srv = dbFetchCell("SELECT COUNT(device_id) FROM devices WHERE location = ? AND type = 'server'", array($location));
    $fwl = dbFetchCell("SELECT COUNT(device_id) FROM devices WHERE location = ? AND type = 'firewall'", array($location));
    $hostalerts = dbFetchCell("SELECT COUNT(device_id) FROM devices WHERE location = ? AND status = '0'", array($location));
  } else {
    $num = dbFetchCell("SELECT COUNT(D.device_id) FROM devices AS D, devices_perms AS P WHERE D.device_id = P.device_id AND P.user_id = ? AND location = ?", array($_SESSION['user_id'], $location));
    $net = dbFetchCell("SELECT COUNT(D.device_id) FROM devices AS D, devices_perms AS P WHERE D.device_id = P.device_id AND P.user_id = ? AND location = ? AND D.type = 'network'", array($_SESSION['user_id'], $location));
    $srv = dbFetchCell("SELECT COUNT(D.device_id) FROM devices AS D, devices_perms AS P WHERE D.device_id = P.device_id AND P.user_id = ? AND location = ? AND type = 'server'", array($_SESSION['user_id'], $location));
    $fwl = dbFetchCell("SELECT COUNT(D.device_id) FROM devices AS D, devices_perms AS P WHERE D.device_id = P.device_id AND P.user_id = ? AND location = ? AND type = 'firewall'", array($_SESSION['user_id'], $location));
    $hostalerts = dbFetchCell("SELECT COUNT(device_id) FROM devices AS D, devices_perms AS P WHERE D.device_id = P.device_id AND P.user_id = ? AND location = ? AND status = '0'", array($_SESSION['user_id'], $location));
  }

  if ($hostalerts) { $alert = '<img src="images/16/flag_red.png" alt="alert" />'; } else { $alert = ""; }

  $value = base64_encode(json_encode(array($location)));
  $name  = ($location == '' ? '[[未知]]' : htmlspecialchars($location));
  echo('      <tr class="locations">
           <td class="interface" width="300">' . generate_link($name, array('page' => 'devices', 'location' => $value)) . '</td>
           <td width="100">' . $alert . '</td>
           <td width="100">' . $num . ' 设备</td>
           <td width="100">' . $net . ' 网络</td>
           <td width="100">' . $srv . ' 服务器</td>
           <td width="100">' . $fwl . ' 防火墙</td>
         </tr>
       ');

  if ($vars['view'] == "traffic")
  {
    echo('<tr></tr><tr class="locations"><td colspan=6>');

    $graph_array['type']   = "location_bits";
    $graph_array['height'] = "100";
    $graph_array['width']  = "220";
    $graph_array['to']     = $config['time']['now'];
    $graph_array['legend'] = "no";
    $graph_array['id']     = $location;

    print_graph_row($graph_array);

    echo("</tr></td>");
  }
  $done = "yes";
}

echo("</table>");

// EOF
