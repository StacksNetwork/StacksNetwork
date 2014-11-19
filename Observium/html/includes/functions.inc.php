<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage functions
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

include_once($config['html_dir'].'/includes/graphs/functions.inc.php');

$print_functions = array('addresses', 'events', 'mac_addresses', 'rows',
                         'status', 'arptable', 'fdbtable', 'navbar',
                         'search', 'syslogs', 'inventory', 'alert',
                         'device', 'authlog');

foreach ($print_functions as $item)
{
  $print_path = $config['html_dir'].'/includes/print/'.$item.'.inc.php';
  if (is_file($print_path)) { include($print_path); }
}

// Parce $_GET, $_POST and URI into $vars
function get_vars($vars_order = array())
{
  if (is_string($vars_order))
  {
    $vars_order = explode(' ', $vars_order);
  }
  else if (empty($vars_order) || !is_array($vars_order))
  {
    $vars_order = array('OLDGET', 'POST', 'URI', 'GET'); // Default order
  }

  $vars = array();
  foreach ($vars_order as $order)
  {
    $order = strtoupper($order);
    switch ($order)
    {
      case 'OLDGET':
        // Parse GET variables into $vars for backwards compatibility
        // Can probably remove this soon
        foreach ($_GET as $key=>$get_var)
        {
          if (strstr($key, "opt"))
          {
            list($name, $value) = explode("|", $get_var);
            if (!isset($value)) { $value = "yes"; }
            if (!isset($vars[$name])) { $vars[$name] = $value; }
          }
        }
        break;
      case 'POST':
        // Parse POST variables into $vars
        foreach ($_POST as $name => $value)
        {
          if (!isset($vars[$name]))
          {
            $vars[$name] = $value;
            // Additional, detect if $value is encoded array
            $value = base64_decode($vars[$name]);
            if (preg_match('/^[\[\{]\"/', $value))
            {
              $value = json_decode($value, TRUE);
              if (is_array($value)) { $vars[$name] = $value; }
            }
          }
        }
        break;
      case 'URI':
      case 'URL':
        // Parse URI into $vars
        $segments = explode('/', trim($_SERVER['REQUEST_URI'], '/'));
        foreach ($segments as $pos => $segment)
        {
          $segment = urldecode($segment);
          if ($pos == "0" && strpos($segment, '=') === FALSE)
          {
            $vars['page'] = $segment;
          } else {
            list($name, $value) = explode('=', $segment, 2);
            if (!isset($vars[$name]))
            {
              if (!isset($value) || $value === '')
              {
                $vars[$name] = 'yes';
              } else {
                $vars[$name] = urldecode($value);
                // Override $value if this is base64 encoded json string.
                $value = base64_decode($vars[$name]);
                if (preg_match('/^[\[\{]\"/', $value))
                {
                  $value = json_decode($value, TRUE);
                  if (is_array($value))
                  {
                    if (isset($_POST['search_form']) && $_POST['search_form'])
                    {
                      //Unset arrays and multiselect options for search forms (use $_POST variables instead)
                      unset($vars[$name]);
                    } else {
                      $vars[$name] = $value;
                    }
                  }
                }
              }
            }
          }
        }
        break;
      case 'GET':
        // Parse GET variable into $vars,
        // very simple, not detects encoded arrays
        foreach ($_GET as $name => $value)
        {
          if (!isset($vars[$name])) { $vars[$name] = urldecode($value); }
        }
        break;
    }
  }

  // Always convert location to array
  if (isset($vars['location']))
  {
    if      ($vars['location'] === '')     { unset($vars['location']); }                     // Unset location if is empty string
    else if (!is_array($vars['location'])) { $vars['location'] = array($vars['location']); } // All other location strings covert to array
  }
  // Unset hidden param from print_search()
  unset($vars['search_form']);

  return($vars);
}

function generate_alert_graph($graph_array)
{
  global $config;

  $vars = $graph_array;
  $auth = TRUE;
  $vars['image_data_uri'] = TRUE;
  $vars['height'] = '150';
  $vars['width']  = '400';
  $vars['legend'] = 'no';
  $vars['from']   = $config['time']['twoday'];
  $vars['to']     = $config['time']['now'];

  include($config['html_dir'].'/includes/graphs/graph.inc.php');

  return $image_data_uri;
}

// Old percent_colour
//function percent_colour($percent)
//{
//  $r = min(255, 5 * ($percent - 25));
//  $b = max(0, 255 - (5 * ($percent + 25)));
//
// return sprintf('#%02x%02x%02x', $r, $b, $b);
//}

function datetime_preset($preset)
{
  $begin_fmt = 'Y-m-d 00:00:00';
  $end_fmt   = 'Y-m-d 23:59:59';

  switch($preset)
  {
    case 'sixhours':
      $from = date('Y-m-d H:i:00', strtotime('-6 hours'));
      $to   = date('Y-m-d H:i:59');
      break;
    case 'today':
      $from = date($begin_fmt);
      $to   = date($end_fmt);
      break;
    case 'yesterday':
      $from = date($begin_fmt, strtotime('-1 day'));
      $to   = date($end_fmt,   strtotime('-1 day'));
      break;
    case 'tweek':
      $from = (date('l') == 'Monday') ? date($begin_fmt) : date($begin_fmt, strtotime('last Monday'));
      $to   = (date('l') == 'Sunday') ? date($end_fmt)   : date($end_fmt,   strtotime('next Sunday'));
      break;
    case 'lweek':
      $from = date($begin_fmt, strtotime('-6 days'));
      $to   = date($end_fmt);
      break;
    case 'tmonth':
      $tmonth = date('Y-m');
      $from = $tmonth.'-01 00:00:00';
      $to   = date($end_fmt, strtotime($tmonth.' next month - 1 hour'));
      break;
    case 'lmonth':
      $from = date($begin_fmt, strtotime('previous month + 1 day'));
      $to   = date($end_fmt);
      break;
    case 'tyear':
      $from = date('Y-01-01 00:00:00');
      $to   = date('Y-12-31 23:59:59');
      break;
    case 'lyear':
      $from = date($begin_fmt, strtotime('previous year + 1 day'));
      $to   = date($end_fmt);
      break;
  }

  return array('from' => $from, 'to' => $to);
}

function bug()
{
  echo('<div class="alert alert-error">
  <button type="button" class="close" data-dismiss="alert">&times;</button>
  <strong>Bug!</strong> Please report this to the Observium development team.
</div>');
}

// This function determines type of web browser.
function detect_browser()
{
  global $cache;

  if ($cache['detect_browser'])
  {
    return $cache['detect_browser'];
  }

  include_once($GLOBALS['config']['html_dir'].'/includes/Mobile_Detect.php');

  $detect = new Mobile_Detect;

  $cache['detect_browser'] = 'generic';
  if ($detect->isMobile())
  {
    // Any phone device (exclude tablets).
    $cache['detect_browser'] = 'mobile';
    if ($detect->isTablet())
    {
      // Any tablet device.
      $cache['detect_browser'] = 'tablet';
    }
  }

  return $cache['detect_browser'];
}

function safe_base64_encode($string)
{
  $data = base64_encode($string);
  $data = str_replace(array('+','/','='), array('-','_',''), $data);
  return $data;
}

function safe_base64_decode($string)
{
  $data = str_replace(array('-','_'), array('+','/'), $string);
  $mod4 = strlen($data) % 4;
  if ($mod4)
  {
    $data .= substr('====', $mod4);
  }
  return base64_decode($data);
}

function encrypt($string, $key)
{
  return safe_base64_encode(mcrypt_encrypt(MCRYPT_RIJNDAEL_256, $key, $string, MCRYPT_MODE_ECB));
}

function decrypt($encrypted, $key)
{
  return mcrypt_decrypt(MCRYPT_RIJNDAEL_256, $key, safe_base64_decode($encrypted), MCRYPT_MODE_ECB);
}

function data_uri($file, $mime)
{
  $contents = file_get_contents($file);
  $base64   = base64_encode($contents);

  return ('data:' . $mime . ';base64,' . $base64);
}

// This function does rewrites from the lowercase identifiers we use to the
// standard capitalisation. UK English style plurals, please.
// This uses $config['nicecase']
function nicecase($item)
{
  $mappings = $GLOBALS['config']['nicecase'];
  if (isset($mappings[$item])) { return $mappings[$item]; }

  return ucfirst($item);
}

function toner_map($descr, $colour)
{
  foreach ($GLOBALS['config']['toner'][$colour] as $str)
  {
    if (stripos($descr, $str) !== FALSE) { return TRUE; }
  }

  return FALSE;
}

function toner2colour($descr, $percent)
{
  $colour = get_percentage_colours(100-$percent);

  if (substr($descr, -1) == 'C' || toner_map($descr, "cyan"   )) { $colour['left'] = "55D6D3"; $colour['right'] = "33B4B1"; }
  if (substr($descr, -1) == 'M' || toner_map($descr, "magenta")) { $colour['left'] = "F24AC8"; $colour['right'] = "D028A6"; }
  if (substr($descr, -1) == 'Y' || toner_map($descr, "yellow" )) { $colour['left'] = "FFF200"; $colour['right'] = "DDD000"; }
  if (substr($descr, -1) == 'K' || toner_map($descr, "black"  )) { $colour['left'] = "000000"; $colour['right'] = "222222"; }

  return $colour;
}

function generate_link($text, $vars, $new_vars = array())
{
  return '<a href="'.generate_url($vars, $new_vars).'">'.$text.'</a>';
}

function pagination($vars, $total, $per_page = 10)
{
  if (is_numeric($vars['pageno']))   { $page = (int)$vars['pageno']; } else { $page = 1; }
  if (is_numeric($vars['pagesize'])) { $per_page = (int)$vars['pagesize']; }

  $adjacents = 5;

  $lastpage = ceil($total/$per_page);
  $page = ($page == 0 ? 1 : $page);
  if ($lastpage < $page) { $page = (int)$lastpage; }
  $start = ($page - 1) * $per_page;

  $prev = $page - 1;
  $next = $page + 1;

  $lpm1 = $lastpage - 1;

  $pagination = "";

  if ($lastpage > 1)
  {
    $pagination .= '<form action="">';
    $pagination .= '<div class="pagination pagination-centered"><ul>';

    if ($prev)
    {
      #$pagination .= '<li><a href="'.generate_url($vars, array('pageno' => 1)).'">首页</a></li>';
      $pagination .= '<li><a href="'.generate_url($vars, array('pageno' => $prev)).'">上一页</a></li>';
    }

    if ($lastpage < 7 + ($adjacents * 2))
    {
      for ($counter = 1; $counter <= $lastpage; $counter++)
      {
        if ($counter == $page)
        {
          $pagination.= "<li class='active'><a>$counter</a></li>";
        } else {
          $pagination.= "<li><a href='".generate_url($vars, array('pageno' => $counter))."'>$counter</a></li>";
        }
      }
    }
    elseif ($lastpage > 5 + ($adjacents * 2))
    {
      if ($page < 1 + ($adjacents * 2))
      {
        for ($counter = 1; $counter < 4 + ($adjacents * 2); $counter++)
        {
          if ($counter == $page)
          {
            $pagination.= "<li class='active'><a>$counter</a></li>";
          } else {
            $pagination.= "<li><a href='".generate_url($vars, array('pageno' => $counter))."'>$counter</a></li>";
          }
        }

        $pagination.= "<li><a href='".generate_url($vars, array('pageno' => $lpm1))."'>$lpm1</a></li>";
        $pagination.= "<li><a href='".generate_url($vars, array('pageno' => $lastpage))."'>$lastpage</a></li>";
      }
      elseif ($lastpage - ($adjacents * 2) > $page && $page > ($adjacents * 2))
      {
        $pagination.= "<li><a href='".generate_url($vars, array('pageno' => '1'))."'>1</a></li>";
        $pagination.= "<li><a href='".generate_url($vars, array('pageno' => '2'))."'>2</a></li>";

        for ($counter = $page - $adjacents; $counter <= $page + $adjacents; $counter++)
        {
          if ($counter == $page)
          {
            $pagination.= "<li class='active'><a>$counter</a></li>";
          } else {
            $pagination.= "<li><a href='".generate_url($vars, array('pageno' => $counter))."'>$counter</a></li>";
          }
        }

        $pagination.= "<li><a href='".generate_url($vars, array('pageno' => $lpm1))."'>$lpm1</a></li>";
        $pagination.= "<li><a href='".generate_url($vars, array('pageno' => $lastpage))."'>$lastpage</a></li>";
      } else {
        $pagination.= "<li><a href='".generate_url($vars, array('pageno' => '1'))."'>1</a></li>";
        $pagination.= "<li><a href='".generate_url($vars, array('pageno' => '2'))."'>2</a></li>";
        for ($counter = $lastpage - (2 + ($adjacents * 2)); $counter <= $lastpage; $counter++)
        {
          if ($counter == $page)
          {
            $pagination.= "<li class='active'><a>$counter</a></li>";
          } else {
            $pagination.= "<li><a href='".generate_url($vars, array('pageno' => $counter))."'>$counter</a></li>";
          }
        }
      }
    }

    if ($page < $counter - 1)
    {
      $pagination.= "<li><a href='".generate_url($vars, array('pageno' => $next))."'>下一页</a></li>";
      # No need for "Last" as we don't have "First", 1, 2 and the 2 last pages are always in the list.
      #$pagination.= "<li><a href='".generate_url($vars, array('pageno' => $lastpage))."'>最后</a></li>";
    } else {
      $pagination.= "<li class='active'><a>下一页</a></li>";
      #$pagination.= "<li class='active'><a>最后</a></li>";
    }

    $pagination.= "</ul>";

    $pagination.= '
       <div class="pull-right input-prepend">
       <span class="add-on well-shaded"># 每页显示</span>
       <select style="width: 75px;" name="type" id="type"
       onchange="window.open(this.options[this.selectedIndex].value,\'_top\')">';

    foreach (array('10','20','50','100','500','1000', '10000', '100000') as $pagesize)
    {
      #$pagination .= "<option value='".generate_url($vars, array('pagesize' => $pagesize))."'";
      $pagination .= "<option value='".generate_url($vars, array('pagesize' => $pagesize, 'pageno' => floor($start / $pagesize)))."'";

      if ($pagesize == $vars['pagesize']) { $pagination .= (" selected"); }
      $pagination .= ">".$pagesize."</option>";
    }

    $pagination .= '</select></div></div></form>';
  }

  return $pagination;
}

function generate_url($vars, $new_vars = array())
{
  $vars = ($vars) ? array_merge($vars, $new_vars) : $new_vars;

  $url = $vars['page'];
  if ($url[strlen($url)-1] !== '/') { $url .= '/'; }
  unset($vars['page']);

  foreach ($vars as $var => $value)
  {
    if ($var == "username" || $var == "password")
    {
      // Ignore these vars. They shouldn't end up in URLs.
    } elseif (is_array($value))
    {
      $url .= urlencode($var) . '=' . base64_encode(json_encode($value)) . '/';
    } elseif ($value == "0" || $value != "" && strstr($var, "opt") === FALSE && is_numeric($var) === FALSE)
    {
      $url .= urlencode($var) . '=' . urlencode($value).'/';
    }
  }

  // If we're being generated outside of the web interface, prefix the generated URL to make it work properly.
  if (is_cli()) { $url = $GLOBALS['config']['web_url'] . $url; }

  return($url);
}

function generate_feed_url($vars)
{
  $url = FALSE;
  if (!class_exists('SimpleXMLElement')) { return $url; } // Break if class SimpleXMLElement is not available.

  if (is_numeric($_SESSION['user_id']) && is_numeric($_SESSION['userlevel']))
  {
    $key = get_user_pref($_SESSION['user_id'], 'atom_key');
  }
  if ($key)
  {
    $param   = array(rtrim($GLOBALS['config']['base_url'], '/').'/feed.php?id='.$_SESSION['user_id']);
    $param[] = 'hash='.encrypt($_SESSION['user_id'].'|'.$_SESSION['userlevel'], $key);

    $feed_type = 'atom';
    foreach ($vars as $var => $value)
    {
      if ($value != '')
      {
        switch ($var)
        {
          case 'v':
            if ($value == 'rss')
            {
              $param[] = "$var=rss";
              $feed_type = 'rss';
            }
            break;
          case 'feed':
            $title = "Observium :: ".ucfirst($value)." Feed";
            $param[] = 'size='.$GLOBALS['config']['frontpage']['eventlog']['items'];
            // no break here
          case 'size':
            $param[] = "$var=$value";
            break;
        }
      }
    }

    $baseurl = implode('&amp;', $param);

    $url = '<link href="'.$baseurl.'" rel="alternate" title="'.$title.'" type="application/'.$feed_type.'+xml" />';
  }

  return $url;
}

function generate_location_url($location, $vars = array())
{
  if (!is_array($location)) { $location = array($location); }
  $value = base64_encode(json_encode($location));
  return generate_url(array('page' => 'devices', 'location' => $value), $vars);
}

function generate_overlib_content($graph_array, $text = NULL)
{
  global $config;

  $graph_array['height'] = "100";
  $graph_array['width']  = "210";

  $overlib_content = '<div style="width: 590px;"><span style="font-weight: bold; font-size: 16px;">'.$text."</span><br />";
  foreach (array('day', 'week', 'month', 'year') as $period)
  {
    $graph_array['from'] = $config['time'][$period];
    $overlib_content .= generate_graph_tag($graph_array);
  }

  $overlib_content .= "</div>";

  return $overlib_content;
}

function get_percentage_colours($percentage)
{
  if ($percentage > '90') { $background['left']='c4323f'; $background['right']='C96A73'; }
  elseif ($percentage > '75') { $background['left']='bf5d5b'; $background['right']='d39392'; }
  elseif ($percentage > '50') { $background['left']='bf875b'; $background['right']='d3ae92'; }
  elseif ($percentage > '25') { $background['left']='5b93bf'; $background['right']='92b7d3'; }
  else { $background['left']='9abf5b'; $background['right']='bbd392'; }

  return($background);
}

function generate_device_url($device, $vars=array())
{
  return generate_url(array('page' => 'device', 'device' => $device['device_id']), $vars);
}

function generate_device_link_header($device, $vars=array())
{
  global $config;

  humanize_device($device);

  if ($device['os'] == "ios") { formatCiscoHardware($device, true); } // FIXME or generic function for more than just IOS? [and/or do this at poll time]

  $contents = '
      <table class="table table-striped table-bordered table-rounded table-condensed">
        <tr class="'.$device['html_row_class'].'" style="font-size: 10pt;">
          <td style="width: 10px; background-color: '.$device['html_tab_colour'].'; margin: 0px; padding: 0px"></td>
          <td width="40" style="padding: 10px; text-align: center; vertical-align: middle;">'.getImage($device).'</td>
          <td width="200"><a href="#" class="'.$class.'" style="font-size: 15px; font-weight: bold;">'.$device['hostname'].'</a><br />'. htmlspecialchars(truncate($device['location'],64, '')) .'</td>
          <td>'.htmlspecialchars($device['hardware']).' <br /> '.$device['os_text'].' '.$device['version'].'</td>
          <td>'.deviceUptime($device, 'short').'<br />'.htmlspecialchars($device['sysName']).'
          </tr>
        </table>
';

  return $contents;
}

function generate_device_link_contents($device, $vars=array(), $start=0, $end=0)
{

  global $config;

  if (!$start) { $start = $config['time']['day']; }
  if (!$end)   { $end   = $config['time']['now']; }

  $contents = generate_device_link_header($device, $vars=array());

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

  foreach ($graphs as $entry)
  {
    $graph     = $entry['graph'];
    $graphhead = $entry['text'];
    $contents .= '<div style="width: 708px">';
    $contents .= '<span style="margin-left: 5px; font-size: 12px; font-weight: bold;">'.$graphhead.'</span><br />';
    $contents .= "<img src=\"graph.php?device=" . $device['device_id'] . "&amp;from=".$start."&amp;to=".$end."&amp;width=275&amp;height=100&amp;type=".$graph."&amp;legend=no&amp;draw_all=yes" . '" style="margin: 2px;">';
    $contents .= "<img src=\"graph.php?device=" . $device['device_id'] . "&amp;from=".$config['time']['week']."&amp;to=".$end."&amp;width=275&amp;height=100&amp;type=".$graph."&amp;legend=no&amp;draw_all=yes" . '" style="margin: 2px;">';
    $contents .= '</div>';
  }

  return $contents;
}

function generate_device_link($device, $text=NULL, $vars=array(), $start=0, $end=0)
{
  $class = devclass($device);
  if (!$text) { $text = $device['hostname']; }

#  $contents = generate_device_link_contents($device, $vars, $start, $end);

  $text = htmlentities($text);
  $url = generate_device_url($device, $vars);
  $link = overlib_link($url, $text, $contents, $class);

  if (!device_permitted($device['device_id'])) { return $device['hostname']; }

  return '<a href="'.$url.'" class="entity-popup '.$class.'" data-eid="'.$device['device_id'].'" data-etype="device">'.$text.'</a>';
}

/// Generate overlib links from URL, link text, contents and a class.
function overlib_link($url, $text, $contents, $class = NULL)
{
  global $config, $link_iter;

  $link_iter++;

  /// Allow the Grinch to disable popups and destroy Christmas.
  if ($config['web_mouseover'] && detect_browser() != 'mobile')
  {
    $output  = '<a href="'.$url.'" class="tooltip-from-data '.$class.'" data-tooltip="'.htmlspecialchars($contents).'">'.$text.'</a>';
  } else {
    $output  = '<a href="'.$url.'" class="'.$class.'">'.$text.'</a>';
  }

  return $output;
}

// Generate a typical 4-graph popup using $graph_array
function generate_graph_popup($graph_array)
{
  global $config;

  // Take $graph_array and print day,week,month,year graps in overlib, hovered over graph

  $original_from = $graph_array['from'];

  $graph = generate_graph_tag($graph_array);
  $content = "<div class=entity-title>".$graph_array['popup_title']."</div>";
  $content .= '<div style="width: 850px">';
  $graph_array['legend']   = "yes";
  $graph_array['height']   = "100";
  $graph_array['width']    = "340";
  $graph_array['from']     = $config['time']['day'];
  $content .= generate_graph_tag($graph_array);
  $graph_array['from']     = $config['time']['week'];
  $content .= generate_graph_tag($graph_array);
  $graph_array['from']     = $config['time']['month'];
  $content .= generate_graph_tag($graph_array);
  $graph_array['from']     = $config['time']['year'];
  $content .= generate_graph_tag($graph_array);
  $content .= "</div>";

  $graph_array['from'] = $original_from;

  $graph_array['link'] = generate_url($graph_array, array('page' => 'graphs', 'height' => NULL, 'width' => NULL, 'bg' => NULL));

#  $graph_array['link'] = "graphs/type=" . $graph_array['type'] . "/id=" . $graph_array['id'];

  return overlib_link($graph_array['link'], $graph, $content, NULL);
}

// output the popup generated in generate_graph_popup();
function print_graph_popup($graph_array)
{
  echo(generate_graph_popup($graph_array));
}

function permissions_cache($user_id)
{
  $permissions = array();

  foreach (dbFetchRows("SELECT * FROM `devices_perms` WHERE `user_id` = ?", array($user_id)) as $device)
  {
    $permissions['device'][$device['device_id']] = 1;
  }

  foreach (dbFetchRows("SELECT * FROM `ports_perms` WHERE `user_id` = ?", array($user_id)) as $port)
  {
    $permissions['port'][$port['port_id']] = 1;
  }

  foreach (dbFetchRows("SELECT * FROM `bill_perms` WHERE `user_id` = ?", array($user_id)) as $bill)
  {
    $permissions['bill'][$bill['bill_id']] = 1;
  }

  return $permissions;
}

function bill_permitted($bill_id)
{
  global $permissions;

  if ($_SESSION['userlevel'] >= "5")
  {
    $allowed = TRUE;
  } elseif ($permissions['bill'][$bill_id]) {
    $allowed = TRUE;
  } else {
    $allowed = FALSE;
  }

  return $allowed;
}

function port_permitted($port_id, $device_id = NULL)
{
  global $permissions;

  if (!is_numeric($device_id)) { $device_id = get_device_id_by_port_id($port_id); }

  if ($_SESSION['userlevel'] >= "5")
  {
    $allowed = TRUE;
  } elseif (device_permitted($device_id)) {
    $allowed = TRUE;
  } elseif ($permissions['port'][$port_id]) {
    $allowed = TRUE;
  } else {
    $allowed = FALSE;
  }

  return $allowed;
}

function port_permitted_array(&$ports)
{
  // Strip out the ports the user isn't allowed to see, if they don't have global rights
  if ($_SESSION['userlevel'] < '7')
  {
    foreach ($ports as $key => $port)
    {
      if (!port_permitted($port['port_id'], $port['device_id']))
      {
        unset($ports[$key]);
      }
    }
  }
}

function application_permitted($app_id, $device_id = NULL)
{
  global $permissions;

  if (is_numeric($app_id))
  {
    if (!$device_id) { $device_id = get_device_id_by_app_id ($app_id); }
    if ($_SESSION['userlevel'] >= "5") {
      $allowed = TRUE;
    } elseif (device_permitted($device_id)) {
      $allowed = TRUE;
    } elseif ($permissions['application'][$app_id]) {
      $allowed = TRUE;
    } else {
      $allowed = FALSE;
    }
  } else {
    $allowed = FALSE;
  }

  return $allowed;
}

function device_permitted($device_id)
{
  global $permissions;

  if ($_SESSION['userlevel'] >= "5")
  {
    $allowed = true;
  } elseif ($permissions['device'][$device_id]) {
    $allowed = true;
  } else {
    $allowed = false;
  }

  return $allowed;
}

function print_graph_tag($args)
{
  echo(generate_graph_tag($args));
}

function generate_graph_tag($args)
{
  $style = implode(";", $args['style']);
  unset($args['style']);

  foreach ($args as $key => $arg)
  {
    $urlargs[] = $key."=".$arg;
  }

  return '<img src="graph.php?' . implode('&amp;',$urlargs).'" style="max-width: 100%; width: auto; '.$style.'" alt="" />';
}

function generate_graph_js_state($args)
{
  // we are going to assume we know roughly what the graph url looks like here.
  // TODO: Add sensible defaults
  $from   = (is_numeric($args['from'])   ? $args['from']   : 0);
  $to     = (is_numeric($args['to'])     ? $args['to']     : 0);
  $width  = (is_numeric($args['width'])  ? $args['width']  : 0);
  $height = (is_numeric($args['height']) ? $args['height'] : 0);
  $legend = str_replace("'", "", $args['legend']);

  $state = <<<STATE
<script type="text/javascript" language="JavaScript">
document.graphFrom = $from;
document.graphTo = $to;
document.graphWidth = $width;
document.graphHeight = $height;
document.graphLegend = '$legend';
</script>
STATE;

  return $state;
}

/**
 * Generate Percentage Bar
 *
 * This function generates an Observium percentage bar from a supplied array of arguments.
 * It is possible to draw a bar that does not work at all,
 * So care should be taken to make sure values are valid.
 *
 * @param array $args
 * @return string
 */

function percentage_bar($args)
{
  if (strlen($args['bg']))     { $style .= 'background-color:'.$args['bg'].';'; }
  if (strlen($args['border'])) { $style .= 'border-color:'.$args['border'].';'; }
  if (strlen($args['width']))  { $style .= 'width:'.$args['width'].';'; }
  if (strlen($args['text_c'])) { $style_b .= 'color:'.$args['text_c'].';'; }

  $total = '0';
  $output = '<div class="percbar" style="'.$style.'">';
  foreach ($args['bars'] as $bar)
  {
    $output .= '<div class="bar" style="width:'.$bar['percent'].'%; background-color:'.$bar['colour'].';"></div>';
    $total += $bar['percent'];
  }
  $left = '100' - $total;
  if ($left > 0) { $output .= '<div class="bar" style="width:'.$left.'%;"></div>'; }

  if ($left >= 0) { $output .= '<div class="bar-text" style="margin-left: -100px; margin-top: 0px; float: right; text-align: right; '.$style_b.'">'.$args['text'].'</div>'; }

  foreach ($args['bars'] as $bar)
  {
    $output .= '<div class="bar-text" style="width:'.$bar['percent'].'%; max-width:'.$bar['percent'].'%; padding-left: 4px;">'.$bar['text'].'</div>';
  }
#  if ($left > '0') { $output .= '<div class="bar-text" style="margin-left: -100px; margin-top: -16px; float: right; text-align: right; '.$style_b.'">'.$args['text'].'</div>'; }

  $output .= '</div>';

  return $output;
}

// Legacy function
// DO NOT USE THIS. Please replace instances of it with percentage_bar from above.
function print_percentage_bar($width, $height, $percent, $left_text, $left_colour, $left_background, $right_text, $right_colour, $right_background)
{

  if ($percent > "100") { $size_percent = "100"; } else { $size_percent = $percent; }

  $percentage_bar['border']  = "#".$left_background;
  $percentage_bar['bg']      = "#".$right_background;
  $percentage_bar['width']   = $width;
  $percentage_bar['text']    = $right_text;
  $percentage_bar['bars'][0] = array('percent' => $size_percent, 'colour' => '#'.$left_background, 'text' => $left_text);

  $output = percentage_bar($percentage_bar);

  return $output;
}

function generate_port_link_header($port)
{
  global $config;

  // Push through processing function to set attributes
  humanize_port($port);

  $contents = '
      <table style="margin-top: 10px; margin-bottom: 10px;" class="table table-striped table-bordered table-rounded table-condensed">
        <tr class="'.$port['row_class'].'" style="font-size: 10pt;">
          <td style="width: 10px; background-color: '.$port['table_tab_colour'].'; margin: 0px; padding: 0px"></td>
          <td style="width: 10px;"></td>
          <td width="250"><a href="#" class="'.$port['html_row_class'].'" style="font-size: 15px; font-weight: bold;">'.rewrite_ifname($port['label']).'</a><br />'.htmlentities($port['ifAlias']).'</td>
          <td width="100">'.$port['human_speed'].'<br />'.$port['ifMtu'].'</td>
          <td>'.$port['human_type'].'<br />'.$port['human_mac'].'</td>
        </tr>
          </table>';

  return $contents;
}

function generate_port_popup($port, $text = NULL, $type = NULL)
{
  global $config;

  humanize_port($port);

  if (!$text) { $text = rewrite_ifname($port['label']); }
  if ($type) { $port['graph_type'] = $type; }
  if (!isset($port['graph_type'])) { $port['graph_type'] = 'port_bits'; }

  $class = ifclass($port['ifOperStatus'], $port['ifAdminStatus']);

  if (!isset($port['os'])) { $port = array_merge($port, device_by_id_cache($port['device_id'])); }

  $content = generate_device_link_header($port);
  $content .= generate_port_link_header($port);

  $content .= '<div style="width: 700px">';
  $graph_array['type']     = $port['graph_type'];
  $graph_array['legend']   = "yes";
  $graph_array['height']   = "100";
  $graph_array['width']    = "275";
  $graph_array['to']       = $config['time']['now'];
  $graph_array['from']     = $config['time']['day'];
  $graph_array['id']       = $port['port_id'];
  $content .= generate_graph_tag($graph_array);
  $graph_array['from']     = $config['time']['week'];
  $content .= generate_graph_tag($graph_array);
  $graph_array['from']     = $config['time']['month'];
  $content .= generate_graph_tag($graph_array);
  $graph_array['from']     = $config['time']['year'];
  $content .= generate_graph_tag($graph_array);
  $content .= "</div>";

  return $content;
}

function generate_port_link($port, $text = NULL, $type = NULL)
{
  global $config;

  humanize_port($port);

  if (!isset($port['html_class'])) { $port['html_class'] = ifclass($port['ifOperStatus'], $port['ifAdminStatus']); }
  if (!isset($text)) { $text = rewrite_ifname($port['label']); }

  #if (!isset($port['os'])) { $port = array_merge($port, device_by_id_cache($port['device_id'])); }

  $url = generate_port_url($port);

  if (port_permitted($port['port_id'], $port['device_id']))
  {
    return '<a href="'.$url.'" class="entity-popup '.$port['html_class'].'" data-eid="'.$port['port_id'].'" data-etype="port">'.$text.'</a>';
  } else {
    return rewrite_ifname($text);
  }
}

function generate_port_url($port, $vars=array())
{
  return generate_url(array('page' => 'device', 'device' => $port['device_id'], 'tab' => 'port', 'port' => $port['port_id']), $vars);
}

function generate_port_thumbnail($args)
{
  if (!$args['bg']) { $args['bg'] = "FFFFFF"; }
  $args['content'] = "<img src='graph.php?type=".$args['graph_type']."&amp;id=".$args['port_id']."&amp;from=".$args['from']."&amp;to=".$args['to']."&amp;width=".$args['width']."&amp;height=".$args['height']."&amp;bg=".$args['bg']."'>";
  echo(generate_port_link($args, $args['content']));
}

function print_optionbar_start ($height = 0, $width = 0, $marginbottom = 5)
{
   echo(PHP_EOL . '<div class="well well-shaded">' . PHP_EOL);
}

function print_optionbar_end()
{
  echo(PHP_EOL . '  </div>' . PHP_EOL);
}

function geteventicon($message)
{
  if ($message == "Device status changed to Down") { $icon = "server_connect.png"; }
  if ($message == "Device status changed to Up") { $icon = "server_go.png"; }
  if ($message == "Interface went down" || $message == "Interface changed state to Down") { $icon = "if-disconnect.png"; }
  if ($message == "Interface went up" || $message == "Interface changed state to Up") { $icon = "if-connect.png"; }
  if ($message == "Interface disabled") { $icon = "if-disable.png"; }
  if ($message == "Interface enabled") { $icon = "if-enable.png"; }
  if (isset($icon)) { return $icon; } else { return false; }
}

function overlibprint($text)
{
  return "onmouseover=\"return overlib('" . $text . "');\" onmouseout=\"return nd();\"";
}

function devclass($device)
{
  if (isset($device['status']) && $device['status'] == '0') { $class = "red"; } else { $class = ""; }
  if (isset($device['ignore']) && $device['ignore'] == '1')
  {
     $class = "grey";
     if (isset($device['status']) && $device['status'] == '1') { $class = "green"; }
  }
  if (isset($device['disabled']) && $device['disabled'] == '1') { $class = "grey"; }

  return $class;
}

function get_locations()
{
  global $cache;

  $locations = array();
  foreach ($cache['device_locations'] as $location => $count)
  {
    $locations[] = $location;
  }
  sort($locations);

  return $locations;
}

function foldersize($path)
{
  $total_size = 0;
  $files = scandir($path);
  $total_files = 0;

  foreach ($files as $t)
  {
    if (is_dir(rtrim($path, '/') . '/' . $t))
    {
      if ($t<>"." && $t<>"..")
      {
        $size = foldersize(rtrim($path, '/') . '/' . $t);
        $total_size += $size;
      }
    } else {
      $size = filesize(rtrim($path, '/') . '/' . $t);
      $total_size += $size;
      $total_files++;
    }
  }

  return array($total_size, $total_files);
}

// return the filename of the device RANCID config file
function get_rancid_filename($hostname, $rdebug)
{
  global $config;

  $hostnames = array($hostname);

  if ($rdebug) { echo("主机名: $hostname<br />"); }

  // Also check non-FQDN hostname.
  list($shortname) = explode('.', $hostname);

  if ($rdebug) { echo("短主机名: $shortname<br />"); }

  if ($shortname != $hostname)
  {
    $hostnames[] = $shortname;
    if ($rdebug) { echo("主机名不同于短主机名, 寻找两者<br />"); }
  }

  // Addition of a domain suffix for non-FQDN device names.
  if (isset($config['rancid_suffix']) && $config['rancid_suffix'] !== '')
  {
    $hostnames[] = $hostname . '.' . trim($config['rancid_suffix'], ' .');
    if ($rdebug) { echo("不正确的后缀配置, 继续寻找 " . $hostname . '.' . trim($config['rancid_suffix'], ' .') . "<br />"); }
  }

  foreach ($config['rancid_configs'] as $config_path)
  {
    if ($config_path[strlen($config_path)-1] != '/') { $config_path .= '/'; }
    if ($rdebug) { echo("在设置目录中寻找: <b>$config_path</b><br />"); }

    foreach ($hostnames as $host)
    {
      if (is_file($config_path . $host))
      {
        if ($rdebug) { echo("文件 <b>" . $config_path . $host . "</b> 找到.<br />"); }
        return $config_path . $host;
      } else {
        if ($rdebug) { echo("文件 <b>" . $config_path . $host . "</b> 未找到.<br />"); }
      }
    }
  }

  return FALSE;
}

// return the filename of the device NFSEN rrd file
function get_nfsen_filename($hostname)
{
  global $config;

  $nfsen_rrds = (is_array($config['nfsen_rrds']) ? $config['nfsen_rrds'] : array($config['nfsen_rrds']));
  foreach ($nfsen_rrds as $nfsen_rrd)
  {
    if ($nfsen_rrd[strlen($nfsen_rrd)-1] != '/') { $nfsen_rrd .= '/'; }
    $basefilename_underscored = preg_replace('/\./', $config['nfsen_split_char'], $hostname);
    if ($config['nfsen_suffix'])
    {
      $nfsen_filename = (strstr($basefilename_underscored, $config['nfsen_suffix'], TRUE));
    } else {
      $nfsen_filename = $basefilename_underscored;
    }
    $nfsen_rrd_file = $nfsen_rrd . $nfsen_filename . '.rrd';
    if (is_file($nfsen_rrd_file))
    {
      return $nfsen_rrd_file;
    }
  }

  return FALSE;
}

function generate_ap_link($args, $text = NULL, $type = NULL)
{
  global $config;

  humanize_port($args);
  if (!$text) { $text = rewrite_ifname($args['label']); }
  if ($type) { $args['graph_type'] = $type; }
  if (!isset($args['graph_type'])) { $args['graph_type'] = 'port_bits'; }

  if (!isset($args['hostname'])) { $args = array_merge($args, device_by_id_cache($args['device_id'])); }

  $content = "<div class=entity-title>".$args['text']." - " . rewrite_ifname($args['label']) . "</div>";
  if ($args['ifAlias']) { $content .= $args['ifAlias']."<br />"; }
  $content .= "<div style=\'width: 850px\'>";
  $graph_array['type']     = $args['graph_type'];
  $graph_array['legend']   = "yes";
  $graph_array['height']   = "100";
  $graph_array['width']    = "340";
  $graph_array['to']           = $config['time']['now'];
  $graph_array['from']     = $config['time']['day'];
  $graph_array['id']       = $args['accesspoint_id'];
  $content .= generate_graph_tag($graph_array);
  $graph_array['from']     = $config['time']['week'];
  $content .= generate_graph_tag($graph_array);
  $graph_array['from']     = $config['time']['month'];
  $content .= generate_graph_tag($graph_array);
  $graph_array['from']     = $config['time']['year'];
  $content .= generate_graph_tag($graph_array);
  $content .= "</div>";

  $url = generate_ap_url($args);
  if (port_permitted($args['interface_id'], $args['device_id']))
  {
    return overlib_link($url, $text, $content, $class);
  } else {
    return rewrite_ifname($text);
  }
}

function generate_ap_url($ap, $vars=array())
{
  return generate_url(array('page' => 'device', 'device' => $ap['device_id'], 'tab' => 'accesspoint', 'ap' => $ap['accesspoint_id']), $vars);
}

// Generate SQL query for permissions
// Common used by pages: eventlog, syslog, any search
//
// Examples return:
// generate_query_permitted(array('device')) ==
//    ' AND `device_id` IN (1,4,8,33) AND `device_id` NOT IN (66) '
// generate_query_permitted(array('device'), array('device_table' => 'D')) ==
//    ' AND `D`.`device_id` IN (1,4,8,33) AND `D`.`device_id` NOT IN (66) '
// generate_query_permitted(array('device', 'port'), array('port_table' => 'I')) ==
//    ' AND `device_id` IN (1,4,8,33) AND `device_id` NOT IN (66) AND `I`.`port_id` IN (1,4,8,33) AND `I`.`port_id` NOT IN (66) '
// for exclude ignored device and ports set $options['ignored'] as TRUE:
// generate_query_permitted(array('device', 'port'), array('port_table' => 'I', 'ignored' => TRUE)) ==
// Uses global variables: $_SESSION['userlevel'], $config['web_show_disabled'], $cache['devices'], $cache['ports'], $vars['page']
//
/// Note. Query uses comparison operator IN,
/// number of values in the IN list is limited by the 'max_allowed_packet' option (default: 1048576)
// For use first need include: include($config['html_dir'] . "/includes/cache-data.inc.php");
function generate_query_permitted($type_array = array('device'), $options = array())
{
  if (!is_array($type_array)) { $type_array = array($type_array); }
  $user_limitted = ($_SESSION['userlevel'] < 7 ? TRUE : FALSE);
  $page = $GLOBALS['vars']['page'];

  $query_permitted = '';

  foreach ($type_array as $type)
  {
    switch ($type)
    {
      // Devices permission query
      case 'device':
      case 'devices':
        $column = '`device_id`';
        if (isset($options['device_table'])) { $column = '`'.$options['device_table'].'`.'.$column; }

        // Show only permitted devices
        if ($user_limitted)
        {
          if (count($GLOBALS['cache']['devices']['permitted']))
          {
            $query_permitted .= " AND $column IN (";
            $query_permitted .= implode(',', $GLOBALS['cache']['devices']['permitted']);
            $query_permitted .= ')';
          } else {
            // Exclude all entries, because there is no permitted devices
            $query_permitted .= ' AND 0';
          }
        }

        // Also don't show ignored and disabled devices (except on 'device' page)
        $devices_excluded = array();
        if ($page != 'device')
        {
          if ($options['ignored'] && count($GLOBALS['cache']['devices']['ignored']))
          {
            $devices_excluded = array_merge($devices_excluded, $GLOBALS['cache']['devices']['ignored']);
          }
          if (!$GLOBALS['config']['web_show_disabled'] && count($GLOBALS['cache']['devices']['disabled']))
          {
            $devices_excluded = array_merge($devices_excluded, $GLOBALS['cache']['devices']['disabled']);
          }
        }
        if (count($devices_excluded))
        {
          // Set query with excluded devices
          $query_permitted .= " AND $column NOT IN (";
          $query_permitted .= implode(',', array_unique($devices_excluded));
          $query_permitted .= ')';
        }
        break;
      // Ports permission query
      case 'port':
      case 'ports':
        $column = '`port_id`';
        if (isset($options['port_table'])) { $column = '`'.$options['port_table'].'`.'.$column; }

        // Show only permitted ports
        if ($user_limitted)
        {
          if (count($GLOBALS['cache']['ports']['permitted']))
          {
            $query_permitted .= " AND $column IN (";
            $query_permitted .= implode(',', $GLOBALS['cache']['ports']['permitted']);
            $query_permitted .= ')';
          } else {
            // Exclude all entries, because there is no permitted ports
            $query_permitted .= ' AND 0';
          }
        }

        $ports_excluded = array();
        // Don't show ports with disabled polling.
        if (count($GLOBALS['cache']['ports']['poll_disabled']))
        {
          $ports_excluded = array_merge($ports_excluded, $GLOBALS['cache']['ports']['poll_disabled']);
        }
        // Don't show deleted ports (except on 'deleted-ports' page)
        if ($page != 'deleted-ports' && count($GLOBALS['cache']['ports']['deleted']))
        {
          $ports_excluded = array_merge($ports_excluded, $GLOBALS['cache']['ports']['deleted']);
        }
        if ($page != 'device' && !in_array('device', $type_array))
        {
          // Don't show ports for disabled devices (except on 'device' page or if 'device' permissions already queried)
          if (count($GLOBALS['cache']['ports']['device_disabled']) && !$user_limitted)
          {
            $ports_excluded = array_merge($ports_excluded, $GLOBALS['cache']['ports']['device_disabled']);
          }
          // Don't show ports for ignored devices (except on 'device' page)
          if ($options['ignored'] && count($GLOBALS['cache']['ports']['device_ignored']))
          {
            $ports_excluded = array_merge($ports_excluded, $GLOBALS['cache']['ports']['device_ignored']);
          }
        }
        // Don't show ignored ports (only on some pages!)
        if (($page == 'overview' || $options['ignored']) && count($GLOBALS['cache']['ports']['ignored']))
        {
          $ports_excluded = array_merge($ports_excluded, $GLOBALS['cache']['ports']['ignored']);
        }
        if (count($ports_excluded))
        {
          // Set query with excluded ports
          $query_permitted .= " AND $column NOT IN (";
          $query_permitted .= implode(',', array_unique($ports_excluded));
          $query_permitted .= ')';
        }
        break;
      case 'sensor':
      case 'sensors':
        // For sensors
        break;
      case 'bill':
      case 'bills':
        // For bills
        break;
    }
  }

  $query_permitted .= ' ';

  return $query_permitted;
}

function get_user_prefs($user_id)
{
  $prefs = array();
  foreach (dbFetchRows("SELECT * FROM `users_prefs` WHERE `user_id` = ?", array($user_id)) as $entry)
  {
    $prefs[$entry['pref']] = $entry;
  }
  return $prefs;
}

function get_user_pref($user_id, $pref)
{
  if ($entry = dbFetchRow("SELECT `value` FROM `users_prefs` WHERE `user_id` = ? AND `pref` = ?", array($user_id, $pref)))
  {
    return $entry['value'];
  }
  else
  {
    return NULL;
  }
}

function set_user_pref($user_id, $pref, $value)
{
  if (dbFetchCell("SELECT COUNT(*) FROM `users_prefs` WHERE `user_id` = ? AND `pref` = ?", array($user_id, $pref)))
  {
    $id = dbUpdate(array('value' => $value), 'users_prefs', '`user_id` = ? AND `pref` = ?', array($user_id, $pref));
  }
  else
  {
    $id = dbInsert(array('user_id' => $user_id, 'pref' => $pref, 'value' => $value), 'users_prefs');
  }
  return $id;
}

function del_user_pref($user_id, $pref)
{
  return dbDelete('users_prefs', "`user_id` = ? AND `pref` = ?", array($user_id, $pref));
}

// EOF
