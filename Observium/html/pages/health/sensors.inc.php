<?php

global $sensor_type;

$sql  = "SELECT *, `sensors`.`sensor_id` AS `sensor_id`";
$sql .= " FROM `sensors`";
$sql .= " JOIN `devices` ON `sensors`.`device_id` = `devices`.`device_id`";
$sql .= " LEFT JOIN  `sensors-state` ON `sensors`.`sensor_id` = `sensors-state`.`sensor_id`";
$sql .= " WHERE `sensors`.`sensor_class` = '".$sensor_type."'";
$sql .= " ORDER BY `devices`.`hostname`, `sensors`.`sensor_descr`";

if ($vars['view'] == "graphs") { $stripe_class = "table-striped-two"; } else { $stripe_class = "table-striped"; }

echo('<table class="table '.$stripe_class.' table-condensed table-bordered">');
echo('  <thead>');
echo('    <tr>');
echo('      <th width="250">设备</th>');
echo('      <th>传感器</th>');
echo('      <th width="40"></th>');
echo('      <th width="100"></th>');
echo('      <th width="100">当前</th>');
echo('      <th width="175">阈值</th>');
echo('    </tr>');
echo('  </thead>');

echo('  <tbody>');

foreach (dbFetchRows($sql, $param) as $sensor)
{
  if (isset($cache['devices']['id'][$sensor['device_id']]))
  {
    if (!$config['web_show_disabled'])
    {
      if ($cache['devices']['id'][$sensor['device_id']]['disabled']) { continue; }
    }

    humanize_sensor($sensor);

    $alert = ($sensor['state_event'] == 'alert' ? 'oicon-exclamation-red' : '');

    // FIXME - make this "four graphs in popup" a function/include and "small graph" a function.
    // FIXME - DUPLICATED IN device/overview/sensors

    $graph_array           = array();
    $graph_array['to']     = $config['time']['now'];
    $graph_array['id']     = $sensor['sensor_id'];
    $graph_array['type']   = "sensor_$sensor_type";
    $graph_array['legend'] = "no";

    $link_array = $graph_array;
    $link_array['page'] = "graphs";
    unset($link_array['height'], $link_array['width'], $link_array['legend']);
    $link_graph = generate_url($link_array);

    $link = generate_url(array("page" => "device", "device" => $sensor['device_id'], "tab" => "health", "metric" => $sensor['sensor_class']));

    $overlib_content = generate_overlib_content($graph_array, $sensor['hostname'] ." - " . $sensor['sensor_descr'], NULL);

    $graph_array['width'] = 80; $graph_array['height'] = 20; $graph_array['bg'] = 'ffffff00'; # the 00 at the end makes the area transparent.
    $graph_array['from'] = $config['time']['day'];

    $sensor['sensor_descr'] = truncate($sensor['sensor_descr'], 48, '');
    if ($sensor['sensor_state'])
    {
      $sensor_value = $sensor['state_name'];
      $sensor_minigraph = overlib_link($link, generate_graph_tag($graph_array), $overlib_content);
      $sensor_threshold = '';
    } else {
      $sensor_value = $sensor['human_value'];
      $sensor_minigraph = overlib_link($link, generate_graph_tag($graph_array), $overlib_content);
      $sensor_threshold = round($sensor['sensor_limit_low'],2) . $sensor['sensor_symbol'] . ' - ' . round($sensor['sensor_limit'],2) . $sensor['sensor_symbol'];
    }

    echo('<tr class="device-overview">
          <td class="entity">' . generate_device_link($sensor) . '</td>
          <td>' . overlib_link($link, $sensor['sensor_descr'], $overlib_content) . '</td>
          <td class="text-right"><i class="'.$alert.'"></i></td>
          <td>'.$sensor_minigraph.'</td>
          <td><strong>'.overlib_link($link, '<span class="'.$sensor['state_class'].'">' . $sensor_value . $sensor['sensor_symbol'] . '</span>', $overlib_content).'</strong></td>
          <td>' . $sensor_threshold . '</td>
          </tr>' . PHP_EOL);

    if ($vars['view'] == "graphs")
    {
      echo("<tr><td colspan=7>");

      unset($graph_array['height'], $graph_array['width'], $graph_array['legend']);
      $graph_array['to']     = $config['time']['now'];
      $graph_array['id']     = $sensor['sensor_id'];
      $graph_array['type']   = "sensor_$sensor_type";

      print_graph_row($graph_array);

      echo("</td></tr>");
    } # endif graphs

 }
}

echo("</tbody>");
echo("</table>");

// EOF
