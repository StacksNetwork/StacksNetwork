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
  if ($_SESSION['userlevel'] > "7")
  {
    $wmi_override = mres($_POST['wmi_override']);
    if ($wmi_override)
    {
      $wmi_hostname = mres($_POST['wmi_hostname']);
      $wmi_domain   = mres($_POST['wmi_domain']);
      $wmi_username = mres($_POST['wmi_username']);
      $wmi_password = mres($_POST['wmi_password']);
    }

    if ($wmi_override)         { set_dev_attrib($device, 'wmi_override', $wmi_override); } else { del_dev_attrib($device, 'wmi_override'); }
    if (!empty($wmi_hostname)) { set_dev_attrib($device, 'wmi_hostname', $wmi_hostname); } else { del_dev_attrib($device, 'wmi_hostname'); }
    if (!empty($wmi_domain))   { set_dev_attrib($device, 'wmi_domain', $wmi_domain); } else { del_dev_attrib($device, 'wmi_domain'); }
    if (!empty($wmi_username)) { set_dev_attrib($device, 'wmi_username', $wmi_username); } else { del_dev_attrib($device, 'wmi_username'); }
    if (!empty($wmi_password)) { set_dev_attrib($device, 'wmi_password', $wmi_password); } else { del_dev_attrib($device, 'wmi_password'); }

    $update_message = "设备 IPMI 数据更新.";
    $updated = 1;
  }
  else
  {
    include("includes/error-no-perm.inc.php");
  }
}

if($_POST['toggle_poller'] && isset($GLOBALS['config']['wmi']['modules'][$_POST['toggle_poller']]))
{
  $module = mres($_POST['toggle_poller']);
  if (isset($attribs['wmi_poll_'.$module]) && $attribs['wmi_poll_'.$module] != $GLOBALS['config']['wmi']['modules'][$_POST['toggle_poller']])
  {
    del_dev_attrib($device, 'wmi_poll_' . $module);
  } elseif ($GLOBALS['config']['wmi']['modules'][$_POST['toggle_poller']] == 0) {
    set_dev_attrib($device, 'wmi_poll_' . $module, "1");
  } else {
    set_dev_attrib($device, 'wmi_poll_' . $module, "0");
  }
  $attribs = get_dev_attribs($device['device_id']);
}

?>

<script type="text/javascript">
  $(document).ready(function() {
    toggleDisable();
    $("#wmi_override").change(function() {
      toggleDisable();
    });
  });

  function toggleDisable() {
    if (!$("#wmi_override").is(":checked"))
    {
      $('#edit input[type=text], #edit input[type=password]').prop("disabled", true);
    }
    else
    {
      $('#edit input[type=text], #edit input[type=password]').prop("disabled", false);
    }
  }
</script>
<fieldset><legend>WMI配置</legend></fieldset>
<div class="row">
  <div class="col-md-6">
    <div class="well info_box">
      <div class="title"><i class="oicon-key"></i> Authentication</div>
      <form id="edit" name="edit" method="post" action="" class="form-horizontal">
        <fieldset>
          <input type=hidden name="editing" value="yes">
          <div class="control-group">
            <label class="control-label" for="wmi_override">重写WMI配置</label>
            <div class="controls">
              <input type="checkbox" id="wmi_override" name="wmi_override" <?php if (get_dev_attrib($device,'wmi_override')) { echo(' checked="1"'); } ?> />
            </div>
          </div>

          <div class="control-group">
            <label class="control-label" for="wmi_hostname">WMI主机名</label>
            <div class="controls">
              <input name="wmi_hostname" type="text" size="32" value="<?php echo(htmlspecialchars(get_dev_attrib($device,'wmi_hostname'))); ?>"></input>
            </div>
          </div>

          <div class="control-group">
            <label class="control-label" for="wmi_domain">WMI域名</label>
            <div class="controls">
              <input name="wmi_domain" type="text" size="32" value="<?php echo(htmlspecialchars(get_dev_attrib($device,'wmi_domain'))); ?>"></input>
            </div>
          </div>

          <div class="control-group">
            <label class="control-label" for="wmi_username">WMI用户名</label>
            <div class="controls">
              <input name="wmi_username" type="text" size="32" value="<?php echo(htmlspecialchars(get_dev_attrib($device,'wmi_username'))); ?>"></input>
            </div>
          </div>

          <div class="control-group">
            <label class="control-label" for="wmi_password">WMI密码</label>
            <div class="controls">
              <input name="wmi_password" type="password" size="32" value="<?php echo(htmlspecialchars(get_dev_attrib($device,'wmi_password'))); ?>"></input>
            </div>
          </div>

          <div class="form-actions">
            <button type="submit" class="btn btn-primary" name="submit" value="save"><i class="icon-ok icon-white"></i> Save Changes</button>
          </div>
        </fieldset>
      </form>
    </div>
  </div>
  <div class="col-md-6">
    <div class="well info_box">
      <div class="title"><i class="oicon-gear"></i> 轮询模块</div>
      <table class="table table-bordered table-striped table-condensed table-rounded">
        <thead>
        <tr>
          <th>模块</th>
          <th width="80">全局</th>
          <th width="80">设备</th>
          <th width="80"></th>
        </tr>
        </thead>
        <tbody>
<?php

  foreach ($GLOBALS['config']['wmi']['modules'] as $module => $module_status)
  {
    echo('<tr><td><b>'.$module.'</b></td><td>');

    echo(($module_status ? '<span class=green>启用</span>' : '<span class=red>禁用</span>' ));

    echo('</td><td>');

    if (isset($attribs['wmi_poll_'.$module]))
    {
      if ($attribs['wmi_poll_'.$module]) { echo("<span class=green>启用</span>"); $toggle = "禁用"; $btn_class = "btn-danger";
      } else { echo('<span class=red>禁用</span>'); $toggle = "启用"; $btn_class = "btn-success";}
    } else {
      if ($module_status) { echo("<span class=green>enabled</span>"); $toggle = "禁用"; $btn_class = "btn-danger";
      } else { echo('<span class=red>禁用</span>'); $toggle = "启用"; $btn_class = "btn-success";}
    }

    echo('</td><td>');

    echo('<form id="toggle_poller" name="toggle_poller" method="post" action="">
            <input type=hidden name="toggle_poller" value="'.$module.'">
            <button type="submit" class="btn btn-mini '.$btn_class.'" name="Submit" value="Toggle">'.$toggle.'</button>
            </label>
          </form>');
    echo('</td></tr>');
  }

?>
        </tbody>
      </table>
    </div>
  </div>
</div>
<?php

// EOF
