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

$active['billing']  = (($vars['tab'] == "billing") ? "active" : "");
$active['24hour']   = (($vars['tab'] == "24hour") ? "active" : "");
$active['monthly']  = (($vars['tab'] == "monthly") ? "active" : "");
$active['previous'] = (($vars['tab'] == "previous") ? "active" : "");
$active['detail']   = (($vars['tab'] == "detail") ? "active" : "");

if (empty($active['billing']) && empty($active['24hour']) && empty($active['monthly']) && empty($active['detail']) && empty($active['previous'])) { $active['billing'] = "active"; }
$graph              = "";

$cur_days     = date('d', ($config['time']['now'] - strtotime($datefrom)));
$total_days   = date('d', (strtotime($dateto)));

//$used         = format_bytes_billing($total_data);
//$average      = format_bytes_billing($total_data / $cur_days);
//$estimated    = format_bytes_billing($total_data / $cur_days * $total_days);

if ($bill_data['bill_type'] == "quota") {
  $quota      = $bill_data['bill_quota'];
  $percent    = round(($total_data) / $quota * 100, 2);
  $used       = format_bytes_billing($total_data);
  $allowed    = format_si($quota)."B";
  $overuse    = $total_data - $quota;
  $overuse    = (($overuse <= 0) ? "<span class=\"badge badge-success\">-</span>" : "<span class=\"badge badge-important\">".format_bytes_billing($overuse)."</span>");
  $type       = "限流";
  $imgtype    = "&amp;ave=yes";
  $current    = array(
                  'in' => format_bytes_billing($bill_data['total_data_in']),
                  'out' => format_bytes_billing($bill_data['total_data_out']),
                  'tot' => format_bytes_billing($bill_data['total_data'])
                );

  $average    = array(
                  'in' => format_bytes_billing($bill_data['total_data_in'] / $cur_days),
                  'out' => format_bytes_billing($bill_data['total_data_out'] / $cur_days),
                  'tot' => format_bytes_billing($bill_data['total_data'] / $cur_days)
                );

  $estimated  = array(
                  'in' => format_bytes_billing($bill_data['total_data_in'] / $cur_days * $total_days),
                  'out' => format_bytes_billing($bill_data['total_data_out'] / $cur_days * $total_days),
                  'tot' => format_bytes_billing($bill_data['total_data'] / $cur_days * $total_days)
                );
} elseif ($bill_data['bill_type'] == "cdr") {
  $cdr        = $bill_data['bill_cdr'];
  $percent    = round(($rate_95th) / $cdr * 100, 2);
  $used       = format_si($rate_95th)."bps";
  $allowed    = format_si($cdr)."bps";
  $overuse    = $rate_95th - $cdr;
  $overuse    = (($overuse <= 0) ? "<span class=\"badge badge-success\">-</span>" : "<span class=\"badge badge-important\">".format_si($overuse)."bps</span>");
  $type       = "CDR / 95th %";
  $imgtype    = "&amp;95th=yes";
  $current    = array(
                  'in' => format_si($bill_data['rate_95th_in'])."bps",
                  'out' => format_si($bill_data['rate_95th_out'])."bps",
                  'tot' => format_si($bill_data['rate_95th'])."bps"
                );
  $average    = array(
                  'in' => format_si($bill_data['rate_average_in'])."bps",
                  'out' => format_si($bill_data['rate_average_out'])."bps",
                  'tot' => format_si($bill_data['rate_average'])."bps"
                );
  $estimated  = array(
                  'in' => "n/a",
                  'out' => "n/a",
                  'tot' => "n/a"
                );
}

$optional['cust']  = (($isAdmin && !empty($bill_data['bill_custid'])) ? $bill_data['bill_custid'] : "n/a");
$optional['ref']   = (($isAdmin && !empty($bill_data['bill_ref'])) ? $bill_data['bill_ref'] : "n/a");
$optional['notes'] = (!empty($bill_data['bill_notes']) ? $bill_data['bill_notes'] : "n/a");
$optional['poll']  = (!empty($bill_data['bill_polled']) ? $bill_data['bill_polled'] : "n/a");
$optional['calc']  = (!empty($bill_data['bill_last_calc']) ? $bill_data['bill_last_calc'] : "n/a");

$lastmonth    = dbFetchCell("SELECT UNIX_TIMESTAMP(DATE_SUB(NOW(), INTERVAL 1 MONTH))");
$yesterday    = dbFetchCell("SELECT UNIX_TIMESTAMP(DATE_SUB(NOW(), INTERVAL 1 DAY))");
$rightnow     = date(U);

$bi           = "<img src='billing-graph.php?bill_id=" . $bill_id . "&amp;bill_code=" . $vars['bill_code'];
$bi          .= "&amp;from=" . $unixfrom .  "&amp;to=" . $unixto;
$bi          .= "&amp;x=1050&amp;y=300";
$bi          .= "$imgtype'>";

$li           = "<img src='billing-graph.php?bill_id=" . $bill_id . "&amp;bill_code=" . $vars['bill_code'];
$li          .= "&amp;from=" . $unix_prev_from .  "&amp;to=" . $unix_prev_to;
$li          .= "&amp;x=1050&amp;y=300";
$li          .= "$imgtype'>";

$di           = "<img src='billing-graph.php?bill_id=" . $bill_id . "&amp;bill_code=" . $vars['bill_code'];
$di          .= "&amp;from=" . $config['time']['day'] .  "&amp;to=" . $config['time']['now'];
$di          .= "&amp;x=1050&amp;y=300";
$di          .= "$imgtype'>";

$mi           = "<img src='billing-graph.php?bill_id=" . $bill_id . "&amp;bill_code=" . $vars['bill_code'];
$mi          .= "&amp;from=" . $lastmonth .  "&amp;to=" . $rightnow;
$mi          .= "&amp;x=1050&amp;y=300";
$mi          .= "$imgtype'>";

if ($active['billing'] == "active") { $graph = $bi; }
elseif ($active['24hour'] == "active") { $graph = $di; }
elseif ($active['monthly'] == "active") { $graph = $mi; }
elseif ($active['previous'] == "active") { $graph = $li; }

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

?>

<div class="row" style="margin-bottom: 15px;">
  <div class="col-md-6">
    <div class="well info_box">
      <div class="title"><i class="oicon-chart"></i> 账单描述</div>
      <div class="content">

        <table class="table table-striped table-bordered table-condensed table-rounded">
         <thead>
          <tr>
            <th style="width: 25%;">类型</th>
            <th style="width: 25%;">限流</th>
            <th style="width: 25%;">已用</th>
            <th style="width: 25%;">超额</th>
          </tr>
        </thead>
        <tr>
            <td style="width: 25%;"><span class="label label-inverse"><?php echo($type); ?></span></td>
            <td style="width: 25%;"><span class="badge badge-success"><?php echo($allowed); ?></span></td>
            <td><span class="badge badge-warning"><?php echo($used); ?></span></td>
            <td><?php echo($overuse); ?></td>
          </tr>
        </table>

        <table class="table table-bordered table-striped table-condensed" style="margin-top: 10px;">
          <thead>
            <tr>
              <th style="width: 25%;"></th>
              <th style="width: 25%;">流入流量</th>
              <th style="width: 25%;">流出流量</th>
              <th style="width: 25%;">已用</th>
            </tr>
           </thead>
          <tr>
<?php if ($bill_data['bill_type'] == "cdr") { ?>
            <th style="width: 125px;">95th计费</th>
<?php } else { ?>
            <th style="width: 125px;">合计</th>
<?php } ?>

            <td><span class="badge badge-success"><?php echo($current['in']); ?></span></td>
            <td><span class="badge badge-info"><?php echo($current['out']); ?></span></td>
            <td><span class="badge"><?php echo($current['tot']); ?></span></td>
          </tr>
          <tr>
            <th>平均</th>

            <td><span class="badge badge-success"><?php echo($average['in']); ?></span></td>
            <td><span class="badge badge-info"><?php echo($average['out']); ?></span></td>
            <td><span class="badge"><?php echo($average['tot']); ?></span></td>
          </tr>
<?php if ($bill_data['bill_type'] == "quota") { ?>
          <tr>
            <th>预计</th>

            <td><span class="badge badge-success"><?php echo($estimated['in']); ?></span></td>
            <td><span class="badge badge-info"><?php echo($estimated['out']); ?></span></td>
            <td><span class="badge"><?php echo($estimated['tot']); ?></span></td>
          </tr>
<?php } ?>
          <tr>
            <td colspan="4">
              <?php $background = get_percentage_colours($percent); ?>
              <?php echo(print_percentage_bar (400, 20, $percent, $percent.'%', "ffffff", $background['left'], 100-$percent."%" , "ffffff", $background['right']));  ?>
            </td>
          </tr>

        </table>
      </div>
    </div>
  </div>

  <div class="col-md-6">
    <div class="well info_box">
      <div class="title"><i class="oicon-information-button"></i> 计费信息</div>
      <div class="content">
        <table class="table table-striped table-bordered table-condensed table-rounded">
          <tr>
            <th style="width: 25%;">计费周期</th>
            <td><?php echo($fromtext." to ".$totext); ?></td>
          </tr>

          <tr>
            <th style="width: 175px;"><i class="icon-user"></i> 用户参考</th>
            <td><?php echo($optional['cust']); ?></td>
          </tr>
          <tr>
            <th><i class="icon-info-sign"></i> 计费参考</th>

            <td><?php echo($optional['ref']); ?></td>
          </tr>
          <tr>
            <th><i class="icon-comment"></i> 备注</th>

            <td><?php echo($optional['notes']); ?></td>
          </tr>
          <tr>
            <th style="width: 175px;"><i class="icon-time"></i> 最近一次轮询</th>

            <td><?php echo(strftime('%A, %e %B %Y @ %H:%M:%S', $optional['poll'])); ?></td>
          </tr>
          <tr>
            <th><i class="icon-time"></i> 最近一次计费</th>

            <td><?php echo(strftime('%A, %e %B %Y @ %H:%M:%S', time($optional['calc']))); ?></td>
          </tr>
          <tr>
            <th style="width: 175px;"><i class="icon-random"></i> 计费端口</th>

            <td><?php include($config['html_dir']."/pages/bill/ports.inc.php");
                ?></td>
          </tr>
<?php
/**
          <tr>
            <th><i class="icon-random"></i> 总流量</th>

            <td><?php echo(format_si($ports_info['capacity'])); ?>bps</td>
          </tr>
*/
?>
        </table>
      </div>
    </div>
  </div>
</div>
