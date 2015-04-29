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

echo("<span style='font-weight: bold;'>服务</span> &#187; ");

$menu_options = array('basic' => '基本',
                      'details' => '详情');

if (!$vars['view']) { $vars['view'] = "basic"; }

$sep = "";
foreach ($menu_options as $option => $text)
{
  if (empty($vars['view'])) { $vars['view'] = $option; }
  echo($sep);
  if ($vars['view'] == $option) { echo("<span class='pagemenu-selected'>"); }
  echo(generate_link($text, $vars, array('view'=>$option)));
  if ($vars['view'] == $option) { echo("</span>"); }
  $sep = " | ";
}

unset($sep);

print_optionbar_end();

if (dbFetchCell("SELECT COUNT(service_id) FROM `services` WHERE device_id = ?", array($device['device_id'])) > '0')
{
  echo("<div style='margin: 5px;'><table cellpadding=7 border=0 cellspacing=0 width=100%>");
  $i = "1";
  foreach (dbFetchRows("SELECT * FROM `services` WHERE `device_id` = ? ORDER BY `service_type`", array($device['device_id'])) as $service)
  {
    include("includes/print-service.inc.php");

       if ($vars['view'] == "details")
       {
         $graph_array['height'] = "100";
         $graph_array['width']  = "210";
         $graph_array['to']     = $config['time']['now'];
         $graph_array['id']     = $service['service_id'];
         $graph_array['type']   = "service_availability";

         $periods = array('day', 'week', 'month', 'year');

         echo('<tr style="background-color: '.$bg.'; padding: 7px;"><td colspan=4>');

         print_graph_row($graph_array);

         echo("</td></tr>");
       }
  }
  echo("</table></div>");
}
else
{
   echo("无服务");
}

$page_title[] = "服务";

// EOF
