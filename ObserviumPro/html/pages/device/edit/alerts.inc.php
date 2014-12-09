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
    $override_sysContact_bool = mres($_POST['override_sysContact']); # FIXME not sure if this mres is needed, it's sent to dbFacile? or doesn't set dev attrib use that?
    if (isset($_POST['sysContact'])) { $override_sysContact_string  = mres($_POST['sysContact']); }
    $disable_notify  = mres($_POST['disable_notify']);

    if ($override_sysContact_bool) { set_dev_attrib($device, 'override_sysContact_bool', '1'); } else { del_dev_attrib($device, 'override_sysContact_bool'); }
    if (isset($override_sysContact_string)) { set_dev_attrib($device, 'override_sysContact_string', $override_sysContact_string); };
    if ($disable_notify) { set_dev_attrib($device, 'disable_notify', '1'); } else { del_dev_attrib($device, 'disable_notify'); }

    // 2019-12-05 23:30:00

    if (isset($vars['ignore_until']) && $vars['ignore_until_enable'] == 'on' )
    {
      $update['ignore_until'] = $vars['ignore_until'];
    } else {
      $update['ignore_until'] = array('NULL');
    }

    dbUpdate($update, 'devices', '`device_id` = ?', array($device['device_id']));

    $update_message = "装置警报设置更新.";
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

$override_sysContact_bool = get_dev_attrib($device,'override_sysContact_bool');
$override_sysContact_string = get_dev_attrib($device,'override_sysContact_string');
$disable_notify = get_dev_attrib($device,'disable_notify');
?>

      <form id="edit" name="edit" method="post" action="" class="form-horizontal">
        <input type="hidden" name="editing" value="yes">
        <fieldset>
          <legend>报警设置</legend>
        </fieldset>
  <div class="control-group">
    <label class="control-label" for="override_sysContact">忽略直到</label>
    <div class="controls">
              <div class="input-prepend" id="ignore_until" style="margin-bottom: 0;">
                <span class="add-on btn"><i data-time-icon="icon-time" data-date-icon="icon-calendar" class="icon-time"></i></span>
                <input type="text" style="width: 150px;" data-format="yyyy-MM-dd hh:mm:ss" name="ignore_until" id="ignore_until" value="<?php echo($device['ignore_until'] ? $device['ignore_until'] : ''); ?>">
              </div>
              <input type=checkbox data-toggle="switch" name="ignore_until_enable" <?php echo($device['ignore_until'] ? 'checked' : ''); ?>>
    </div>
  </div>

  <div class="control-group">
    <label class="control-label" for="override_sysContact">重写系统联系人</label>
    <div class="controls">
      <input onclick="edit.sysContact.disabled=!edit.override_sysContact.checked" type="checkbox"
            name="override_sysContact" <?php if ($override_sysContact_bool) { echo(' checked="1"'); } ?> />
      <span class="help-inline">使用下面的自定义联系人</span>
    </div>
  </div>

  <div class="control-group">
    <label class="control-label" for="sysContact">自定义联系人</label>
    <div class="controls">
      <input type=text name="sysContact" size="32" <?php if (!$override_sysContact_bool) { echo(' disabled="1"'); } ?> value="<?php echo(htmlspecialchars($override_sysContact_string)); ?>" />
    </div>
  </div>

  <div class="control-group">
    <label class="control-label" for="override_sysContact">禁用报警</label>
    <div class="controls">
      <input type="checkbox" name="disable_notify"<?php if ($disable_notify) { echo(' checked="1"'); } ?> />
      <span class="help-inline">不要发送通知邮件 (<i>但写入事件日志</i>)</span>
    </div>
  </div>
  <div class="form-actions">
    <button type="submit" class="btn btn-primary" name="submit" value="save"><i class="icon-ok icon-white"></i> 保存变更</button>
  </div>
</form>

<script type="text/javascript">
      $(document).ready(function() {
        $('#ignore_until').datetimepicker({
          //pickSeconds: false,
          dateFormat: "MM-dd-yyyy",
          timeFormat: "HH:mm",
          dateTimeFormat: "MM-dd-yyyy HH:mm:ss"
         });
       });
</script>

<?php

// EOF
