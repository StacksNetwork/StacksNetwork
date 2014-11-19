<?php

include_once($config['html_dir']."/includes/graphs/common.inc.php");

// Here we scale the number of numerical columns shown to make sure we keep the text.

if ($width > "400") {
  $data_len  = "33";
  $data_show = array('lst', 'avg', 'min', 'max');
} elseif ($width > "300") {
  $data_len  = "24";
  $data_show = array('lst', 'avg', 'max');
} else {
  $data_len = "16";
  $data_show = array('lst', 'avg');
}

// Here we scale the length of the description to make sure we keep the numbers

if ($width > "600")
{
  $descr_len = 36;
}
else if ($width > "400")
{
  $descr_len = floor(($width - 28) / 9) - 18;
}
else if ($width > "350")
{
  $descr_len = floor(($width - 28) / 9) - 9;
}
else if ($width > "300")
{
  $descr_len = floor(($width - 28) / 8) - 9;
} else {
  $descr_len = floor(($width + 52) / 7) - $data_len;
}

// Build the legend headers using the length values previously calculated

if ($legend != 'no')
{
  $rrd_options .= " COMMENT:'".substr(str_pad($unit_text, $descr_len+2),0,$descr_len+2)."'";
  if (in_array("lst", $data_show)) { $rrd_options .= " COMMENT:'Curr'"; }
  if (in_array("avg", $data_show)) { $rrd_options .= " COMMENT:'    Avg'"; }
  if (in_array("min", $data_show)) { $rrd_options .= " COMMENT:'    Min'"; }
  if (in_array("max", $data_show)) { $rrd_options .= " COMMENT:'    Max'"; }
  $rrd_options .= " COMMENT:'\\l'";
}

$colour_iter = 0;

foreach ($rrd_list as $i => $rrd)
{
  if ($rrd['colour'])
  {
    $colour = $rrd['colour'];
  } else {
    if (!isset($config['graph_colours'][$colours][$colour_iter])) { $colour_iter = 0; }
    $colour = $config['graph_colours'][$colours][$colour_iter];
    $colour_iter++;
  }

  $ds = $rrd['ds'];
  $filename = $rrd['filename'];

  $descr = rrdtool_escape($rrd['descr'], $descr_len);

  $id = "ds".$i;

  $rrd_options .= " DEF:".$id."=$filename:$ds:AVERAGE";

  if ($simple_rrd)
  {
    $rrd_options .= " CDEF:".$id."min=".$id." ";
    $rrd_options .= " CDEF:".$id."max=".$id." ";
  } else {
    $rrd_options .= " DEF:".$id."min=$filename:$ds:MIN";
    $rrd_options .= " DEF:".$id."max=$filename:$ds:MAX";
  }

  if ($rrd['invert'])
  {
    $rrd_options .= " CDEF:".$id."i=".$id.",-1,*";
    $rrd_optionsb .= " LINE1.25:".$id."i#".$colour.":'$descr'";
    if (!empty($rrd['areacolour'])) { $rrd_optionsb .= " AREA:".$id."i#" . $rrd['areacolour']; }
  } else {
    $rrd_optionsb .= " LINE1.25:".$id."#".$colour.":'$descr'";
    if (!empty($rrd['areacolour'])) { $rrd_optionsb .= " AREA:".$id."#" . $rrd['areacolour']; }
  }

  if (in_array("lst", $data_show)) { $rrd_optionsb .= " GPRINT:".$id.":LAST:%6.1lf%s"; }
  if (in_array("avg", $data_show)) { $rrd_optionsb .= " GPRINT:".$id.":AVERAGE:%6.1lf%s"; }
  if (in_array("min", $data_show)) { $rrd_optionsb .= " GPRINT:".$id."min:MIN:%6.1lf%s"; }
  if (in_array("max", $data_show)) { $rrd_optionsb .= " GPRINT:".$id."max:MAX:%6.1lf%s"; }

  $rrd_optionsb .= " COMMENT:'\\l'";
  #$colour_iter++;

}

$rrd_options .= $rrd_optionsb;
$rrd_options .= " HRULE:0#555555";

// EOF
