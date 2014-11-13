<?php

$url    = generate_url(array('page' => 'bill', 'bill_id' => $bill_id, 'view' => 'delete'));

?>

<div class="tabBox">
  <ul class="nav nav-tabs" id="delBillTab">
    <li class="active first"><a href="#delete" data-toggle="tab">Delete bill</a></li>
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
          <label class="control-label" for="confirm"><strong>Confirm</strong></label>
          <div class="controls">
            <label class="checkbox">
              <input type="checkbox" name="confirm" value="confirm" onchange="javascript: showWarning(this.checked);">
              Yes, please delete this bill!
            </label>
          </div>
        </div>
        <div class="alert alert-message" id="warning" style="display: none;">
          <h4 class="alert-heading"><i class="icon-warning-sign"></i> Warning!</h4>
          Are you sure you want to delete this bill?
        </div>
      </fieldset>
      <div class="form-actions">
        <button id="deleteBtn" type="submit" class="btn btn-danger" disabled="disabled"><i class="icon-trash icon-white"></i> <strong>Delete Bill</strong></button>
      </div>
    </form>
  </div>
</div>