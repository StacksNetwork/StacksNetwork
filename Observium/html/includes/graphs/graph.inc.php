<?php

#ob_clean();

$total_start = utime();

preg_match('/^(?P<type>[a-z0-9A-Z-]+)_(?P<subtype>[a-z0-9A-Z-_]+)/', $vars['type'], $graphtype);

$graphfile = $config['temp_dir'] . "/"  . strgen() . ".png";

if($debug) print_vars($graphtype);

if(isset($graphtype['type']) && isset($graphtype['subtype']))
{
  $type = $graphtype['type'];
  $subtype = $graphtype['subtype'];
} else {
  graph_error("无效的图像格式.");
  exit;
}

if (is_numeric($vars['device']))
{
  $device = device_by_id_cache($vars['device']);
} elseif(!empty($vars['device'])) {
  $device = device_by_name($vars['device']);
}

// FIXME -- remove these

// $from, $to - unixtime (or rrdgraph time interval, i.e. '-1d', '-6w')
// $timestamp_from, $timestamp_to - timestamps formatted as 'Y-m-d H:i:s'
$timestamp_pattern = '/^(\d{4})-(\d{2})-(\d{2}) ([01][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$/';
if (isset($vars['timestamp_from']) && preg_match($timestamp_pattern, $vars['timestamp_from']))
{
  $vars['from'] = strtotime($vars['timestamp_from']);
}
if (isset($vars['timestamp_to']) && preg_match($timestamp_pattern, $vars['timestamp_to']))
{
  $vars['to'] = strtotime($vars['timestamp_to']);
}

$from     = (isset($vars['from'])) ? $vars['from'] : time() - 86400;
$to       = (isset($vars['to'])) ? $vars['to'] : time();

if ($from < 0) { $from = $to + $from; }

$period = $to - $from;

$prev_from = $from - $period;


$graph_include = FALSE;
if (is_file($config['html_dir'] . "/includes/graphs/$type/$subtype.inc.php"))
{
  $graph_include = $config['html_dir'] . "/includes/graphs/$type/$subtype.inc.php";
}
elseif (is_file($config['html_dir'] . "/includes/graphs/$type/graph.inc.php"))
{
  $graph_include = $config['html_dir'] . "/includes/graphs/$type/graph.inc.php";
}

if ($graph_include)
{
  include($config['html_dir'] . "/includes/graphs/$type/auth.inc.php");

  if (isset($auth) && $auth)
  {
    include($graph_include);
  }

}
else
{
  graph_error($type.'_'.$subtype); //Graph Template Missing");
}

if ($error_msg) {
  // We have an error :(

  graph_error($graph_error);

} elseif (!$auth) {
  // We are unauthenticated :(

  if ($width < 200)
  {
   graph_error("No Auth");
  } else {
   graph_error("No Authorization");
  }
} else {
  #$rrd_options .= " HRULE:0#999999";
  if ($no_file)
  {

    if ($width < 200)
    {
      graph_error("无RRD");
    } else {
      graph_error("未找到 RRD数据文件");
    }

  } elseif (isset($vars['command_only']) && $vars['command_only'] == TRUE) {

    $graph_start = utime();
    $return = rrdtool_graph($graphfile, $rrd_options);
    $graph_end = utime(); $graph_run = $graph_end - $graph_start; $graph_time = substr($graph_run, 0, 5);
    $total_end = utime(); $total_run = $total_end - $total_start; $total_time = substr($total_run, 0, 5);

    unlink($graphfile);

    $graph_return['total_time'] = $total_time;
    $graph_return['rrdtool_time'] = $graph_time;
    $graph_return['cmd']  = "rrdtool graph $graphfile $rrd_options";

  } else {

    if ($rrd_options)
    {
      rrdtool_graph($graphfile, $rrd_options);
      if ($debug) { echo($rrd_cmd); }
      if (is_file($graphfile))
      {
        if ($vars['image_data_uri'] == TRUE)
        {
          $image_data_uri = data_uri($graphfile,'image/png');
        } elseif (!$debug) {
          header('Content-type: image/png');
          $fd = fopen($graphfile,'r');fpassthru($fd);fclose($fd);
        } else {
          echo(`ls -l $graphfile`);
          echo('<img src="'.data_uri($graphfile,'image/png').'" alt="graph" />');
        }
        unlink($graphfile);
      }
      else
      {
        if ($width < 200)
        {
          graph_error("Draw Error");
        }
        else
        {
          graph_error("Draw Error");
        }
      }
    }
    else
    {
      if ($width < 200)
      {
        graph_error("定义错误");
      } else {
        graph_error("图像定义错误");
      }
    }
  }
}

// EOF
