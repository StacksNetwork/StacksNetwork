<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage billing
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2015 Adam Armstrong
 *
 */

ini_set('allow_url_fopen', 0);

include_once("../includes/defaults.inc.php");
include_once("../config.php");
include_once("../includes/definitions.inc.php");
include("../includes/functions.inc.php");
include("includes/functions.inc.php");
include("includes/authenticate.inc.php");

if ($_SERVER['REMOTE_ADDR'] != $_SERVER['SERVER_ADDR']) { if (!$_SESSION['authenticated']) { echo("未经授权"); exit; } }
require("includes/jpgraph/src/jpgraph.php");
include("includes/jpgraph/src/jpgraph_line.php");
include("includes/jpgraph/src/jpgraph_utils.inc.php");
include("includes/jpgraph/src/jpgraph_date.php");

$vars = get_vars('GET');

if (is_numeric($vars['bill_id']))
{
  if ($_SERVER['REMOTE_ADDR'] != $_SERVER['SERVER_ADDR'])
  {
    if (bill_permitted($vars['bill_id']))
    {
      $bill_id = $vars['bill_id'];
    } else {
      echo("禁止未经授权的访问.");
      exit;
    }
  } else {
    $bill_id = $vars['bill_id'];
  }
} else {
  echo("禁止未经授权的访问.");
  exit;
}

$start = $vars['from'];
$end =   $vars['to'];
$xsize = $vars['x'];
$ysize = $vars['y'];
$count = $vars['count'];
$count = $count + 0;
$iter = 1;

if ($vars['type']) { $type = $vars['type']; } else { $type = "date"; }

$dur = $end - $start;

$datefrom = date('Ymthis', $start);
$dateto = date('Ymthis',   $end);

#$rate_data = getRates($bill_id,$datefrom,$dateto);
$rate_data = dbFetchRow("SELECT * from `bills` WHERE `bill_id`= ? LIMIT 1", array($bill_id));
$rate_95th = $rate_data['rate_95th'];
$rate_average = $rate_data['rate_average'];

#$bi_a = dbFetchRow("SELECT * FROM bills WHERE bill_id = ?", array($bill_id));
#$bill_name = $bi_a['bill_name'];
$bill_name = $rate_data['bill_name'];

$dur = $end - $start;

$counttot = dbFetchCell("SELECT count(`delta`) FROM `bill_data` WHERE `bill_id` = ? AND `timestamp` >= FROM_UNIXTIME( ? ) AND `timestamp` <= FROM_UNIXTIME( ? )", array($bill_id, $start, $end));

$count = round($dur / 300 / (($ysize - 100) * 3), 0);
if ($count <= 1) { $count = 2; }

#$count = round($counttot / 260, 0);
#if ($count <= 1) { $count = 2; }

#$max = dbFetchCell("SELECT delta FROM bill_data WHERE bill_id = ? AND `timestamp` >= FROM_UNIXTIME( ? ) AND `timestamp` <= FROM_UNIXTIME( ? ) ORDER BY delta DESC LIMIT 0,1", array($bill_id, $start, $end));
#if ($max > 1000000) { $div = "1000000"; $yaxis = "Mbit/sec";  } else { $div = "1000"; $yaxis = "Kbit/sec"; }

$i = '0';

foreach (dbFetch("SELECT *, UNIX_TIMESTAMP(timestamp) AS formatted_date FROM bill_data WHERE bill_id = ? AND `timestamp` >= FROM_UNIXTIME( ? ) AND `timestamp` <= FROM_UNIXTIME( ? ) ORDER BY timestamp ASC", array($bill_id, $start, $end)) as $row)
{
  @$timestamp = $row['formatted_date'];
  if (!$first) { $first = $timestamp; }
  @$delta = $row['delta'];
  @$period = $row['period'];
  @$in_delta = $row['in_delta'];
  @$out_delta = $row['out_delta'];
  @$in_value = round($in_delta * 8 / $period, 2);
  @$out_value = round($out_delta * 8 / $period, 2);

  @$last = $timestamp;

  $iter_in      += $in_delta;
  $iter_out     += $out_delta;
  $iter_period  += $period;

  if ($iter == $count)
  {
    $out_data[$i]   = round($iter_out * 8 / $iter_period, 2);
    $out_data_inv[$i]   = $out_data[$i] * -1;
    $in_data[$i]   = round($iter_in * 8 / $iter_period, 2);
    $tot_data[$i]   = $out_data[$i] + $in_data[$i];
    $tot_data_inv[$i]   = $tot_data[$i] * -1;

    if ($tot_data[$i] > $max_value) { $max_value = $tot_data[$i]; }

    $ticks[$i]      = $timestamp;
    $per_data[$i]   = $rate_95th;
    $ave_data[$i]   = $rate_average;
    $iter       = "1";
    $i++;
    unset($iter_out, $iter_in, $iter_period);
  }

  $iter++;
}

$graph_name = date('M j g:ia', $start) . " - " . date('M j g:ia', $last);

$n = count($ticks);
$xmin = $ticks[0];
$xmax = $ticks[$n-1];

$graph_name = date('M j g:ia', $xmin) . " - " . date('M j g:ia', $xmax);

$graph = new Graph($xsize, $ysize, $graph_name);
$graph->img->SetImgFormat("png");

$graph->SetScale('datlin',0,0,$start,$end);

#$graph->title->Set("$graph_name");
$graph->title->SetFont(FF_FONT2,FS_BOLD,10);
$graph->xaxis->SetFont(FF_FONT1,FS_BOLD);

$graph->xaxis->SetTextLabelInterval(2);

$graph->xaxis->SetPos('min');
#$graph->xaxis->SetLabelAngle(15);
$graph->yaxis->HideZeroLabel(1);
$graph->yaxis->SetFont(FF_FONT1);
$graph->yaxis->SetLabelAngle(0);
$graph->xaxis->title->SetFont(FF_FONT1,FS_NORMAL,10);
$graph->yaxis->title->SetFont(FF_FONT1,FS_NORMAL,10);
$graph->yaxis->SetTitleMargin(50);
$graph->xaxis->SetTitleMargin(30);
#$graph->xaxis->HideLastTickLabel();
#$graph->xaxis->HideFirstTickLabel();
#$graph->yaxis->scale->SetAutoMin(1);
$graph->xaxis->title->Set($type);
$graph->yaxis->title->Set("比特/秒");
$graph->yaxis->SetLabelFormatCallback("format_si");

function TimeCallback($aVal) {
    global $dur;

    if ($dur < 172800)
    {
      return Date('H:i',$aVal);
    } elseif ($dur < 604800) {
      return Date('D',$aVal);
    } else {
      return Date('j M',$aVal);
    }
}

$graph->xaxis->SetLabelFormatCallback('TimeCallBack');

$graph->ygrid->SetFill(true,'#EFEFEF@0.5','#FFFFFF@0.5');
$graph->xgrid->Show(true,true);
$graph->xgrid->SetColor('#e0e0e0','#efefef');
$graph->SetMarginColor('white');
$graph->SetFrame(false);
$graph->SetMargin(75,30,30,45);
$graph->legend->SetFont(FF_FONT1,FS_NORMAL);

$lineplot = new LinePlot($tot_data, $ticks);
$lineplot->SetLegend("总流量");
$lineplot->SetColor("#d5d5d5");
$lineplot->SetFillColor("#d5d5d5@0.5");

#$lineplot2 = new LinePlot($tot_data_inv, $ticks);
#$lineplot2->SetColor("#d5d5d5");
#$lineplot2->SetFillColor("#d5d5d5@0.5");

$lineplot_in = new LinePlot($in_data, $ticks);

$lineplot_in->SetLegend("流入流量");
$lineplot_in->SetColor('#'.$config['graph_colours']['greens'][1]);
$lineplot_in->SetFillColor('#'.$config['graph_colours']['greens'][0]);
$lineplot_in->SetWeight(1);

$lineplot_out = new LinePlot($out_data_inv, $ticks);
$lineplot_out->SetLegend("流出流量");
$lineplot_out->SetColor('#'.$config['graph_colours']['blues'][1]);
$lineplot_out->SetFillColor('#'.$config['graph_colours']['blues'][0]);
$lineplot_out->SetWeight(1);

if ($vars['95th'])
{
  $lineplot_95th = new LinePlot($per_data, $ticks);
  $lineplot_95th ->SetColor("red");
}

if ($vars['ave'])
{
  $lineplot_ave = new LinePlot($ave_data, $ticks);
  $lineplot_ave ->SetColor("red");
}

$graph->legend->SetLayout(LEGEND_HOR);
$graph->legend->Pos(0.52, 0.90, 'center');

$graph->Add($lineplot);
#$graph->Add($lineplot2);

$graph->Add($lineplot_in);
$graph->Add($lineplot_out);

if ($vars['95th'])
{
  $graph->Add($lineplot_95th);
}

if ($vars['ave'])
{
  $graph->Add($lineplot_ave);
}

$graph->stroke();

// EOF
