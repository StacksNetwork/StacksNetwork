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

$pagetitle[]      = "添加新账单";
$links['this']    = generate_url($vars);
$links['bills']   = generate_url(array('page' => 'bills'));

?>

<div class="tabBox">
  <ul class="nav nav-tabs" id="addBillTab">
    <li class="active"><a href="#properties" data-toggle="tab">账单属性</a></li>
<?php

if ($_SESSION['userlevel'] == "10") {
  if (is_numeric($vars['port'])) {
    $billingport = dbFetchRow("SELECT * FROM `ports` AS P, `devices` AS D WHERE `port_id` = ? AND D.device_id = P.device_id", array($vars['port']));
    echo("    <li><a href=\"#ports\" data-toggle=\"tab\">账单端口</a></li>\n");
  }

?>
  </ul>
  <div class="tabcontent tab-content" id="addBillTabContent" style="min-height: 50px; padding-bottom: 18px;">
    <div class="tab-pane fade active in" id="properties">
      <form name="form1" method="post" action="<?php echo($links['bills']); ?>" class="form-horizontal">
        <input type="hidden" name="addbill" value="yes">
        <script type="text/javascript">
          function billType() {
            $('#cdrDiv').toggle();
            $('#quotaDiv').toggle();
          }
        </script>
        <fieldset>
          <legend>账单属性</legend>
          <div class="control-group">
            <label class="control-label" for="bill_name"><strong>说明</strong></label>
            <div class="controls">
              <input class="col-lg-4" type="text" name="bill_name" value="<?php echo($billingport['port_descr_descr']); ?>">
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="bill_type"><strong>账单类型</strong></label>
            <div class="controls">
              <input type="radio" style="margin-bottom: 8px;" name="bill_type" value="cdr" checked onchange="javascript: billType();" /> CDR 95th
              <input type="radio" style="margin-bottom: 8px;" name="bill_type" value="quota" onchange="javascript: billType();" /> 限额
              <div id="cdrDiv">
                <input class="span1" type="text" name="bill_cdr">
                <select name="bill_cdr_type" style="width: 233px;">
                  <option value="Kbps">千字节/秒 (Kbps)</option>
                  <option value="Mbps" selected>兆/秒 (Mbps)</option>
                  <option value="Gbps">千兆/秒 (Gbps)</option>
                </select>
              </div>
              <div id="quotaDiv" style="display: none">
                <input class="span1" type="text" name="bill_quota">
                <select name="bill_quota_type" style="width: 233px;">
                  <option value="MB">百兆 (MB)</option>
                  <option value="GB" selected>千兆 (GB)</option>
                  <option value="TB">万兆 (TB)</option>
                </select>
              </div>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="bill_day"><strong>账单日</strong></label>
            <div class="controls">
              <select name="bill_day" style="width: 60px;">
<?php

for ($x=1;$x<32;$x++) {
  echo("                <option value=\"".$x."\">".$x."</option>\n");
}

?>
              </select>
            </div>
          </div>
        </fieldset>
        <fieldset>
          <legend>可选信息</legend>
          <div class="control-group">
            <label class="control-label" for="bill_custid"><strong>客户&nbsp;介绍人</strong></label>
            <div class="controls">
              <input class="col-lg-4" type="text" name="bill_custid">
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="bill_ref"><strong>帐单参考</strong></label>
            <div class="controls">
              <input class="col-lg-4" type="text" name="bill_ref" value="<?php echo($billingport['port_descr_circuit']); ?>">
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="bill_notes"><strong>备注</strong></label>
            <div class="controls">
              <input class="col-lg-4" type="text" name="bill_notes" value="<?php echo($billingport['port_descr_speed']); ?>">
            </div>
          </div>
        </fieldset>
        <div class="form-actions">
          <!-- <button class="btn btn-info" style="float: right;"><i class="icon-circle-arrow-left icon-white"></i> <strong>返回账单</strong></button> //-->
          <button type="submit" class="btn btn-primary"><i class="icon-ok-sign icon-white"></i> <strong>添加账单</strong></button>
        </div>
    </div>
    <div class="tab-pane fade in" id="ports">
<?php

  if (is_array($billingport)) {
    $devicebtn = str_replace("list-device", "btn", generate_device_link($billingport));
    $portbtn   = str_replace("interface-upup", "btn", generate_port_link($billingport));
    $portalias = (empty($billingport['ifAlias']) ? "" : " - ".$billingport['ifAlias']."");
    $devicebtn = str_replace("\">".$billingport['hostname'], "\" style=\"color: #000;\"><i class=\"icon-asterisk\"></i> ".$billingport['hostname'], $devicebtn);
    $devicebtn = str_replace("overlib('", "overlib('<div style=\'border: 5px solid #e5e5e5; background: #fff; padding: 10px;\'>", $devicebtn);
    $devicebtn = str_replace("<div>',;", "</div></div>',", $devicebtn);
    $portbtn   = str_replace("\">".strtolower($billingport['ifName']), "\" style=\"color: #000;\"><i class=\"icon-random\"></i> ".$billingport['ifName']."".$portalias, $portbtn);
    $portbtn   = str_replace("overlib('", "overlib('<div style=\'border: 5px solid #e5e5e5; background: #fff; padding: 10px;\'>", $portbtn);
    $portbtn   = str_replace("<div>',;", "</div></div>',", $portbtn);
    echo("      <fieldset>\n");
    echo("        <legend>账单端口</legend>\n");
    echo("        <input type=\"hidden\" name=\"port\" value=\"".$billingport['port_id']."\">\n");
    echo("        <div class=\"control-group\">\n");
    echo("          <div class=\"btn-toolbar\">\n");
    echo("            <div class=\"btn-group\">\n");
    echo("              ".$devicebtn."\n");
    echo("              ".$portbtn."\n");
    echo("            </div>\n");
    echo("          </div>\n");
    echo("        </div>\n");
    echo("      </fieldset>\n");
  }

?>
  </div>
</div>
      </form>

<?php

  } else {
    echo("<div class=\"alert alert-error\"><i class=\"icon-warning-sign\"></i> <strong>错误!</strong><br />您没有管理权限来创建一个新的账单.</div>");
  }

?>
