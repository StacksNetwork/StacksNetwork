<?php

/**
 * Observium Network Management and Monitoring System
 * Copyright (C) 2006-2014, Adam Armstrong - http://www.observium.org
 *
 * @package    observium
 * @subpackage webui
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

@include("includes/jpgraph/src/jpgraph.php");

if (!is_file("includes/jpgraph/src/jpgraph.php") || defined('DEFAULT_THEME_CLASS'))
{
  ?>

<div class="alert alert-error">
 <h4>JpGraph 设置错误</h4>
 <p><i>JpGraph 已经从 Observium 中移除资料库现在必须单独安装.</i></p>
 <ul style="margin-left: 30px"> <!-- ugly css hax, someone please FIXME -->
   <li>请下载 <a href="http://jpgraph.net/download/">http://jpgraph.net/download/</a> 并解压到 html/includes/jpgraph.</li>
   <li>从配置文件中删除主题定义 html/includes/jpgraph/src/jpg-config.inc.php</li>
 </ul>
</div>

  <?php
}

$isAdmin    = (($_SESSION['userlevel'] == "10") ? true : false);
$isUser     = bill_permitted($bill_id);

if ($vars['addbill'] == "yes" && !empty($vars['bill_name']))
{
  $updated = '1';

  if (isset($vars['bill_quota']) or isset($vars['bill_cdr'])) {
    if ($vars['bill_type'] == "quota") {
      if (isset($vars['bill_quota_type'])) {
        if ($vars['bill_quota_type'] == "MB") { $multiplier = 1 * $config['billing']['base']; }
        if ($vars['bill_quota_type'] == "GB") { $multiplier = 1 * $config['billing']['base'] * $config['billing']['base']; }
        if ($vars['bill_quota_type'] == "TB") { $multiplier = 1 * $config['billing']['base'] * $config['billing']['base'] * $config['billing']['base']; }
        $bill_quota = (is_numeric($vars['bill_quota']) ? $vars['bill_quota'] * $config['billing']['base'] * $multiplier : 0);
        $bill_cdr = 0;
      }
    }
    if ($vars['bill_type'] == "cdr") {
      if (isset($vars['bill_cdr_type'])) {
        if ($vars['bill_cdr_type'] == "Kbps") { $multiplier = 1 * $config['billing']['base']; }
        if ($vars['bill_cdr_type'] == "Mbps") { $multiplier = 1 * $config['billing']['base'] * $config['billing']['base']; }
        if ($vars['bill_cdr_type'] == "Gbps") { $multiplier = 1 * $config['billing']['base'] * $config['billing']['base'] * $config['billing']['base']; }
        $bill_cdr = (is_numeric($vars['bill_cdr']) ? $vars['bill_cdr'] * $multiplier : 0);
        $bill_quota = 0;
      }
    }
  }

  $insert = array('bill_name' => $vars['bill_name'], 'bill_type' => $vars['bill_type'], 'bill_cdr' => $bill_cdr, 'bill_day' => $vars['bill_day'], 'bill_quota' => $bill_quota,
                  'bill_custid' => $vars['bill_custid'], 'bill_ref' => $vars['bill_ref'], 'bill_notes' => $vars['bill_notes']);

  $bill_id = dbInsert($insert, 'bills');

  $message .= $message_break . "账单 ".escape_html($vars['bill_name'])." (".$bill_id.") 已生成!";
  $message_break .= "<br />";

  if (is_numeric($bill_id) && is_numeric($vars['port']))
  {
    dbInsert(array('bill_id' => $bill_id, 'port_id' => $vars['port']), 'bill_ports');
    $message .= $message_break . "端口 ".escape_html($vars['port'])." 已添加!";
    $message_break .= "<br />";
  }
}

$page_title[] = "账单";

switch($vars["view"]) {
  case "history":
    echo("<h2 style=\"margin-bottom: 10px;\">客户账单: 历史账单</h2>\n");

    include("pages/bills/search.inc.php");
    include("pages/bills/month.inc.php");
    break;
  case "add":
    echo("<h2 style=\"margin-bottom: 10px;\">客户账单: 添加账单</h2>\n");

    include("pages/bill/navbar.inc.php");
    include("pages/bills/add.inc.php");
    break;
  default:
    echo("<h2 style=\"margin-bottom: 10px;\">客户账单: 本期账单</h2>\n");

    include("pages/bills/search.inc.php");
    include("pages/bills/month.inc.php");
}

echo("<script src=\"".$config['base_url']."js/bootstrap-tooltip.js\"></script>\n");
echo("<script src=\"".$config['base_url']."js/bootstrap-tab.js\"></script>\n");
echo("<script src=\"".$config['base_url']."js/billing.js\"></script>\n");

// EOF
