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

if ($_POST['editing'])
{
  if ($_SESSION['userlevel'] > 7)
  {
    $ipmi_hostname  = mres($_POST['ipmi_hostname']);
    $ipmi_username  = mres($_POST['ipmi_username']);
    $ipmi_password  = mres($_POST['ipmi_password']);
    $ipmi_port      = mres($_POST['ipmi_port']);
    $ipmi_interface = mres($_POST['ipmi_interface']);

    if ($ipmi_hostname  != '') { set_dev_attrib($device, 'ipmi_hostname' , $ipmi_hostname);  } else { del_dev_attrib($device, 'ipmi_hostname'); }
    if ($ipmi_username  != '') { set_dev_attrib($device, 'ipmi_username' , $ipmi_username);  } else { del_dev_attrib($device, 'ipmi_username'); }
    if ($ipmi_password  != '') { set_dev_attrib($device, 'ipmi_password' , $ipmi_password);  } else { del_dev_attrib($device, 'ipmi_password'); }
    if ($ipmi_interface != '') { set_dev_attrib($device, 'ipmi_interface', $ipmi_interface); } else { del_dev_attrib($device, 'ipmi_interface'); }

    if (is_numeric($ipmi_port)) { set_dev_attrib($device, 'ipmi_port'     , $ipmi_port);      } else { del_dev_attrib($device, 'ipmi_port'); }

    $update_message = "Device IPMI data updated.";
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
  <legend>IPMI Settings</legend>
  <input type="hidden" name="editing" value="yes">

  <div class="control-group">
    <label class="control-label" for="ipmi_hostname">IPMI Hostname</label>
    <div class="controls">
      <input name="ipmi_hostname" type="text" size="32" value="<?php echo(htmlspecialchars(get_dev_attrib($device,'ipmi_hostname'))); ?>"/>
    </div>
  </div>

  <div class="control-group">
    <label class="control-label" for="ipmi_port">IPMI Port</label>
    <div class="controls">
      <input type=text name="ipmi_port" size="32" value="<?php echo(htmlspecialchars(get_dev_attrib($device,'ipmi_port'))); ?>"/>
    </div>
  </div>

  <div class="control-group">
    <label class="control-label" for="ipmi_username">IPMI Username</label>
    <div class="controls">
      <input name="ipmi_username" type="text" size="32" value="<?php echo(htmlspecialchars(get_dev_attrib($device,'ipmi_username'))); ?>"/>
    </div>
  </div>

  <div class="control-group">
    <label class="control-label" for="ipmi_password">IPMI Password</label>
    <div class="controls">
      <input name="ipmi_password" type="password" size="32" value="<?php echo(htmlspecialchars(get_dev_attrib($device,'ipmi_password'))); ?>"/>
    </div>
  </div>

  <div class="control-group">
  <label class="control-label" for="ipmi_interface">IPMI Interface</label>
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
    <button type="submit" class="btn btn-primary" name="submit" value="save"><i class="icon-ok icon-white"></i> Save Changes</button>
    <span class="help-inline">To disable IPMI polling, please clear the setting fields and click <strong>Save Changes</strong>.</span>
  </div>

  </fieldset>
</form>
