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

print_optionbar_start();

$link_array = array('page'    => 'device',
                    'device'  => $device['device_id'],
                    'tab'     => 'routing',
                    'proto'   => 'cef');

if(!isset($vars['view'])) { $vars['view'] = "basic"; }

echo('<span style="font-weight: bold;">CEF</span> &#187; ');

if ($vars['view'] == "basic") { echo("<span class='pagemenu-selected'>"); }
echo(generate_link("基础", $link_array,array('view'=>'basic')));
if ($vars['view'] == "basic") { echo("</span>"); }

echo(" | ");

if ($vars['view'] == "graphs") { echo("<span class='pagemenu-selected'>"); }
echo(generate_link("流量图", $link_array,array('view'=>'graphs')));
if ($vars['view'] == "graphs") { echo("</span>"); }

print_optionbar_end();

echo('
        <table  border="0" cellspacing="0" cellpadding="5" width="100%">');

echo('<tr><th><a title="物理硬件实体">主体</a></th>
          <th><a title="Address Family">AFI</a></th>
          <th><a title="CEF交换路径">路径</a></th>
          <th><a title="丢弃的数据包数量.">丢弃</a></th>
          <th><a title="Number of packets that could not be switched in the normal path and were punted to the next-fastest switching vector.">Punt</a></th>
          <th><a title="Number of packets that could not be switched in the normal path and were punted to the host.<br />For switch paths other than a centralized turbo switch path, punt and punt2host function the same way. With punt2host from a centralized turbo switch path (PAS and RSP), punt will punt the packet to LES, but punt2host will bypass LES and punt directly to process switching.">Punt2Host</a></th>
      </tr>');

$i=0;

foreach (dbFetchRows("SELECT * FROM `cef_switching` WHERE `device_id` = ?  ORDER BY `entPhysicalIndex`, `afi`, `cef_index`", array($device['device_id'])) as $cef)
{

  $entity = dbFetchRow("SELECT * FROM `entPhysical` WHERE device_id = ? AND `entPhysicalIndex` = ?", array($device['device_id'], $cef['entPhysicalIndex']));

  if (!is_integer($i/2)) { $bg_colour = $list_colour_a; } else { $bg_colour = $list_colour_b; }

  $interval = $cef['updated'] - $cef['updated_prev'];

  if (!$entity['entPhysicalModelName'] && $entity['entPhysicalContainedIn'])
  {
    $parent_entity = dbFetchRow("SELECT * FROM `entPhysical` WHERE device_id = ? AND `entPhysicalIndex` = ?", array($device['device_id'], $entity['entPhysicalContainedIn']));
    $entity_name = $entity['entPhysicalName'] . " (" . $parent_entity['entPhysicalModelName'] .")";
  } else {
    $entity_name = $entity['entPhysicalName'] . " (" . $entity['entPhysicalModelName'] .")";
  }

  echo("<tr bgcolor=$bg_colour><td>".$entity_name."</td>
            <td>".$cef['afi']."</td>
            <td>");

  switch ($cef['cef_path']) {
    case "RP RIB":
      echo '<a title="Process switching with CEF assistance.">RP RIB</a>';
      break;
    case "RP LES":
      echo '<a title="Low-end switching. Centralized CEF switch path.">RP LES</a>';
      break;
    case "RP PAS":
      echo '<a title="CEF turbo switch path.">RP PAS</a>';
      break;
    default:
       echo $cef['cef_path'];
  }

  echo("</td>");
  echo("<td>".format_si($cef['drop']));
  if ($cef['drop'] > $cef['drop_prev']) { echo(" <span style='color:red;'>(".round(($cef['drop']-$cef['drop_prev'])/$interval,2)."/sec)</span>"); }
  echo("</td>");
  echo("<td>".format_si($cef['punt']));
  if ($cef['punt'] > $cef['punt_prev']) { echo(" <span style='color:red;'>(".round(($cef['punt']-$cef['punt_prev'])/$interval,2)."/sec)</span>"); }
  echo("</td>");
  echo("<td>".format_si($cef['punt2host']));
  if ($cef['punt2host'] > $cef['punt2host_prev']) { echo(" <span style='color:red;'>(".round(($cef['punt2host']-$cef['punt2host_prev'])/$interval,2)."/sec)</span>"); }
  echo("</td>");

        echo("</tr>
       ");

  if ($vars['view'] == "graphs")
  {
    $graph_array['height'] = "100";
    $graph_array['width']  = "215";
    $graph_array['to']     = $config['time']['now'];
    $graph_array['id']     = $cef['cef_switching_id'];
    $graph_array['type']   = "cefswitching_graph";

    echo("<tr bgcolor='$bg_colour'><td colspan=6>");

    print_graph_row($graph_array);

    echo("</td></tr>");
  }

  $i++;
}

echo("</table>");

// EOF
