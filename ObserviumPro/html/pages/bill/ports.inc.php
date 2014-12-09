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

$res   = "";
$count = 0;
$speed = 0;
$port_ids = dbFetchRows("SELECT `port_id` FROM `bill_ports` WHERE bill_id = ?", array($bill_id));

foreach ($port_ids AS $port_entry)
{
  $port   = get_port_by_id($port_entry['port_id']);
  $device = device_by_id_cache($port['device_id']);

  $emptyCheck = true;
  $count++;
  $speed += $port['ifSpeed'];

  /// FIXME - clean this up, it's horrible.

  $devicebtn = '<button class="btn"><i class="oicon-servers"></i> '.generate_device_link($device).'</button>';

  if (empty($port['ifAlias'])) { $portalias = ""; } else { $portalias = " - ".$port['ifAlias'].""; }

  $portbtn = '<button class="btn">'.generate_port_link($port, '<i class="oicon-network-ethernet"></i> '.rewrite_ifname($port['label']).$portalias).'</button>';

  $res    .= "            <div class=\"btn-group\">\n";
  $res    .= "              ".$devicebtn."\n";
  $res    .= "              ".$portbtn."\n";
  $res    .= "            </div><br />\n";
}

if (!$emptyCheck)
{
  $res     = "          <div class=\"alert alert-info\">\n";
  $res    .= "            <i class=\"icon-info-sign\"></i> <strong>没有端口分配至该账单</strong>\n";
  $res    .= "          </div>\n";
}

$ports_info = array("ports" => $count, "capacity" => $speed);

?>

      <?php echo($res); ?>
