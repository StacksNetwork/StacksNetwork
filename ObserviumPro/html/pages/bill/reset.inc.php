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
  <ul class="nav nav-tabs" id="resetBillTab">
    <li class="active first"><a href="#reset" data-toggle="tab">重置账单</a></li>
  </ul>
  <div class="tabcontent tab-content" id="resetBillTabContent" style="min-height: 50px; padding-bottom: 18px;">
    <form name="form1" action="<?php echo($url); ?>" method="post" class="form-horizontal">
      <script type="text/javascript">
        function showWarning() {
          var checked = $('input:checked').length;
          if (checked == '0') {
            $('#resetBtn').attr('disabled', 'disabled');
            $('#warning').hide();
          } else {
            $('#resetBtn').removeAttr('disabled');
            $('#warning').show();
          }
        }
      </script>
      <input type="hidden" name="action" value="reset_bill">
      <fieldset class="tab-pane fade active in" id="reset">
        <!-- <legend>重置账单</legend> //-->
        <div class="control-group">
          <label class="control-label" for="confirm"><strong>确认</strong></label>
          <div class="controls">
            <label class="checkbox">
              <input type="checkbox" name="confirm" value="mysql" onchange="javascript: showWarning();">
              是的，请重置MySQL数据在这个账单的所有网络接口!
            </label>
<!--            <label class="checkbox" rel="tooltip-left" title="This option isn't available at this time">
              <input disabled type="checkbox" name="confirm" value="rrd" onchange="javascript: showWarning();">
              Yes, please reset RRD data for all interfaces on this bill!
            </label>
-->
          </div>
        </div>
        <div class="alert alert-message" id="warning" style="display: none;">
          <h4 class="alert-heading"><i class="icon-warning-sign"></i> 警告!</h4>
          您确定要重 <strong>MySQL</strong> 和/或 <strong>RRD</strong> 数据在这个账单的所有网络接口?
        </div>
      </fieldset>
      <div class="form-actions">
        <button id="resetBtn" type="submit" class="btn btn-danger" disabled="disabled"><i class="icon-refresh icon-white"></i> <strong>重置账单</strong></button>
      </div>
    </form>
  </div>
</div>
