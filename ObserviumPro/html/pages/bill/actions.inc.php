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

if ($vars['action'] == "delete_bill" && $vars['confirm'] == "confirm")
{
  foreach (dbFetchRows("SELECT * FROM `bill_ports` WHERE `bill_id` = ?", array($bill_id)) as $port_data)
  {
    dbDelete('port_in_measurements', '`port_id` = ?', array($port_data['bill_id']));
    dbDelete('port_out_measurements', '`port_id` = ?', array($port_data['bill_id']));
  }

  dbDelete('bill_hist', '`bill_id` = ?', array($bill_id));
  dbDelete('bill_ports', '`bill_id` = ?', array($bill_id));
  dbDelete('bill_data', '`bill_id` = ?', array($bill_id));
  dbDelete('bill_perms', '`bill_id` = ?', array($bill_id));
  dbDelete('bills', '`bill_id` = ?', array($bill_id));

  echo("<div class=infobox>账单已删除, 重定向到账单列表.</div>");
  echo("<meta http-equiv='刷新' content=\"2; url='bills/'\">");
}

if ($vars['action'] == "reset_bill" && ($vars['confirm'] == "rrd" || $vars['confirm'] == "mysql"))
{
  if ($vars['confirm'] == "mysql")
  {
    foreach (dbFetchRows("SELECT * FROM `bill_ports` WHERE `bill_id` = ?", array($bill_id)) as $port_data)
    {
      dbDelete('port_in_measurements', '`port_id` = ?', array($port_data['bill_id']));
      dbDelete('port_out_measurements', '`port_id` = ?', array($port_data['bill_id']));
    }
    dbDelete('bill_hist', '`bill_id` = ?', array($bill_id));
    dbDelete('bill_data', '`bill_id` = ?', array($bill_id));
  }
  if ($vars['confirm'] == "rrd")
  {
    // TODO: First need to add new rrd with poller/discover, so the default rrd isn't wipped
  }

  echo("<div class=infobox>账单已重置. 重定向到账单列表.</div>");
  echo("<meta http-equiv='刷新' content=\"2; url='bills/'\">");
}

if ($vars['action'] == "add_bill_port")
{
  foreach ($vars['port_id'] as $entry)
  {
    $check = dbFetchRows("SELECT port_id FROM `bill_ports` WHERE `bill_id` = ? LIMIT 1", array($entry));
    if ($check[0]['port_id'] != $entry)
    {
      dbInsert(array('bill_id' => $vars['bill_id'], 'port_id' => $entry), 'bill_ports');
    }
  }
}

if ($vars['action'] == "delete_bill_port")
{
  dbDelete('bill_ports', "`bill_id` =  ? AND `port_id` = ?", array($bill_id, $vars['port_id']));
}
if ($vars['action'] == "update_bill")
{
  if (isset($vars['bill_quota']) or isset($vars['bill_cdr']))
  {
    if ($vars['bill_type'] == "quota")
    {
      if (isset($vars['bill_quota_type']))
      {
        if ($vars['bill_quota_type'] == "MB") { $multiplier = 1 * $config['billing']['base']; }
        if ($vars['bill_quota_type'] == "GB") { $multiplier = 1 * $config['billing']['base'] * $config['billing']['base']; }
        if ($vars['bill_quota_type'] == "TB") { $multiplier = 1 * $config['billing']['base'] * $config['billing']['base'] * $config['billing']['base']; }
        $bill_quota = (is_numeric($vars['bill_quota']) ? $vars['bill_quota'] * $config['billing']['base'] * $multiplier : 0);
        $bill_cdr = 0;
      }
    }
    if ($vars['bill_type'] == "cdr")
    {
      if (isset($vars['bill_cdr_type']))
      {
        if ($vars['bill_cdr_type'] == "Kbps") { $multiplier = 1 * $config['billing']['base']; }
        if ($vars['bill_cdr_type'] == "Mbps") { $multiplier = 1 * $config['billing']['base'] * $config['billing']['base']; }
        if ($vars['bill_cdr_type'] == "Gbps") { $multiplier = 1 * $config['billing']['base'] * $config['billing']['base'] * $config['billing']['base']; }
        $bill_cdr = (is_numeric($vars['bill_cdr']) ? $vars['bill_cdr'] * $multiplier : 0);
        $bill_quota = 0;
      }
    }
  }

  $bill_notify  = ($vars['bill_notify'] == 'on' ? 1 : 0);
  $bill_contact = (strlen($vars['bill_contact']) ? $vars['bill_contact'] : array('NULL'));

  if (dbUpdate(array('bill_name' => $vars['bill_name'], 'bill_day' => $vars['bill_day'], 'bill_quota' => $bill_quota, 'bill_cdr' => $bill_cdr,
                     'bill_type' => $vars['bill_type'], 'bill_custid' => $vars['bill_custid'], 'bill_ref' => $vars['bill_ref'],
                     'bill_notes' => $vars['bill_notes'], 'bill_contact' => $bill_contact, 'bill_notify' => $bill_notify), 'bills', '`bill_id` = ?', array($bill_id)))
  {
    print_message("账单属性更新");
  }
}

// EOF
