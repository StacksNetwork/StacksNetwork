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
<form id="delete_host" name="delete_host" method="post" action="delhost/"  class="form-horizontal">
  <input type="hidden" name="id" value="<?php echo($device['device_id']); ?>">

  <script type="text/javascript">
    function showWarning(checked) {
      //$('#warning').toggle();
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
      这将从Observium包括所有日志条目删除该设备, 但不会删除RRDs.");
?>

    <div class="control-group">
      <label class="control-label">删除RRDs</label>
      <div class="controls">
        <input type="checkbox" name="deleterrd" value="confirm" onchange="javascript: showWarningRRD(this.checked);">
      </div>
    </div>

    <div class="control-group">
      <label class="control-label" for="sysContact">确认删除</label>
      <div class="controls">
        <input type="checkbox" name="confirm" value="confirm" onchange="javascript: showWarning(this.checked);">
      </div>
    </div>

    <div class="form-actions">
      <button id="deleteBtn" type="submit" class="btn btn-danger" name="delete" disabled="disabled"><i class="icon-remove icon-white"></i> 删除设备</button>
    </div>
  </fieldset>
</form>

<?php

// EOF
