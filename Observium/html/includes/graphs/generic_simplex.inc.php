<?php

if ($config['old_graphs'])
{
  include($config['html_dir']."/includes/graphs/old_generic_simplex.inc.php");
} else {
  // Draw generic bits graph
  // args: ds_in, ds_out, unit_integer, rrd_filename, bg, legend, from, to, width, height, inverse, percentile

  include_once($config['html_dir']."/includes/graphs/common.inc.php");

  $unit_text = str_pad(truncate($unit_text,18,''),18);
  $line_text = str_pad(truncate($line_text,12,''),12);

  if (isset($unit_integer) && $unit_integer)
  {
    $ds_format = '"%6.0lf "'; //NOTE. max value 999999
  } else {
    $ds_format = '"%6.2lf%s"';
  }

  if ($multiplier)
  {
    $rrd_options .= " DEF:".$ds."_o=".$rrd_filename.":".$ds.":AVERAGE";
    $rrd_options .= " DEF:".$ds."_max_o=".$rrd_filename.":".$ds.":MAX";
    $rrd_options .= " DEF:".$ds."_min_o=".$rrd_filename.":".$ds.":MIN";

    $rrd_options .= " CDEF:".$ds."=".$ds."_o,$multiplier,*";
    $rrd_options .= " CDEF:".$ds."_max=".$ds."_max_o,$multiplier,*";
    $rrd_options .= " CDEF:".$ds."_min=".$ds."_min_o,$multiplier,*";
  } else {
    $rrd_options .= " DEF:".$ds."=".$rrd_filename.":".$ds.":AVERAGE";
    $rrd_options .= " DEF:".$ds."_max=".$rrd_filename.":".$ds.":MAX";
    $rrd_options .= " DEF:".$ds."_min=".$rrd_filename.":".$ds.":MIN";
  }

  if ($print_total)
  {
    $rrd_options .= " VDEF:".$ds."_total=ds,TOTAL";
  }

  if ($percentile)
  {
    $rrd_options .= " VDEF:".$ds."_percentile=".$ds.",".$percentile.",PERCENT";
  }

  if ($_GET['previous'] == "yes")
  {
    if ($multiplier)
    {
      $rrd_options .= " DEF:".$ds."_oX=".$rrd_filename.":".$ds.":AVERAGE:start=".$prev_from.":end=".$from;
      $rrd_options .= " DEF:".$ds."_max_oX=".$rrd_filename.":".$ds.":MAX:start=".$prev_from.":end=".$from;
      $rrd_options .= " SHIFT:".$ds."_oX:$period";
      $rrd_options .= " SHIFT:".$ds."_max_oX:$period";
      $rrd_options .= " CDEF:".$ds."X=".$ds."_oX,$multiplier,*";
      $rrd_options .= " CDEF:".$ds."_maxX=".$ds."_max_oX,$multiplier,*";
    } else {
      $rrd_options .= " DEF:".$ds."X=".$rrd_filename.":".$ds.":AVERAGE:start=".$prev_from.":end=".$from;
      $rrd_options .= " DEF:".$ds."_maxX=".$rrd_filename.":".$ds.":MAX:start=".$prev_from.":end=".$from;
      $rrd_options .= " SHIFT:".$ds."X:$period";
      $rrd_options .= " SHIFT:".$ds."_maxX:$period";
    }
    if ($print_total)
    {
      $rrd_options .= " VDEF:".$ds."_totalX=ds,TOTAL";
    }
    if ($percentile)
    {
      $rrd_options .= " VDEF:".$ds."_percentileX=".$ds.",".$percentile.",PERCENT";
    }
    //if ($graph_max)
    //{
    //  $rrd_options .= " AREA:".$ds."_max#".$colour_area_max.":";
    //}
  }

  if ($colour_minmax)
  {
    $rrd_options .= " AREA:".$ds."_max#c5c5c5";
    $rrd_options .= " AREA:".$ds."_min#ffffff";
  } else {
    if ($graph_max)
    {
      $rrd_options .= " AREA:".$ds."_max#".$colour_area_max.":";
    }
    $rrd_options .= " AREA:".$ds."#".$colour_area.":";

  }

  $rrd_options .= " COMMENT:'".$unit_text."Now       Avg       Max       ";

  if ($percentile)
  {
    $rrd_options .= "      ".$percentile."th %";
  }

  $rrd_options .= "\\n'";
  $rrd_options .= " LINE1.25:".$ds."#".$colour_line.":'".$line_text."'";

  $rrd_options .= " GPRINT:".$ds.":LAST:".$ds_format;
  $rrd_options .= " GPRINT:".$ds.":AVERAGE:".$ds_format;
  $rrd_options .= " GPRINT:".$ds."_max:MAX:".$ds_format;

  if ($percentile)
  {
    $rrd_options .= " GPRINT:".$ds."_percentile:".$ds_format;
  }

  $rrd_options .= "\\\\n";
  $rrd_options .= " COMMENT:\\\\n";

  if ($print_total)
  {
    $rrd_options .= " GPRINT:".$ds."_tot:Total\ ".$ds_format."\)\\\\l";
  }

  if ($percentile)
  {
    $rrd_options .= " LINE1:".$ds."_percentile#aa0000";
  }

  if ($_GET['previous'] == "yes")
  {
    $rrd_options .= " LINE1.25:".$ds."X#666666:'Prev \\\\n'";
    $rrd_options .= " AREA:".$ds."X#99999966:";
  }
}

// EOF
