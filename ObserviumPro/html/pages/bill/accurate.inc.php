<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage webui
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

// Print tabs and graphs for accurate billing view

switch($vars['tab'])
{

  case "24hour":
    $active['24hour']  = "active";
    $graph  = '<img src="billing-graph.php?bill_id=' . $bill_id . '&amp;bill_code=' . $_GET['bill_code'];
    $graph .= '&amp;from=' . $config['time']['day'] .  '&amp;to=' . $config['time']['now'];
    $graph .= '&amp;x=1230&amp;y=300';
    $graph .= $imgtype.'" alt="">';
    break;

  case "monthly":
    $active['monthly']  = "active";
    $graph  = '<img src="billing-graph.php?bill_id=' . $bill_id . '&amp;bill_code=' . $_GET['bill_code'];
    $graph .= '&amp;from=' . $lastmonth_unix .  '&amp;to=' . $rightnow_unix;
    $graph .= '&amp;x=1230&amp;y=300';
    $graph .= $imgtype.'" alt="">';
    break;

  case "previous":
    $active['previous']  = "active";
    $graph  = '<img src="billing-graph.php?bill_id=' . $bill_id . '&amp;bill_code=' . $_GET['bill_code'];
    $graph .= '&amp;from=' . $unix_prev_from .  '&amp;to=' . $unix_prev_to;
    $graph .= '&amp;x=1230&amp;y=300';
    $graph .= $imgtype.'" alt="">';
    break;

  case "billing":
  default:
    $active['billing']  = "active";
    $graph    = '<img src="billing-graph.php?bill_id=' . $bill_id . '&amp;bill_code=' . $_GET['bill_code'];
    $graph   .= '&amp;from=' . $unixfrom .  '&amp;to=' . $unixto;
    $graph   .= '&amp;x=1230&amp;y=300';
    $graph   .= $imgtype.'" alt="">';
    break;
}

$links['billing']   = generate_url(array('page' => 'bill', 'bill_id' => $bill_id, 'view' => 'accurate', 'tab' => 'billing'));
$links['24hour']    = generate_url(array('page' => 'bill', 'bill_id' => $bill_id, 'view' => 'accurate', 'tab' => '24hour'));
$links['monthly']   = generate_url(array('page' => 'bill', 'bill_id' => $bill_id, 'view' => 'accurate', 'tab' => 'monthly'));
$links['previous']  = generate_url(array('page' => 'bill', 'bill_id' => $bill_id, 'view' => 'accurate', 'tab' => 'previous'));

?>

<div class="tabBox">
  <ul class="nav nav-tabs" id="accurateBillTab">
    <li class="<?php echo($active['billing']); ?> first"><a href="<?php echo($links['billing']); ?>">显示账单</a></li>
    <li class="<?php echo($active['24hour']); ?>"><a href="<?php echo($links['24hour']); ?>">24小时查看</a></li>
    <li class="<?php echo($active['monthly']); ?>"><a href="<?php echo($links['monthly']); ?>">月度查看</a></li>
    <li class="<?php echo($active['previous']); ?>"><a href="<?php echo($links['previous']); ?>">以前的计费视图</a></li>
  </ul>
  <div class="tabcontent tab-content" id="transferBillTabContent" style="min-height: 300px;">
    <div class="tab-pane active" id="accurateGraph" style="text-align: center;">
      <?php echo($graph."\n"); ?>
    </div>
  </div>
</div>
