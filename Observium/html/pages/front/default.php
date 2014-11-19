<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage web
 * @author     Dennis de Houx <info@all-in-one.be>
 * @copyright  (C) 2006-2014 Adam Armstrong
 * @version    1.9.2
 *
 */

$vars['page'] = 'overview'; // Always set variable page (need for generate_query_permitted())
 
foreach ($config['frontpage']['order'] as $module)
{
  switch ($module)
  {
    case "status_summary":
      include("includes/status-summary.inc.php");
      break;
    case "map":
      show_map($config);
      break;
    case "device_status_boxes":
      show_status_boxes($config);
      break;
    case "device_status":
      show_status($config);
      break;
    case "overall_traffic":
      show_traffic($config);
      break;
    case "custom_traffic":
      show_customtraffic($config);
      break;
    case "syslog":
      show_syslog($config);
      break;
    case "eventlog":
      show_eventlog($config);
      break;
    case "minigraphs":
      show_minigraphs($config);
      break;
    case "micrographs":
      show_micrographs($config);
      break;
  }
}

function show_map($config)
{
  ?>
<div class="row" style="margin-bottom: 10px;">
  <div class="col-md-12">

  <style type="text/css">
    #chart_div label { width: auto; display:inline; }
    #chart_div img { max-width: none; }
  </style>
  <!-- <div id="reset" style="width: 100%; text-align: right;"><input type="button" onclick="resetMap();" value="重置地图" /></div> -->
  <div id="chart_div" style="height: <?php echo($config['frontpage']['map']['height']); ?>px;"></div>

  <?php   if ($config['frontpage']['map']['api'] != 'google-mc') { ?>
  <script type='text/javascript' src='//www.google.com/jsapi'></script>
  <script type='text/javascript'>
    google.load('visualization', '1.1', {'packages': ['geochart']});
    google.setOnLoadCallback(drawRegionsMap);
    function drawRegionsMap() {
      var data = new google.visualization.DataTable();
      data.addColumn('number', '纬度');
      data.addColumn('number', '经度');
      data.addColumn('string', '位置');
      data.addColumn('number', '状态');
      data.addColumn('number', '设备');
      data.addColumn({type: 'string', role: 'tooltip'});
      data.addColumn('string', 'url');
      data.addRows([
        <?php
        $locations_up = array();
        $locations_down = array();
        foreach (get_locations() as $location)
        {
          $location_name = ($location == '' ? '[[UNKNOWN]]' : strtr(htmlspecialchars($location), "'", "`"));
          $location_url = generate_location_url($location);
          $devices_down = array();
          $devices_up = array();
          $count = $GLOBALS['cache']['device_locations'][$location];
          $down  = 0;
          foreach ($GLOBALS['cache']['devices']['id'] as $device)
          {
            if ($device['location'] == $location)
            {
              if ($device['status'] == "0" && $device['ignore'] == "0")
              {
                $down++;
                $devices_down[] = $device['hostname']; $lat = $device['location_lat']; $lon = $device['location_lon'];
              }
              else if ($device['status'] == "1")
              {
                $devices_up[]   = $device['hostname']; $lat = $device['location_lat']; $lon = $device['location_lon'];
              }
            }
          }
          $count = (($count < 100) ? $count : 100);
          if ($down > 0)
          {
            $locations_down[] = "[$lat, $lon, '$location_name', $down, ".$count*$down.", '".count($devices_up). " 设备启用, " . count($devices_down). " 设备关闭: (". implode(", ", $devices_down).")', '$location_url']";
          } else if ($count) {
            $locations_up[]   = "[".$lat.", ".$lon.", '".$location_name."',         0,       ".$count.", '".count($devices_up). " Devices UP: (". implode(", ", $devices_up).")', '$location_url']";
          }
        }
        echo(implode(",\n        ", array_merge($locations_up, $locations_down)));
      ?>
      ]);

      var options = {
        region: '<?php echo $config['frontpage']['map']['region']; ?>',
        resolution: '<?php echo $config['frontpage']['map']['resolution']; ?>',
        displayMode: 'markers',
        keepAspectRatio: 0,
        //width: 1240,
        //height: 480,
        is3D: true,
        legend: 'none',
        enableRegionInteractivity: true,
        <?php if ($config['frontpage']['map']['realworld']) { echo "\t\t  datalessRegionColor: '#93CA76',"; }
              else { echo "\t\t  datalessRegionColor: '#d5d5d5',"; }
              if ($config['frontpage']['map']['realworld']) { echo "\t\t  backgroundColor: {fill: '#000000'},"; } ?>
        backgroundColor: {fill: 'transparent'},
        magnifyingGlass: {enable: true, zoomFactor: 5},
        colorAxis: {values: [0, 1, 2, 3], colors: ['darkgreen', 'orange', 'orangered', 'red']},
        markerOpacity: 0.75,
        sizeAxis: {minValue: 1,  maxValue: 10, minSize: 10, maxSize: 40}
      };

      var view = new google.visualization.DataView(data);
      // exclude last url column in the GeoChart
      view.setColumns([0, 1, 2, 3, 4, 5]);

      var chart = new google.visualization.GeoChart(document.getElementById('chart_div'));
      google.visualization.events.addListener(chart, 'ready', onReady);
      function onReady() {
        google.visualization.events.addListener(chart, 'select', gotoLocation);
      }
      function gotoLocation() {
        var selection = chart.getSelection();
        var item = selection[0];
        var url = data.getValue(item.row, 6);
        window.location = url;
      }
      chart.draw(view, options);
    };
  </script>

  <?php } else { // begin google-mc

    $where  = ' WHERE 1 ';
    $where .= generate_query_permitted(array('device'), array('ignored' => TRUE));
    //Detect map center
    if (!is_numeric($config['frontpage']['map']['center']['lat']) || !is_numeric($config['frontpage']['map']['center']['lng']))
    {
      $map_center = dbFetchRow('SELECT MAX(`location_lon`) AS `lng_max`, MIN(`location_lon`) AS `lng_min`,
                               MAX(`location_lat`) AS `lat_max`, MIN(`location_lat`) AS `lat_min`
                               FROM `devices` '.$where);
      $map_center['lat'] = ($map_center['lat_max'] + $map_center['lat_min']) / 2;
      $map_center['lng'] = ($map_center['lng_max'] + $map_center['lng_min']) / 2;
      $config['frontpage']['map']['center']['lat'] = $map_center['lat'];
      $config['frontpage']['map']['center']['lng'] = $map_center['lng'];

      //Also auto-zoom
      if (!is_numeric($config['frontpage']['map']['zoom']))
      {
        $map_center['lat_size'] = abs($map_center['lat_max'] - $map_center['lat_min']);
        $map_center['lng_size'] = abs($map_center['lng_max'] - $map_center['lng_min']);
        $l_max = max($map_center['lng_size'], $map_center['lat_size'] * 2);
        // This is the magic array (2: min zoom, 10: max zoom).
        foreach (array(1 => 10, 2 => 9, 4 => 8, 6 => 7, 15 => 5, 45 => 4, 90 => 3, 360 => 2) as $g => $z)
        {
          if ($l_max <= $g)
          {
            $config['frontpage']['map']['zoom'] = $z;
            break;
          }
        }
      }
      /// r($map_center);
    } else {
      if (!is_numeric($config['frontpage']['map']['zoom'])) { $config['frontpage']['map']['zoom'] = 4; }
    } ?>

  <script type='text/javascript' src='//www.google.com/jsapi'></script>
  <script type="text/javascript" src="js/google/markerclusterer.js"></script>
  <script src="//maps.google.com/maps/api/js?sensor=false"></script>
  <?php if ($config['frontpage']['map']['clouds']) { ?> <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=weather"></script><?php } ?>

  <script type="text/javascript">
    google.load('visualization', '1.1', {'packages': ['geochart']});
    function getMapData() {
    var data = new google.visualization.DataTable();
    data.addColumn('number', '纬度');
    data.addColumn('number', '经度');
    data.addColumn('number', '正常数量');
    data.addColumn('number', '停止数量');
    data.addColumn({type: 'string', role: 'tooltip'});
    data.addColumn('string', '位置');
    data.addColumn('string', 'url');
    data.addRows([
    <?php
    $locations = array();
    foreach ($GLOBALS['cache']['devices']['id'] as $device)
    {
      if ($device["status"] == "0" && $device["ignore"] == "0" && $device["disabled"] == "0") {
        $locations[$device['location_lat']][$device['location_lon']]["down_hosts"][] = $device;
      } elseif ($device["status"] == "1") {
        $locations[$device['location_lat']][$device['location_lon']]["up_hosts"][] = $device;
      }
    }

    foreach ($locations as $la => $lat) {
      foreach ($lat as $lo => $lon) {
        $num_up = count($lon["up_hosts"]);
        $num_down = count($lon["down_hosts"]);
        $total_hosts = $num_up + $num_down;
        $tooltip = "$total_hosts Hosts";

        $location_name = "";
        if ($num_down > 0)
        {
          $location_name = ($lon['down_hosts'][0]['location'] == '' ? '[[UNKNOWN]]' : strtr(htmlspecialchars($lon['down_hosts'][0]['location']), "'", "`"));
          $location_url  = generate_location_url($lon['down_hosts'][0]['location']);
          $tooltip .= "\\n\\nDown hosts:";

          foreach ($lon["down_hosts"] as $down_host) {
            $tooltip .= "\\n" . $down_host['hostname'];
          }
        }
        elseif ($num_up > 0)
        {
          $location_name = ($lon['up_hosts'][0]['location'] == '' ? '[[UNKNOWN]]' : strtr(htmlspecialchars($lon['up_hosts'][0]['location']), "'", "`"));
          $location_url  = generate_location_url($lon['up_hosts'][0]['location']);
        }

        echo "[$la, $lo, $num_up, $num_down, \"$tooltip\", '$location_name', '$location_url'],\n      ";
      }
    } ?>

    ]);
    return data;
  }

  function initialize() {
    var data = getMapData();
    var markers = [];
    var base_link = '<?php echo generate_url(array("page" => "devices")); ?>';
    for (var i = 0; i < data.getNumberOfRows(); i++) {
      var latLng = new google.maps.LatLng(data.getValue(i, 0), data.getValue(i, 1));
      icon_ = '//maps.gstatic.com/mapfiles/ridefinder-images/mm_20_green.png';

      var num_up = data.getValue(i, 2);
      var num_down = data.getValue(i, 3);
      var location = data.getValue(i, 5);
      var ratio_up = num_up / (num_up + num_down);

      if (ratio_up < 0.9999) {
        icon_ = '//maps.gstatic.com/mapfiles/ridefinder-images/mm_20_red.png';
      }

      var marker = new google.maps.Marker({
        position: latLng,
        icon: icon_,
        title: data.getValue(i, 4),
        location: location,
        num_up: num_up,
        num_down: num_down,
        url: data.getValue(i, 6)
      });

//      marker.num_up = num_up;
//      marker.num_down = num_down;

      markers.push(marker);

      google.maps.event.addDomListener(marker, 'click', function() {
        window.location.href = this.url;
      });
    }
    var styles = [];
    for (var i = 0; i < 4; i++) {
      image_path = "/images/mapclusterer/";
      image_ext = ".png";
      styles.push({
        url: image_path + i + image_ext,
        height: 52,
        width: 53
      });
    }

    var mcOptions = {gridSize: 30,
                      maxZoom: 15,
                      zoomOnClick: false,
                      styles: styles
                    };
    var markerClusterer = new MarkerClusterer(map, markers, mcOptions);

    var iconCalculator = function(markers, numStyles) {
      var total_up = 0;
      var total_down = 0;
      for (var i = 0; i < markers.length; i++) {
        total_up += markers[i].num_up;
        total_down += markers[i].num_down;
      }

      var ratio_up = total_up / (total_up + total_down);

      //The map clusterer really does seem to use index-1...
      index_ = 1;
      if (ratio_up < 0.9999) {
        index_ = 4; // Could be 2, and then more code to use all 4 images
      }

      return {
        text: (total_up + total_down),
        index: index_
      };
    }

    markerClusterer.setCalculator(iconCalculator);
  }

  var center_ = new google.maps.LatLng(<?php echo $config['frontpage']['map']['center']['lat']; ?>, <?php echo $config['frontpage']['map']['center']['lng']; ?>);
  var map = new google.maps.Map(document.getElementById('chart_div'), {
    zoom: <?php echo $config['frontpage']['map']['zoom']?>,
    center: center_,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });

  <?php if ($config['frontpage']['map']['clouds']) { ?>
  var cloudLayer = new google.maps.weather.CloudLayer();
  cloudLayer.setMap(map);
  <?php } ?>

  function resetMap() {
    map.setZoom(4);
    map.panTo(center_);
  }

  google.maps.event.addListener(map, 'click', function(event) {
    map.setZoom(map.getZoom() + <?php echo $config['frontpage']['map']['zooms_per_click']; ?>);
    map.panTo(event.latLng);
  });
  google.maps.event.addDomListener(window, 'load', initialize);

  </script>
  <?php } // End google-mc ?>
  </div>
</div>
<?php
}
  // End show_map

  function show_traffic($config) {
  // Show Traffic
    // FIXME - This is not how we do port types.

    if ($_SESSION['userlevel'] >= '5') {
    $sql  = "select * from ports as I, devices as D WHERE `ifAlias` like 'Transit:%' AND I.device_id = D.device_id ORDER BY I.ifAlias";
    $query = mysql_query($sql);
    unset ($seperator);
    while ($interface = mysql_fetch_assoc($query)) {
      $ports['transit'] .= $seperator . $interface['port_id'];
      $seperator = ",";
    }
    $sql  = "select * from ports as I, devices as D WHERE `ifAlias` like 'Peering:%' AND I.device_id = D.device_id ORDER BY I.ifAlias";
    $query = mysql_query($sql);
    unset ($seperator);
    while ($interface = mysql_fetch_assoc($query)) {
      $ports['peering'] .= $seperator . $interface['port_id'];
      $seperator = ",";
    }
    $sql  = "select * from ports as I, devices as D WHERE `ifAlias` like 'Core:%' AND I.device_id = D.device_id ORDER BY I.ifAlias";
    $query = mysql_query($sql);
    unset ($seperator);
    while ($interface = mysql_fetch_assoc($query)) {
      $ports['core'] .= $seperator . $interface['port_id'];
      $seperator = ",";
    }
    $links['transit']  = generate_url(array("page" => "iftype", "type" => "transit"));
    $links['peering']  = generate_url(array("page" => "iftype", "type" => "peering"));
    $links['peer_trans']  = generate_url(array("page" => "iftype", "type" => "peering,transit"));
    echo('<div class="row">');
    echo('  <div class="col-md-6 ">');
    echo('    <h3 class="bill">今日整体透传流量</h3>');
    echo('    <a href="'.$links['transit'].'"><img src="graph.php?type=multiport_bits_separate&amp;id='.$ports['transit'].'&amp;legend=no&amp;from='.$config['time']['day'].'&amp;to='.$config['time']['now'].'&amp;width=480&amp;height=100" /></a>');
    echo('  </div>');
    echo('  <div class="col-md-6 ">');
    echo('    <h3 class="bill">今日总计对等交换流量</h3>');
    echo('    <a href="'.$links['peering'].'"><img src="graph.php?type=multiport_bits_separate&amp;id='.$ports['peering'].'&amp;legend=no&amp;from='.$config['time']['day'].'&amp;to='.$config['time']['now'].'&amp;width=480&amp;height=100" /></a>');
    echo('  </div>');
    echo('</div>');
    echo('<div class="row">');
    echo('  <div class="col-md-12">');
    echo('    <h3 class="bill">本月整体透传 &amp; 对等交换流量</h3>');
    echo('    <a href="'.$links['peer_trans'].'"><img src="graph.php?type=multiport_bits_duo_separate&amp;id='.$ports['peering'].'&amp;idb='.$ports['transit'].'&amp;legend=no&amp;from='.$config['time']['month'].'&amp;to='.$config['time']['now'].'&amp;width=1100&amp;height=200" /></a>');
    echo('  </div>');
    echo('</div>');
    unset($links);
    }
  }
  // End show_traffic

  function show_customtraffic($config) {
  // Show Custom Traffic
    if ($_SESSION['userlevel'] >= '5') {
    $config['frontpage']['custom_traffic']['title'] = (empty($config['frontpage']['custom_traffic']['title']) ? "自定义流量" : $config['frontpage']['custom_traffic']['title']);
    echo("<div class=\"row\">");
    echo("  <div class=\"col-md-6 \">");
    echo("    <h3 class=\"bill\">".$config['frontpage']['custom_traffic']['title']." 今天</h3>");
    echo("    <img src=\"graph.php?type=multiport_bits&amp;id=".$config['frontpage']['custom_traffic']['ids']."&amp;legend=no&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=480&amp;height=100\"/>");
    echo("  </div>");
    echo("  <div class=\"col-md-6 \">");
    echo("    <h3 class=\"bill\">".$config['frontpage']['custom_traffic']['title']." 本周</h3>");
    echo("    <img src=\"graph.php?type=multiport_bits&amp;id=".$config['frontpage']['custom_traffic']['ids']."&amp;legend=no&amp;from=".$config['time']['week']."&amp;to=".$config['time']['now']."&amp;width=480&amp;height=100\"/>");
    echo("  </div>");
    echo("</div>");
    echo("<div class=\"row\">");
    echo("  <div class=\"col-md-12 \">");
    echo("    <h3 class=\"bill\">".$config['frontpage']['custom_traffic']['title']." 本月</h3>");
    echo("    <img src=\"graph.php?type=multiport_bits&amp;id=".$config['frontpage']['custom_traffic']['ids']."&amp;legend=no&amp;from=".$config['time']['month']."&amp;to=".$config['time']['now']."&amp;width=1100&amp;height=200\"/>");
    echo("  </div>");
    echo("</div>");
    }
  }  // End show_customtraffic

  function show_minigraphs($config)
  {
    // Show Custom MiniGraphs
    if ($_SESSION['userlevel'] >= '5')
    {
    $minigraphs = explode(";", $config['frontpage']['minigraphs']['ids']);
    $legend = (($config['frontpage']['minigraphs']['legend'] == false) ? "no" : "yes");
    echo("<div class=\"row\">\n");
    echo("  <div class=\"col-md-12\">\n");
    if ($config['frontpage']['minigraphs']['title'])
    {
      echo("    <h3 class=\"bill\">".$config['frontpage']['minigraphs']['title']."</h3>\n");
    }

    foreach ($minigraphs as $graph)
    {
      list($device, $type, $header) = explode(",", $graph, 3);
      if (strpos($type, "device") === false)
      {
      $links = generate_url(array("page" => "graphs", "type" => $type, "id" => $device));
    //, "from" => $config['time']['day'], "to" => $config['time']['now']));
      echo("    <div class=\"pull-left\"><p style=\"text-align: center; margin-bottom: 0px;\"><strong>".$header."</strong></p><a href=\"".$links."\"><img src=\"graph.php?type=".$type."&amp;id=".$device."&amp;legend=".$legend."&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=215&amp;height=100\"/></a></div>\n");
      } else {
      $links = generate_url(array("page" => "graphs", "type" => $type, "device" => $device));
    //, "from" => $config['time']['day'], "to" => $config['time']['now']));
      echo("    <div class=\"pull-left\"><p style=\"text-align: center; margin-bottom: 0px;\"><strong>".$header."</strong></p><a href=\"".$links."\"><img src=\"graph.php?type=".$type."&amp;device=".$device."&amp;legend=".$legend."&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=215&amp;height=100\"/></a></div>\n");
      }
    }
    unset($links);
    echo("  </div>\n");
    echo("</div>\n");
    }
  } // End show_minigraphs

  function show_micrographs($config)
  {
    echo("<!-- Show custom micrographs -->\n");
    if ($_SESSION['userlevel'] >= '5')
    {
    $width = $config['frontpage']['micrograph_settings']['width'];
    $height = $config['frontpage']['micrograph_settings']['height'];
    echo("<div class=\"row\">\n");
    echo("  <div class=\"col-md-12\">\n");
    echo("  <table class=\"table table-bordered table-condensed-more table-rounded\">\n");
    echo("    <tbody>\n");
    foreach ($config['frontpage']['micrographs'] as $row)
    {
      $micrographs = explode(";", $row['ids']);
      $legend = (($row['legend'] == false) ? "no" : "yes");
      echo("    <tr>\n");
      if ($row['title'])
      {
      echo("      <th style=\"vertical-align: middle;\">".$row['title']."</th>\n");
      }

      echo("      <td>");
      foreach ($micrographs as $graph)
      {
      list($device, $type, $header) = explode(",", $graph, 3);
      if (strpos($type, "device") === false)
      {
    $which = "id";
      } else {
      $which = "device";
    }

      $links = generate_url(array("page" => "graphs", "type" => $type, $which => $device));
      echo("<div class=\"pull-left\">");
      if ($header)
      {
    echo("<p style=\"text-align: center; margin-bottom: 0px;\">".$header."</p>");
      }
      echo("<a href=\"".$links."\" style=\"margin-left: 5px\"><img src=\"graph.php?type=".$type."&amp;".$which."=".$device."&amp;legend=".$legend."&amp;width=".$width."&amp;height=".$height."\"/></a>");
      echo("</div>");
      }
      unset($links);
      echo("      </td>\n");
      echo("    </tr>\n");
    }
    echo("    </tbody>\n");
    echo("  </table>\n");
    echo("  </div>\n");
    echo("</div>\n");
    }
  } // End show_micrographs

  function show_status($config)
  {
    // Show Status
    echo("<div class=\"row\">");
    echo("  <div class=\"col-md-12\">");
    echo("    <h3 class=\"bill\">设备报警</h3>");
    print_status($config['frontpage']['device_status']);
    echo("  </div>");
    echo("</div>");
  } // End show_status

  function show_status_boxes($config)
  {
    // Show Status Boxes
    echo("<div class=\"row\">\n");
    echo('  <div class="col-md-12" style="padding-right: 0px;">'.PHP_EOL);
    print_status_boxes($config['frontpage']['device_status']);
    echo("  </div>\n");
    echo("</div>\n");
  } // End show_status_boxes

  function show_syslog($config)
  {
    // Show syslog
    $show_syslog = "<div class=\"row\">";
    $show_syslog .= "  <div class=\"col-md-12 \">";
    $show_syslog .= "    <h3 class=\"bill\">最近的日志信息</h3>";
    echo $show_syslog;
    print_syslogs(array('pagesize' => $config['frontpage']['syslog']['items'], 'priority' => $config['frontpage']['syslog']['priority']));
    $show_syslog = "  </div>";
    $show_syslog .= "</div>";
    echo $show_syslog;
  } // end show_syslog

  function show_eventlog($config)
  {
    // Show eventlog
    echo <<<EVENTS
    <div class="row">
      <div class="col-md-12">
        <h3 class="bill">最近的事件日志条目</h3>
EVENTS;
    print_events(array('pagesize' => $config['frontpage']['eventlog']['items']));
    echo "  </div>\n</div>";
  } // End show_eventlog

// EOF
