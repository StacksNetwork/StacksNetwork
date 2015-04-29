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

if ($vars['editing'])
{
  if ($_SESSION['userlevel'] > 7)
  {
    if ($vars['ipmi_hostname']  != '')  { set_dev_attrib($device, 'ipmi_hostname' , $vars['ipmi_hostname']);  } else { del_dev_attrib($device, 'ipmi_hostname'); }
    if ($vars['ipmi_username']  != '')  { set_dev_attrib($device, 'ipmi_username' , $vars['ipmi_username']);  } else { del_dev_attrib($device, 'ipmi_username'); }
    if ($vars['ipmi_password']  != '')  { set_dev_attrib($device, 'ipmi_password' , $vars['ipmi_password']);  } else { del_dev_attrib($device, 'ipmi_password'); }
    if (is_numeric($vars['ipmi_port'])) { set_dev_attrib($device, 'ipmi_port'     , $vars['ipmi_port']);      } else { del_dev_attrib($device, 'ipmi_port'); }

    // We check interface & userlevel input from the dropdown against the allowed values in the definition array.
    if ($vars['ipmi_interface'] != '' && array_search($vars['ipmi_interface'], array_keys($config['ipmi']['interfaces'])) !== FALSE)
    {
      set_dev_attrib($device, 'ipmi_interface', $vars['ipmi_interface']);
    } else {
      del_dev_attrib($device, 'ipmi_interface');
      print_error('指定无效的接口 (' . $vars['ipmi_interface'] . ').');
    }

    if ($vars['ipmi_userlevel'] != '' && array_search($vars['ipmi_userlevel'], array_keys($config['ipmi']['userlevels'])) !== FALSE)
    {
      set_dev_attrib($device, 'ipmi_userlevel', $vars['ipmi_userlevel']);
    } else {
      del_dev_attrib($device, 'ipmi_userlevel');
      print_error('无效的用户指定的层次 (' . $vars['ipmi_userlevel'] . ').');
    }

    $update_message = "IPMI数据更新装置.";
    $updated = 1;
  }
  else
  {
    include("includes/error-no-perm.inc.php");
  }
}

if ($updated && $update_message)
{
  print_message($update_message);
} elseif ($update_message) {
  print_error($update_message);
}

?>

<form id="edit" name="edit" method="post" action="" class="form-horizontal">
  <fieldset>
  <legend>IPMI设定</legend>
  <input type="hidden" name="editing" value="yes">

  <div class="control-group">
    <label class="control-label" for="ipmi_hostname">IPMI主机名</label>
    <div class="controls">
      <input name="ipmi_hostname" type="text" size="32" value="<?php echo(escape_html(get_dev_attrib($device, 'ipmi_hostname'))); ?>"/>
    </div>
  </div>

  <div class="control-group">
    <label class="control-label" for="ipmi_port">IPMI端口</label>
    <div class="controls">
      <input type=text name="ipmi_port" size="32" value="<?php echo(escape_html(get_dev_attrib($device, 'ipmi_port'))); ?>"/>
    </div>
  </div>

  <div class="control-group">
    <label class="control-label" for="ipmi_username">IPMI用户名</label>
    <div class="controls">
      <input name="ipmi_username" type="text" size="32" value="<?php echo(escape_html(get_dev_attrib($device, 'ipmi_username'))); ?>"/>
    </div>
  </div>

  <div class="control-group">
    <label class="control-label" for="ipmi_password">IPMI密码</label>
    <div class="controls">
      <input name="ipmi_password" type="password" size="32" value="<?php echo(escape_html(get_dev_attrib($device, 'ipmi_password'))); // FIXME. For passwords we should use filter instead escape! ?>"/>
    </div>
  </div>

  <div class="control-group">
  <label class="control-label" for="ipmi_interface">IPMI用户等级</label>
    <div class="controls">
      <select class="selectpicker" name="ipmi_userlevel">
        <?php
        foreach ($config['ipmi']['userlevels'] as $type => $descr)
        {
          echo("<option value='".$type."'");
          if ($type == get_dev_attrib($device,'ipmi_userlevel')) { echo(" selected='selected'"); }
          echo(">".$descr['text']."</option>");
        }
        ?>
      </select>
    </div>
  </div>

  <div class="control-group">
  <label class="control-label" for="ipmi_interface">IPMI接口</label>
    <div class="controls">
      <select class="selectpicker" name="ipmi_interface">
        <?php
        foreach ($config['ipmi']['interfaces'] as $type => $descr)
        {
          echo("<option value='".$type."'");
          if ($type == get_dev_attrib($device,'ipmi_interface')) { echo(" selected='selected'"); }
          echo(">".$descr['text']."</option>");
        }
        ?>
      </select>
    </div>
  </div>

  <div class="form-actions">
    <button type="submit" class="btn btn-primary" name="submit" value="save"><i class="icon-ok icon-white"></i> 保存修改</button>
    <span class="help-inline">禁用IPMI投票, 请清除设置域 <strong>保存修改</strong>.</span>
  </div>

  </fieldset>
</form>
