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

//        <span style="clear:none; float: right; margin-right: 10px; border-left: 1px;">
//          <a href="#delete_alert_modal" data-toggle="modal"><i class="oicon-minus-circle"></i></a>
//          <a href="#delete_alert_modal" data-toggle="modal"><i class="oicon-minus-circle"></i></a>
//        </span>


include($config['html_dir']."/includes/alerting-navbar.inc.php");

 // Hardcode exit if user doesn't have global write permissions.
  if ($_SESSION['userlevel'] < 10)
  {
    include("includes/error-no-perm.inc.php");

    exit;
  }

  if (isset($vars['submit']) && $vars['submit'] == "add_alert_check")
  {
    echo '<div class="alert alert-info">
    <button type="button" class="close" data-dismiss="alert">×</button>
    <div class="pull-left" style="padding:0 5px 0 0"><i class="oicon-information"></i></div>
    <h4>添加警报检测</h4>';

    foreach (array('entity_type', 'alert_name', 'alert_severity', 'check_conditions', 'assoc_device_conditions', 'assoc_entity_conditions') as $var)
    {
      if (!isset($vars[$var]) || strlen($vars[$var]) == '0') { echo("缺少必要数据.</div>"); break 2; }
    }

    $check_array = array();

    $conds = array();
    foreach (explode("\n", $vars['check_conditions']) AS $cond)
    {
      list($this['metric'], $this['condition'], $this['value']) = explode(" ", trim($cond), 3);
      $conds[] = $this;
    }
    $check_array['conditions'] = json_encode($conds);

    $check_array['entity_type'] = $vars['entity_type'];
    $check_array['alert_name'] = $vars['alert_name'];
    $check_array['alert_message'] = $vars['alert_message'];
    $check_array['severity'] = $vars['alert_severity'];
    $check_array['suppress_recovery'] = ($vars['alert_send_recovery'] == 'on' ? 0 : 1);
    $check_array['alerter'] = NULL;
    $check_array['and'] = $vars['alert_and'];
    $check_array['delay'] = $vars['alert_delay'];
    $check_array['enable'] = '1';

    $check_id = dbInsert('alert_tests', $check_array);
    if (is_numeric($check_id))
    {
      echo('<p>Alert inserted as <a href="'.generate_url(array('page' => 'alert_check', 'alert_test_id' => $check_id)).'">'.$check_id.'</a></p>');
      $assoc_array = array();
      $assoc_array['alert_test_id'] = $check_id;
      $assoc_array['entity_type'] = $vars['entity_type'];
      $assoc_array['enable'] = '1';
      $dev_conds = array();
      foreach (explode("\n", $vars['assoc_device_conditions']) AS $cond)
      {
        list($this['attrib'], $this['condition'], $this['value']) = explode(" ", trim($cond), 3);
        $dev_conds[] = $this;
      }
      $assoc_array['device_attribs'] = json_encode($dev_conds);
      if ($vars['assoc_device_conditions'] == "*") { $vars['assoc_device_conditions'] = json_encode(array()); }
      $ent_conds = array();
      foreach (explode("\n", $vars['assoc_entity_conditions']) AS $cond)
      {
        list($this['attrib'], $this['condition'], $this['value']) = explode(" ", trim($cond), 3);
        $ent_conds[] = $this;
      }
      $assoc_array['entity_attribs'] = json_encode($ent_conds);
      if ($vars['assoc_entity_conditions'] == "*") { $vars['assoc_entity_conditions'] = json_encode(array()); }

      $assoc_id = dbInsert('alert_assoc', $assoc_array);
      if (is_numeric($assoc_id))
      {
        echo("<p>关联插入 ".$assoc_id."</p>");
      } else {
        echo('<p class="red">关联创建失败.</p>');
      }
    } else {
      echo('<p class="red">创建通知失败. 请注意警报名称<b>必须</b>是独一无二的.</p>');
    }
    echo '</div>';
  }

?>

<form name="form1" method="post" action="" class="form-horizontal">

<legend>新的警报检测程序</legend>

<div class="row">
  <div class="col-md-6">
  <div class="widget">
    <div class="widget-header">
      <i class="oicon-bell"></i><h3>检测程序详情</h3>
    </div>
    <div class="widget-content">

  <fieldset>
  <div class="control-group">
    <label class="control-label" for="entity_type">实体类型</label>
    <div class="controls">
      <select name="entity_type" class="selectpicker" data-show-icon="true">
        <?php

        foreach ($config['entities'] as $entity_type => $entity_type_array)
        {
          echo '<option value="'.$entity_type.'" ';
            if (!isset($entity_type_array['icon'])) { $entity_type_array['icon'] = $config['entity_default']['icon']; }
            echo($vars['entity_type'] == $entity_type  || ($vars['entity_type'] == '')  ? 'selected' : '');
          echo ' data-icon="'.$entity_type_array['icon'].'"> '.nicecase($entity_type).'</option>';
        }
        ?>
      </select>
    </div>
        </div>

  <div class="control-group">
    <label class="control-label" for="alert_name">警报名称</label>
    <div class="controls">
      <input type=text name="alert_name" size="32" placeholder="警报名称"/>
    </div>
  </div>
        <div class="control-group">
    <label class="control-label" for="alert_message">信息</label>
    <div class="controls">
      <textarea class="form-control col-md-11" name="alert_message" rows="3" placeholder="报警信息."/></textarea>
    </div>
        </div>
        <div class="control-group">
    <label class="control-label" for="alert_delay">警报延迟</label>
    <div class="controls">
      <input type=text name="alert_delay" size="40" placeholder="&#8470; 检测延迟警报."/>
    </div>
  </div>
    <div class="control-group">
      <label class="control-label" for="alert_send_recovery">发送恢复</label>
      <div class="controls">
        <input type=checkbox name="alert_send_recovery" checked data-toggle="switch" data-off-color="danger" />
      </div>
    </div>
        <div class="control-group">
    <label class="control-label" for="alert_severity">严重程度</label>
    <div class="controls">
      <select name="alert_severity" class="selectpicker">
        <!-- 这个选项是未实现的, 所以比其他任何关键的是隐藏了 -->
        <!-- <option value="info">信息</option> -->
        <!-- <option value="warn">警告</option> -->
        <option value="crit" data-icon="oicon-exclamation-red">线路</option>
      </select>
    </div>
        </div>
  </fieldset>
      </div> <!-- content -->
    </div> <!--  info_box-->
  </div> <!-- col -->



<div class="col-md-6">
  <div class="widget">
    <div class="widget-header">
      <i class="oicon-traffic-light"></i><h3>检测条件</h3>
      <div class="widget-controls">
        <a href="#" onclick="return false;" class="tooltip-from-element" data-tooltip-id="tooltip-help-conditions"><i class="oicon-question"></i></a>
      </div>
    </div>
    <div class="widget-content">

        <div style="margin-bottom: 10px;">
      <select name="alert_and" class="selectpicker">
        <option value="0" data-icon="oicon-or">要求任何条件</option>
              <option value="1" data-icon="oicon-and" selected>要求所有的条件</option>
      </select>
          </div>
  <textarea class="col-md-12" rows="3" name="check_conditions"></textarea>

      </div> <!-- content -->
    </div> <!-- infobox -->

    <!-- Assocations -->
  <div class="widget">
    <div class="widget-header">
      <i class="oicon-sql-join-left"></i><h3>关联</h3>
      <div class="widget-controls">
        <a href="#" onclick="return false;" class="tooltip-from-element" data-tooltip-id="tooltip-help-associations"><i class="oicon-question"></i></a>
      </div>
    </div>
    <div class="widget-content">
        <div class="control-group">
          <label>设备关联</label>
          <textarea class="col-md-12" rows="3" name="assoc_device_conditions" placeholder=""></textarea>
          </div>
        <div class="control-group">
          <label>实体关联</label>
          <textarea class="col-md-12" rows="3" name="assoc_entity_conditions"></textarea>
        </div>
      </div> <!-- content -->
    </div> <!-- infobox -->

  </div> <!-- col -->
</div> <!-- row -->

<div class="form-actions">
  <button type="submit" class="btn btn-success" name="submit" value="add_alert_check"><i class="icon-plus oicon-white"></i> 添加检测</button>
</div>

</form>

<div id="tooltip-help-conditions" style="display: none;">

      条件应该输入该格式
      <pre>metric_1 condition value_1
metric_2 condition value_2
metric_3 condition value_3</pre>

      例如在一个启用的端口异常时报警
      <pre>ifAdminStatus equals up
ifOperStatus equals down</pre>

</div>

<div id="tooltip-help-associations" style="display: none;">

      应该使用该组织格式
      <pre>attribute_1 condition value_1
attribute_2 condition value_2
attribute_3 condition value_3</pre>

      例如匹配核心网络设备的主机名
      <pre>type equals network
hostname match *cisco*</pre>

      例如要匹配一个万兆以太网端口
      <pre>ifType equals ethernetCsmacd
ifSpeed ge 100000000</pre>

      如果您输入 * 在任何设备或实体字段, 那将匹配所有设备或所有实体.
</div>

<?php

// EOF
