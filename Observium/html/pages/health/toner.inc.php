<?php

$graph_type = "toner_usage";

if ($vars['view'] == "graphs") { $stripe_class = "table-striped-two"; } else { $stripe_class = "table-striped"; }

echo('<table class="table '.$stripe_class.' table-bordered table-condensed">');
echo('  <thead>');

echo("<tr class=strong>
        <th width=280>设备</th>
        <th>Toner</th>
        <th width=100></th>
        <th width=200>等级</th>
        <th width=70>剩余</th>
      </tr>");

echo('</thead>');

foreach (dbFetchRows("SELECT * FROM `toner` AS S, `devices` AS D WHERE S.device_id = D.device_id ORDER BY D.hostname, S.toner_descr") as $toner)
{
  if (isset($cache['devices']['id'][$toner['device_id']]))
  {
    if (!$config['web_show_disabled'])
    {
      if ($cache['devices']['id'][$toner['device_id']]['disabled']) { continue; }
    }

    $total = $toner['toner_capacity'];
    $perc = $toner['toner_current'];

    $graph_array['type']        = $graph_type;
    $graph_array['id']          = $toner['toner_id'];
    $graph_array['from']        = $config['time']['day'];
    $graph_array['to']          = $config['time']['now'];
    $graph_array['height']      = "20";
    $graph_array['width']       = "80";
    $graph_array_zoom           = $graph_array;
    $graph_array_zoom['height'] = "150";
    $graph_array_zoom['width']  = "400";
    $link = "graphs/id=" . $graph_array['id'] . "/type=" . $graph_array['type'] . "/from=" . $graph_array['from'] . "/to=" . $graph_array['to'] . "/";
    $mini_graph = overlib_link($link, generate_graph_tag($graph_array), generate_graph_tag($graph_array_zoom), NULL);

    $background = get_percentage_colours(100 - $perc);

    /// FIXME - popup for toner entity.

    echo('<tr><td class="entity">' . generate_device_link($toner) . '</td><td class="strong">' . $toner['toner_descr'] . '</td>
         <td>'.$mini_graph.'</td>
         <td>
          <a href="#">'.print_percentage_bar (400, 20, $perc, "$perc%", "ffffff", $background['left'], $free, "ffffff", $background['right']).'</a>
          </td><td>'.$perc.'%</td></tr>');

    if ($vars['view'] == "graphs")
    {
      echo("<tr></tr><tr class='health'><td colspan=5>");

      unset($graph_array['height'], $graph_array['width'], $graph_array['legend']);
      $graph_array['to']     = $config['time']['now'];
      $graph_array['id']     = $toner['toner_id'];
      $graph_array['type']   = $graph_type;

      print_graph_row($graph_array);

      echo("</td></tr>");
    } # endif graphs
  }
}

echo("</table>");

// EOF
