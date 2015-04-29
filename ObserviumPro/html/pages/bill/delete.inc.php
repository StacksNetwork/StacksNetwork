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

$url    = generate_url(array('page' => 'bill', 'bill_id' => $bill_id, 'view' => 'delete'));

?>

<div class="tabBox">
  <ul class="nav nav-tabs" id="delBillTab">
    <li class="active first"><a href="#delete" data-toggle="tab">删除账单</a></li>
  </ul>
  <div id="delBillTabContent" class="tabcontent tab-content" style="min-height: 50px; padding-bottom: 18px;">
    <form name="form1" action="<?php echo($url); ?>" method="post" class="form-horizontal">
      <script type="text/javascript">
        function showWarning(checked) {
          $('#warning').toggle();
          if (checked) {
            $('#deleteBtn').removeAttr('disabled');
          } else {
            $('#deleteBtn').attr('disabled', 'disabled');
          }
        }
      </script>
      <input type="hidden" name="action" value="delete_bill">
      <fieldset class="tab-pane fade active in" id="delete">
        <!-- <legend>Delete Bill</legend> //-->
        <div class="control-group">
          <label class="control-label" for="confirm"><strong>确认</strong></label>
          <div class="controls">
            <label class="checkbox">
              <input type="checkbox" name="confirm" value="confirm" onchange="javascript: showWarning(this.checked);">
              是的, 请删除该账单!
            </label>
          </div>
        </div>
        <div class="alert alert-message" id="warning" style="display: none;">
          <h4 class="alert-heading"><i class="icon-warning-sign"></i> 警告!</h4>
          您确定要删除该账单吗?
        </div>
      </fieldset>
      <div class="form-actions">
        <button id="deleteBtn" type="submit" class="btn btn-danger" disabled="disabled"><i class="icon-trash icon-white"></i> <strong>删除账单</strong></button>
      </div>
    </form>
  </div>
</div>