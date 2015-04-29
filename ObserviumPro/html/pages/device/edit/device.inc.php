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
  if ($_SESSION['userlevel'] > "7")
  {
    $updated = 0;

    $override_sysLocation_bool = $vars['override_sysLocation'];
    if (isset($vars['sysLocation'])) { $override_sysLocation_string = $vars['sysLocation']; }

    if (get_dev_attrib($device,'override_sysLocation_bool') != $override_sysLocation_bool
     || get_dev_attrib($device,'override_sysLocation_string') != $override_sysLocation_string)
    {
      $updated = 2;
    }

    if ($override_sysLocation_bool) { set_dev_attrib($device, 'override_sysLocation_bool', '1'); } else { del_dev_attrib($device, 'override_sysLocation_bool'); }
    if (isset($override_sysLocation_string)) { set_dev_attrib($device, 'override_sysLocation_string', $override_sysLocation_string); };

    # FIXME needs more sanity checking! and better feedback
    # FIXME -- update location too? Need to trigger geolocation!

    $param = array('purpose' => $vars['descr'], 'type' => $vars['type'], 'ignore' => $vars['ignore'], 'disabled' => $vars['disabled']);

    $rows_updated = dbUpdate($param, 'devices', '`device_id` = ?', array($device['device_id']));

    if ($rows_updated > 0 || $updated)
    {
      if ((bool)$vars['ignore'] != (bool)$device['ignore'])
      {
        log_event('设备 '.((bool)$vars['ignore'] ? 'ignored' : 'attended').': '.$device['hostname'], $device['device_id'], 'device', $device['device_id'], 5);
      }
      if ((bool)$vars['disabled'] != (bool)$device['disabled'])
      {
        log_event('设备 '.((bool)$vars['disabled'] ? 'disabled' : 'enabled').': '.$device['hostname'], $device['device_id'], 'device');
      }
      $update_message = "设备更新的记录.";
      if ($updated == 2) { $update_message.= " 请注意, 最新的系统位置字符串将在轮询后可见."; }
      $updated = 1;
      $device = dbFetchRow("SELECT * FROM `devices` WHERE `device_id` = ?", array($device['device_id']));
    } elseif ($rows_updated = '-1') {
      $update_message = "装置记录不变. 没有更新的必要.";
      $updated = -1;
    } else {
      $update_message = "装置的记录更新错误.";
    }
  }
  else
  {
    include("includes/error-no-perm.inc.php");
  }
}

$descr = $device['purpose'];

$override_sysLocation_bool = get_dev_attrib($device,'override_sysLocation_bool');
$override_sysLocation_string = get_dev_attrib($device,'override_sysLocation_string');

if ($updated && $update_message)
{
  print_message($update_message);
} elseif ($update_message) {
  print_error($update_message);
}

?>

 <form id="edit" name="edit" method="post" class="form-horizontal" action="<?php echo($url); ?>">

  <fieldset>
  <legend>设备属性</legend>
  <input type=hidden name="editing" value="yes">
  <div class="control-group">
    <label class="control-label" for="descr">概述</label>
    <div class="controls">
      <input name="descr" type=text size="32" value="<?php echo(escape_html($device['purpose'])); ?>" />
    </div>
  </div>

  <div class="control-group">
    <label class="control-label" for="type">类型</label>
    <div class="controls">
      <select class="selectpicker" name="type">
<?php
$unknown = 1;
foreach ($config['device_types'] as $type)
{
  echo('          <option value="'.$type['type'].'"');
  if ($device['type'] == $type['type']) { echo(' selected="selected"'); $unknown = 0; }
  echo(' >' . ucfirst($type['type']) . '</option>');
}
if ($unknown) { echo('          <option value="other">其它</option>'); }

?>
              </select>
            </div>
  </div>

  <div class="control-group">
    <label class="control-label" for="sysLocation">重写系统的位置</label>

    <div class="controls">
      <input id="location_check" type="checkbox" onclick="edit.sysLocation.disabled=!edit.override_sysLocation.checked"
            name="override_sysLocation" <?php if ($override_sysLocation_bool) { echo(' checked="checked"'); } ?> data-id="location_check" data-label="使用自定义的位置.">
    </div>
  </div>

<script>

$('#location_check').click(function() {
    $('#location_text').attr('disabled',! this.checked)
});

</script>

  <div class="control-group">
    <label class="control-label" for="sysLocation">自定义位置</label>
    <div class="controls" id="location_text">
      <input type=text name="sysLocation" size="32" <?php if (!$override_sysLocation_bool) { echo(' disabled="disabled"'); } ?>
              value="<?php echo(escape_html($override_sysLocation_string)); ?>" />
    </div>
  </div>

  <div class="control-group">
    <label class="control-label" for="disabled">禁用</label>
    <div class="controls">
      <input name="disabled" type="checkbox" id="disabled" value="1" <?php if ($device["disabled"]) { echo("checked=checked"); } ?> />
      <span class="help-inline">禁用轮询和发现.</span>
    </div>
  </div>
  <?php // FIXME (Mike): $device['ignore'] and get_dev_attrib($device,'disable_notify') it is same/redundant options? ?>
  <div class="control-group">
    <label class="control-label" for="sysLocation">忽略设备</label>
    <div class="controls">
      <input name="ignore" type="checkbox" id="disable" value="1" <?php if ($device['ignore']) { echo("checked=checked"); } ?> />
      <span class="help-inline">忽略设备.</span>
    </div>
  </div>
  </fieldset>

  <div class="form-actions">
    <button type="submit" class="btn btn-primary" name="submit" value="save"><i class="icon-ok icon-white"></i> 保存修改</button>
  </div>

</form>

<?php

print_optionbar_start();
list($sizeondisk, $numrrds) = foldersize($config['rrd_dir']."/".$device['hostname']);
echo("磁盘大小: <b>" . formatStorage($sizeondisk) . "</b> 存有 <b>" . $numrrds . " 个RRD文件</b>.");
print_optionbar_end();

// EOF
