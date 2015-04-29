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

$links['billing']   = generate_url(array('page' => 'bill', 'bill_id' => $bill_id, 'view' => 'transfer', 'tab' => 'billing'));
$links['24hour']    = generate_url(array('page' => 'bill', 'bill_id' => $bill_id, 'view' => 'transfer', 'tab' => '24hour'));
$links['monthly']   = generate_url(array('page' => 'bill', 'bill_id' => $bill_id, 'view' => 'transfer', 'tab' => 'monthly'));
$links['detail']    = generate_url(array('page' => 'bill', 'bill_id' => $bill_id, 'view' => 'transfer', 'tab' => 'detail'));
$links['previous']  = generate_url(array('page' => 'bill', 'bill_id' => $bill_id, 'view' => 'transfer', 'tab' => 'previous'));

/*
if (empty($active['billing']) && empty($active['24hour']) && empty($active['monthly']) && empty($active['detail']) && empty($active['previous'])) { $active['billing'] = "active"; }
$graph              = "";

$cur_days     = date('d', ($config['time']['now'] - strtotime($datefrom)));
$total_days   = date('d', (strtotime($dateto)));

$used         = format_bytes_billing($total_data);
$average      = format_bytes_billing($total_data / $cur_days);
$estimated    = format_bytes_billing($total_data / $cur_days * $total_days);

if ($bill_data['bill_type'] == "quota") {
  $quota      = $bill_data['bill_quota'];
  $percent    = round(($total_data) / $quota * 100, 2);
  $allowed    = format_si($quota)."B";
  $overuse    = $total_data - $quota;
  $overuse    = (($overuse <= 0) ? "<span class=\"badge badge-success\">-</span>" : "<span class=\"badge badge-important\">".format_bytes_billing($overuse)."</span>");
  $type       = "Quota";
} elseif ($bill_data['bill_type'] == "cdr") {
  $cdr        = $bill_data['bill_cdr'];
  $percent    = "0";
  $allowed    = "-";
  $overuse    = "<span class=\"badge badge-success\">-</span>";
  $type       = "CDR / 95th percentile";
}

$optional['cust']  = (($isAdmin && !empty($bill_data['bill_custid'])) ? $bill_data['bill_custid'] : "n/a");
$optional['ref']   = (($isAdmin && !empty($bill_data['bill_ref'])) ? $bill_data['bill_ref'] : "n/a");
$optional['notes'] = (!empty($bill_data['bill_notes']) ? $bill_data['bill_notes'] : "n/a");

$lastmonth    = dbFetchCell("SELECT UNIX_TIMESTAMP(DATE_SUB(NOW(), INTERVAL 1 MONTH))");
$yesterday    = dbFetchCell("SELECT UNIX_TIMESTAMP(DATE_SUB(NOW(), INTERVAL 1 DAY))");
$rightnow     = date(U);
*/
$bi           = '<img src="bandwidth-graph.php?bill_id=' . $bill_id . '&amp;bill_code=' . $vars['bill_code'];
$bi          .= '&amp;from=' . $unixfrom .  '&amp;to=' . $unixto;
$bi          .= '&amp;type=day&amp;imgbill=1';
$bi          .= '&amp;x=1230&amp;y=300" alt="">';

$li           = '<img src="bandwidth-graph.php?bill_id=' . $bill_id . '&amp;bill_code=' . $vars['bill_code'];
$li          .= '&amp;from=' . $unix_prev_from .  '&amp;to=' . $unix_prev_to;
$li          .= '&amp;type=day';
$li          .= '&amp;x=1230&amp;y=300" alt="">';

$di           = '<img src="bandwidth-graph.php?bill_id=' . $bill_id . '&amp;bill_code=' . $vars['bill_code'];
$di          .= '&amp;from=' . $config['time']['day'] .  '&amp;to=' . $config['time']['now'];
$di          .= '&amp;type=hour';
$di          .= '&amp;x=1230&amp;y=300" alt="">';

$mi           = '<img src="bandwidth-graph.php?bill_id=' . $bill_id . '&amp;bill_code=' . $vars['bill_code'];
$mi          .= '&amp;from=' . $lastmonth .  '&amp;to=' . $rightnow;
$mi          .= '&amp;type=day';
$mi          .= '&amp;x=1230&amp;y=300" alt="">';

/*
switch(true) {
  case($percent >= 90):
    $perc['BG'] = "danger";
    break;
  case($percent >= 75):
    $perc['BG'] = "warning";
    break;
  case($percent >= 50):
    $perc['BG'] = "success";
    break;
  default:
    $perc['BG'] = "info";
}
$perc['width'] = (($percent <= "100") ? $percent : "100");
*/
// GB Convert (1000 vs 1024)
function gbConvert($data) {
  global $config;

  $count = strlen($data);
  $div   = floor($count / 4);
  $res   = round($data / pow(1000, $div) * pow($config['billing']['base'], $div));
  return $res;
}

function transferOverview($bill_id, $start, $end) {
  $tot       = array();
  $traf      = array();
  global $cur_days, $total_days;

  //$cur_days     = date('d', ($config['time']['now'] - strtotime($datefrom)));
  //$total_days   = date('d', (strtotime($dateto)));
  $res       = "    <table class=\"table table-striped table-bordered table-hover table-condensed table-rounded\" style=\"margin-bottom: 0px;\">";
  $res      .= "      <thead>";
  $res      .= "        <tr>";
  $res      .= "          <th>周期</th>";
  $res      .= "          <th style=\"text-align: center;\">流入流量</th>";
  $res      .= "          <th style=\"text-align: center;\">流出流量</th>";
  $res      .= "          <th style=\"text-align: center;\">合计</th>";
  $res      .= "          <th style=\"text-align: center;\">小计</th>";
  $res      .= "        </tr>";
  $res      .= "      </thead>";
  $res      .= "      <tbody>";
  foreach (dbFetch("SELECT DISTINCT UNIX_TIMESTAMP(timestamp) as timestamp, SUM(delta) as traf_total, SUM(in_delta) as traf_in, SUM(out_delta) as traf_out FROM bill_data WHERE `bill_id`= ? AND `timestamp` >= FROM_UNIXTIME(?) AND `timestamp` <= FROM_UNIXTIME(?) GROUP BY DATE(timestamp) ORDER BY timestamp ASC", array($bill_id, $start, $end)) as $data) {
    $date        = strftime("%A, %e %B %Y", $data['timestamp']);
    $tot['in']  += gbConvert($data['traf_in']);
    $tot['out'] += gbConvert($data['traf_out']);
    $tot['tot'] += gbConvert($data['traf_total']);
    $traf['in']  = formatStorage(gbConvert($data['traf_in']), "3");
    $traf['out'] = formatStorage(gbConvert($data['traf_out']), "3");
    $traf['tot'] = formatStorage(gbConvert($data['traf_total']), "3");
    $traf['stot'] = formatStorage(gbConvert($tot['tot']), "3");
    $res    .= "        <tr>";
    $res    .= "          <td><i class=\"icon-calendar\"></i> ".$date."</td>";
    $res    .= "          <td style=\"text-align: center;\"><span class=\"badge badge-success\">".$traf['in']."</span></td>";
    $res    .= "          <td style=\"text-align: center;\"><span class=\"badge badge-info\">".$traf['out']."</span></td>";
    $res    .= "          <td style=\"text-align: center;\"><span class=\"badge badge-inverse\">".$traf['tot']."</span></td>";
    $res    .= "          <td style=\"text-align: center;\"><span class=\"badge badge\">".$traf['stot']."</span></td>";
    $res    .= "        </tr>";
  }
  $est['in'] = formatStorage($tot['in'] / $cur_days * $total_days);
  $est['out']= formatStorage($tot['out'] / $cur_days * $total_days);
  $est['tot']= formatStorage($tot['tot'] / $cur_days * $total_days);
  $res      .= "        <tr class=\"alert\">";
  $res      .= "          <td><strong>Estimated for this billing period</strong></td>";
  $res      .= "          <td style=\"text-align: center;\"><span class=\"badge badge-success\"><strong>".$est['in']."</strong></span></td>";
  $res      .= "          <td style=\"text-align: center;\"><span class=\"badge badge-info\"><strong>".$est['out']."</strong></span></td>";
  $res      .= "          <td style=\"text-align: center;\"><span class=\"badge badge-inverse\"><strong>".$est['tot']."</strong></span></td>";
  $res      .= "          <td></td>";
  $res      .= "        </tr>";
  $tot['in'] = formatStorage($tot['in']);
  $tot['out']= formatStorage($tot['out']);
  $tot['tot']= formatStorage($tot['tot']);
  $res      .= "        <tr class=\"info\">";
  $res      .= "          <td><strong>Total of this billing period</strong></td>";
  $res      .= "          <td style=\"text-align: center;\"><span class=\"badge badge-success\"><strong>".$tot['in']."</strong></span></td>";
  $res      .= "          <td style=\"text-align: center;\"><span class=\"badge badge-info\"><strong>".$tot['out']."</strong></span></td>";
  $res      .= "          <td style=\"text-align: center;\"><span class=\"badge badge-inverse\"><strong>".$tot['tot']."</strong></span></td>";
  $res      .= "          <td></td>";
  $res      .= "        </tr>";
  $res      .= "      </tbody>";
  $res      .= "    </table>";
  return $res;
}

if ($active['billing'] == "active") { $graph = $bi; }
elseif ($active['24hour'] == "active") { $graph = $di; }
elseif ($active['monthly'] == "active") { $graph = $mi; }
elseif ($active['detail'] == "active") { $graph = transferOverview($bill_id, $unixfrom, $unixto); }
elseif ($active['previous'] == "active") { $graph = $li; }

/**

?>

<div class="row" style="margin-bottom: 15px;">
  <div class="col-md-6 well info_box">
    <div id="title"><i class="oicon-information"></i> 账单概述</div>
    <table class="table table-striped table-bordered table-condensed table-rounded">
      <tr>
        <th style="width: 125px;">账单周期</th>
        <td style="width: 5px;">:</td>
        <td><?php echo($fromtext." to ".$totext); ?></td>
      </tr>
      <tr>
        <th>Type</th>
        <td>:</td>
        <td><span class="label label-inverse"><?php echo($type); ?></span></td>
      </tr>
      <tr>
        <th>Allowed</th>
        <td>:</td>
        <td><span class="badge badge-success"><?php echo($allowed); ?></span></td>
      </tr>
      <tr>
        <th>Used</th>
        <td>:</td>
        <td><span class="badge badge-warning"><?php echo($used); ?></span></td>
      </tr>
      <tr>
        <th>Average</th>
        <td>:</td>
        <td><span class="badge"><?php echo($average); ?></span></td>
      </tr>
      <tr>
        <th>Estimated</th>
        <td>:</td>
        <td><span class="badge badge-info"><?php echo($estimated); ?></span></td>
      </tr>
<?php if ($bill_data['bill_type'] == "quota") { ?>
      <tr>
        <th>Overusage</th>
        <td>:</td>
        <td><?php echo($overuse); ?></td>
      </tr>
      <tr>
        <td colspan="3">
          <?php $background = get_percentage_colours($percent); ?>
          <?php echo(print_percentage_bar(400, 20, $percent, $percent.'%', "ffffff", $background['left'], 100-$percent."%", "ffffff", $background['right'])); ?>
        </td>
      </tr>
<?php } ?>
    </table>
  </div>
  <div class="col-md-6">
   <div class="well info_box">
    <div id="title"><i class="oicon-information-button"></i> 可选信息</div>
    <table class="table table-striped table-bordered table-condensed table-rounded">
      <tr>
        <th style="width: 175px;"><i class="icon-user"></i> 客户参考</th>
        <td style="width: 5px;">:</td>
        <td><?php echo($optional['cust']); ?></td>
      </tr>
      <tr>
        <th><i class="icon-info-sign"></i> 账单参考</th>
        <td>:</td>
        <td><?php echo($optional['ref']); ?></td>
      </tr>
      <tr>
        <th><i class="icon-comment"></i> 备注</th>
        <td>:</td>
        <td><?php echo($optional['notes']); ?></td>
      </tr>
    </table>
   </div>
   <div class="well info_box">
    <div id="title"><i class="oicon-network-ethernet"></i> 端口信息</div>
    <table class="table table-striped table-bordered table-condensed table-rounded">
      <tr>
        <th style="width: 175px;"><i class="icon-random"></i> 端口数量</th>
        <td style="width: 5px;">:</td>
        <td><?php echo($ports_info['ports']); ?></td>
      </tr>
      <tr>
        <th><i class="icon-random"></i> 总容量</th>
        <td>:</td>
        <td><?php echo(format_si($ports_info['capacity'])); ?>bps</td>
      </tr>
    </table>
   </div>
  </div>
</div>

<?php

*/

?>

<div class="tabBox">
  <ul class="nav nav-tabs" id="transferBillTab">
    <li class="<?php echo($active['billing']); ?> first"><a href="<?php echo($links['billing']); ?>">账单显示</a></li>
    <li class="<?php echo($active['24hour']); ?>"><a href="<?php echo($links['24hour']); ?>">24小时滚动视图</a></li>
    <li class="<?php echo($active['monthly']); ?>"><a href="<?php echo($links['monthly']); ?>">月度滚动视图</a></li>
    <li class="<?php echo($active['detail']); ?>"><a href="<?php echo($links['detail']); ?>">详细计费视图</a></li>
    <li class="<?php echo($active['previous']); ?>"><a href="<?php echo($links['previous']); ?>">以前的滚动计费视图</a></li>
  </ul>
  <div class="tabcontent tab-content" id="transferBillTabContent" style="min-height: 300px;">
    <div class="tab-pane fade in active" id="transferGraph" style="text-align: center;">
      <?php echo($graph."\n"); ?>
    </div>
  </div>
</div>
