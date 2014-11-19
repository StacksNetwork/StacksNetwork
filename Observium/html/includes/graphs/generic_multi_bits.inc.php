<?php

// Draws aggregate bits graph from multiple RRDs
// Variables : colour_[line|area]_[in|out], rrd_filenames

include_once($config['html_dir']."/includes/graphs/common.inc.php");

$i=0;

foreach ($rrd_filenames as $key => $rrd_filename)
{
  if ($rrd_inverted[$key]) { $in = 'out'; $out = 'in'; } else { $in = 'in'; $out = 'out'; }

  $rrd_options .= " DEF:".$in."octets" . $i . "=".$rrd_filename.":".$ds_in.":AVERAGE";
  $rrd_options .= " DEF:".$out."octets" . $i . "=".$rrd_filename.":".$ds_out.":AVERAGE";
  $in_thing .= $separator . "inoctets" . $i . ",UN,0," . "inoctets" . $i . ",IF";
  $out_thing .= $separator . "outoctets" . $i . ",UN,0," . "outoctets" . $i . ",IF";
  $pluses .= $plus;
  $separator = ",";
  $plus = ",+";

  if ($_GET['previous'])
  {
    $rrd_options .= " DEF:".$in."octets" . $i . "X=".$rrd_filename.":".$ds_in.":AVERAGE:start=".$prev_from.":end=".$from;
    $rrd_options .= " DEF:".$out."octets" . $i . "X=".$rrd_filename.":".$ds_out.":AVERAGE:start=".$prev_from.":end=".$from;
    $rrd_options .= " SHIFT:".$in."octets" . $i . "X:$period";
    $rrd_options .= " SHIFT:".$out."octets" . $i . "X:$period";
    $in_thingX .= $separatorX . "inoctets" . $i . "X,UN,0," . "inoctets" . $i . "X,IF";
    $out_thingX .= $separatorX . "outoctets" . $i . "X,UN,0," . "outoctets" . $i . "X,IF";
    $plusesX .= $plusX;
    $separatorX = ",";
    $plusX = ",+";
  }
  $i++;
}

if ($i)
{
  if ($inverse) { $in = 'out'; $out = 'in'; } else { $in = 'in'; $out = 'out'; }
  $rrd_options .= " CDEF:".$in."octets=" . $in_thing . $pluses;
  $rrd_options .= " CDEF:".$out."octets=" . $out_thing . $pluses;
  $rrd_options .= " CDEF:doutoctets=outoctets,-1,*";
  $rrd_options .= " CDEF:inbits=inoctets,8,*";
  $rrd_options .= " CDEF:outbits=outoctets,8,*";
  $rrd_options .= " CDEF:doutbits=doutoctets,8,*";
  $rrd_options .= " VDEF:95thin=inbits,95,PERCENT";
  $rrd_options .= " VDEF:95thout=outbits,95,PERCENT";
  $rrd_options .= " VDEF:d95thout=doutbits,5,PERCENT";

  if ($_GET['previous'] == "yes")
  {
    $rrd_options .= " CDEF:".$in."octetsX=" . $in_thingX . $pluses;
    $rrd_options .= " CDEF:".$out."octetsX=" . $out_thingX . $pluses;
    $rrd_options .= " CDEF:doutoctetsX=outoctetsX,-1,*";
    $rrd_options .= " CDEF:inbitsX=inoctetsX,8,*";
    $rrd_options .= " CDEF:outbitsX=outoctetsX,8,*";
    $rrd_options .= " CDEF:doutbitsX=doutoctetsX,8,*";
    $rrd_options .= " VDEF:95thinX=inbitsX,95,PERCENT";
    $rrd_options .= " VDEF:95thoutX=outbitsX,95,PERCENT";
    $rrd_options .= " VDEF:d95thoutX=doutbitsX,5,PERCENT";
  }

  if ($legend == 'no' || $legend == '1')
  {
    $rrd_options .= " AREA:inbits#".$colour_area_in.":";
    $rrd_options .= " LINE1.25:inbits#".$colour_line_in.":";
    $rrd_options .= " AREA:doutbits#".$colour_area_out.":";
    $rrd_options .= " LINE1.25:doutbits#".$colour_line_out.":";
  } else {
    $rrd_options .= " AREA:inbits#".$colour_area_in.":";
    $rrd_options .= " COMMENT:'bps      Now       Avg      Max      95th %\\n'";
    $rrd_options .= " LINE1.25:inbits#".$colour_line_in.":In\ ";
    $rrd_options .= " GPRINT:inbits:LAST:%6.2lf%s";
    $rrd_options .= " GPRINT:inbits:AVERAGE:%6.2lf%s";
    $rrd_options .= " GPRINT:inbits:MAX:%6.2lf%s";
    $rrd_options .= " GPRINT:95thin:%6.2lf%s\\\\n";
    $rrd_options .= " AREA:doutbits#".$colour_area_out.":";
    $rrd_options .= " LINE1.25:doutbits#".$colour_line_out.":Out";
    $rrd_options .= " GPRINT:outbits:LAST:%6.2lf%s";
    $rrd_options .= " GPRINT:outbits:AVERAGE:%6.2lf%s";
    $rrd_options .= " GPRINT:outbits:MAX:%6.2lf%s";
    $rrd_options .= " GPRINT:95thout:%6.2lf%s\\\\n";
  }

  $rrd_options .= " LINE1:95thin#aa0000";
  $rrd_options .= " LINE1:d95thout#aa0000";

  if ($_GET['previous'] == "yes")
  {
    $rrd_options .= " AREA:inbitsX#9999966:";
    $rrd_options .= " AREA:doutbitsX#99999966:";
  }

}

#$rrd_options .= " HRULE:0#999999";

// EOF
