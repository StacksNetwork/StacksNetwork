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

if (!isset($vars['sort'])) { $vars['sort'] = "in"; }
if (!isset($vars['period'])) { $vars['period'] = "day"; }
$from = "-" . $vars['period'];
$from = $config['time'][$vars['period']];

echo("<div style='margin: 0px 0px 0px 0px'>
       <div style=' margin:0px; float: left;';>
         <div class='well well-small well-shaded'>
         <span class=device-head>天</span><br />

         <a href='".generate_url($link_array,array('view' => 'macaccounting', 'subview' => 'top10', 'graph'=>$vars['graph'], sort => $vars['sort'], 'period' => 'day'))."'>

           <img style='border: #5e5e5e 2px;' valign=middle src='graph.php?id=".$port['port_id'].
                  "&amp;stat=".$vars['graph']."&amp;type=port_mac_acc_total&amp;sort=".$vars['sort']."&amp;from=".$config['time']['day']."&amp;to=".$config['time']['now']."&amp;width=150&amp;height=50' />
         </a>
         </div>
         <div class='well well-small well-shaded'>
         <span class=device-head>2天</span><br />
         <a href='".generate_url($link_array,array('view' => 'macaccounting', 'subview' => 'top10', 'graph'=>$vars['graph'], sort => $vars['sort'], 'period' => 'twoday'))."/'>
           <img style='border: #5e5e5e 2px;' valign=middle src='graph.php?id=".$port['port_id'].
                  "&amp;stat=".$vars['graph']."&amp;type=port_mac_acc_total&amp;sort=".$vars['sort']."&amp;from=".$config['time']['twoday']."&amp;to=".$config['time']['now']."&amp;width=150&amp;height=50' />
         </a>
         </div>
         <div class='well well-small well-shaded'>
         <span class=device-head>周</span><br />
          <a href='".generate_url($link_array,array('view' => 'macaccounting', 'subview' => 'top10', 'graph'=>$vars['graph'], sort => $vars['sort'], 'period' => 'week'))."/'>
          <img style='border: #5e5e5e 2px;' valign=middle src='graph.php?id=".$port['port_id']."&amp;type=port_mac_acc_total&amp;sort=".$vars['sort']."&amp;stat=".$vars['graph']."&amp;from=".$config['time']['week']."&amp;to=".$config['time']['now']."&amp;width=150&amp;height=50' />
          </a>
          </div>
          <div class='well well-small well-shaded'>
          <span class=device-head>月</span><br />
          <a href='".generate_url($link_array,array('view' => 'macaccounting', 'subview' => 'top10', 'graph'=>$vars['graph'], sort => $vars['sort'], 'period' => 'month'))."/'>
          <img style='border: #5e5e5e 2px;' valign=middle src='graph.php?id=".$port['port_id']."&amp;type=port_mac_acc_total&amp;sort=".$vars['sort']."&amp;stat=".$vars['graph']."&amp;from=".$config['time']['month']."&amp;to=".$config['time']['now']."&amp;width=150&amp;height=50' />
          </a>
          </div>
          <div class='well well-small well-shaded'>
          <span class=device-head>年</span><br />
          <a href='".generate_url($link_array,array('view' => 'macaccounting', 'subview' => 'top10', 'graph'=>$vars['graph'], sort => $vars['sort'], 'period' => 'year'))."/'>
          <img style='border: #5e5e5e 2px;' valign=middle src='graph.php?id=".$port['port_id']."&amp;type=port_mac_acc_total&amp;sort=".$vars['sort']."&amp;stat=".$vars['graph']."&amp;from=".$config['time']['year']."&amp;to=".$config['time']['now']."&amp;width=150&amp;height=50' />
          </a>
          </div>
     </div>
     <div style='float: left;'>
       <img src='graph.php?id=".$port['port_id']."&amp;type=port_mac_acc_total&amp;sort=".$vars['sort']."&amp;stat=".$vars['graph']."&amp;from=$from&amp;to=".$config['time']['now']."&amp;width=765&amp;height=300' />
     </div>
     <div style=' margin:0px; float: left;';>
          <div class='well well-small well-shaded'>
         <span class=device-head>Bits</span><br />
         <a href='".generate_url($link_array,array('view' => 'macaccounting', 'subview' => 'top10', 'graph'=>'bits', sort => $vars['sort'], 'period' => $vars['period']))."'>
           <img style='border: #5e5e5e 2px;' valign=middle src='graph.php?id=".$port['port_id']."&amp;stat=bits&amp;type=port_mac_acc_total&amp;sort=".$vars['sort']."&amp;from=$from&amp;to=".$config['time']['now']."&amp;width=150&amp;height=50' />
         </a>
         </div>
         <div class='well well-small well-shaded'>
         <span class=device-head>数据包</span><br />
         <a href='".generate_url($link_array,array('view' => 'macaccounting', 'subview' => 'top10', 'graph'=>'pkts', sort => $vars['sort'], 'period' => $vars['period']))."/'>
           <img style='border: #5e5e5e 2px;' valign=middle src='graph.php?id=".$port['port_id']."&amp;stat=pkts&amp;type=port_mac_acc_total&amp;sort=".$vars['sort']."&amp;from=$from&amp;to=".$config['time']['now']."&amp;width=150&amp;height=50' />
         </a>
         </div>
         <div class='well well-small well-shaded'>
         <span class=device-head>最高流入</span><br />
         <a href='".generate_url($link_array,array('view' => 'macaccounting', 'subview' => 'top10', 'graph'=>$vars['graph'], sort => 'in', 'period' => $vars['period']))."'>
           <img style='border: #5e5e5e 2px;' valign=middle src='graph.php?id=".$port['port_id'].
                  "&amp;stat=".$vars['graph']."&amp;type=port_mac_acc_total&amp;sort=in&amp;from=$from&amp;to=".$config['time']['now']."&amp;width=150&amp;height=50' />
         </a>
         </div>
         <div class='well well-small well-shaded'>
         <span class=device-head>最高流出</span><br />
         <a href='".generate_url($link_array,array('view' => 'macaccounting', 'subview' => 'top10', 'graph'=>$vars['graph'], sort => 'out', 'period' => $vars['period']))."'>
           <img style='border: #5e5e5e 2px;' valign=middle src='graph.php?id=".$port['port_id'].
                  "&amp;stat=".$vars['graph']."&amp;type=port_mac_acc_total&amp;sort=out&amp;from=$from&amp;to=".$config['time']['now']."&amp;width=150&amp;height=50' />
         </a>
         </div>
         <div class='well well-small well-shaded'>
         <span class=device-head>最高汇总</span><br />
         <a href='".generate_url($link_array,array('view' => 'macaccounting', 'subview' => 'top10', 'graph'=>$vars['graph'], sort => 'both', 'period' => $vars['period']))."'>
           <img style='border: #5e5e5e 2px;' valign=middle src='graph.php?id=".$port['port_id'].
                  "&amp;stat=".$vars['graph']."&amp;type=port_mac_acc_total&amp;sort=both&amp;from=$from&amp;to=".$config['time']['now']."&amp;width=150&amp;height=50' />
         </a>
         </div>
     </div>
   </div>
");

unset($query);

// EOF
