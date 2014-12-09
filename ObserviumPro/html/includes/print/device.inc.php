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

// DOCME needs phpdoc block
function print_device_header($device)
{
  global $config;

  if (!is_array($device)) { print_error("无效的设备通过对 print_device_header!"); }

  if ($device['status'] == '0') {  $class = "div-alert"; } else {   $class = "div-normal"; }
  if ($device['ignore'] == '1')
  {
    $class = "div-ignore-alert";
    if ($device['status'] == '1')
    {
      $class = "div-ignore";
    }
  }

  if ($device['disabled'] == '1')
  {
    $class = "div-disabled";
  }

  $type = strtolower($device['os']);

  echo('<table class="table table-hover table-striped table-bordered table-condensed table-rounded" style="vertical-align: middle; margin-bottom: 10px;">');
  echo('
              <tr class="'.$device['html_row_class'].'" style="vertical-align: middle;">
               <td style="width: 1px; background-color: '.$device['html_tab_colour'].'; margin: 0px; padding: 0px; min-width: 10px; max-width: 10px;"></td>
               <td style="width: 70px; text-align: center; vertical-align: middle;">'.getImage($device).'</td>
               <td style="vertical-align: middle;"><span style="font-size: 20px;">' . generate_device_link($device) . '</span>
               <br /><a href="'.generate_location_url($device['location']).'">' . htmlspecialchars($device['location']) . '</a></td>
               <td>');

  if (isset($config['os'][$device['os']]['over']))
  {
    $graphs = $config['os'][$device['os']]['over'];
  }
  elseif (isset($device['os_group']) && isset($config['os'][$device['os_group']]['over']))
  {
    $graphs = $config['os'][$device['os_group']]['over'];
  }
  else
  {
    $graphs = $config['os']['default']['over'];
  }

  $graph_array = array();
  $graph_array['height'] = "100";
  $graph_array['width']  = "310";
  $graph_array['to']     = $config['time']['now'];
  $graph_array['device'] = $device['device_id'];
  $graph_array['type']   = "device_bits";
  $graph_array['from']   = $config['time']['day'];
  $graph_array['legend'] = "no";
  $graph_array['popup_title'] = $descr;

  $graph_array['height'] = "45";
  $graph_array['width']  = "150";
  $graph_array['bg']     = "FFFFFF00";

  // Preprocess device graphs array
  foreach ($device['graphs'] as $graph)
  {
    $graphs_enabled[] = $graph['graph'];
  }

  foreach ($graphs as $entry)
  {
    if ($entry['graph'] && in_array(str_replace('device_','',$entry['graph']),$graphs_enabled) !== FALSE)
    {
      $graph_array['type'] = $entry['graph'];

      if (isset($entry['text']))
      {
        // Text is provided in the array, this overrides the default
        $text = $entry['text'];
      } else {
        // No text provided for the minigraph, fetch from array
        preg_match('/^(?P<type>[a-z0-9A-Z-]+)_(?P<subtype>[a-z0-9A-Z-_]+)/', $entry['graph'], $graphtype);

        if (isset($graphtype['type']) && isset($graphtype['subtype']))
        {
          $type = $graphtype['type'];
          $subtype = $graphtype['subtype'];
        
          $text = $config['graph_types'][$type][$subtype]['descr'];
        } else {
          $text = nicecase($subtype); // Fallback to the type itself as a string, should not happen!
        }
      }

      echo('<div class="pull-right" style="padding: 2px; margin: 0;">');
      print_graph_popup($graph_array);
      echo("<div style='padding: 0px; font-weight: bold; font-size: 7pt; text-align: center;'>$text</div>");
      echo("</div>");
    }
  }

  echo('    </td>
   </tr>
 </table>');
}

// EOF
