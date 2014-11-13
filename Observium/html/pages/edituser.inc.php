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

?>
<h2>用户管理</h2>
<?php

include("usermenu.inc.php");
include("includes/javascript-interfacepicker.inc.php");

$pagetitle[] = "编辑用户";

if ($_SESSION['userlevel'] != '10') { include("includes/error-no-perm.inc.php"); } else
{
?>

<form method="post" action="" class="form form-inline">
<div class="navbar navbar-narrow">
  <div class="navbar-inner">
    <div class="container">
      <a class="brand">编辑用户</a>
      <ul class="nav">

<?php

  $user_list = auth_user_list();

  echo('
         <li>
          <input type="hidden" value="edituser" name="page">
          <select name="user_id" onchange="location.href=\'edituser/user_id=\' + this.options[this.selectedIndex].value + \'/\';">');
  if (!isset($vars['user_id'])) { echo('<option value="">选择用户</option>'); }

  foreach ($user_list as $user_entry)
  {
    echo("<option value='" . $user_entry['user_id']  . "'");
    if ($user_entry['user_id'] == $vars['user_id']) { echo(' selected '); }
    #echo(" onchange=\"location.href='edituser/user_id=' + this.options[this.selectedIndex].value + '/';\" ");
    echo(">" . $user_entry['username'] . "</option>");
  }

  echo('</select>
      </li>');

  if ($vars['user_id'])
  {
    // Load the user's information
    $user_data = dbFetchRow("SELECT * FROM users WHERE user_id = ?", array($vars['user_id']));

    // Become the selected user. Dirty.
    // FIXME this functionality is currently BROKEN. Commented out the link until we handle this better.
    // echo("<li><a href='edituser/action=becomeuser/user_id=".$vars['user_id']."/'>以该用户登录</a></li>");

    // Delete the selected user.
    if (auth_usermanagement())
    {
      echo("<li><a href='edituser/action=deleteuser/user_id=".$vars['user_id']."/'>删除用户</a></li>");
    }
  }
?>

      </ul>
    </div>
  </div>
</div>
</form>

<?php
  if ($vars['user_id'])
  {
   if ($vars['action'] == "deleteuser")
   {

     include("pages/edituser/deleteuser.inc.php");

   } else {

    // Perform actions if requested

    if (auth_can_change_password($user_data['username']) && $vars['action'] == "changepass")
    {
      if ($_POST['new_pass'] == $_POST['new_pass2'])
      {
        auth_change_password($user_data['username'], $_POST['new_pass']);
        print_message("密码已变更.");
       } else {
        print_error("密码不匹配!");
      }
    }

    // FIXME broken PoS code.
    if ($vars['action'] == "becomeuser")
    {
      $_SESSION['origusername'] = $_SESSION['username'];
      $_SESSION['username'] = $user_data['username'];
      header('Location: '.$config['base_url']);
      dbInsert(array('user' => $_SESSION['origusername'], 'address' => $_SERVER["REMOTE_ADDR"], 'result' => '以 ' . $_SESSION['username']), '身份登录');

      include("includes/authenticate.inc.php");
    }

    if ($vars['action'] == "deldevperm")
    {
      if (dbFetchCell("SELECT COUNT(*) FROM devices_perms WHERE `device_id` = ? AND `user_id` = ?", array($vars['device_id'] ,$vars['user_id'])))
      {
        dbDelete('devices_perms', "`device_id` =  ? AND `user_id` = ?", array($vars['device_id'], $vars['user_id']));
      }
    }
    if ($vars['action'] == "adddevperm")
    {
      if (!dbFetchCell("SELECT COUNT(*) FROM devices_perms WHERE `device_id` = ? AND `user_id` = ?", array($vars['device_id'] ,$vars['user_id'])))
      {
        dbInsert(array('device_id' => $vars['device_id'], 'user_id' => $vars['user_id']), 'devices_perms');
      }
    }
    if ($vars['action'] == "delifperm")
    {
      if (dbFetchCell("SELECT COUNT(*) FROM ports_perms WHERE `port_id` = ? AND `user_id` = ?", array($vars['port_id'], $vars['user_id'])))
      {
        dbDelete('ports_perms', "`port_id` =  ? AND `user_id` = ?", array($vars['port_id'], $vars['user_id']));
      }
    }
    if ($vars['action'] == "addifperm")
    {
      if (!dbFetchCell("SELECT COUNT(*) FROM ports_perms WHERE `port_id` = ? AND `user_id` = ?", array($vars['port_id'], $vars['user_id'])))
      {
        dbInsert(array('port_id' => $vars['port_id'], 'user_id' => $vars['user_id']), 'ports_perms');
      }
    }
    if ($vars['action'] == "delbillperm")
    {
      if (dbFetchCell("SELECT COUNT(*) FROM bill_perms WHERE `bill_id` = ? AND `user_id` = ?", array($vars['bill_id'], $vars['user_id'])))
      {
        dbDelete('bill_perms', "`bill_id` =  ? AND `user_id` = ?", array($vars['bill_id'], $vars['user_id']));
      }
    }
    if ($vars['action'] == "addbillperm")
    {
      if (!dbFetchCell("SELECT COUNT(*) FROM bill_perms WHERE `bill_id` = ? AND `user_id` = ?", array($vars['bill_id'], $vars['user_id'])))
      {
        dbInsert(array('bill_id' => $vars['bill_id'], 'user_id' => $vars['user_id']), 'bill_perms');
      }
    }

    if (auth_can_change_password($vars['user_id'])) // FIXME user_id? function takes username as a parameter, so this can't work!
    {
      echo("<div class='well'>
              <div style='font-size: 18px; font-weight: bold; margin-bottom: 5px;'>更改密码</div>
        <form method='post' action='edituser/user_id=".$vars['user_id']."'>
        <input type=hidden name='action' value='changepass'>
        <input type=hidden value='" . $vars['user_id'] . "' name='user_id'>
        <table width='100%'>
        <tr><td>新密码</td><td align='right'><input type=password name=new_pass autocomplete='off'></input></td></tr>
        <tr><td>重复密码</td><td align='right'><input type=password name=new_pass2 autocomplete='off'></input></td></tr>
        <tr><td></td><td align='right'><input type=submit class=submit></td></tr></table></form></div>");
        // Change pass
    }

    echo("<table width=100%><tr><td valign=top width=33%>");

    // Display devices this users has access to
    echo("<h3>设备访问</h3>");

    $device_perms = dbFetchRows("SELECT * from devices_perms as P, devices as D WHERE `user_id` = ? AND D.device_id = P.device_id", array($vars['user_id']));
    foreach ($device_perms as $device_perm)
    {
      echo("<strong>" . $device_perm['hostname'] . " <a href='edituser/action=deldevperm/user_id=" . $vars['user_id'] . "/device_id=" . $device_perm['device_id'] . "'><img src='images/16/cross.png' align=absmiddle border=0></a></strong><br />");
      $access_list[] = $device_perm['device_id'];
      $permdone = "yes";
    }

    if (!$permdone) { echo("没有配置"); }

    // Display devices this user doesn't have access to
    echo("<h4>授予新设备访问权限</h4>");
    echo("<form method='post' action=''>
            <input type='hidden' value='" . $vars['user_id'] . "' name='user_id'>
            <input type='hidden' value='edituser' name='page'>
            <input type='hidden' value='adddevperm' name='action'>
            <select name='device_id' class=selector>");

    $devices = dbFetchRows("SELECT * FROM `devices` ORDER BY hostname");
    foreach ($devices as $device)
    {
      unset($done);
      foreach ($access_list as $ac) { if ($ac == $device['device_id']) { $done = 1; } }
      if (!$done)
      {
        echo("<option value='" . $device['device_id'] . "'>" . $device['hostname'] . "</option>");
      }
    }

    echo("</select> <input type='submit' name='Submit' value='添加'></form>");
    echo("</td>");

    echo("<td valign=top width=33%>");
    echo("<h3>接口访问</h3>");
    $interface_perms = dbFetchRows("SELECT * from ports_perms as P, ports as I, devices as D WHERE `user_id` = ? AND I.port_id = P.port_id AND D.device_id = I.device_id", array($vars['user_id']));

    foreach ($interface_perms as $interface_perm)
    {
      echo("<table><tr><td><strong>".$interface_perm['hostname']." - ".$interface_perm['ifDescr']."</strong><br />".
                  "" . $interface_perm['ifAlias'] . "</td><td width=50>&nbsp;&nbsp;<a href='edituser/action=delifperm/user_id=" . $vars['user_id'] .
       "/port_id=" . $interface_perm['port_id'] . "'><img src='images/16/cross.png' align=absmiddle border=0></a></td></tr></table>");
      $ipermdone = "yes";
    }

    if (!$ipermdone) { echo("没有配置"); }

    // Display devices this user doesn't have access to
    echo("<h4>允许访问新的接口</h4>");

    echo("<form action='' method='post'>
        <input type='hidden' value='" . $vars['user_id'] . "' name='user_id'>
        <input type='hidden' value='edituser' name='page'>
        <input type='hidden' value='addifperm' name='action'>
        <table><tr><td>设备: </td>
         <td><select id='device' class='selector' name='device' onchange='getInterfaceList(this)'>
          <option value=''>选择一个设备</option>");

    foreach ($devices as $device)
    {
      unset($done);
      foreach ($access_list as $ac) { if ($ac == $device['device_id']) { $done = 1; } }
      if (!$done) { echo("<option value='" . $device['device_id']  . "'>" . $device['hostname'] . "</option>"); }
    }

    echo("</select></td></tr><tr>
       <td>接口: </td><td><select class=selector id='port_id' name='port_id'>
       </select></td>
       </tr><tr></table><input type='submit' name='Submit' value='添加'></form>");

    echo("</td><td valign=top width=33%>");
    echo("<h3>账单访问</h3>");

    $bill_perms = dbFetchRows("SELECT * from bills AS B, bill_perms AS P WHERE P.user_id = ? AND P.bill_id = B.bill_id", array($vars['user_id']));

    foreach ($bill_perms as $bill_perm)
    {
      echo("<table><tr><td><strong>".$bill_perm['bill_name']."</strong></td><td width=50>&nbsp;&nbsp;<a href='edituser/action=delbillperm/user_id=" .
        $vars['user_id'] . "/bill_id=" . $bill_perm['bill_id'] . "'><img src='images/16/cross.png' align=absmiddle border=0></a></td></tr></table>");
      $bill_access_list[] = $bill_perm['bill_id'];

      $bpermdone = "yes";
    }

    if (!$bpermdone) { echo("没有配置"); }

    // Display devices this user doesn't have access to
    echo("<h4>允许访问新的账单</h4>");
    echo("<form method='post' action=''>
            <input type='hidden' value='" . $vars['user_id'] . "' name='user_id'>
            <input type='hidden' value='edituser' name='page'>
            <input type='hidden' value='addbillperm' name='action'>
            <select name='bill_id' class=selector>");

    $bills = dbFetchRows("SELECT * FROM `bills` ORDER BY `bill_name`");
    foreach ($bills as $bill)
    {
      unset($done);
      foreach ($bill_access_list as $ac) { if ($ac == $bill['bill_id']) { $done = 1; } }
      if (!$done)
      {
        echo("<option value='" . $bill['bill_id'] . "'>" . $bill['bill_name'] . "</option>");
      }
    }

    echo("</select> <input type='submit' name='Submit' value='添加'></form>");
    echo("</td></table>");

   }

  }

}

?>
