<?php

$pagetitle[]      = "Current Billing Period";
$isAdmin          = (($_SESSION['userlevel'] == "10") ? true : false);
$disabled         = ($isAdmin ? "" : "disabled=\"disabled\"");
$links['add']     = ($isAdmin ? generate_url($vars, array('view' => 'add')) : "javascript:;");
$links['prev']    = generate_url($vars, array('view' => 'history'));
$links['cur']     = generate_url($vars, array('view' => ''));

include_once('searchaction.inc.php');

echo '<table class="table table-condensed table-bordered table-striped table-hover table-rounded">
        <thead>
          <tr>
            <th>Billing name</th>
            <th style="width: 60px; text-align: center;">Type</th>
            <th style="width: 70px; text-align: center;">Allowed</th>
            <th style="width: 70px; text-align: center;">Used</th>
            <th style="width: 70px; text-align: center;">Overusage</th>
            <th style="width: 225px;"></th>
            <th style="width: 215px;">
              <div class="btn-group">';
if($vars['view'] == 'history')
{
  echo '
           <a class="btn btn-mini btn-primary" style="color: #fff;" href="'.$links['cur'].'"><i class="icon-chevron-right icon-white"></i> Current period</a>';
} else{
  echo '
           <a class="btn btn-mini btn-primary" style="color: #fff;" href="'.$links['prev'].'"><i class="icon-chevron-left icon-white"></i> Previous period</a>';
}

echo '
                <a class="btn btn-mini btn-success" style="color: #fff;" href="'.$links['add'].'"'.$disabled.'"><i class="icon-plus-sign icon-white"></i> Add Bill</a>
              </div>
            </th>
          </tr>
        </thead>
        <tbody>'.PHP_EOL;

//foreach (dbFetchRows("SELECT * FROM `bills` ORDER BY `bill_name`") as $bill) {
foreach (dbFetchRows("SELECT * FROM `bills` ".$where." ORDER BY `bill_name`", $param) as $bill) {
  if (bill_permitted($bill['bill_id'])) {
    unset($class);
    $day_data     = getDates($bill['bill_day']);

    if ($vars['view'] == 'history')
    {
      $datefrom     = $day_data['2'];
      $dateto       = $day_data['3'];
      $history      = dbFetchRow("SELECT * FROM `bill_history` WHERE `bill_id` = ? AND `bill_datefrom` = ? ORDER BY `bill_datefrom` LIMIT 1", array($bill['bill_id'], $datefrom, $dateto));
      $rate_data    = $history;
    } else {
      $datefrom     = $day_data['0'];
      $dateto       = $day_data['1'];
      $rate_data    = $bill;
    }

    $rate_95th    = $rate_data['rate_95th'];
    $dir_95th     = $rate_data['dir_95th'];
    $total_data   = $rate_data['total_data'];
    $rate_average = $rate_data['rate_average'];
    $notes        = $bill['bill_notes'];
    $custid       = $bill['bill_custid'];
    $refid        = $bill['bill_ref'];
    $billid       = $bill['bill_id'];

    if ($bill['bill_type'] == "cdr") {
      $type = "CDR 95th";
      if ($view == 'history') {
        $allowed = format_si($history['bill_allowed'])."bps";
        $used    = format_si($rate_data['rate_95th'])."bps";
        $overuse = $rate_data['rate_95th'] - $history['bill_allowed'];
        $overuse = (($overuse <= 0) ? "-" : format_si($overuse)."bps");
      } else {
        $allowed = format_si($bill['bill_cdr'])."bps";
        $used    = format_si($rate_data['rate_95th'])."bps";
        $percent = round(($rate_data['rate_95th'] / $bill['bill_cdr']) * 100,2);
        $overuse = $rate_data['rate_95th'] - $bill['bill_cdr'];
        $overuse = (($overuse <= 0) ? "-" : format_si($overuse)."bps");
      }
    } elseif ($bill['bill_type'] == "quota") {
      $type = "Quota";
      if ($vars['view'] == 'history') {
        $allowed = format_bytes_billing($history['bill_allowed']);
        $used    = format_bytes_billing($rate_data['traf_total']);
        $percent = round(($rate_data['traf_total'] / ($history['bill_allowed'])) * 100,2);
        $overuse = $rate_data['traf_total'] - $history['bill_allowed'];
        $overuse = (($overuse <= 0) ? "-" : format_bytes_billing($overuse));
      } else {
        $allowed = format_bytes_billing($bill['bill_quota']);
        $used    = format_bytes_billing($rate_data['total_data']);
        $percent = round(($rate_data['total_data'] / ($bill['bill_quota'])) * 100,2);
        $overuse = $rate_data['total_data'] - $bill['bill_quota'];
        $overuse = (($overuse <= 0) ? "-" : format_bytes_billing($overuse));
      }
    }

    $background = get_percentage_colours($percent);

    switch(true) {
      case ($percent >= 90):
        $perc['BG'] = "danger";
        break;
      case ($percent >= 75):
        $perc['BG'] = "warning";
        break;
      case ($percent >= 50):
        $perc['BG'] = "success";
        break;
      default:
        $perc['BG'] = "info";
    }
    $perc['width']    = (($percent <= "100") ? $percent : "100");
    $label['type']    = (($type == "Quota") ? "info" : "inverse");
    $label['overuse'] = (($overuse == "-") ? "success" : "important");
    $notes            = (!empty($notes) ? "<br /><span class=\"label\"><i class=\"icon-comment icon-white\"></i> &nbsp;".$notes."&nbsp;</span>" : "");
    $ref['cust']      = (!empty($custid) ? "<a href=\"javascript:;\" rel=\"tooltip\" alt=\"".$custid."\"><i class=\"icon-user\"></i></a>" : "");
    $ref['bill']      = (!empty($refid) ? "<a href=\"javascript:;\" rel=\"tooltip\" alt=\"".$refid."\"><i class=\"icon-info-sign\"></i></a>" : "");
    $ref['html']      = (((!empty($ref['cust']) || !empty($ref['bill'])) && ($isAdmin == true)) ? "<span style=\"float: right;\">".$ref['cust']."".$ref['bill']."</span>" : "");
    $links['quick']   = generate_url(array('page' => 'bill', 'bill_id' => $billid, 'view' => 'quick'));
    $links['accurate']= generate_url(array('page' => 'bill', 'bill_id' => $billid, 'view' => 'accurate'));
    $links['transfer']= generate_url(array('page' => 'bill', 'bill_id' => $billid, 'view' => 'transfer'));
    $links['history'] = generate_url(array('page' => 'bill', 'bill_id' => $billid, 'view' => 'history'));
    $links['edit']    = ($isAdmin ? generate_url(array('page' => 'bill', 'bill_id' => $billid, 'view' => 'edit')) : "javascript:;");
    $links['reset']   = ($isAdmin ? generate_url(array('page' => 'bill', 'bill_id' => $billid, 'view' => 'reset')) : "javascript:;");
    $links['delete']  = ($isAdmin ? generate_url(array('page' => 'bill', 'bill_id' => $billid, 'view' => 'delete')) : "javascript:;");
    echo("
          <tr>
            <td>
              <i class=\"icon-hdd\"></i> <a href=\"".$links['quick']."\"><strong class=\"interface\">".$bill['bill_name']."</strong></a>".$ref['html']."<br />
              <i class=\"icon-calendar\"></i> ".strftime("%F", strtotime($datefrom))." to ".strftime("%F", strtotime($dateto))."
              ".$notes."
            </td>
            <td style=\"text-align: center;\"><span class=\"label label-".$label['type']."\">".$type."</span></td>
            <td style=\"text-align: center;\">".$allowed."</td>
            <td style=\"text-align: center;\">".$used."</td>
            <td style=\"text-align: center;\">".$overuse."</td>
            <td>");
     echo(print_percentage_bar (400, 20, $percent, $percent.'%', "ffffff", $background['left'], ($percent < 100 ? 100-$percent."%" : "0%") , "ffffff", $background['right']));
     echo("
            </td>
            <td>
              <div class=\"btn-toolbar\" style=\"margin-top: 0px;\">
 <!--
                <div class=\"btn-group pull-right\">
                  <a class=\"btn btn-mini btn-primary\" href=\"".$links['quick']."\" rel=\"tooltip\" alt=\"Show quick graphs\"><i class=\"icon-list-alt icon-white\"></i> Quick</a>
                  <a class=\"btn btn-mini btn-primary\" href=\"".$links['accurate']."\" rel=\"tooltip\" alt=\"Show accurate graphs\"><i class=\"icon-signal icon-white\"></i> Accurate</a>
                  <a class=\"btn btn-mini btn-primary\" href=\"".$links['transfer']."\" rel=\"tooltip\" alt=\"Show transfer graphs\"><i class=\"icon-tasks icon-white\"></i> Transfer</a>
                  <a class=\"btn btn-mini btn-primary\" href=\"".$links['history']."\" rel=\"tooltip\" alt=\"Show historical usage\"><i class=\"icon-calendar icon-white\"></i> History</a>
                </div>
 -->
                <div class=\"btn-group pull-right\" style=\"margin-top: 0px;\">
                  <a class=\"btn btn-mini btn-success\" href=\"".$links['edit']."\" rel=\"tooltip\" alt=\"Edit bill\"".$disabled."><i class=\"icon-edit icon-white\"></i> Edit</a>
                  <a class=\"btn btn-mini btn-warning\" href=\"".$links['reset']."\" rel=\"tooltip\" alt=\"Reset bill\"".$disabled."><i class=\"icon-refresh icon-white\"></i> Reset</a>
                  <a class=\"btn btn-mini btn-danger\" href=\"".$links['delete']."\" rel=\"tooltip\" alt=\"Delete bill\"".$disabled."><i class=\"icon-trash icon-white\"></i> Delete</a>
                </div>
              </div>
            </td>
          </tr>\n");
  } // PERMITTED
}

echo("  </tbody>\n");
echo("</table>\n");

?>
