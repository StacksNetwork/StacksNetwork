<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage graphs
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

// Draws aggregate bits graph from multiple RRDs
// Variables : colour_[line|area]_[in|out], rrd_filenames

include_once($config['html_dir']."/includes/graphs/common.inc.php");

if ($format == "octets" || $format == "bytes")
{
  $units = "Bps";
  $format = "octets";
} else {
  $units = "bps";
  $format = "bits";
}

$i = 0;
$rrd_multi = array();
foreach ($rrd_filenames as $key => $rrd_filename)
{
  if ($rrd_inverted[$key]) { $in = 'out'; $out = 'in'; } else { $in = 'in'; $out = 'out'; }

  $rrd_options .= " DEF:".$in."octets" . $i . "=".$rrd_filename.":".$ds_in.":AVERAGE";
  $rrd_options .= " DEF:".$out."octets" . $i . "=".$rrd_filename.":".$ds_out.":AVERAGE";

  $rrd_multi['in_thing'][]  = "inoctets" .  $i . ",UN,0," . "inoctets" .  $i . ",IF";
  $rrd_multi['out_thing'][] = "outoctets" . $i . ",UN,0," . "outoctets" . $i . ",IF";

  if ($_GET['previous'])
  {
    $rrd_options .= " DEF:".$in."octets" . $i . "X=".$rrd_filename.":".$ds_in.":AVERAGE:start=".$prev_from.":end=".$from;
    $rrd_options .= " DEF:".$out."octets" . $i . "X=".$rrd_filename.":".$ds_out.":AVERAGE:start=".$prev_from.":end=".$from;
    $rrd_options .= " SHIFT:".$in."octets" . $i . "X:$period";
    $rrd_options .= " SHIFT:".$out."octets" . $i . "X:$period";

    $rrd_multi['in_thingX'][]  = "inoctets" .  $i . "X,UN,0," . "inoctets" .  $i . "X,IF";
    $rrd_multi['out_thingX'][] = "outoctets" . $i . "X,UN,0," . "outoctets" . $i . "X,IF";
  }
  $i++;
}

if ($i)
{
  if ($inverse) { $in = 'out'; $out = 'in'; } else { $in = 'in'; $out = 'out'; }
  $in_thing  = implode(',', $rrd_multi['in_thing']);
  $out_thing = implode(',', $rrd_multi['out_thing']);
  $pluses    = str_repeat(',+', count($rrd_multi['in_thing']) - 1);
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
    $in_thingX  = implode(',', $rrd_multi['in_thingX']);
    $out_thingX = implode(',', $rrd_multi['out_thingX']);
    $plusesX    = str_repeat(',+', count($rrd_multi['in_thingX']) - 1);
    $rrd_options .= " CDEF:".$in."octetsX=" . $in_thingX . $plusesX;
    $rrd_options .= " CDEF:".$out."octetsX=" . $out_thingX . $plusesX;
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
    $rrd_options .= " AREA:in".$format."#".$colour_area_in.":";
#    $rrd_options .= " LINE1.25:in".$format."#".$colour_line_in.":";
    $rrd_options .= " AREA:dout".$format."#".$colour_area_out.":";
#    $rrd_options .= " LINE1.25:dout".$format."#".$colour_line_out.":";
  } else {
    $rrd_options .= " COMMENT:'bps      Now       Avg      Max      95th %\\n'";
    $rrd_options .= " AREA:in".$format."#".$colour_area_in.":'In '";
#    $rrd_options .= " LINE1.25:in".$format."#".$colour_line_in.":'In '";
    $rrd_options .= " GPRINT:in".$format.":LAST:%6.2lf%s";
    $rrd_options .= " GPRINT:in".$format.":AVERAGE:%6.2lf%s";
    $rrd_options .= " GPRINT:in".$format.":MAX:%6.2lf%s";
    $rrd_options .= " GPRINT:95thin:%6.2lf%s\\\\n";
    $rrd_options .= " AREA:dout".$format."#".$colour_area_out.":Out";
#    $rrd_options .= " LINE1.25:dout".$format."#".$colour_line_out.":Out";
    $rrd_options .= " GPRINT:out".$format.":LAST:%6.2lf%s";
    $rrd_options .= " GPRINT:out".$format.":AVERAGE:%6.2lf%s";
    $rrd_options .= " GPRINT:out".$format.":MAX:%6.2lf%s";
    $rrd_options .= " GPRINT:95thout:%6.2lf%s\\\\n";
  }

  $rrd_options .= " LINE1:95thin#aa0000";
  $rrd_options .= " LINE1:d95thout#aa0000";

  if ($_GET['previous'] == "yes")
  {
    $rrd_options .= " AREA:in".$format."X#99999999:";
    $rrd_options .= " AREA:dout".$format."X#99999999:";
    $rrd_options .= " LINE1:in".$format."X#666666:";
    $rrd_options .= " LINE1:dout".$format."X#666666:";
  }

}

#$rrd_options .= " HRULE:0#999999";

// Clean
unset($rrd_multi, $in_thing, $out_thing, $pluses, $in_thingX, $out_thingX, $plusesX);

// EOF
