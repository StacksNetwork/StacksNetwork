<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage webui
 * @copyright  (C) 2006-2015 Adam Armstrong
 *
 */

  $bill_id     = ((is_numeric($vars['bill_id'])) ? $vars['bill_id'] : 0);
  $history_id  = ((is_numeric($vars['history_id'])) ? $vars['history_id'] : 0);

  $filename    = "billing-report_".$history_id.".pdf";
  $i           = 0;
  $config['billing']['base']   = $config['billing']['base'];
  $html        = "";
  $history     = array();
  $customer    = array();
  $device      = array();

  // Page Layout
  $portret     = $pdf->serializeTCPDFtagParameters(array('P'));
  $landscape   = $pdf->serializeTCPDFtagParameters(array('L'));

  // History Database content
  foreach (dbFetchRows("SELECT * FROM `bill_hist` WHERE `bill_id`= ? AND `id` = ? ORDER BY `bill_datefrom` DESC LIMIT 1", array($bill_id, $history_id)) as $row) {
    if (bill_permitted($row['bill_id'])) {
      $history['datefrom']      = strftime("%A, %e %B %Y @ %T", strtotime($row['bill_datefrom']));
      $history['dateto']        = strftime("%A, %e %B %Y @ %T", strtotime($row['bill_dateto']));
      $history['timestampfrom'] = strtotime($row['bill_datefrom']);
      $history['timestampto']   = strtotime($row['bill_dateto']);
      $history['type']          = $row['bill_type'];
      $history['percent']       = $row['bill_percent'];
      $history['dir_95th']      = $row['dir_95th'];
      $history['rate_95th']     = formatRates($row['rate_95th']);
      $history['total_data']    = formatStorage($row['traf_total'] * $config['billing']['base'] * $config['billing']['base']);;
      $history['background']    = get_percentage_colours($row['bill_percent']);
      if ($row['bill_type'] == "CDR") {
        $history['allowed']     = format_number($row['bill_allowed'], $config['billing']['base'])."B";
        $history['used']        = format_number($row['rate_95th'], $config['billing']['base'])."B";
        $history['in']          = format_number($row['rate_95th_in'], $config['billing']['base'])."B";
        $history['out']         = format_number($row['rate_95th_out'], $config['billing']['base'])."B";
        $history['overusage']   = (($row['bill_overuse'] <= 0) ? "-" : "<span style=\"color: #".$history['background']['left']."; \">".format_number($row['bill_overuse'] * 1000)."</span>" );
      } else {
        $history['allowed']     = formatStorage($row['bill_allowed'] * $config['billing']['base'] * $config['billing']['base']);
        $history['used']        = formatStorage($row['traf_total'] * $config['billing']['base'] * $config['billing']['base']);
        $history['in']          = formatStorage($row['traf_in'] * $config['billing']['base'] * $config['billing']['base']);
        $history['out']         = formatStorage($row['traf_out'] * $config['billing']['base'] * $config['billing']['base']);
        $history['overusage']   = (($row['bill_overuse'] <= 0) ? "-" : "<span style=\"color: #".$history['background']['left']."; \">".formatStorage($row['bill_overuse'] * $config['billing']['base'] * $config['billing']['base'])."</span>" );
      }
    }
  }

  // Customer Database content
  foreach (dbFetchRows("SELECT bill_name, bill_custid, bill_ref, bill_notes FROM `bills` WHERE `bill_id` = ? ORDER BY `bill_id` LIMIT 1", array($bill_id)) as $row) {
    if (bill_permitted($bill_id)) {
      $customer['id']          = $row['bill_custid'];
      $customer['name']        = $row['bill_name'];
      $customer['ref']         = $row['bill_ref'];
      $customer['notes']       = $row['bill_notes'];
    }
  }

  // Billing types
  $bill_type['95per']   = (($history['type'] != "CDR") ? "[&nbsp;&nbsp;&nbsp;] 95th计费" : "<b>[X] 95th计费</b>");
  $bill_type['quota']   = (($history['type'] != "Quota") ? "[&nbsp;&nbsp;&nbsp;] 限额" : "<b>[X] 限额</b>");
  $bill_type['average'] = (($history['type'] != "Ave") ? "[&nbsp;&nbsp;&nbsp;] 平均" : "<b>[X] 平均</b>");

  // QR Tag
  $http        = ((empty($_SERVER['HTTPS'])) ? "http" : "https" );
  $url['his']  = $http."://".$_SERVER['HTTP_HOST']."/bill/bill_id=".$bill_id."/view=history/detail=".$history_id."/";
  $url['pdf']  = $http."://".$_SERVER['HTTP_HOST']."/pdf.php?type=billing&report=history&bill_id=".$bill_id."&history_id=".$history_id;
  $created     = strftime("%A, %e %B %Y @ %T", strtotime("now"));
  //$qrInfo      = "More Info  : ".$url['his']."\nPDF Report : ".$url['pdf']."\nPDF Created: ".$created."\n";
  $qrInfo      = "More Info  : ".$url['his']."\nPDF Created: ".$created."\n";
  $qrStyle     = array('border' => false, 'vpadding' => auto, 'hpadding' => auto, 'fgcolor' => array(0, 0, 0), 'bgcolor' => false, 'module_width' => 1, 'module_height' => 1);
  $qrTag       = $pdf->serializeTCPDFtagParameters(array($qrInfo, 'QRCODE,H', 162, 68, 50, 50, $qrStyle, 'N'));

  // Include css

  include_once("pdf_css.inc.php");

  $html       .= $css;

  // GB Convert (1000 vs 1024)
  function gbConvert($data) {
    global $config;

    $count = strlen($data);
    $div   = floor($count / 4);
    $res   = round($data / pow(1000, $div) * pow($config['billing']['base'], $div));
    return $res;
  }

  // Generate graphs
  function genGraphs($bill_id, $imgtype, $from, $to, $bittype = "Quota") {
    $http      = ((empty($_SERVER['HTTPS'])) ? "http" : "https" );
    $res       = $http."://".$_SERVER['HTTP_HOST']."/";
    if ($imgtype == "bitrate") {
      $res .= "billing-graph.php?bill_id=".$bill_id;
      if ($bittype == "Quota") {
        $res .= "&ave=yes";
      } elseif ($bittype == "CDR") {
        $res .= "&95th=yes";
      }
    } else {
      $res .= "bandwidth-graph.php?bill_id=".$bill_id;
    }
    $res .= "&type=".$imgtype;
    $res .= "&x=1190&y=250";
    $res .= "&from=".$from."&to=".$to;
    if (!bill_permitted($bill_id)) {
      $res = "images/observium-logo.png";
    }
    return $res;
  }

  // Device Information
  function listBillPorts($bill_id) {
    $res       = "";
    $res      .= "<table>";
    $res      .= "  <tr>";
    $res      .= "    <th>设备</th>";
    $res      .= "    <th>硬件</th>";
    $res      .= "    <th>接口/端口</th>";
    $res      .= "    <th>速率</th>";
    //$res      .= "    <th>概述</th>";
    //$res      .= "    <th>备注</th>";
    $res      .= "  </tr>";
    foreach (dbFetchRows("SELECT * FROM `bill_ports` as b, `ports` as p, `devices` as d WHERE b.bill_id = ? AND p.port_id = b.port_id AND d.device_id = p.device_id", array($bill_id)) as $row) {
      if (bill_permitted($bill_id)) {
        $device['name']   = $row['sysName'];
        //$device['port']   = $row['ifName']." (".$row['ifDescr'].")";
        $device['port']   = $row['ifName'];
        $device['speed']  = formatRates($row['ifSpeed']);
        $device['hw']     = $row['hardware'];
        $device['descr']  = $row['port_descr_descr'];
        $device['notes']  = $row['port_descr_notres'];
        $res  .= "  <tr>";
        $res  .= "    <td>".$device['name']."</td>";
        $res  .= "    <td>".$device['hw']."</td>";
        $res  .= "    <td>".$device['port']."</td>";
        $res  .= "    <td>".$device['speed']."</td>";
        //$res  .= "    <td>".$device['descr']."</td>";
        //$res  .= "    <td>".$device['notes']."</td>";
        $res  .= "  </tr>";
      }
    }
    $res      .= "</table>";
    return $res;
  }

  // Bitrate Graph overview
  function graphOverviewBitrate($bill_id, $history) {
    global $pdf;

    $img['bitrate'] = genGraphs($bill_id, "bitrate", $history['timestampfrom'], $history['timestampto'], $history['type']);
    $bitrate        = $pdf->serializeTCPDFtagParameters(array($img['bitrate'], 10, 44, 280, '', 'PNG', '', 'T'));
    $res       = "";
    $res      .= "<tcpdf method=\"Image\" params=\"".$bitrate."\" />";
    return $res;
  }

  // Transfer Graph overview
  function graphOverviewTransfer($bill_id, $history) {
    global $pdf;

    $img['bw_day']  = genGraphs($bill_id, "day", $history['timestampfrom'], $history['timestampto']);
    $img['bw_hour'] = genGraphs($bill_id, "hour", $history['timestampfrom'], $history['timestampto']);
    $bw_day         = $pdf->serializeTCPDFtagParameters(array($img['bw_day'], 10, 44, 280, '', 'PNG', '', 'T'));
    $bw_hour        = $pdf->serializeTCPDFtagParameters(array($img['bw_hour'], 10, 117, 280, '', 'PNG', '', 'T'));
    $res       = "";
    $res      .= "<tcpdf method=\"Image\" params=\"".$bw_day."\" />";
    $res      .= "<tcpdf method=\"Image\" params=\"".$bw_hour."\" />";
    return $res;
  }

  // Transfer overview
  function transferOverview($bill_id, $history) {
    global $list_colour_a, $list_colour_b, $config;

    $i         = 0;
    $tot       = array();
    $traf      = array();
    $start     = $history['timestampfrom'];
    $end       = $history['timestampto'];
    //$background= $history['background'];
    $res       = "";
    $res      .= "<table class=\"transferOverview\">";
    $res      .= "  <tr bgcolor=\"#000\">";
    $res      .= "    <th class=\"period\">日期</th>";
    $res      .= "    <th class=\"inbound\">流入流量</th>";
    $res      .= "    <th class=\"outbound\">流出流量</th>";
    $res      .= "    <th class=\"total\">合计</th>";
    $res      .= "  </tr>";
    foreach (dbFetch("SELECT DISTINCT UNIX_TIMESTAMP(timestamp) as timestamp, SUM(delta) as traf_total, SUM(in_delta) as traf_in, SUM(out_delta) as traf_out FROM bill_data WHERE `bill_id`= ? AND `timestamp` >= FROM_UNIXTIME(?) AND `timestamp` <= FROM_UNIXTIME(?) GROUP BY DATE(timestamp) ORDER BY timestamp ASC", array($bill_id, $start, $end)) as $data) {
      $date        = strftime("%A, %e %B %Y", $data['timestamp']);
      $tot['in']  += gbConvert($data['traf_in']);
      $tot['out'] += gbConvert($data['traf_out']);
      $tot['tot'] += gbConvert($data['traf_total']);
      $traf['in']  = formatStorage(gbConvert($data['traf_in']), "3");
      $traf['out'] = formatStorage(gbConvert($data['traf_out']), "3");
      $traf['tot'] = formatStorage(gbConvert($data['traf_total']), "3");
      $row_colour  = ((!is_integer($i/2)) ? $list_colour_a : $list_colour_b );
      $res    .= "  <tr bgcolor=\"".$row_colour."\">";
      $res    .= "    <td>".$date."</td>";
      $res    .= "    <td class=\"right\">".$traf['in']."</td>";
      $res    .= "    <td class=\"right\">".$traf['out']."</td>";
      $res    .= "    <td class=\"right\">".$traf['tot']."</td>";
      $res    .= "  </tr>";
      $i++;
    }
    $tot['in'] = formatStorage($tot['in']);
    $tot['out']= formatStorage($tot['out']);
    $tot['tot']= formatStorage($tot['tot']);
    $res      .= "  <tr bgcolor=\"#ccc\" style=\"border-top: 1px solid #000;\">";
    $res      .= "    <td></td>";
    $res      .= "    <td class=\"right\"><b>".$tot['in']."</b></td>";
    $res      .= "    <td class=\"right\"><b>".$tot['out']."</b></td>";
    $res      .= "    <td class=\"right\"><b>".$tot['tot']."</b></td>";
    $res      .= "  </tr>";
    $res      .= "</table>";
    return $res;
  }

  // Html template
  $logo        = $pdf->serializeTCPDFtagParameters(array('images/observium-logo.png', 15, 18, 100, '', '', 'www.observium.org', 'T'));
  $html       .= "<tcpdf method=\"Image\" params=\"".$logo."\" />";
  $html       .= "<h1 class=\"right\">账单报告</h1>";
  $html       .= "<p></p>";
  $html       .= "<p></p>";
  $html       .= "<p></p>";

  $html       .= "<h2>账单信息</h2>";
  $html       .= "<p></p>";
  $html       .= "<table>";
  $html       .= "  <tr>";
  $html       .= "    <th class=\"title\">客户</th>";
  $html       .= "    <td class=\"divider\">:</td>";
  $html       .= "    <td class=\"content\">".$customer['name']."</td>";
  $html       .= "    <td class=\"qtag\" rowspan=\"6\"><tcpdf method=\"write2DBarcode\" params=\"".$qrTag."\" /></td>";
  $html       .= "  </tr>";
  $html       .= "  <tr>";
  $html       .= "    <th>客户ID</th>";
  $html       .= "    <td>:</td>";
  $html       .= "    <td>".$customer['id']."</td>";
  $html       .= "  </tr>";
  $html       .= "  <tr>";
  $html       .= "    <th>客户信息</th>";
  $html       .= "    <td>:</td>";
  $html       .= "    <td>".$customer['ref']."</td>";
  $html       .= "  </tr>";
  $html       .= "  <tr>";
  $html       .= "    <th>客户备注</th>";
  $html       .= "    <td>:</td>";
  $html       .= "    <td>".$customer['notes']."</td>";
  $html       .= "  </tr>";
  $html       .= "  <tr>";
  $html       .= "    <th>账单ID</th>";
  $html       .= "    <td>:</td>";
  $html       .= "    <td>".$bill_id."</td>";
  $html       .= "  </tr>";
  $html       .= "  <tr>";
  $html       .= "    <th>历史ID</th>";
  $html       .= "    <td>:</td>";
  $html       .= "    <td>".$history_id."</td>";
  $html       .= "  </tr>";
  $html       .= "</table>";
  $html       .= "<p></p>";

  $html       .= "<h2>计费周期</h2>";
  $html       .= "<p></p>";
  $html       .= "<table>";
  $html       .= "  <tr>";
  $html       .= "    <th class=\"title\">From</th>";
  $html       .= "    <td class=\"divider\">:</td>";
  $html       .= "    <td class=\"content\">".$history['datefrom']."</td>";
  $html       .= "  </tr>";
  $html       .= "  <tr>";
  $html       .= "    <th>To</th>";
  $html       .= "    <td>:</td>";
  $html       .= "    <td>".$history['dateto']."</td>";
  $html       .= "  </tr>";
  $html       .= "</table>";
  $html       .= "<p></p>";
  $html       .= "<p></p>";

  $html       .= "<h2>设备接口/端口信息</h2>";
  $html       .= "<p></p>";
  $html       .= listBillPorts($bill_id);
  $html       .= "<p></p>";
  $html       .= "<p></p>";

  $html       .= "<h2>使用信息</h2>";
  $html       .= "<p></p>";
  $html       .= "<table>";
  $html       .= "  <tr>";
  $html       .= "    <th class=\"title\">类型</th>";
  $html       .= "    <td class=\"divider\">:</td>";
  $html       .= "    <td class=\"content\">".$bill_type['95per']."</td>";
  $html       .= "  </tr>";
  $html       .= "  <tr>";
  $html       .= "    <td></td>";
  $html       .= "    <td></td>";
  $html       .= "    <td>".$bill_type['quota']."</td>";
  $html       .= "  </tr>";
  $html       .= "  <tr>";
  $html       .= "    <td></td>";
  $html       .= "    <td></td>";
  $html       .= "    <td>".$bill_type['average']."</td>";
  $html       .= "  </tr>";
  $html       .= "  <tr>";
  $html       .= "    <th>传输</th>";
  $html       .= "    <td>:</td>";
  $html       .= "    <td>".$history['used']." (<span style=\"color: #".$history['background']['left']."; \">".$history['percent']."%</span>) </td>";
  $html       .= "  </tr>";
  $html       .= "  <tr>";
  $html       .= "    <th>流入流量</th>";
  $html       .= "    <td>:</td>";
  $html       .= "    <td>".$history['in']."</td>";
  $html       .= "  </tr>";
  $html       .= "  <tr>";
  $html       .= "    <th>流出流量</th>";
  $html       .= "    <td>:</td>";
  $html       .= "    <td>".$history['out']."</td>";
  $html       .= "  </tr>";
  $html       .= "  <tr>";
  $html       .= "    <th>允许</th>";
  $html       .= "    <td>:</td>";
  $html       .= "    <td>".$history['allowed']."</td>";
  $html       .= "  </tr>";
  $html       .= "  <tr>";
  $html       .= "    <th>超额</th>";
  $html       .= "    <td>:</td>";
  $html       .= "    <td>".$history['overusage']."</td>";
  $html       .= "  </tr>";
  $html       .= "</table>";

  $html       .= "<tcpdf method=\"AddPage\" params=\"".$landscape."\" />";
  $html       .= "<h2>比特速率图表概述</h2>";
  $html       .= "<p></p>";
  $html       .= graphOverviewBitrate($bill_id, $history);

  $html       .= "<tcpdf method=\"AddPage\" params=\"".$landscape."\" />";
  $html       .= "<h2>传输流量图概述</h2>";
  $html       .= "<p></p>";
  $html       .= graphOverviewTransfer($bill_id, $history);

  $html       .= "<tcpdf method=\"AddPage\" params=\"".$portret."\" />";
  $html       .= "<h2>详细的传输概述</h2>";
  $html       .= "<p></p>";
  $html       .= transferOverview($bill_id, $history);

?>
