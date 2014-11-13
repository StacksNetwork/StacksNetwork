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

unset($vars['page']);

// Setup here

if (isset($_SESSION['widescreen']))
{
  $graph_width=1700;
  $thumb_width=180;
} else {
  $graph_width=1159;
  $thumb_width=113;
}

$timestamp_pattern = '/^(\d{4})-(\d{2})-(\d{2}) ([01][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$/';
if (isset($vars['timestamp_from']) && preg_match($timestamp_pattern, $vars['timestamp_from']))
{
  $vars['from'] = strtotime($vars['timestamp_from']);
  unset($vars['timestamp_from']);
}
if (isset($vars['timestamp_to'])   && preg_match($timestamp_pattern, $vars['timestamp_to']))
{
  $vars['to'] = strtotime($vars['timestamp_to']);
  unset($vars['timestamp_to']);
}
if (!is_numeric($vars['from'])) { $vars['from'] = $config['time']['day']; }
if (!is_numeric($vars['to']))   { $vars['to']   = $config['time']['now']; }

preg_match('/^(?P<type>[a-z0-9A-Z-]+)_(?P<subtype>.+)/', $vars['type'], $graphtype);

if ($debug) print_vars($graphtype);

$type = $graphtype['type'];
$subtype = $graphtype['subtype'];

if (is_numeric($vars['device']))
{
  $device = device_by_id_cache($vars['device']);
} elseif (!empty($vars['device'])) {
  $device = device_by_name($vars['device']);
}

if (is_file("includes/graphs/".$type."/auth.inc.php"))
{
  include("includes/graphs/".$type."/auth.inc.php");
}

if (!$auth)
{
  include("includes/error-no-perm.inc.php");
} else {

  // If there is no valid device specified in the URL, generate an error.
  ## Not all things here have a device (multiple-port graphs or location graphs)
  //if (!is_array($device))
  //{
  //  print_error('<h3>No valid device specified</h3>
  //                  A valid device was not specified in the URL. Please retype and try again.');
  //  break;
  //}

  // Print the device header
  if (isset($device) && is_array($device))
  {
    print_device_header($device);
  }

  if (isset($config['graph_types'][$type][$subtype]['descr']))
  {
    $title .= " :: ".$config['graph_types'][$type][$subtype]['descr'];
  } else {
    $title .= " :: ".ucfirst($subtype);
  }

  // Generate navbar with subtypes
  $graph_array = $vars;
  $graph_array['height'] = "60";
  $graph_array['width']  = $thumb_width;
  $graph_array['legend'] = "no";
  $graph_array['to']     = $config['time']['now'];

  $navbar = array('brand' => "流量图", 'class' => "navbar-narrow");

  switch ($type)
  {
    case 'device':
    case 'sensor':
    case 'cefswitching':
    case 'munin':
      $navbar['options']['graph'] = array('text' => ucfirst($type).' ('.$subtype.')',
                                          'url' => generate_url($vars, array('type' => $type."_".$subtype, 'page' => "graphs")));
      break;
    default:
      # Load our list of available graphtypes for this object
      /// FIXME not all of these are going to be valid
      /// This is terrible. --mike
      /// The future solution is to keep a 'registry' of which graphtypes apply to which entities and devices.
      /// I'm not quite sure if this is going to be too slow. --adama 2013-11-11
      if ($handle = opendir($config['html_dir'] . "/includes/graphs/".$type."/"))
      {
        while (false !== ($file = readdir($handle)))
        {
          if ($file != "." && $file != ".." && $file != "auth.inc.php" && $file != "graph.inc.php" && strstr($file, ".inc.php"))
          {
            $types[] = str_replace(".inc.php", "", $file);
          }
        }
        closedir($handle);
      }

      foreach ($title_array as $key => $element)
      {
        $navbar['options'][$key] = $element;
      }

      $navbar['options']['graph']     = array('text' => 'Graph');

      sort($types);

      foreach ($types as $avail_type)
      {
        if ($subtype == $avail_type)
        {
          $navbar['options']['graph']['suboptions'][$avail_type]['class'] = 'active';
          $navbar['options']['graph']['text'] .= ' ('.$avail_type.')';
        }
        $navbar['options']['graph']['suboptions'][$avail_type]['text'] = $avail_type;
        $navbar['options']['graph']['suboptions'][$avail_type]['url'] = generate_url($vars, array('type' => $type."_".$avail_type, 'page' => "graphs"));
      }
  }

  print_navbar($navbar);

  // Start form for the custom range.

  echo '<div class="well well-shaded">';

  $thumb_array = array('sixhour' => '6 小时',
                       'day' => '24 小时',
                       'twoday' => '48 小时',
                       'week' => '1 周',
                       //'twoweek' => '2 周',
                       'month' => '1 月',
                       //'twomonth' => '2 月',
                       'year' => '1 年',
                       'twoyear' => '2 年'
                      );

  echo('<table width=100% style="background: transparent;"><tr>');

  foreach ($thumb_array as $period => $text)
  {
    $graph_array['from']   = $config['time'][$period];

    $link_array = $vars;
    $link_array['from'] = $graph_array['from'];
    $link_array['to'] = $graph_array['to'];
    $link_array['page'] = "graphs";
    $link = generate_url($link_array);

    echo('<td align=center>');
    echo('<span class="device-head">'.$text.'</span><br />');
    echo('<a href="'.$link.'">');
    echo(generate_graph_tag($graph_array));
    echo('</a>');
    echo('</td>');

  }

  echo('</tr></table>');

  $graph_array = $vars;
  $graph_array['height'] = "300";
  $graph_array['width']  = $graph_width;

  print_optionbar_end();

  $search = array();
  $search[] = array('type'    => 'datetime',
                    'id'      => 'timestamp',
                    'presets' => TRUE,
                    'min'     => '2007-04-03 16:06:59',  // Hehe, who will guess what this date/time means? --mike
                                                         // First commit! Though Observium was already 7 months old by that point. --adama
                    'max'     => date('Y-m-d 23:59:59'), // Today
                    'from'    => date('Y-m-d H:i:s', $vars['from']),
                    'to'      => date('Y-m-d H:i:s', $vars['to']));
  print_search($search, NULL, 'update');
  unset($search);

// Run the graph to get data array out of it

$vars = array_merge($vars, $graph_array);
$vars['command_only'] = 1;

include("includes/graphs/graph.inc.php");

unset($vars['command_only']);

// Print options navbar

$navbar = array();
$navbar['brand'] = "选项";
$navbar['class'] = "navbar-narrow";

$navbar['options']['legend']   =  array('text' => '显示图例', 'inverse' => TRUE);
$navbar['options']['previous'] =  array('text' => '历史流量图');
$navbar['options']['trend']    =  array('text' => '趋势流量图');
$navbar['options']['max']      =  array('text' => '峰值流量图');

$navbar['options_right']['showcommand'] =  array('text' => 'RRD 指令');

foreach (array('options' => $navbar['options'], 'options_right' => $navbar['options_right'] ) as $side => $options)
{
  foreach ($options AS $option => $array)
  {
    if ($array['inverse'] == TRUE)
    {
      if ($vars[$option] == "no")
      {
        $navbar[$side][$option]['url'] = generate_url($vars, array('page' => "graphs", $option => NULL));
      } else {
        $navbar[$side][$option]['url'] = generate_url($vars, array('page' => "graphs", $option => 'no'));
        $navbar[$side][$option]['class'] .= " active";
      }
    } else {
      if ($vars[$option] == "yes")
      {
        $navbar[$side][$option]['url'] = generate_url($vars, array('page' => "graphs", $option => NULL));
        $navbar[$side][$option]['class'] .= " active";
      } else {
        $navbar[$side][$option]['url'] = generate_url($vars, array('page' => "graphs", $option => 'yes'));
      }
    }
  }
}

print_navbar($navbar);
unset($navbar);

/// End options navbar

  echo generate_graph_js_state($graph_array);

  echo('<div style="width: '.$graph_array['width'].'; margin: auto;">');
  echo(generate_graph_tag($graph_array));
  echo("</div>");

  if (isset($graph_return['descr']))
  {

    print_optionbar_start();
    echo('<div style="float: left; width: 30px;">
          <div style="margin: auto auto;">
            <img valign=absmiddle src="images/16/information.png" />
          </div>
          </div>');
    echo($graph_return['descr']);
    print_optionbar_end();
  }

#print_vars($graph_return);

  if (isset($vars['showcommand']))
  {
?>

  <div class="well info_box">
    <div class="title">
      <i class="oicon-clock"></i> 性能 &amp; 输出
    </div>
    <div class="content">
      <?php echo("RRDTool 输出: ".$return."<br />"); ?>
      <?php echo("<p>合计时间: ".$graph_return['total_time']." | RRDtool 时间: ".$graph_return['rrdtool_time']."s</p>"); ?>
    </div>
  </div>

  <div class="well info_box">
    <div class="title">
      <i class="oicon-application-terminal"></i> RRDTool 指令
    </div>
    <div class="content">
      <?php echo($graph_return['cmd']); ?>
    </div>
  </div>

  <div class="well info_box">
    <div class="title">
      <i class="oicon-database"></i> RRDTool 使用文件
    </div>
    <div class="content">
      <?php
        if (is_array($graph_return['rrds']))
        {
          foreach ($graph_return['rrds'] as $rrd)
          {
            echo("$rrd <br />");
          }
        } else {
            echo("无 RRD 信息返回. 可能是因为图模块尚未返回数据. <br />");
        }
      ?>
    </div>
  </div>
<?php
  }
}

// EOF
