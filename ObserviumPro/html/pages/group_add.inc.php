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

include($config['html_dir']."/includes/group-navbar.inc.php");

 // Hardcode exit if user doesn't have global write permissions.
  if ($_SESSION['userlevel'] < 10)
  {
    include("includes/error-no-perm.inc.php");

    exit;
  }
  // print_vars($vars);

  if ($vars['submit'] == "add_group")
  {

    echo '<div class="alert alert-info">
    <button type="button" class="close" data-dismiss="alert">×</button>
    <div class="pull-left" style="padding:0 5px 0 0"><i class="oicon-information"></i></div>
    <h4>添加分组</h4>';

    foreach (array('entity_type', 'group_name', 'group_descr',
                   'assoc_device_conditions', 'assoc_entity_conditions') as $var)
    {
      if (!isset($vars[$var]) || strlen($vars[$var]) == '0') { echo("Missing required data.</div>"); break 2; }
    }

    $group_array = array();

    $group_array['entity_type'] = $vars['entity_type'];
    $group_array['group_name']  = $vars['group_name'];
    $group_array['group_descr'] = $vars['group_descr'];

    $group_id = dbInsert('groups', $group_array);

    if (is_numeric($group_id))
    {
      echo('<p>分组已创建为ID <a href="'.generate_url(array('page' => 'group', 'group_id' => $group_id)).'">'.$group_id.'</a></p>');

      $assoc_array = array();
      $assoc_array['group_id']    = $group_id;
      $assoc_array['entity_type'] = $vars['entity_type'];
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

      $assoc_id = dbInsert('groups_assoc', $assoc_array);
      if (is_numeric($assoc_id))
      {
        echo("<p>关联插入 ".$assoc_id."</p>");
      } else {
        echo('<p class="red">关联创建失败.</p>');
      }
    } else {
      echo('<p class="red">分组创建失败. 请注意, 该组名称<b>必须</b>是独一无二的.</p>');
    }
    echo '</div>';
  }

?>

<form name="add_group" method="post" action="" class="form-horizontal">

<legend>新建分组</legend>

<div class="row">
  <div class="col-md-6">
    <div class="well info_box">
      <div class="title"><i class="oicon-bell"></i> 分组详情</div>
      <div class="content">
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
    <label class="control-label" for="group_name">分组名称</label>
    <div class="controls">
      <input type=text name="group_name" size="32" placeholder="组名称"/>
    </div>
  </div>
        <div class="control-group">
    <label class="control-label" for="group_descr">概述</label>
    <div class="controls">
      <textarea class="form-control col-md-11" name="group_descr" rows="3" placeholder="分组概述"></textarea>
    </div>
  </div>
  </fieldset>
      </div> <!-- content -->
    </div> <!--  info_box-->
  </div> <!-- col -->

 <div class="col-md-6">
    <div class="well info_box">
      <div class="title"><i class="oicon-sql-join-left"></i> 初始关联</div>
      <div class="title" style="float: right; margin-bottom: -10px;"><a href="#" onclick="return false;" class="tooltip-from-element" data-tooltip-id="tooltip-help-associations"><i class="oicon-question"></i></a></div>
      <div class="content">
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
  <button type="submit" class="btn btn-success" name="submit" value="add_group"><i class="icon-plus oicon-white"></i> 添加分组</button>
</div>

</form>

<div id="tooltip-help-associations" style="display: none;">

      Associations should be entered in this format
      <pre>attribute_1 condition value_1
attribute_2 condition value_2
attribute_3 condition value_3</pre>

      For example, to match a network device with core in its hostname
      <pre>type equals network
hostname match *cisco*</pre>

      For example, to match an ethernet port which is connected at 10 gigabit
      <pre>ifType equals ethernetCsmacd
ifSpeed ge 100000000</pre>

      If you put * in either the device or entity fields, it will match all devices or all entities respectively.
</div>

<?php

// EOF
