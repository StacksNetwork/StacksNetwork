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

if ($_SESSION['userlevel'] < 10)
{
  include("includes/error-no-perm.inc.php");

  exit;
}

$pagetitle[] = "删除设备";

if (is_numeric($_REQUEST['id']))
{
  if ($_REQUEST['confirm'])
  {
    $delete_rrd = ($_REQUEST['deleterrd'] == 'confirm') ? TRUE : FALSE;
    print_success(delete_device(mres($_REQUEST['id']), $delete_rrd));
    echo('<div class="btn-group ">
            <button type="button" class="btn btn-default"><a href="/"><i class="oicon-globe-model"></i> 概述</a></button>
            <button type="button" class="btn btn-default"><a href="/devices/"><i class="oicon-servers"></i> 设备列表</a></button>
          </div>');

  }
  else
  {
    $device = device_by_id_cache($_REQUEST['id']);
    print_warning("您确定需要删除该设备吗 <strong>" . $device['hostname'] . "</strong>?");
?>
<br />
<form name="form1" method="post" action="" class="form-horizontal" >
  <input type="hidden" name="id" value="<?php echo $_REQUEST['id'] ?>" />
  <input type="hidden" name="confirm" value="1" />
  <!--<input type="submit" class="submit" name="Submit" value="确认删除设备" />-->
  <button type="submit" class="btn btn-danger"><i class="icon-remove icon-white"></i> 删除设备</button>
</form>

<?php
  }
}
else
{
?>

<form name="form1" method="post" action="" class="form-horizontal" >

  <script type="text/javascript">
    function showWarning(checked) {
      $('#warning').toggle();
      if (checked) {
        $('#deleteBtn').removeAttr('disabled');
      } else {
        $('#deleteBtn').attr('disabled', 'disabled');
      }
    }
    function showWarningRRD(checked) {
      if (checked) {
        $('.alert').hide();
      } else {
        $('.alert').show();
      }
    }
  </script>

  <fieldset>
    <legend>删除设备</legend>
<?php
  print_warning("<h4>警告!</h4>
      这将从Observium包括所有日志条目删除该设备, 但不会删除RRDS.");
?>

    <div class="control-group">
      <label class="control-label" for="id">设备</label>
      <div class="controls">
        <select name="id">
<?php
foreach (dbFetchRows("SELECT * FROM `devices` ORDER BY `hostname`") as $data)
{
  $disabled = ($data['disabled']) ? ' [disabled]' : '';
  echo("<option value='".$data['device_id']."'>".$data['hostname'].$disabled."</option>");
}
?>
        </select>
      </div>
    </div>

    <div class="control-group">
      <label class="control-label">删除RRDs</label>
      <div class="controls">
        <input type="checkbox" name="deleterrd" value="confirm" onchange="javascript: showWarningRRD(this.checked);">
      </div>
    </div>

    <div class="control-group">
      <label class="control-label" for="id">删除确认</label>
      <div class="controls">
        <input type="checkbox" name="confirm" value="confirm" onchange="javascript: showWarning(this.checked);">
      </div>
    </div>
  </fieldset>

  <div class="form-actions">
    <button id="deleteBtn" type="submit" class="btn btn-danger" disabled="disabled"><i class="icon-remove icon-white"></i> 删除设备</button>
  </div>

</form>
<?php
}

// EOF
