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

// Alert test display and editing page.

include($config['html_dir']."/includes/alerting-navbar.inc.php");

$check = dbFetchRow("SELECT * FROM `alert_tests` WHERE `alert_test_id` = ?", array($vars['alert_test_id']));

if ($_SESSION['userlevel'] == 10 && $vars['submit'])
{
  // We are editing. Lets see what we are editing.
  if ($vars['submit'] == "check_conditions")
  {
    $conds = array(); $cond_array = array();
    foreach (explode("\n", $vars['check_conditions']) AS $cond)
    {
      list($cond_array['metric'], $cond_array['condition'], $cond_array['value']) = explode(" ", trim($cond), 3);
      $conds[] = $cond_array;
    }
    $conds = json_encode($conds);
    $rows_updated = dbUpdate(array('conditions' => $conds, 'and' => $vars['alert_and']), 'alert_tests', '`alert_test_id` = ?',array($vars['alert_test_id']));
  }
  elseif ($vars['submit'] == "assoc_add")
  {
    $d_conds = array(); $cond_array = array();
    foreach (explode("\n", trim($vars['assoc_device_conditions'])) AS $cond)
    {
      list($cond_array['attrib'], $cond_array['condition'], $cond_array['value']) = explode(" ", trim($cond), 3);
      $d_conds[] = $cond_array;
    }
    $d_conds = json_encode($d_conds);

    $e_conds = array(); $cond_array = array();
    foreach (explode("\n", trim($vars['assoc_entity_conditions'])) AS $cond)
    {
      list($cond_array['attrib'], $cond_array['condition'], $cond_array['value']) = explode(" ", trim($cond), 3);
      $e_conds[] = $cond_array;
    }
    $e_conds = json_encode($e_conds);
    $rows_updated = dbInsert('alert_assoc', array('alert_test_id' => $vars['alert_test_id'], 'entity_type' => $check['entity_type'], 'device_attribs' => $d_conds, 'entity_attribs' => $e_conds));
  }
  elseif ($vars['submit'] == "delete_assoc")
  {
    $rows_updated = dbDelete('alert_assoc', '`alert_assoc_id` = ?', array($vars['assoc_id']));
  }
  elseif ($vars['submit'] == "assoc_conditions")
  {
    $d_conds = array(); $cond_array = array();
    foreach (explode("\n", trim($vars['assoc_device_conditions'])) AS $cond)
    {
      list($cond_array['attrib'], $cond_array['condition'], $cond_array['value']) = explode(" ", trim($cond), 3);
      $d_conds[] = $cond_array;
    }
    $d_conds = json_encode($d_conds);

    $e_conds = array(); $cond_array = array();
    foreach (explode("\n", trim($vars['assoc_entity_conditions'])) AS $cond)
    {
      list($cond_array['attrib'], $cond_array['condition'], $cond_array['value']) = explode(" ", trim($cond), 3);
      $e_conds[] = $cond_array;
    }
    $e_conds = json_encode($e_conds);
    $rows_updated = dbUpdate(array('device_attribs' => $d_conds, 'entity_attribs' => $e_conds), 'alert_assoc', '`alert_assoc_id` = ?', array($vars['assoc_id']));
  }
  elseif ($vars['submit'] == "alert_details")
  {
    $rows_updated = dbUpdate(array('alert_name' => $vars['alert_name'], 'alert_message' => $vars['alert_message'],
      'severity' => $vars['alert_severity'], 'delay' => $vars['alert_delay'], 'suppress_recovery' => (isset($vars['alert_send_recovery']) ? 0 : 1)), 'alert_tests', '`alert_test_id` = ?', array($vars['alert_test_id']));
  }

  if ($rows_updated > 0)
  {
    $update_message = $rows_updated . " 记录已更新.";
    $updated = 1;
  } elseif ($rows_updated = '-1') {
    $update_message = "记录不变. 没有更新的必要.";
    $updated = -1;
  } else {
    $update_message = "记录更新错误.";
    $updated = 0;
  }

  if ($updated && $update_message)
  {
    print_message($update_message);
  } elseif ($update_message) {
    print_error($update_message);
  }

  // Refresh the $check array to reflect the updates
  $check = dbFetchRow("SELECT * FROM `alert_tests` WHERE `alert_test_id` = ?", array($vars['alert_test_id']));
}

// Process the alert checker to add classes and colours and count status.
humanize_alert_check($check);

/// End bit to go in to function

?>

<div class="row">
  <div class="col-md-12">
    <div class="well info_box">
      <div class="title"><i class="oicon-bell"></i> 检测器详情</div>
<?php
  if ($_SESSION['userlevel'] == 10) { ?>
      <div class="title title-right"><a href="#delete_alert_modal" data-toggle="modal"><i class="oicon-minus-circle"></i> 删除</a></div>
      <div style="margin-right: 5px;" class="title title-right">
        <a href="#edit_alert_modal" data-toggle="modal"><i class="oicon-pencil"></i> 编辑</a>
      </div>
<?php
  }

 #if ($_SESSION['userlevel'] >= '10') { echo '      <div class="title pull-right"><a href="'.generate_url($vars, array('edit' => "TRUE")).'"><i class="oicon-gear"></i> 编辑</a></div>'; }

echo '
      <div class="content">

        <table class="table table-striped table-bordered table-condensed table-rounded">
         <thead>
          <tr>
            <th style="width: 5%;">测试ID</th>
            <th style="width: 15%;">实体类型</th>
            <th style="width: 20%;">名称</th>
            <th style="width: 45%;">信息</th>
            <th style="width: 5%;">选项</th>
            <th style="width: 5%;">延迟</th>
            <th style="width: 10%;">状态</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>', $check['alert_test_id'], '</td>
            <td>', '<i class="',$config['entities'][$check['entity_type']]['icon'],'"></i> ', nicecase($check['entity_type']), '</td>
            <td>', escape_html($check['alert_name']), '</td>
            <td><i>', escape_html($check['alert_message']), '</i></td>
            <td>';  // FUCK THIS COMMA SHIT IT IS HIGHLY ANNOYING -T
            if ($check['suppress_recovery']) { echo('<div style="text-decoration: line-through" title="回收通知抑制">R</div>'); }
            echo '</td>
            <td>', $check['delay'], '</td>
            <td><i>', $check['status_numbers'], '</i></td>
          </tr>
        </tbody></table>
      </div>
    </div>
  </div>
</div>';

  $assocs = dbFetchRows("SELECT * FROM `alert_assoc` WHERE `alert_test_id` = ?", array($vars['alert_test_id']));

?>
<div class="row">
  <div class="col-md-4">
    <div class="well info_box">
      <div class="title"><i class="oicon-traffic-light"></i> 检查情况</div>
<?php
  if ($_SESSION['userlevel'] == 10) {
   ?>
      <div class="title title-right"><a href="#conditions_modal" data-toggle="modal"><i class="oicon-pencil"></i> 编辑</a></div>
  <?php

  }

echo '<div class="content">';

if ($check['and'] == "1")
{
  echo '要求所有的条件相匹配的';
} else {
  echo '需要符合的条件';
}

echo('<table class="table table-condensed table-bordered table-striped table-rounded">');
echo('<thead><tr>');
echo('<th style="width: 33%;">参数</th>');
echo('<th style="width: 33%;">情况</th>');
if ($_SESSION['userlevel'] >= '10')
{
  echo '<th style="width: 33%;">值</th>';
} else {
  echo '<th style="width: 33%;">值</th>';
}

echo '</tr></thead>';

$conditions = json_decode($check['conditions'], TRUE);

$condition_text = array();

foreach ($conditions as $condition)
{
  $condition_text[] = $condition['metric'].' '.$condition['condition'].' '.$condition['value'];
  echo '<tr>';
  echo '<td>'.escape_html($condition['metric']).'</td>';
  echo '<td>'.escape_html($condition['condition']).'</td>';
  echo '<td>'.escape_html($condition['value']).'</td>';
  echo '</tr>';
}

?>

</table>
   </div>
 </div>
  </div>
  <div class="col-md-8">
    <div class="well info_box">
      <div class="title"><i class="oicon-sql-join-left"></i> 关联</div>
<?php
if ($_SESSION['userlevel'] == 10) {
?>
      <div style="margin-right: 5px;" class="title title-right"><a href="#add_assoc_modal" data-toggle="modal"><i class="oicon-plus-circle"></i> 添加</a></div>
<?php } ?>

      <div class="content">
<table class="table table-condensed table-bordered table-striped table-rounded">
  <thead><tr>
    <th style="width: 45%;">设备匹配</th>
    <th style="">实体匹配</th>
    <th style="width: 10%;"></th>
  </tr></thead>

<?php

foreach ($assocs as $assoc_id => $assoc)
{
  echo('<tr>');
  echo('<td>');
  echo('<code>');
  $assoc['device_attribs'] = json_decode($assoc['device_attribs'], TRUE);
  $assoc_dev_text = array();
  if (is_array($assoc['device_attribs']))
  {
    foreach ($assoc['device_attribs'] as $attribute)
    {
      echo(escape_html($attribute['attrib']).' ');
      echo(escape_html($attribute['condition']).' ');
      echo(escape_html($attribute['value']));
      echo('<br />');
      $assoc_dev_text[] = $attribute['attrib'].' '.$attribute['condition'].' '.$attribute['value'];
    }
  } else {
    echo("*");
  }

  echo("</code>");
  echo('</td>');
  echo('<td><code>');
  $assoc['entity_attribs'] = json_decode($assoc['entity_attribs'], TRUE);
  $assoc_entity_text = array();
  if (is_array($assoc['entity_attribs']))
  {
    foreach ($assoc['entity_attribs'] as $attribute)
    {
      echo(escape_html($attribute['attrib']).' ');
      echo(escape_html($attribute['condition']).' ');
      echo(escape_html($attribute['value']));
      echo('<br />');
      $assoc_entity_text[] = $attribute['attrib'].' '.$attribute['condition'].' '.$attribute['value'];
    }
  } else {
    echo("*");
  }
  echo '</code></td>';
  echo '<td style="text-align: right;">';

  if ($_SESSION['userlevel'] == 10) {

    echo '<a href="#assoc_edit_modal_',$assoc['alert_assoc_id'],'" data-toggle="modal">
          <i class="oicon-pencil"></i></a> <a href="#assoc_del_modal_',$assoc['alert_assoc_id'],'" data-toggle="modal"><i class="oicon-minus-circle"></i></a>';

  }

  echo('</td>');
  echo('</tr>');

$modals .= '
<div id="assoc_del_modal_'.$assoc['alert_assoc_id'].'" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="delete_alert" aria-hidden="true">
 <form id="edit" name="edit" method="post" class="form" action="">
  <input type="hidden" name="assoc_id" value="'. $assoc['alert_assoc_id'].'">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel"><i class="oicon-minus-circle"></i> 删除关联规则 '.$assoc['alert_assoc_id'].'</h3>
  </div>
  <div class="modal-body">

  <span class="help-block">这将会删除关联的规则.</span>
  <fieldset>
    <div class="control-group">
      <label class="control-label" for="confirm">
        确认
      </label>
      <div class="controls">
        <label class="checkbox">
          <input type="checkbox" name="confirm" value="confirm" onchange="javascript: showWarning'.$assoc['alert_assoc_id'].'(this.checked);" />
          是的, 请删除此关联规则!
        </label>

        <script type="text/javascript">
        function showWarning'.$assoc['alert_assoc_id'].'(checked) {
          if (checked) { $(\'#delete_button'.$assoc['alert_assoc_id'].'\').removeAttr(\'disabled\'); } else { $(\'#delete_button'.$assoc['alert_assoc_id'].'\').attr(\'disabled\', \'disabled\'); }
        }
      </script>
      </div>
    </div>
  </fieldset>

        <div class="alert alert-message alert-danger" id="warning" style="display:none;">
    <h4 class="alert-heading"><i class="icon-warning-sign"></i> 警告!</h4>
    您确定要删除这个警报关联?
  </div>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
    <button id="delete_button'.$assoc['alert_assoc_id'].'" type="submit" class="btn btn-danger" name="submit" value="delete_assoc" disabled><i class="icon-trash icon-white"></i> 删除关联</button>
  </div>
 </form>
</div>
';

$modals .= '
<div id="assoc_edit_modal_'.$assoc['alert_assoc_id'].'" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
 <form id="edit" name="edit" method="post" class="form" action="">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel"><i class="oicon-sql-join-inner"></i> 编辑关联条件 #'.$assoc['alert_assoc_id'].'</h3>
  </div>
  <div class="modal-body">

  <input type="hidden" name="assoc_id" value="'.$assoc['alert_assoc_id'].'">
  <span class="help-block">请小心编辑这里.</span>

  <fieldset>
    <div class="control-group">
      <label>设备匹配</label>
      <div class="controls">
        <textarea class="col-md-12" rows="4" name="assoc_device_conditions">'.htmlentities(implode("\n", $assoc_dev_text)).'</textarea>
      </div>
    </div>

    <div class="control-group">
      <label>实体匹配</label>
      <div class="controls">
        <textarea class="col-md-12" rows="4" name="assoc_entity_conditions">'.htmlentities(implode("\n", $assoc_entity_text)).'</textarea>
      </div>
    </div>
  </fieldset>

  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
    <button type="submit" class="btn btn-primary" name="submit" value="assoc_conditions"><i class="icon-ok icon-white"></i> 保存变化</button>
  </div>
 </form>
</div>
';

} // End assocation loop

echo('</table>');

echo('
      </div>
    </div>
  </div>
</div>');

echo $modals;

echo '
<div class="row" style="margin-top: 10px;">
  <div class="col-md-12">';

  if ($vars['view'] == 'alert_log')
  {
    print_alert_log($vars);
  } else {
    $vars['pagination'] = TRUE;
    print_alert_table($vars);
  }

echo '

  </div>
</div>';

?>

<?php
if ($_SESSION['userlevel'] == 10) {
?>

<div id="conditions_modal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
 <form id="edit" name="edit" method="post" class="form" action="">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel"><i class="oicon-traffic-light"></i> 编辑检查条件</h3>
  </div>
  <div class="modal-body">
  <span class="help-block">请小心当编辑在这里.</span>
  <fieldset>
    <div class="control-group">
      <div class="controls">
      <select name="alert_and" class="selectpicker">
        <option value="0" data-icon="oicon-or" <?php if ($check['and'] == '0') { echo 'selected'; } ?>>要求任何条件</option>
        <option value="1" data-icon="oicon-and" <?php if ($check['and'] == '1') { echo 'selected'; } ?>>要求所有的条件</option>
      </select>
     </div>
    </div>
    <div class="control-group">
      <div class="controls">
        <textarea class="col-md-12" rows="4" name="check_conditions"><?php echo(htmlentities(implode("\n", $condition_text))); ?></textarea>
      </div>
    </div>
  </fieldset>

  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
    <button type="submit" class="btn btn-primary" name="submit" value="check_conditions"><i class="icon-ok icon-white"></i> 保存变更</button>
  </div>
 </form>
</div>

<div id="delete_alert_modal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="delete_alert" aria-hidden="true">
 <form id="edit" name="edit" method="post" class="form" action="<?php echo(generate_url(array('page' => 'alert_checks'))); ?>">
  <input type="hidden" name="alert_test_id" value="<?php echo($check['alert_test_id']); ?>" />
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel"><i class="oicon-minus-circle"></i> 删除报警检测器 <?php echo($check['alert_test_id']); ?></h3>
  </div>
  <div class="modal-body">

  <span class="help-block">这将完全删除警报检查所有设备/实体关联.</span>
  <fieldset>
    <div class="control-group">
      <label class="control-label" for="confirm">
        确认
      </label>
      <div class="controls">
        <label class="checkbox">
          <input type="checkbox" name="confirm" value="confirm" onchange="javascript: showWarning(this.checked);" />
          是的, 请删除此警报检查!
        </label>

 <script type="text/javascript">
        function showWarning(checked) {
          $('#warning').toggle();
          if (checked) {
            $('#delete_button').removeAttr('disabled');
          } else {
            $('#delete_button').attr('disabled', 'disabled');
          }
        }
      </script>

</div>
    </div>
  </fieldset>

        <div class="alert alert-message alert-danger" id="warning" style="display:none;">
    <h4 class="alert-heading"><i class="icon-warning-sign"></i> 警报!</h4>
      这种检查和关联将彻底删除!
  </div>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
    <button id="delete_button" type="submit" class="btn btn-danger" name="submit" value="delete_alert_checker" disabled><i class="icon-trash icon-white"></i> 删除报警</button>
  </div>
 </form>
</div>

<!-- Add association -->

<div id="add_assoc_modal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="add_assoc_label" aria-hidden="true">
 <form id="add_assoc" name="add_assoc" method="post" class="form" action="">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="add_assoc_label"><i class="oicon-sql-join-inner"></i> 编辑关联的条件</h3>
  </div>
  <div class="modal-body">

  <span class="help-block">请小心当编辑在这里.</span>

  <fieldset>
    <div class="control-group">
      <label>设备匹配</label>
      <div class="controls">
        <textarea class="col-md-12" rows="4" name="assoc_device_conditions"></textarea>
      </div>
    </div>

    <div class="control-group">
      <label>实体匹配</label>
      <div class="controls">
        <textarea class="col-md-12" rows="4" name="assoc_entity_conditions"></textarea>
      </div>
    </div>
  </fieldset>

  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
    <button type="submit" class="btn btn-primary" name="submit" value="assoc_add"><i class="icon-ok icon-white"></i> 添加关联</button>
  </div>
 </form>
</div>

<!-- End add assocation -->

<?php } ?>

<div id="edit_alert_modal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
 <form id="edit" name="edit" method="post" class="form" action="">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel"><i class="oicon-sql-join-inner"></i> 编辑检测器详情</h3>
  </div>
  <div class="modal-body">

  <input type="hidden" name="alert_test_id" value="<?php echo $check['alert_test_id']; ?>" />
<?php /*
<!-- FIXME This entire form is copied almost verbatim from add_alert_check.inc.php - functionize? note col-md-12 instead of 11 --> */ ?>
  <fieldset>
    <div class="control-group">
      <label class="control-label" for="alert_name">报警名称</label>
      <div class="controls">
        <input type=text name="alert_name" size="32" value="<?php echo($check['alert_name']); ?>" placeholder="报警名称"/>
      </div>
    </div>

    <div class="control-group">
      <label class="control-label" for="alert_message">信息</label>
      <div class="controls">
        <textarea class="form-control col-md-12" name="alert_message" rows="3" placeholder="报警信息."/><?php echo(htmlspecialchars($check['alert_message'])); ?></textarea>
      </div>
    </div>

    <div class="control-group">
      <label class="control-label" for="alert_delay">报警延迟</label>
      <div class="controls">
        <input type=text name="alert_delay" size="40" value="<?php echo($check['delay']); ?>" placeholder="&#8470; 检查延迟警报."/>
      </div>
    </div>

    <div class="control-group">
      <label class="control-label" for="alert_send_recovery">发送回收的通知</label>
      <div class="controls"><?php /* HALP. If I enable data-toggle on the below switch/checkbox I don't get the data in the form submission anymore, wtf am I missing? */ ?>
        <input type=checkbox id="alert_send_recovery" name="alert_send_recovery" <?php if (!$check['suppress_recovery']) { echo "checked"; } ?> nope-no-data-toggle="switch-mini" dcata-on-color="danger" dcata-off-color="primary" >
      </div>
    </div>

    <div class="control-group">
      <label class="control-label" for="alert_severity">严重程度</label>
      <div class="controls">
        <select selected name="alert_severity" class="selectpicker"><?php /* There is no database field for this, so we hardcode this */ ?>
          <!-- This option is unimplemented, so anything other than critical is hidden for now -->
          <!-- <option value="info">信息</option> -->
          <!-- <option value="warn">警报</option> -->
          <option <?php echo($check['severity']  == 'crit' ? 'selected' : '') ?> value="crit" data-icon="oicon-exclamation-red">波动</option>
        </select>
      </div>
    </div>
  </fieldset>

  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
    <button type="submit" class="btn btn-primary" name="submit" value="alert_details"><i class="icon-ok icon-white"></i> 保存修改</button>
  </div>
 </form>
</div>

