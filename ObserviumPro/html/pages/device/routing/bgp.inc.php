<?php

/**
 * Observium Network Management and Monitoring System
 * Copyright (C) 2006-2014, Adam Armstrong - http://www.observium.org
 *
 * @package    observium
 * @subpackage webui
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2015 Adam Armstrong
 *
 */

?>
<table class="table table-hover table-striped table-bordered table-rounded" style="vertical-align: middle; margin-bottom: 10px;">
  <tbody>
    <tr class="up" style="vertical-align: middle;">
      <td class="state-marker"></td>
      <td style="vertical-align: middle; padding: 10px 14px ;"><span style="font-size: 20px;">BGP AS<?php echo($device['bgpLocalAs']); ?></span>
      </td>
     </tr>
   </tbody>
</table>


<?php

if (!isset($vars['view'])) { $vars['view'] = 'details'; }

unset($navbar);
$link_array = array('page'    => 'device',
                    'device'  => $device['device_id'],
                    'tab'     => 'routing',
                    'proto'   => 'bgp');

$types = array('all'      => '所有',
               'internal' => 'iBGP',
               'external' => 'eBGP');

foreach ($types as $option => $text)
{
  $navbar['options'][$option]['text'] = $text;
  if ($vars['type'] == $option || (empty($vars['type']) && $option == 'all'))
  {
    $navbar['options'][$option]['class'] .= " active";
    $bgp_options = array('type' => NULL);
  } else {
    $bgp_options = array('type' => $option);
  }
  if ($vars['adminstatus']) { $bgp_options['adminstatus'] = $vars['adminstatus']; }
  elseif ($vars['state']) { $bgp_options['state'] = $vars['state']; }
  $navbar['options'][$option]['url'] = generate_url($link_array, $bgp_options);
}

$statuses = array('stop'  => '关闭',
                  'start' => '启用',
                  'down'  => '异常');
foreach ($statuses as $option => $text)
{
  $status = ($option == 'down') ? 'state' : 'adminstatus';
  $navbar['options'][$option]['text'] = $text;
  if ($vars[$status] == $option)
  {
    $navbar['options'][$option]['class'] .= " active";
    $bgp_options = array($status => NULL);
  } else {
    $bgp_options = array($status => $option);
  }
  if ($vars['type']) { $bgp_options['type'] = $vars['type']; }
  $navbar['options'][$option]['url'] = generate_url($link_array, $bgp_options);
}

$navbar['options_right']['details']['text'] = '无图';
if ($vars['view'] == 'details') { $navbar['options_right']['details']['class'] .= ' active'; }
$navbar['options_right']['details']['url'] = generate_url($vars, array('view' => 'details', 'graph' => 'NULL'));

$navbar['options_right']['updates']['text'] = '更新';
if ($vars['graph'] == 'updates') { $navbar['options_right']['updates']['class'] .= ' active'; }
$navbar['options_right']['updates']['url'] = generate_url($vars, array('view' => 'graphs', 'graph' => 'updates'));

$bgp_graphs = array('unicast'   => array('text' => '单播'),
                    //'multicast' => array('text' => '多播'),
                    'mac'       => array('text' => 'MAC计算'));
$bgp_graphs['unicast']['types'] = array('prefixes_ipv4unicast' => 'IPv4单播前缀',
                                        'prefixes_ipv6unicast' => 'IPv6单播前缀',
                                        'prefixes_ipv4vpn'     => 'VPNv4前缀');
//$bgp_graphs['multicast']['types'] = array('prefixes_ipv4multicast' => 'IPv4多播前缀',
//                                          'prefixes_ipv6multicast' => 'IPv6多播前缀');
$bgp_graphs['mac']['types'] = array('macaccounting_bits' => 'MAC比特',
                                    'macaccounting_pkts' => 'MAC数据包');
foreach ($bgp_graphs as $bgp_graph => $bgp_options)
{
  $navbar['options_right'][$bgp_graph]['text'] = $bgp_options['text'];
  foreach ($bgp_options['types'] as $option => $text)
  {
    if ($vars['graph'] == $option)
    {
      $navbar['options_right'][$bgp_graph]['class'] .= ' active';
      $navbar['options_right'][$bgp_graph]['suboptions'][$option]['class'] = 'active';
    }
    $navbar['options_right'][$bgp_graph]['suboptions'][$option]['text'] = $text;
    $navbar['options_right'][$bgp_graph]['suboptions'][$option]['url'] = generate_url($vars, array('view' => 'graphs', 'graph' => $option));
  }
}

$navbar['class'] = "navbar-narrow";
$navbar['brand'] = "BGP";
print_navbar($navbar);

// Pagination
$vars['pagination'] = TRUE;

//r($cache['bgp']);
print_bgp($vars);

// EOF
