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

// Build a list of user ids we can use to search for bills that user is allowed to see.

if ($isAdmin) {
  foreach (dbFetchRows("SELECT * FROM `entity_permissions` WHERE `entity_type` = 'bill' GROUP BY `user_id` ORDER BY `user_id` ") as $customers) {
    if (bill_permitted($customers['entity_id'])) {
      $customer = dbFetchRow("SELECT * FROM `users` WHERE `user_id` = ? ORDER BY `user_id`", array($customers['user_id']));
      $name     = (empty($customer['realname']) ? $customer['username'] : $customer['realname']);
      $select   = (($_POST['billinguser'] == $customer['user_id']) ? " selected" : "");
      $users[$customer['user_id']] = $name;
    }
  }
} else {
  $users[$_SESSION['user_id']] = $_SESSION['username'];
}

// Billing name field
$search[] = array('type'    => 'text',
                  'name'    => '账单名称',
                  'id'      => 'billingname',
                  'value'   => $vars['billingname']);

// Billing type field
$search[] = array('type'    => 'select',
                  'name'    => '所有类型',
                  'id'      => 'billingtype',
                  'value'   => $vars['billingtype'],
                  'values'  => array('cdr' => 'CDR/95th', 'quota' => '限额') );

//Billing user field
$search[] = array('type'    => 'select',
                  'name'    => '用户',
                  'id'      => 'billinguser',
                  'width'   => '130px',
                  'value'   => $vars['billinguser'],
                  'values'  => $users);

print_search($search, '账单搜索');

?>

