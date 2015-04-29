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

include("includes/javascript-interfacepicker.inc.php");

// This needs more verification. Is it already added? Does it exist?

$base = $config["billing"]["base"];
$url  = generate_url(array('page' => 'bill', 'bill_id' => $bill_id, 'view' => 'edit'));

if ($bill_data['bill_type'] == "quota") {
  $data = $bill_data['bill_quota'];
  $tmp['mb'] = $data / $base / $base;
  $tmp['gb'] = $data / $base / $base / $base;
  $tmp['tb'] = $data / $base / $base / $base / $base;
  if (($tmp['tb']>1) and ($tmp['tb']<$base)) { $quota =  array("type" => "tb", "select_tb" => " selected", "data" => $tmp['tb']); }
  elseif (($tmp['gb']>1) and ($tmp['gb']<$base)) { $quota = array("type" => "gb", "select_gb" => " selected", "data" => $tmp['gb']); }
  elseif (($tmp['mb']>1) and ($tmp['mb']<$base)) { $quota = array("type" => "mb", "select_mb" => " selected", "data" => $tmp['mb']); }
}
if ($bill_data['bill_type'] == "cdr") {
  $data = $bill_data['bill_cdr'];
  $tmp['kbps'] = $data / $base;
  $tmp['mbps'] = $data / $base / $base;
  $tmp['gbps'] = $data / $base / $base / $base;
  if ($tmp['gbps']>1 and ($tmp['gbps']<$base)) { $cdr =  array("type" => "gbps", "select_gbps" => " selected", "data" => $tmp['gbps']); }
  elseif (($tmp['mbps']>1) and ($tmp['mbps']<$base)) { $cdr = array("type" => "mbps", "select_mbps" => " selected", "data" => $tmp['mbps']); }
  elseif (($tmp['kbps']>1) and ($tmp['kbps']<$base)) { $cdr = array("type" => "kbps", "select_kbps" => " selected", "data" => $tmp['kbps']); }
}

?>
      <form id="edit" name="edit" method="post" action="<?php echo($url); ?>" class="form-horizontal">
<div class="row">
  <div class="col-md-6">
   <div class="well info_box">
    <div class="title"><i class="oicon-wrench"></i> 账单属性</div>
    <div class="content">
        <input type="hidden" name="action" value="update_bill">
        <script type="text/javascript">
          function billType() {
            $('#cdrDiv').toggle();
            $('#quotaDiv').toggle();
          }
        </script>
        <fieldset>
          <div class="control-group">
            <label class="control-label" for="bill_name">说明</label>
            <div class="controls">
              <input class="col-lg-10" type="text" name="bill_name" value="<?php echo $bill_data["bill_name"]; ?>" />
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="bill_type">账单类型</label>
            <div class="controls">
              <input type="radio" style="margin-bottom: 8px;" name="bill_type" value="cdr" onchange="javascript: billType();" <?php if ($bill_data['bill_type'] == "cdr") { echo('checked '); } ?>/> CDR / 95th计费
              <input type="radio" style="margin-bottom: 8px;" name="bill_type" value="quota" onchange="javascript: billType();" <?php if ($bill_data['bill_type'] == "quota") { echo('checked '); } ?>/> 限额
            <!--
              <div class="btn-group" data-toggle="buttons-radio" style="margin-bottom: 5px;">
                <button class="btn btn-small btn-primary<?php if ($bill_data['bill_type'] == "cdr") { echo(' active'); } ?>" name="bill_type" value="cdr" onclick="javascript: billType();">CDR / 95th percentile</button>
                <button class="btn btn-small btn-primary<?php if ($bill_data['bill_type'] == "quota") { echo(' active'); } ?>" name="bill_type" value="quota" onclick="javascript: billType();">限额</button>
              </div>
            //-->
              <div id="cdrDiv"<?php if ($bill_data['bill_type'] == "quota") { echo(' style="display: none"'); } ?>>
                <input class="col-lg-2" type="text" name="bill_cdr" value="<?php echo $cdr['data']; ?>">
                <select name="bill_cdr_type" style="width: 253px;">
                  <option value="Kbps"<?php echo $cdr['select_kbps']; ?>>千字节/秒 (Kbps)</option>
                  <option value="Mbps"<?php echo $cdr['select_mbps']; ?>>兆/秒 (Mbps)</option>
                  <option value="Gbps"<?php echo $cdr['select_gbps']; ?>>千兆/秒 (Gbps)</option>
                </select>
              </div>
              <div id="quotaDiv"<?php if ($bill_data['bill_type'] == "cdr") { echo(' style="display: none"'); } ?>>
                <input class="col-lg-2" type="text" name="bill_quota" value="<?php echo $quota['data']; ?>">
                <select name="bill_quota_type" style="width: 253px;">
                  <option value="MB"<?php echo $quota['select_mb']; ?>>百兆 (MB)</option>
                  <option value="GB"<?php echo $quota['select_gb']; ?>>千兆 (GB)</option>
                  <option value="TB"<?php echo $quota['select_tb']; ?>>万兆 (TB)</option>
                </select>
              </div>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="bill_day">账单日</label>
            <div class="controls">
              <select name="bill_day" style="width: 60px;">
<?php

for ($x=1;$x<32;$x++) {
  $select = (($bill_data['bill_day'] == $x) ? " selected" : "");
  echo("              <option value=\"".$x."\"".$select.">".$x."</option>");
}

?>
              </select>
            </div>
          </div>
        </fieldset>
    </div>
   </div>

<?php /**

   <div class="well info_box">
     <div class="title"><i class="oicon-warning"></i> 客户通知</div>
     <div class="content">
        <fieldset>
          <div class="control-group">
            <label class="control-label" for="bill_notify">激活通知</label>
            <div class="controls">
              <input id="bill_notify" type="checkbox" name="bill_notify" data-id="bill_notify" data-label="激活超额用户通知."
<?php if($bill_data['bill_notify'] == 1) { echo('checked'); } ?> >
              <span class="help-inline">激活超额用户通知</span>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="bill_contact">客户邮件</label>
            <div class="controls">
              <input class="col-lg-10" type="text" name="bill_contact" value="<?php echo $bill_data['bill_contact']; ?>" />
            </div>
          </div>
        </fieldset>
     </div>
   </div>

*/ ?>

   <div class="well info_box">
     <div class="title"><i class="oicon-information"></i> 可选信息</div>
     <div class="content">
        <fieldset>
          <div class="control-group">
            <label class="control-label" for="bill_custid">客户&nbsp;介绍人</label>
            <div class="controls">
              <input class="col-lg-10" type="text" name="bill_custid" value="<?php echo $bill_data['bill_custid']; ?>" />
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="bill_ref">帐单参考</label>
            <div class="controls">
              <input class="col-lg-10" type="text" name="bill_ref" value="<?php echo $bill_data['bill_ref']; ?>" />
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="bill_notes">备注</label>
            <div class="controls">
              <input class="col-lg-10" type="text" name="bill_notes" value="<?php echo $bill_data['bill_notes']; ?>" />
            </div>
          </div>
        </fieldset>
     </div>
   </div>

   <div class="form-actions" style="margin: 0px -10px -20px -10px;">
     <button type="submit" class="btn btn-primary" name="提交" value="保存"><i class="icon-ok icon-white"></i> 保存属性</button>
   </div>
  </div>

</form>

  <div class="col-md-6">
    <div class="well info_box">
      <div class="title"><i class="oicon-network-ethernet"></i> 账单端口</div>
      <div class="content">

      <form class="form-horizontal">
        <fieldset>
          <div class="control-group">
<?php

$port_ids = dbFetchRows("SELECT `port_id` FROM `bill_ports` WHERE bill_id = ?", array($bill_id));

if (is_array($ports))
{
  foreach ($port_ids AS $port_entry)
  {

    $emptyCheck = true;

    $port   = get_port_by_id($port_entry['port_id']);
    $device = device_by_id_cache($port['device_id']);

    $devicebtn = '<button class="btn"><i class="oicon-servers"></i> '.generate_device_link($device).'</button>';
    if (empty($port['ifAlias'])) { $portalias = ""; } else { $portalias = " - ".$port['ifAlias'].""; }
    $portbtn = '<button class="btn">'.generate_port_link($port, '<i class="oicon-network-ethernet"></i> '.rewrite_ifname($port['label']).$portalias).'</button>';

    $delete  = generate_url(array('page' => 'bill', 'bill_id' => $bill_id, 'view' => 'edit', 'action' => 'delete_bill_port', 'port_id' => $port['port_id']));

    echo('          <form action="'.$url.'" method="get" name="delete">' . PHP_EOL);
    echo('            <input type="hidden" name="action" value="delete_bill_port" />' . PHP_EOL);
    echo('            <input type="hidden" name="port_id" value="'.$port['port_id'].'" />' . PHP_EOL);
    echo('            <div class="btn-toolbar">' . PHP_EOL);
    echo('              <div class="btn-group">' . PHP_EOL);
    echo('                <button type="submit" class="btn btn-danger" style="color: #fff;"><i class="icon-minus-sign icon-white"></i> 删除</button>' . PHP_EOL);
    echo('                ' . $devicebtn . PHP_EOL);
    echo('                ' . $portbtn . PHP_EOL);
    echo('              </div>' . PHP_EOL);
    echo('            </div>' . PHP_EOL);
    echo('          </form>' . PHP_EOL);
  }
  if (!$emptyCheck)
  {
    print_warning('没有端口分配至该账单');
  }
}

?>
        </div>
      </fieldset>
    </form>
   </div>
  </div>
  <div class="well info_box">
    <div class="title"><i class="oicon-network-ethernet"></i> 添加新端口</div>

    <form action="<?php echo($url); ?>" method="post" class="form-horizontal">
      <input type="hidden" name="action" value="add_bill_port" />
      <input type="hidden" name="bill_id" value="<?php echo $bill_id; ?>" />
      <fieldset>
        <div class="control-group">
          <label class="control-label" for="device">设备</label>
          <div class="controls">
            <select style="width: 300px;" id="device" name="device" class="selectpicker" onchange="getInterfaceList(this, 'port_id')">
              <option value=''>选择一个设备</option>
<?php

$devices = dbFetchRows("SELECT * FROM `devices` ORDER BY hostname");
foreach ($devices as $device)
{
  if (device_permitted($device['device_id']))
  {
    echo("              <option value='" . $device['device_id']  . "'>" . $device['hostname'] . "</option>");
  }
}

?>
            </select>
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="port_id">端口</label>
          <div class="controls">
            <select multiple style="width: 300px;" id="port_id" class="selectpicker" name="port_id[]"></select>
          </div>
        </div>
      </fieldset>
      <div class="form-actions" style="margin: 0px -10px -20px -10px;">
        <button type="submit" class="btn btn-primary" name="提交" value="添加"><i class="icon-plus-sign icon-white"></i> 添加接口</button>
      </div>
    </form>
  </div>
</div>
