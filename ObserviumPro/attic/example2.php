
<table border=0 cellpadding=10 cellspacing=10 width=100%>
  <tr>
    <td bgcolor=#e5e5e5 valign=top>
<?php
#      <table width=100% border=0><tr><td><div style="margin-bottom: 5px; font-size: 18px; font-weight: bold;">Devices with Alerts</div></td><td width=35 align=center><div class=strong>Host</div></td><td align=center width=35><div class=tablehead>Int</div></td><td align=center width=35><div class=tablehead>Srv</div></tr>
?>
<?php

$nodes = array();

$sql = mysql_query("SELECT * FROM `devices` AS D, `devices_attribs` AS A WHERE D.status = '1' AND A.device_id = D.device_id AND A.attrib_type = 'uptime' AND A.attrib_value > '0' AND A.attrib_value < '86400'");

while ($device = mysql_fetch_assoc($sql))
{
  unset($already);
  $i = 0;
  while ($i <= count($nodes))
  {
    $thisnode = $device['device_id'];
    if ($nodes[$i] == $thisnode)
    {
     $already = "yes";
    }
    $i++;
  }
  if (!$already) { $nodes[] = $device['device_id']; }
}

$sql = mysql_query("SELECT * FROM `devices` WHERE `status` = '0' AND `ignore` = '0'");
while ($device = mysql_fetch_assoc($sql)) {

      echo("<div style='border: solid 2px #d0D0D0; float: left; padding: 5px; width: 120px; height: 90px; background: #ffbbbb; margin: 4px;'>
      <center><strong>".generate_device_link($device, shorthost($device['hostname']))."</strong><br />
      <span style='font-size: 14px; font-weight: bold; margin: 5px; color: #c00;'>设备异常</span>
      <span class=body-date-1>".truncate($device['location'], 20)."</span>
      </center></div>");

}

$sql = mysql_query("SELECT * FROM `ports` AS I, `devices` AS D WHERE I.device_id = D.device_id AND ifOperStatus = 'down' AND ifAdminStatus = 'up' AND D.ignore = '0' AND I.ignore = '0'");
while ($interface = mysql_fetch_assoc($sql)) {

      echo("<div style='border: solid 2px #D0D0D0; float: left; padding: 5px; width: 120px; height: 90px; background: #ffddaa; margin: 4px;'>
      <center><strong>".generate_device_link($interface, shorthost($interface['hostname']))."</strong><br />
      <span style='font-size: 14px; font-weight: bold; margin: 5px; color: #c00;'>端口异常</span>
      <strong>".generate_port_link($interface, makeshortif($interface['ifDescr']))."</strong> <br />
      <span class=body-date-1>".truncate($interface['ifAlias'], 20)."</span>
      </center></div>");

}

$sql = mysql_query("SELECT * FROM `services` AS S, `devices` AS D WHERE S.device_id = D.device_id AND service_status = 'down' AND D.ignore = '0' AND S.service_ignore = '0'");
while ($service = mysql_fetch_assoc($sql)) {

      echo("<div style='border: solid 2px #D0D0D0; float: left; padding: 5px; width: 120px; height: 90px; background: #ffddaa; margin: 4px;'>
      <center><strong>".generate_device_link($service, shorthost($service['hostname']))."</strong><br />
      <span style='font-size: 14px; font-weight: bold; margin: 5px; color: #c00;'>服务异常</span>
      <strong>".$service['service_type']."</strong><br />
      <span class=body-date-1>".truncate($interface['ifAlias'], 20)."</span>
      </center></div>");

}

$sql = mysql_query("SELECT * FROM `devices` AS D, bgpPeers AS B WHERE bgpPeerState != 'established' AND B.device_id = D.device_id");
while ($peer = mysql_fetch_assoc($sql)) {

      echo("<div style='border: solid 2px #d0D0D0; float: left; padding: 5px; width: 120px; height: 90px; background: #ffddaa; margin: 4px;'>
      <center><strong>".generate_device_link($peer, shorthost($peer['hostname']))."</strong><br />
      <span style='font-size: 14px; font-weight: bold; margin: 5px; color: #c00;'>BGP异常</span>
      <strong>".$peer['bgpPeerIdentifier']."</strong> <br />
      <span class=body-date-1>AS".$peer['bgpPeerRemoteAs']." ".truncate($peer['astext'], 10)."</span>
      </center></div>");

}

if (filter_var($config['uptime_warning'], FILTER_VALIDATE_FLOAT) !== FALSE && $config['uptime_warning'] > 0)
{
  $sql = mysql_query("SELECT * FROM `devices` AS D, devices_attribs AS A WHERE A.device_id = D.device_id AND A.attrib_type = 'uptime' AND A.attrib_value < '" . $config['uptime_warning'] . "'");
  while ($device = mysql_fetch_assoc($sql)) {

        echo("<div style='border: solid 2px #d0D0D0; float: left; padding: 5px; width: 120px; height: 90px; background: #ddffdd; margin: 4px;'>
        <center><strong>".generate_device_link($device, shorthost($device['hostname']))."</strong><br />
        <span style='font-size: 14px; font-weight: bold; margin: 5px; color: #090;'>设备<br />重启</span><br />
        <span class=body-date-1>".formatUptime($device['attrib_value'])."</span>
        </center></div>");
  }
}

echo("

        <div style='clear: both;'>$errorboxes</div> <div style='margin: 4px; clear: both;'>

<h3>最近的日志信息</h3>

");

print_syslogs(array('pagesize' => $config['frontpage']['syslog']['items']));

echo("</div>

   </td>
   <td bgcolor=#e5e5e5 width=275 valign=top>");

// this stuff can be customised to show whatever you want....

if ($_SESSION['userlevel'] >= '5')
{
  $sql  = "select * from ports as I, devices as D WHERE `ifAlias` like 'L2TP: %' AND I.device_id = D.device_id AND D.hostname LIKE '%";
  $sql .= $config['mydomain'] . "' ORDER BY I.ifAlias";
  $query = mysql_query($sql);
  unset ($seperator);
  while ($interface = mysql_fetch_assoc($query))
  {
    $ports['l2tp'] .= $seperator . $interface['port_id'];
    $seperator = ",";
  }

  $sql  = "select * from ports as I, devices as D WHERE `ifAlias` like 'Transit: %' AND I.device_id = D.device_id AND D.hostname LIKE '%";
  $sql .= $config['mydomain'] . "' ORDER BY I.ifAlias";
  $query = mysql_query($sql);
  unset ($seperator);
  while ($interface = mysql_fetch_assoc($query))
  {
    $ports['transit'] .= $seperator . $interface['port_id'];
    $seperator = ",";
  }

  $sql  = "select * from ports as I, devices as D WHERE `ifAlias` like 'Server: thlon-pbx%' AND I.device_id = D.device_id AND D.hostname LIKE '%";
  $sql .= $config['mydomain'] . "' ORDER BY I.ifAlias";
  $query = mysql_query($sql);
  unset ($seperator);
  while ($interface = mysql_fetch_assoc($query))
  {
    $ports['voip'] .= $seperator . $interface['port_id'];
    $seperator = ",";
  }

  if ($ports['transit'])
  {
    echo("<a onmouseover=\"return overlib('<img src=\'graph.php?type=multi_bits&amp;ports=".$ports['transit'].
    "&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=400&amp;height=150\'>', CENTER, LEFT, FGCOLOR, '#e5e5e5', BGCOLOR, '#e5e5e5', WIDTH, 400, HEIGHT, 250);\" onmouseout=\"return nd();\"  >".
    "<div style='font-size: 18px; font-weight: bold;'>互联网透传</div>".
    "<img src='graph.php?type=multi_bits&amp;ports=".$ports['transit'].
    "&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=200&amp;height=100'></a>");
  }

  if ($ports['l2tp'])
  {
    echo("<a onmouseover=\"return overlib('<img src=\'graph.php?type=multi_bits&amp;ports=".$ports['l2tp'].
    "&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=400&amp;height=150\'>', LEFT, FGCOLOR, '#e5e5e5', BGCOLOR, '#e5e5e5', WIDTH, 400, HEIGHT, 250);\" onmouseout=\"return nd();\"  >".
    "<div style='font-size: 18px; font-weight: bold;'>L2TP ADSL</div>".
    "<img src='graph.php?type=multi_bits&amp;ports=".$ports['l2tp'].
    "&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=200&amp;height=100'></a>");
  }

  if ($ports['voip'])
  {
    echo("<a onmouseover=\"return overlib('<img src=\'graph.php?type=multi_bits&amp;ports=".$ports['voip'].
    "&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=400&amp;height=150\'>', LEFT, FGCOLOR, '#e5e5e5', BGCOLOR, '#e5e5e5', WIDTH, 400, HEIGHT, 250);\" onmouseout=\"return nd();\"  >".
    "<div style='font-size: 18px; font-weight: bold;'>VoIP to PSTN</div>".
    "<img src='graph.php?type=multi_bits&amp;ports=".$ports['voip'].
    "&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=200&amp;height=100'></a>");
  }

}

// END VOSTRON

?>
</td>

  </tr>
  <tr>
</tr></table>
