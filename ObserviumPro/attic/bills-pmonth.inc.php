<?php

$pagetitle[]      = "以往计费周期";
$isAdmin          = (($_SESSION['userlevel'] == "10") ? true : false);
$disabled         = ($isAdmin ? "" : "disabled=\"disabled\"");
$links['add']     = ($isAdmin ? generate_url($vars, array('view' => 'add')) : "javascript:;");
$links['cur']     = generate_url($vars, array('view' => ''));

include_once('searchaction.inc.php');

echo("<table class=\"table table-condensed table-bordered table-striped table-hover table-rounded\">
        <thead>
          <tr>
            <th>账单名称</th>
            <th style=\"width: 60px; text-align: center;\">类型</th>
            <th style=\"width: 70px; text-align: center;\">限额</th>
            <th style=\"width: 70px; text-align: center;\">已用</th>
            <th style=\"width: 70px; text-align: center;\">超额</th>
            <th style=\"width: 225px;\"></th>
            <th style=\"width: 215px;\">
              <div class=\"btn-group\">
                <a class=\"btn btn-mini btn-primary\" style=\"color: #fff;\" href=\"".$links['cur']."\"><i class=\"icon-chevron-right icon-white\"></i> 本期</a>
                <a class=\"btn btn-mini btn-success\" style=\"color: #fff;\" href=\"".$links['add']."\"".$disabled."\"><i class=\"icon-plus-sign icon-white\"></i> 添加账单</a>
              </div>
            </th>
          </tr>
        </thead>
        <tbody>\n");

//foreach (dbFetchRows("SELECT * FROM `bills` ORDER BY `bill_name`") as $bill) {
foreach (dbFetchRows("SELECT * FROM `bills` ".$where." ORDER BY `bill_name`", $param) as $bill) {
  if (bill_permitted($bill['bill_id'])) {
    unset($class);
    $day_data     = getDates($bill['bill_day']);
    $datefrom     = $day_data['2'];
    $dateto       = $day_data['3'];
    foreach (dbFetchRows("SELECT * FROM `bill_history` WHERE `bill_id` = ? AND `bill_datefrom` = ? ORDER BY `bill_datefrom` LIMIT 1", array($bill['bill_id'], $datefrom, $dateto)) as $history) {
      unset($class);
      $rate_data    = $history;
      $rate_95th    = $rate_data['rate_95th'];
      $dir_95th     = $rate_data['dir_95th'];
      $total_data   = $rate_data['total_data'];
      $rate_average = $rate_data['rate_average'];
      $notes        = $bill['bill_notes'];
      $custid       = $bill['bill_custid'];
      $refid        = $bill['bill_ref'];
      $billid       = $bill['bill_id'];

      if (strtolower($history['bill_type']) == "cdr") {
        $type = "CDR 95th";
        $allowed = format_si($history['bill_allowed'])."bps";
        $used    = format_si($rate_data['rate_95th'])."bps";
        $percent = round(($rate_data['rate_95th'] / $history['bill_allowed']) * 100,2);
        $background = get_percentage_colours($percent);
        $overuse = $rate_data['rate_95th'] - $history['bill_allowed'];
        $overuse = (($overuse <= 0) ? "-" : format_si($overuse)."bps");
      } elseif (strtolower($history['bill_type']) == "quota") {
        $type = "限额";
        $allowed = format_bytes_billing($history['bill_allowed']);
        $used    = format_bytes_billing($rate_data['traf_total']);
        $percent = round(($rate_data['traf_total'] / ($history['bill_allowed'])) * 100,2);
        $background = get_percentage_colours($percent);
        $overuse = $rate_data['traf_total'] - $history['bill_allowed'];
        $overuse = (($overuse <= 0) ? "-" : format_bytes_billing($overuse));
      }

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
      $label['type']    = (($type == "限额") ? "info" : "inverse");
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
              <td style=\"text-align: center;\"><span class=\"badge badge-success\">".$allowed."</span></td>
              <td style=\"text-align: center;\"><span class=\"badge badge-warning\">".$used."</span></td>
              <td style=\"text-align: center;\"><span class=\"badge badge-".$label['overuse']."\">".$overuse."</span></td>
              <td><div class=\"progress progress-".$perc['BG']."  active\"><div class=\"bar\" style=\"text-align: middle; width: ".$perc['width']."%;\">".$percent."%</div></div></td>
              <td>
                <div class=\"btn-toolbar\" style=\"margin-top: 0px;\">
                  <div class=\"btn-group\">
                    <a class=\"btn btn-mini btn-primary\" href=\"".$links['quick']."\" rel=\"tooltip\" alt=\"显示快速图像\"><i class=\"icon-list-alt icon-white\"></i></a>
                    <a class=\"btn btn-mini btn-primary\" href=\"".$links['accurate']."\" rel=\"tooltip\" alt=\"显示精准图像\"><i class=\"icon-signal icon-white\"></i></a>
                    <a class=\"btn btn-mini btn-primary\" href=\"".$links['transfer']."\" rel=\"tooltip\" alt=\"显示传输图像\"><i class=\"icon-tasks icon-white\"></i></a>
                    <a class=\"btn btn-mini btn-primary\" href=\"".$links['history']."\" rel=\"tooltip\" alt=\"显示历史使用\"><i class=\"icon-calendar icon-white\"></i></a>
                  </div>
                  <div class=\"btn-group pull-right\">
                    <a class=\"btn btn-mini btn-success\" href=\"".$links['edit']."\" rel=\"tooltip\" alt=\"编辑账单\"".$disabled."><i class=\"icon-edit icon-white\"></i></a>
                    <a class=\"btn btn-mini btn-warning\" href=\"".$links['reset']."\" rel=\"tooltip\" alt=\"重置账单\"".$disabled."><i class=\"icon-refresh icon-white\"></i></a>
                    <a class=\"btn btn-mini btn-danger\" href=\"".$links['delete']."\" rel=\"tooltip\" alt=\"删除账单\"".$disabled."><i class=\"icon-trash icon-white\"></i></a>
                  </div>
                </div>
              </td>
            </tr>\n");
    }
  } // PERMITTED
}

echo("  </tbody>\n");
echo("</table>\n");

?>
