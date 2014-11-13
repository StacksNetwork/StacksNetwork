<?php

$graph_type = "processor_usage";

if ($vars['view'] == "graphs") { $stripe_class = "table-striped-two"; } else { $stripe_class = "table-striped"; }

echo('<table class="table '.$stripe_class.' table-condensed table-bordered">');
echo('  <thead>');
echo('    <tr>');
echo('      <th width="200">设备</th>');
echo('      <th>处理器</th>');
echo('      <th width="100"></th>');
echo('      <th width="250">使用</th>');
echo('    </tr>');
echo('  </thead>');

$sql  = "SELECT *, `processors`.`processor_id` AS `processor_id`";
$sql .= " FROM `processors`";
$sql .= " JOIN `devices` ON `processors`.`device_id` = `devices`.`device_id`";
$sql .= " LEFT JOIN  `processors-state` ON `processors`.`processor_id` = `processors-state`.`processor_id`";
$sql .= " ORDER BY `devices`.`hostname`, `processors`.`processor_descr`";

foreach (dbFetchRows($sql) as $proc)
{
  if (isset($cache['devices']['id'][$proc['device_id']]))
  {
    if (!$config['web_show_disabled'])
    {
      if ($cache['devices']['id'][$proc['device_id']]['disabled']) { continue; }
    }

    $device = $proc;

    // FIXME should that really be done here? :-)
    // FIXME - not it shouldn't. we need some per-os rewriting on discovery-time.
    $text_descr = $proc['processor_descr'];
    $text_descr = str_replace("路由处理器", "RP", $text_descr);
    $text_descr = str_replace("交换处理器", "SP", $text_descr);
    $text_descr = str_replace("子模块", "Module ", $text_descr);
    $text_descr = str_replace("DFC卡", "DFC", $text_descr);

    $graph_array           = array();
    $graph_array['to']     = $config['time']['now'];
    $graph_array['id']     = $proc['processor_id'];
    $graph_array['type']   = $graph_type;
    $graph_array['legend'] = "no";

    $link_array = $graph_array;
    $link_array['page'] = "graphs";
    unset($link_array['height'], $link_array['width'], $link_array['legend']);
    $link_graph = generate_url($link_array);

    $link = generate_url( array("page" => "device", "device" => $proc['device_id'], "tab" => "health", "metric" => 'processor'));

    $overlib_content = generate_overlib_content($graph_array, $proc['hostname'] ." - " . $text_descr, NULL);

    $graph_array['width'] = 80; $graph_array['height'] = 20; $graph_array['bg'] = 'ffffff00'; # the 00 at the end makes the area transparent.
    $graph_array['from'] = $config['time']['day'];
    $mini_graph =  generate_graph_tag($graph_array);

    $perc = round($proc['processor_usage']);
    $background = get_percentage_colours($perc);

    echo('<tr>
          <td class="entity">' . generate_device_link($proc) . '</td>
          <td>'.overlib_link($link, $text_descr,$overlib_content).'</td>
          <td>'.overlib_link($link_graph, $mini_graph, $overlib_content).'</td>
          <td><a href="'.$proc_url.'" '.$proc_popup.'>
            '.print_percentage_bar (400, 20, $perc, $perc."%", "ffffff", $background['left'], (100 - $perc)."%" , "ffffff", $background['right']).'
            </a>
          </td>
        </tr>
     ');

    if ($vars['view'] == "graphs")
    {
      echo("<tr><td colspan=5>");

      unset($graph_array['height'], $graph_array['width'], $graph_array['legend']);
      $graph_array['to']     = $config['time']['now'];
      $graph_array['id']     = $proc['processor_id'];
      $graph_array['type']   = $graph_type;

      print_graph_row($graph_array);

      echo("</td></tr>");
    } # endif graphs

  }
}

echo("</table>");

// EOF
