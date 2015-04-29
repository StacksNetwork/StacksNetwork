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

//$isAdmin           = (($_SESSION['userlevel'] == "10") ? true : false);
//$isUser            = bill_permitted($bill['id']);
$isAdd             = (($vars['view'] == "add") ? true : false);
$disabledAdmin     = ($isAdmin ? "" : 'disabled="disabled"');
$disabledUser      = ($isUser ? "" : 'disabled="disabled"');

$navbar['class'] = 'navbar-narrow';
$navbar['brand'] = '账单';

if (!$isAdd)
{
  $navbar['brand'] .= ': '.$bill_data['bill_name'];
}

if ($isUser && !$isAdd)
{
  $navbar['options']['quick']['text'] = '流量图快速显示';
  $navbar['options']['accurate']['text'] = '精准流量图';
  $navbar['options']['transfer']['text'] = '透传流量图';
  $navbar['options']['history']['text'] = '历史操作记录';

  foreach ($navbar['options'] as $option => $array)
  {
    if ($vars['view'] == $option) { $navbar['options'][$option]['class'] .= ' active'; }
    $navbar['options'][$option]['url'] = generate_url($vars, array('view' => $option));
  }
}

if ($isAdmin && !$isAdd)
{
  $navbar_array = array( 
    array('page' => 'edit', 'icon' => 'oicon-gear--edit'), 
    array('page' => 'reset', 'icon' => 'oicon-arrow-circle'), 
    array('page' => 'delete', 'icon' => 'oicon-minus-circle')
  );
  
  foreach ($navbar_array as $entry)
  {
    $navbar['options'][$entry['page']]['url']  = generate_url(array('page' => 'bill', 'bill_id' => $bill_id, 'view' => $entry['page']));
    $navbar['options'][$entry['page']]['text'] = ucfirst($entry['page']);
    $navbar['options'][$entry['page']]['icon'] = $entry['icon'];
    if ($vars['view'] == $entry['page']) { $navbar['options'][$entry['page']]['class'] = ' active'; }
  }
}

$navbar['options_right']['back']['url']  = generate_url(array('page' => 'bills'));
$navbar['options_right']['back']['text'] = '返回';
$navbar['options_right']['back']['icon'] = 'icon-chevron-left';

print_navbar($navbar);
unset($navbar);

// EOF
