    <script type='text/javascript' src='https://www.google.com/jsapi'></script>
    <script type='text/javascript'>
     google.load('visualization', '1', {'packages': ['geochart']});
     google.setOnLoadCallback(drawRegionsMap);

    function drawRegionsMap() {
      var data = new google.visualization.DataTable();
      data.addColumn('string', 'Site');
      data.addColumn('number', 'Status');
      data.addColumn({type: 'string', role: 'tooltip'});
      data.addRows([
<?php

$locations_up = array();
$locations_down = array();
foreach (getlocations() as $location)
{

  $devices = array();
  $devices_down = array();
  $devices_up = array();
  $count = 0;
  $down  = 0;
  // FIXME - doesn't handle sysLocation override.
  foreach (dbFetchRows("SELECT * FROM devices WHERE location = ?", array($location)) as $device)
  {
    $devices[] = $device['hostname'];
    $devices_up[] = $device;
    $count++;
    if ($device['status'] == "0" && $device['disabled'] == "0" && $device['ignore'] == "0") { $down++; $devices_down[] = $device['hostname']." DOWN"; }
  }

  $devices_down = array_merge(array(count($devices_up). " 设备 OK"), $devices_down);

  if ($down > 0) {
    $locations_down[]   = "['".$location."', 100, '".implode(", ", $devices_down)."']";
  } else {
    $locations_up[] = "['".$location."', 0, '".implode(", ", $devices_down)."']";
  }
}

echo(implode(",\n", array_merge($locations_up, $locations_down)));

?>

      ]);

      var options = {
        region: 'world',
        displayMode: 'markers',
        keepAspectRatio: 0,
        width: 1150,
        height: 500,
        magnifyingGlass: {enable: true, zoomFactor: 8},
        colorAxis: {minValue: 0, maxValue: 100, colors: ['green', 'red']},
        markerOpacity: 0.90,
        sizeAxis: {minValue: 10,  maxValue: 10}
      };

      var chart = new google.visualization.GeoChart(document.getElementById('chart_div'));
      chart.draw(data, options);
    };

  </script>

    <div style="margin:0 auto;" id='chart_div'></div>

<?php

function generate_front_box ($background, $content)
{
echo("<div style='text-align: center; margin: 2px; border: solid 2px #D0D0D0; float: left; margin-right: 2px; padding: 3px; width: 117px; height: 85px; background: $background;'>
      $content
      </div>");
}

echo("<div style='padding: 3px 10px; background: #fff;'>");

if ($_SESSION['userlevel'] == '10')
{
$sql = mysql_query("SELECT * FROM `devices` WHERE `status` = '0' AND `ignore` = '0'");
} else {
$sql = mysql_query("SELECT * FROM `devices` AS D, devices_perms AS P WHERE D.device_id = P.device_id AND P.user_id = '" . $_SESSION['user_id'] . "' AND D.status = '0' AND D.ignore = '0'");
}
while ($device = mysql_fetch_assoc($sql)) {

      generate_front_box("#ffaaaa", "<center><strong>".generate_device_link($device, shorthost($device['hostname']))."</strong><br />
      <span style='font-size: 14px; font-weight: bold; margin: 5px; color: #c00;'>设备异常</span> <br />
      <span class=body-date-1>".truncate($device['location'], 20)."</span>
      </center>");

}

if ($_SESSION['userlevel'] == '10')
{
$sql = mysql_query("SELECT * FROM `ports` AS I, `devices` AS D WHERE I.device_id = D.device_id AND ifOperStatus = 'down' AND ifAdminStatus = 'up' AND D.ignore = '0' AND I.ignore = '0'");
} else {
$sql = mysql_query("SELECT * FROM `ports` AS I, `devices` AS D, devices_perms AS P WHERE D.device_id = P.device_id AND P.user_id = '" . $_SESSION['user_id'] . "' AND  I.device_id = D.device_id AND ifOperStatus = 'down' AND ifAdminStatus = 'up' AND D.ignore = '0' AND I.ignore = '0'");
}

// These things need to become more generic, and more manageable across different frontpages... rewrite inc :>

if ($config['frontpage']['device_status']['ports'])
{
  while ($interface = mysql_fetch_assoc($sql))
  {
    if (!$interface['deleted'])
    {
     humanize_port($interface);
     generate_front_box("#ffdd99", "<center><strong>".generate_device_link($interface, shorthost($interface['hostname']))."</strong><br />
      <span style='font-size: 14px; font-weight: bold; margin: 5px; color: #c00;'>端口异常</span><br />
<!--      <img src='graph.php?type=bits&amp;if=".$interface['port_id']."&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=100&amp;height=32' /> -->
        <strong>".generate_port_link($interface, truncate(makeshortif($interface['label']),13,''))."</strong> <br />
        " . ($interface['ifAlias'] ? '<span class="body-date-1">'.truncate($interface['ifAlias'], 20, '').'</span>' : '') . "
        </center>");
    }
  }
}

/* FIXME service permissions? seem nonexisting now.. */
$sql = mysql_query("SELECT * FROM `services` AS S, `devices` AS D WHERE S.device_id = D.device_id AND service_status = 'down' AND D.ignore = '0' AND S.service_ignore = '0'");
while ($service = mysql_fetch_assoc($sql))
{
    generate_front_box("#ffaaaa", "<center><strong>".generate_device_link($service, shorthost($service['hostname']))."</strong><br />
    <span style='font-size: 14px; font-weight: bold; margin: 5px; color: #c00;'>服务异常</span>
    <strong>".$service['service_type']."</strong><br />
    <span class=body-date-1>".truncate($interface['ifAlias'], 20)."</span>
    </center>");
}

if (isset($config['enable_bgp']) && $config['enable_bgp'])
{
  if ($_SESSION['userlevel'] == '10')
  {
    $sql = mysql_query("SELECT * FROM `devices` AS D, bgpPeers AS B WHERE bgpPeerAdminStatus != 'start' AND bgpPeerState != 'established' AND bgpPeerState != '' AND B.device_id = D.device_id AND D.ignore = 0");
  } else {
    $sql = mysql_query("SELECT * FROM `devices` AS D, bgpPeers AS B, devices_perms AS P WHERE D.device_id = P.device_id AND P.user_id = '" . $_SESSION['user_id'] . "' AND  bgpPeerAdminStatus != 'start' AND bgpPeerState != 'established' AND bgpPeerState != '' AND B.device_id = D.device_id AND D.ignore = 0");
  }
  while ($peer = mysql_fetch_assoc($sql))
  {
  generate_front_box("#ffaaaa", "<center><strong>".generate_device_link($peer, shorthost($peer['hostname']))."</strong><br />
      <span style='font-size: 14px; font-weight: bold; margin: 5px; color: #c00;'>BGP异常</span>
      <span style='" . (strstr($peer['bgpPeerIdentifier'],':') ? 'font-size: 10px' : '') . "'><strong>".$peer['bgpPeerIdentifier']."</strong></span><br />
      <span class=body-date-1>AS".truncate($peer['bgpPeerRemoteAs']." ".$peer['astext'], 14, "")."</span>
      </center>");
  }
}

if (filter_var($config['uptime_warning'], FILTER_VALIDATE_FLOAT) !== FALSE && $config['uptime_warning'] > 0)
{
  if ($_SESSION['userlevel'] == '10')
  {
  $sql = mysql_query("SELECT * FROM `devices` AS D WHERE D.status = '1' AND D.uptime > 0 AND D.uptime < '" . $config['uptime_warning'] . "' AND D.ignore = 0");
  } else {
  $sql = mysql_query("SELECT * FROM `devices` AS D, devices_perms AS P WHERE D.device_id = P.device_id AND P.user_id = '" . $_SESSION['user_id'] . "' AND D.status = '1' AND D.uptime > 0 AND D.uptime < '" .
  $config['uptime_warning'] . "' AND D.ignore = 0");
  }

  while ($device = mysql_fetch_assoc($sql))
  {
     generate_front_box("#aaffaa", "<center><strong>".generate_device_link($device, shorthost($device['hostname']))."</strong><br />
        <span style='font-size: 14px; font-weight: bold; margin: 5px; color: #009;'>设备<br />重启</span><br />
        <span class=body-date-1>".formatUptime($device['uptime'], 'short')."</span>
        </center>");
  }
}

if ($config['enable_syslog'])
{
  // Open Syslog Div
  echo("<div style='margin: 4px; clear: both; padding: 5px;'>
    <h3>最近的日志信息</h3>
  ");

  print_syslogs(array('pagesize' => $config['frontpage']['syslog']['items']));

  echo("</div>"); // Close Syslog Div

} else {
  // Open eventlog Div
  echo("<div style='margin: 4px; clear: both; padding: 5px;'>
    <h3>最近的事件日志内容</h3>
  ");

  print_events(array('pagesize' => $config['frontpage']['eventlog']['items']));
  
  echo("</div>"); // Close Syslog Div
}

echo("</div>");

?>
