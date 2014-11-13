<?php

if ($_POST['action'] == "delete_bill" && $_POST['confirm'] == "confirm")
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

  echo("<div class=infobox>Bill Deleted. Redirecting to Bills list.</div>");
  echo("<meta http-equiv='Refresh' content=\"2; url='bills/'\">");
}

if ($_POST['action'] == "reset_bill" && ($_POST['confirm'] == "rrd" || $_POST['confirm'] == "mysql"))
{
  if ($_POST['confirm'] == "mysql") {
    foreach (dbFetchRows("SELECT * FROM `bill_ports` WHERE `bill_id` = ?", array($bill_id)) as $port_data)
    {
      dbDelete('port_in_measurements', '`port_id` = ?', array($port_data['bill_id']));
      dbDelete('port_out_measurements', '`port_id` = ?', array($port_data['bill_id']));
    }
    dbDelete('bill_hist', '`bill_id` = ?', array($bill_id));
    dbDelete('bill_data', '`bill_id` = ?', array($bill_id));
  }
  if ($_POST['confirm'] == "rrd") {
    // TODO: First need to add new rrd with poller/discover, so the default rrd isn't wipped
  }

  echo("<div class=infobox>Bill Reseting. Redirecting to Bills list.</div>");
  echo("<meta http-equiv='Refresh' content=\"2; url='bills/'\">");
}

if ($_POST['action'] == "add_bill_port")
{
  $check = dbFetchRows("SELECT port_id FROM `bill_ports` WHERE `bill_id` = ? LIMIT 1", array($_POST['bill_id']));
  if ($check[0]['port_id'] != $_POST['port_id']) {
    dbInsert(array('bill_id' => $_POST['bill_id'], 'port_id' => $_POST['port_id']), 'bill_ports');
  }
}

if ($_GET['action'] == "delete_bill_port")
{
  dbDelete('bill_ports', "`bill_id` =  ? AND `port_id` = ?", array($bill_id, $_GET['port_id']));
}
if ($_POST['action'] == "update_bill")
{
  if (isset($_POST['bill_quota']) or isset($_POST['bill_cdr']))
  {
    if ($_POST['bill_type'] == "quota")
    {
      if (isset($_POST['bill_quota_type']))
      {
        if ($_POST['bill_quota_type'] == "MB") { $multiplier = 1 * $config['billing']['base']; }
        if ($_POST['bill_quota_type'] == "GB") { $multiplier = 1 * $config['billing']['base'] * $config['billing']['base']; }
        if ($_POST['bill_quota_type'] == "TB") { $multiplier = 1 * $config['billing']['base'] * $config['billing']['base'] * $config['billing']['base']; }
        $bill_quota = (is_numeric($_POST['bill_quota']) ? $_POST['bill_quota'] * $config['billing']['base'] * $multiplier : 0);
        $bill_cdr = 0;
      }
    }
    if ($_POST['bill_type'] == "cdr")
    {
      if (isset($_POST['bill_cdr_type']))
      {
        if ($_POST['bill_cdr_type'] == "Kbps") { $multiplier = 1 * $config['billing']['base']; }
        if ($_POST['bill_cdr_type'] == "Mbps") { $multiplier = 1 * $config['billing']['base'] * $config['billing']['base']; }
        if ($_POST['bill_cdr_type'] == "Gbps") { $multiplier = 1 * $config['billing']['base'] * $config['billing']['base'] * $config['billing']['base']; }
        $bill_cdr = (is_numeric($_POST['bill_cdr']) ? $_POST['bill_cdr'] * $multiplier : 0);
        $bill_quota = 0;
      }
    }
  }

  if (dbUpdate(array('bill_name' => $_POST['bill_name'], 'bill_day' => $_POST['bill_day'], 'bill_quota' => $bill_quota, 'bill_cdr' => $bill_cdr,
                     'bill_type' => $_POST['bill_type'], 'bill_custid' => $_POST['bill_custid'], 'bill_ref' => $_POST['bill_ref'],
                     'bill_notes' => $_POST['bill_notes']), 'bills', '`bill_id` = ?', array($bill_id)))
  {
    print_message("Bill Properties Updated");
  }
}

?>
