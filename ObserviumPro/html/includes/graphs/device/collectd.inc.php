<?php // vim:fenc=utf-8:filetype=php:ts=4
/*
 * Copyright (C) 2009  Bruno Prémont <bonbons AT linux-vserver.org>
 *
 * This program is free software; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation; only version 2 of the License is applicable.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied wadsnty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
 * details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

require('includes/collectd/config.php');
require_once('includes/collectd/functions.php');
require_once('includes/collectd/definitions.php');

// Process input arguments
#$host   = read_var('host', $vars, null);
$host   = $device['hostname'];
if (is_null($host))
  return error400("?/?-?/?", "丢失主机名");
else if (!is_string($host))
  return error400("?/?-?/?", "期望1主机名");
else if (strlen($host) == 0)
  return error400("?/?-?/?", "主机名称不可以空白");

$plugin   = read_var('c_plugin', $vars, null);
if (is_null($plugin))
  return error400($host.'/?-?/?', "丢失插件名称");
else if (!is_string($plugin))
  return error400($host.'/?-?/?', "插件名称必须是字符串");
else if (strlen($plugin) == 0)
  return error400($host.'/?-?/?', "插件名称不可以空白");

$pinst  = read_var('c_plugin_instance', $vars, '');
if (!is_string($pinst))
  return error400($host.'/'.$plugin.'-?/?', "插件实例名称必须是字符串");

$type   = read_var('c_type', $vars, '');
if (is_null($type))
  return error400($host.'/'.$plugin.(strlen($pinst) ? '-'.$pinst : '').'/?', "丢失类别名称");
else if (!is_string($type))
  return error400($host.'/'.$plugin.(strlen($pinst) ? '-'.$pinst : '').'/?', "类型名称必须是字符串");
else if (strlen($type) == 0)
  return error400($host.'/'.$plugin.(strlen($pinst) ? '-'.$pinst : '').'/?', "类型名称不可以空白");

$tinst  = read_var('c_type_instance', $vars, '');

$graph_identifier = $host.'/'.$plugin.(strlen($pinst) ? '-'.$pinst : '').'/'.$type.(strlen($tinst) ? '-'.$tinst : '-*');

$timespan = read_var('timespan', $vars, $config['timespan'][0]['name']);
$timespan_ok = false;
foreach ($config['timespan'] as &$ts)
  if ($ts['name'] == $timespan)
    $timespan_ok = true;
if (!$timespan_ok)
  return error400($graph_identifier, "未知的时间要求");

$logscale   = (boolean)read_var('logarithmic', $vars, false);
$tinylegend = (boolean)read_var('tinylegend', $vars, false);

// Check that at least 1 RRD exists for the specified request
$all_tinst = collectd_list_tinsts($host, $plugin, $pinst, $type);
if (count($all_tinst) == 0)
  return error404($graph_identifier, "没有RRD文件发现图形");

// Now that we are read, do the bulk work
load_graph_definitions($logscale, $tinylegend);

$pinst = strlen($pinst) == 0 ? null : $pinst;
$tinst = strlen($tinst) == 0 ? null : $tinst;

$opts  = array();
$opts['timespan'] = $timespan;
if ($logscale)
  $opts['logarithmic'] = 1;
if ($tinylegend)
  $opts['tinylegend']  = 1;

$rrd_cmd = false;
if (isset($MetaGraphDefs[$type])) {
  $identifiers = array();
  foreach ($all_tinst as &$atinst)
    $identifiers[] = collectd_identifier($host, $plugin, is_null($pinst) ? '' : $pinst, $type, $atinst);
  collectd_flush($identifiers);
  $rrd_cmd = $MetaGraphDefs[$type]($host, $plugin, $pinst, $type, $all_tinst, $opts);
} else {
  if (!in_array(is_null($tinst) ? '' : $tinst, $all_tinst))
    return error404($host.'/'.$plugin.(!is_null($pinst) ? '-'.$pinst : '').'/'.$type.(!is_null($tinst) ? '-'.$tinst : ''), "没有RRD文件发现图形");
  collectd_flush(collectd_identifier($host, $plugin, is_null($pinst) ? '' : $pinst, $type, is_null($tinst) ? '' : $tinst));
  if (isset($GraphDefs[$type]))
    $rrd_cmd = collectd_draw_generic($timespan, $host, $plugin, $pinst, $type, $tinst);
  else
    $rrd_cmd = collectd_draw_rrd($host, $plugin, $pinst, $type, $tinst);
}

if(isset($rrd_cmd))
{
   # FIXME mres? wtf.
   if ($vars['from'])  { $from   = mres($vars['from']);   }
   if ($vars['to'])    { $to   = mres($vars['to']);   }
   $rrd_cmd .= " -s " . $from . " -e " . $to;
}

if ($vars['legend'] == "no")  { $rrd_cmd .= " -g "; }

if ($vars['height'] < "99")  { $rrd_cmd .= " --only-graph "; }
if ($vars['width'] <= "300") { $rrd_cmd .= " --font LEGEND:7:" . $config['mono_font'] . " --font AXIS:6:" . $config['mono_font'] . " "; }
else {                 $rrd_cmd .= " --font LEGEND:8:" . $config['mono_font'] . " --font AXIS:7:" . $config['mono_font'] . " "; }

$rt = 0;
$rrd_options = $rrd_cmd;

?>