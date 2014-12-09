
<table border=0 cellpadding=10 cellspacing=10 width=100%>
  <tr>
    <td bgcolor=#e5e5e5 valign=top>
<?php

$nodes = array();

$uptimesql = "";
if (filter_var($config['uptime_warning'], FILTER_VALIDATE_FLOAT) !== FALSE && $config['uptime_warning'] > 0)
{
  $uptimesql = " AND A.attrib_value < '" . $config['uptime_warning'] . "'";
}

$sql = mysql_query("SELECT * FROM `devices` AS D, `devices_attribs` AS A WHERE D.status = '1' AND A.device_id = D.device_id AND A.attrib_type = 'uptime' AND A.attrib_value > '0' " . $uptimesql);

while ($device = mysql_fetch_assoc($sql)) {
  unset($already);
  $i = 0;
  while ($i <= count($nodes)) {
    $thisnode = $device['device_id'];
    if ($nodes[$i] == $thisnode) {
     $already = "yes";
    }
    $i++;
  }
  if (!$already) { $nodes[] = $device['device_id']; }
}

$sql = mysql_query("SELECT * FROM `devices` WHERE `status` = '0' AND `ignore` = '0'");
while ($device = mysql_fetch_assoc($sql)) {
   if (device_permitted($device['device_id'])) {
      echo("<div style='text-align: center; margin: 2px; border: solid 2px #d0D0D0; float: left; margin-right: 2px; padding: 3px; width: 118px; height: 85px; background: #ffbbbb;'>
       <strong>".generate_device_link($device, shorthost($device['hostname']))."</strong><br />
       <span style='font-size: 14px; font-weight: bold; margin: 5px; color: #c00;'>设备异常</span><br />
       <span class=body-date-1>".truncate($device['location'], 35)."</span>
      </div>");
   }
}

if ($config['frontpage']['device_status']['ports']) {

$sql = mysql_query("SELECT * FROM `ports` AS I, `devices` AS D WHERE I.device_id = D.device_id AND ifOperStatus = 'down' AND ifAdminStatus = 'up' AND D.ignore = '0' AND I.ignore = '0'");
while ($interface = mysql_fetch_assoc($sql)) {
   if (port_permitted($interface['port_id'])) {
      echo("<div style='text-align: center; margin: 2px; border: solid 2px #D0D0D0; float: left; margin-right: 2px; padding: 3px; width: 118px; height: 85px; background: #ffddaa;'>
       <strong>".generate_device_link($interface, shorthost($interface['hostname']))."</strong><br />
       <span style='font-size: 14px; font-weight: bold; margin: 5px; color: #c00;'>端口异常</span><br />
       <strong>".generate_port_link($interface, makeshortif($interface['ifDescr']))."</strong><br />
       <span class=body-date-1>".truncate($interface['ifAlias'], 15)."</span>
      </div>");
   }
}

}

$sql = mysql_query("SELECT * FROM `services` AS S, `devices` AS D WHERE S.device_id = D.device_id AND service_status = 'down' AND D.ignore = '0' AND S.service_ignore = '0'");
while ($service = mysql_fetch_assoc($sql)) {
   if (device_permitted($service['device_id'])) {
      echo("<div style='text-align: center; margin: 2px; border: solid 2px #D0D0D0; float: left; margin-right: 2px; padding: 3px; width: 118px; height: 85px; background: #ffddaa;'>
      <strong>".generate_device_link($service, shorthost($service['hostname']))."</strong><br />
      <span style='font-size: 14px; font-weight: bold; margin: 5px; color: #c00;'>服务异常</span><br />
      <strong>".$service['service_type']."</strong><br />
      <span class=body-date-1>".truncate($interface['ifAlias'], 15)."</span>
      </center></div>");
   }
}

$sql = mysql_query("SELECT * FROM `devices` AS D, bgpPeers AS B WHERE bgpPeerAdminStatus = 'start' AND bgpPeerState != 'established' AND B.device_id = D.device_id");
while ($peer = mysql_fetch_assoc($sql)) {
   if (device_permitted($peer['device_id'])) {
      echo("<div style='text-align: center; margin: 2px; border: solid 2px #D0D0D0; float: left; margin-right: 2px; padding: 3px; width: 118px; height: 85px; background: #ffddaa;'>
      <strong>".generate_device_link($peer, shorthost($peer['hostname']))."</strong><br />
      <span style='font-size: 14px; font-weight: bold; margin: 5px; color: #c00;'>BGP异常</span><br />
      <strong>".$peer['bgpPeerIdentifier']."</strong><br />
      <span class=body-date-1>AS".$peer['bgpPeerRemoteAs']." ".truncate($peer['astext'], 10)."</span>
      </div>");
   }
}

if (filter_var($config['uptime_warning'], FILTER_VALIDATE_FLOAT) !== FALSE && $config['uptime_warning'] > 0)
{
  $sql = mysql_query("SELECT * FROM devices_attribs AS A, `devices` AS D WHERE A.attrib_value < '" . $config['uptime_warning'] . "' AND A.attrib_type = 'uptime' AND A.device_id = D.device_id AND ignore = '0' AND disabled = '0'");
  while ($device = mysql_fetch_assoc($sql)) {
     if (device_permitted($device['device_id']) && $device['attrib_value'] < $config['uptime_warning'] && $device['attrib_type'] == "uptime") {
        echo("<div style='text-align: center; margin: 2px; border: solid 2px #D0D0D0; float: left; margin-right: 2px; padding: 3px; width: 118px; height: 85px; background: #ddffdd;'>
        <strong>".generate_device_link($device, shorthost($device['hostname']))."</strong><br />
        <span style='font-size: 14px; font-weight: bold; margin: 5px; color: #090;'>设备<br />重启</span><br />
        <span class=body-date-1>".formatUptime($device['attrib_value'])."</span>
        </div>");
     }
  }
}

echo("

        <div style='clear: both;'>$errorboxes</div> <div style='margin: 0px; clear: both;'>

<h3>最近的日志信息</h3>

");

print_syslogs(array('pagesize' => $config['frontpage']['syslog']['items']));

echo("</div>

   </td>
   <td bgcolor=#e5e5e5 width=470 valign=top>");

// this stuff can be customised to show whatever you want....

if ($_SESSION['userlevel'] >= '5')
{

  $sql  = "select * from ports as I, devices as D WHERE `ifAlias` like 'ISP-Transit: %' AND I.device_id = D.device_id ORDER BY I.ifAlias";
  $query = mysql_query($sql);
  unset ($seperator);
  while ($interface = mysql_fetch_assoc($query)) {
    $ports['transit'] .= $seperator . $interface['port_id'];
    $seperator = ",";
  }

  $sql  = "select * from ports as I, devices as D WHERE `ifAlias` like 'ISP-Peering: %' AND I.device_id = D.device_id ORDER BY I.ifAlias";
  $query = mysql_query($sql);
  unset ($seperator);
  while ($interface = mysql_fetch_assoc($query)) {
    $ports['peering'] .= $seperator . $interface['port_id'];
    $seperator = ",";
  }

  $ports['broadband'] = "3294,3295,688,3534";
  $ports['wave_broadband'] = "827";

  $ports['new_broadband'] = "3659,4149,4121,4108,3676,4135";

  echo("<div style=' margin-bottom: 5px;'>");

  if ($ports['peering'] && $ports['transit']) {
    echo("<div style='width: 235px; '>
    <a href='internet/' onmouseover=\"return overlib('\
    <img src=\'graph.php?type=multiport_bits_duo&amp;id=".$ports['peering']."&amp;idb=".$ports['transit']."&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=400&amp;height=150\'>\
    <img src=\'graph.php?type=multiport_bits_duo&amp;id=".$ports['peering']."&amp;idb=".$ports['transit']."&amp;from=".$config['time']['week']."&amp;to=".$config['time']['now']."&amp;width=400&amp;height=150\'>\
    ', CENTER, LEFT, FGCOLOR, '#e5e5e5', BGCOLOR, '#e5e5e5', WIDTH, 400, HEIGHT, 150);\" onmouseout=\"return nd();\"  >".
    "<div style='font-size: 16px; font-weight: bold; color: #555555;'>综合互联网流量</div>".
    "<img src='graph.php?type=multiport_bits_duo&amp;id=".$ports['peering']."&amp;idb=".$ports['transit'].
    "&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=385&amp;height=100&amp;legend=no'></a></div>");
  }

  echo("</div>");

  echo("<div style=' margin-bottom: 5px;'>");

  if ($ports['transit']) {
    echo("<div style='width: 235px; float: left;'>
    <a href='iftype/transit/' onmouseover=\"return overlib('\
    <img src=\'graph.php?type=multiport_bits&amp;id=".$ports['transit']."&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=400&amp;height=150\'>\
    <img src=\'graph.php?type=multiport_bits&amp;id=".$ports['transit']."&amp;from=".$config['time']['week']."&amp;to=".$config['time']['now']."&amp;width=400&amp;height=150\'>\
    ', CENTER, LEFT, FGCOLOR, '#e5e5e5', BGCOLOR, '#e5e5e5', WIDTH, 400, HEIGHT, 150);\" onmouseout=\"return nd();\"  >".
    "<div style='font-size: 16px; font-weight: bold; color: #555555;'>互联网透传</div>".
    "<img src='graph.php?type=multiport_bits&amp;id=".$ports['transit'].
    "&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=155&amp;height=100&amp;legend=no'></a></div>");
  }

  if ($ports['peering']) {
    echo("<div style='width: 235px; float: right;'>
    <a href='iftype/peering/' onmouseover=\"return overlib('\
    <img src=\'graph.php?type=multiport_bits&amp;id=".$ports['peering']."&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=400&amp;height=150\'>\
    <img src=\'graph.php?type=multiport_bits&amp;id=".$ports['peering']."&amp;from=".$config['time']['week']."&amp;to=".$config['time']['now']."&amp;width=400&amp;height=150\'>\
    ', CENTER, LEFT, FGCOLOR, '#e5e5e5', BGCOLOR, '#e5e5e5', WIDTH, 400, HEIGHT, 150);\" onmouseout=\"return nd();\"  >".
    "<div style='font-size: 16px; font-weight: bold; color: #555555;'>对等网络</div>".
    "<img src='graph.php?type=multiport_bits&amp;id=".$ports['peering'].
    "&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=155&amp;height=100&amp;legend=no'></a></div>");
  }

  echo("</div>");

  echo("<div style=' margin-bottom: 5px;'>");

  if ($ports['broadband'] && $ports['wave_broadband'] && $ports['new_broadband']) {
    echo("<div style='width: 466px; '>
    <a href='broadband/' onmouseover=\"return overlib('\
    <img src=\'graph.php?type=multiport_bits_trio&amp;id=".$ports['broadband']."&amp;idb=".$ports['new_broadband']."&amp;idc=".$ports['wave_broadband']."&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=400&amp;height=150&amp;inverse=c\'>\
    <img src=\'graph.php?type=multiport_bits_trio&amp;id=".$ports['broadband']."&amp;idb=".$ports['new_broadband']."&amp;idc=".$ports['wave_broadband']."&amp;from=".$config['time']['week']."&amp;to=".$config['time']['now']."&amp;width=400&amp;height=150&amp;inverse=c\'>\
    ', CENTER, LEFT, FGCOLOR, '#e5e5e5', BGCOLOR, '#e5e5e5', WIDTH, 400, HEIGHT, 150);\" onmouseout=\"return nd();\"  >".
    "<div style='font-size: 16px; font-weight: bold; color: #555555;'>汇聚带宽流量</div>".
    "<img src='graph.php?type=multiport_bits_trio&amp;id=".$ports['broadband']."&amp;idb=".$ports['new_broadband']."&amp;idc=".$ports['wave_broadband'].
    "&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=385&amp;height=100&amp;legend=no&amp;inverse=c'></a></div>");
  }

  echo("<div style=' margin-bottom: 5px;'>");

  if ($ports['broadband']) {
    echo("<div style='width: 235px; float: left;'>
    <a onmouseover=\"return overlib('\
    <img src=\'graph.php?type=multiport_bits&amp;id=".$ports['broadband']."&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=400&amp;height=150\'>\
    <img src=\'graph.php?type=multiport_bits&amp;id=".$ports['broadband']."&amp;from=".$config['time']['week']."&amp;to=".$config['time']['now']."&amp;width=400&amp;height=150\'>\
    ', LEFT, FGCOLOR, '#e5e5e5', BGCOLOR, '#e5e5e5', WIDTH, 400, HEIGHT, 150);\" onmouseout=\"return nd();\"  >".
    "<div style='font-size: 16px; font-weight: bold; color: #555555;'>ATM带宽</div>".
    "<img src='graph.php?type=multiport_bits&amp;id=".$ports['broadband'].
    "&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=155&amp;height=100&amp;legend=no'></a></div>");
  }

  echo("<div style=' margin-bottom: 5px;'>");

  if ($ports['new_broadband']) {
    echo("<div style='width: 235px; float: left;'>
    <a onmouseover=\"return overlib('\
    <img src=\'graph.php?type=multiport_bits&amp;id=".$ports['new_broadband']."&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=400&amp;height=150&amp;inverse=0\'>\
    <img src=\'graph.php?type=multiport_bits&amp;id=".$ports['new_broadband']."&amp;from=".$config['time']['week']."&amp;to=".$config['time']['now']."&amp;width=400&amp;height=150&amp;inverse=0\'>\
    ', LEFT, FGCOLOR, '#e5e5e5', BGCOLOR, '#e5e5e5', WIDTH, 400, HEIGHT, 150);\" onmouseout=\"return nd();\"  >".
    "<div style='font-size: 16px; font-weight: bold; color: #555555;'>NGN带宽</div>".
    "<img src='graph.php?type=multiport_bits&amp;id=".$ports['new_broadband']."&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=155&amp;height=100&amp;inverse=0&amp;legend=no'></a></div>");
  }

  echo("</div>");

  if ($ports['wave_broadband']) {
    echo("<div style='width: 235px; float: left;'>
    <a onmouseover=\"return overlib('\
    <img src=\'graph.php?type=port_bits&amp;id=".$ports['wave_broadband']."&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=400&amp;height=150&amp;inverse=1&amp;legend=1\'>\
    <img src=\'graph.php?type=port_bits&amp;id=".$ports['wave_broadband']."&amp;from=".$config['time']['week']."&amp;to=".$config['time']['now']."&amp;width=400&amp;height=150&amp;inverse=1&amp;legend=1\'>\
    ', LEFT, FGCOLOR, '#e5e5e5', BGCOLOR, '#e5e5e5', WIDTH, 400, HEIGHT, 150);\" onmouseout=\"return nd();\"  >".    "
    <div style='font-size: 16px; font-weight: bold; color: #555555;'>波动带宽</div>".
    "<img src='graph.php?type=port_bits&amp;id=".$ports['wave_broadband']."&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=155&amp;height=100&amp;inverse=1&amp;legend=no'></a></div>");
  }

  echo("</div>");

}

?>
</td>

  </tr>
  <tr>
</tr></table>
