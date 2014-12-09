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

// member display and editing page.

include($config['html_dir']."/includes/group-navbar.inc.php");

$group                 = dbFetchRow("SELECT * FROM `groups` WHERE `group_id` = ?", array($vars['group_id']));
$group['member_count'] = dbFetchCell("SELECT COUNT(*) FROM `group_table` WHERE `group_id` = ?", array($group['group_id']));
$assocs                = dbFetchRows("SELECT * FROM `groups_assoc` WHERE `group_id` = ?", array($vars['group_id']));
$entity_type           = $config['entities'][$group['entity_type']];

if ($_SESSION['userlevel'] == 10 && $vars['submit'])
{

  // We are editing. Lets see what we are editing.
  if ($vars['submit'] == "delete_assoc")
  {
    $rows_updated = dbDelete('group_assoc', '`group_assoc_id` = ?', array($vars['assoc_id']));
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
    $rows_updated = dbInsert('groups_assoc', array('group_id' => $vars['group_id'], 'entity_type' => $group['entity_type'], 'device_attribs' => $d_conds, 'entity_attribs' => $e_conds));
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
    $rows_updated = dbUpdate(array('device_attribs' => $d_conds, 'entity_attribs' => $e_conds), 'groups_assoc', '`group_assoc_id` = ?', array($vars['assoc_id']));
  }
  elseif ($vars['submit'] == "group_details")
  {
    $rows_updated = dbUpdate(array('group_descr' => $vars['group_descr']), 'groups', '`group_id` = ?', array($vars['group_id']));
  }

  if ($rows_updated > 0)
  {
    $update_message = $rows_updated . " 记录更新.";
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
  $group   = dbFetchRow("SELECT * FROM `groups` WHERE `group_id` = ?", array($vars['group_id']));
  $assocs  = dbFetchRows("SELECT * FROM `groups_assoc` WHERE `group_id` = ?", array($vars['group_id']));
}

if ($_SESSION['userlevel'] < 5)
{
  // No groups for non-global users!
  include("includes/error-no-perm.inc.php");
}
 else
{

?>

<div class="row">
  <div class="col-md-5">
    <div class="well info_box">
      <div class="title"><i class="oicon-category"></i> 分组详情</div>
      <div class="title title-right"><a href="#delete_group_modal" data-toggle="modal"><i class="oicon-minus-circle"></i> 删除</a></div>
      <div style="margin-right: 5px;" class="title title-right"><a href="#edit_group_modal" data-toggle="modal"><i class="oicon-gear--edit"></i> 编辑</a></div>

                        <?php
#if ($_SESSION['userlevel'] >= '10') { echo '      <div class="title pull-right"><a href="'.generate_url($vars, array('edit' => "TRUE")).'"><i class="oicon-gear"></i> 编辑</a></div>'; }

echo '
      <div class="content">

        <table class="table table-striped table-bordered table-condensed table-rounded">
         <thead>
          <tr>
            <th style="width: 5%;">ID</th>
            <th style="width: 25%;">类型</th>
            <th style="width: 60%;">分组</th>
            <th style="width: 15%;">成员</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>', $group['group_id'], '</td>
            <td><i class="', $entity_type['icon'], '"></i> ', nicecase($group['entity_type']), '</td>
            <td>', $group['group_name'], '<br /><i>', $group['group_descr'], '</i></td>
            <td>', $group['member_count'], '</td>
          </tr>
        </tbody>
       </table>
      </div>
    </div>
  </div>';

?>

  <div class="col-md-7">
    <div class="well info_box">
      <div class="title"><i class="oicon-sql-join-left"></i> 关联</div>
      <div style="margin-right: 5px;" class="title title-right"><a href="#add_assoc_modal" data-toggle="modal"><i class="oicon-plus-circle"></i> 添加</a></div>
      <div class="content">
        <table class="table table-condensed table-bordered table-striped table-rounded">
          <thead>
            <tr>
              <th style="width: 45%;">设备匹配</th>
              <th style="">实体匹配</th>
              <th style="width: 10%;"></th>
            </tr>
          </thead>

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
      echo($attribute['attrib'].' ');
      echo($attribute['condition'].' ');
      echo($attribute['value']);
      echo('<br />');
      $assoc_dev_text[] = $attribute['attrib'].' '.$attribute['condition'].' '.$attribute['value'];
    }
  } else {
    echo("*");
  }

  echo('</code>');
  echo('</td>');
  echo('<td><code>');
  $assoc['entity_attribs'] = json_decode($assoc['entity_attribs'], TRUE);
  $assoc_entity_text = array();
  if (is_array($assoc['entity_attribs']))
  {
    foreach ($assoc['entity_attribs'] as $attribute)
    {
      echo($attribute['attrib'].' ');
      echo($attribute['condition'].' ');
      echo($attribute['value']);
      echo('<br />');
      $assoc_entity_text[] = $attribute['attrib'].' '.$attribute['condition'].' '.$attribute['value'];
    }
  } else {
    echo("*");
  }
  echo '</code></td>';
  echo '
   <td style="text-align: right;">
     <a href="#assoc_modal_',$assoc['group_assoc_id'],'" data-toggle="modal"><i class="oicon-pencil"></i></a>
     <a href="#assoc_del_modal_',$assoc['group_assoc_id'],'" data-toggle="modal"><i class="oicon-minus-circle"></i></a></td>';

  // Print associations edit modal for this association.

?>

<div id="assoc_del_modal_<?php echo $assoc['group_assoc_id']; ?>" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="delete_group" aria-hidden="true">
 <form id="edit" name="edit" method="post" class="form" action="">
  <input type="hidden" name="assoc_id" value="<?php echo $assoc['group_assoc_id']; ?>">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel"><i class="oicon-minus-circle"></i> 删除关联规则 <?php echo($assoc['group_assoc_id']); ?></h3>
  </div>
  <div class="modal-body">

  <span class="help-block">该操作将删除选定的关联规则.</span>
  <fieldset>
    <div class="control-group">
      <label class="control-label" for="confirm">
        Confirm
      </label>
      <div class="controls">
        <label class="checkbox">
          <input type="checkbox" name="confirm" value="confirm" onchange="javascript: showWarning<?php echo $assoc['group_assoc_id']; ?>(this.checked);" />
          是的, 请删除该关联规则!
        </label>

        <script type="text/javascript">
        function showWarning<?php echo $assoc['group_assoc_id']; ?>(checked) {
          if (checked) { $('#delete_button<?php echo $assoc['group_assoc_id']; ?>').removeAttr('disabled'); } else { $('#delete_button<?php echo $assoc['group_assoc_id']; ?>').attr('disabled', 'disabled'); }
        }
      </script>
      </div>
    </div>
  </fieldset>

        <div class="alert alert-message alert-danger" id="warning" style="display:none;">
    <h4 class="alert-heading"><i class="icon-warning-sign"></i> 警告!</h4>
    您确定需要删除该关联警报?
  </div>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
    <button id="delete_button<?php echo $assoc['group_assoc_id']; ?>" type="submit" class="btn btn-danger" name="submit" value="delete_assoc" disabled><i class="icon-trash icon-white"></i> 删除关联</button>
  </div>
 </form>
</div>

<div id="assoc_modal_<?php echo $assoc['group_assoc_id']; ?>" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
 <form id="edit" name="edit" method="post" class="form" action="">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel"><i class="oicon-sql-join-inner"></i> 编辑关联条件</h3>
  </div>
  <div class="modal-body">

  <input type="hidden" name="assoc_id" value="<?php echo $assoc['group_assoc_id']; ?>">
  <span class="help-block">请在编辑该部分时多加注意.</span>

  <fieldset>
    <div class="control-group">
      <label>设备匹配</label>
      <div class="controls">
        <textarea class="col-md-12" rows="4" name="assoc_device_conditions"><?php echo(htmlentities(implode("\n", $assoc_dev_text))); ?></textarea>
      </div>
    </div>

    <div class="control-group">
      <label>实体匹配</label>
      <div class="controls">
        <textarea class="col-md-12" rows="4" name="assoc_entity_conditions"><?php echo(htmlentities(implode("\n", $assoc_entity_text))); ?></textarea>
      </div>
    </div>
  </fieldset>

  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
    <button type="submit" class="btn btn-primary" name="submit" value="assoc_conditions"><i class="icon-ok icon-white"></i> 保存修改</button>
  </div>
 </form>
</div>

<?php

  echo '</tr>';
}

  echo '        </table>';
  echo '      </div>';
  echo '    </div>';
  echo '  </div>';
  echo '</div>';

  echo '<div class="row">';
  echo '  <div class="col-md-12">';

  $members = dbFetchRows("SELECT * FROM `group_table` WHERE `group_id` = ?", array($vars['group_id']));

  $list = array('device_id' => 1, 'entity_id' => 1);

  echo('<table class="table table-condensed table-bordered table-striped table-rounded table-hover">
  <thead>
    <tr>
      <th style="width: 1px;"></th>
      <th style="width: 1px;"></th>');
      // No table id
      //<th style="width: 5%;">Id</th>');

  if ($list['device_id'])     { echo('      <th style="width: 15%">设备</th>'); }
  if ($list['group_id'])      { echo('      <th style="min-width: 15%;">分组</th>'); }
  if ($list['entity_type'])   { echo('      <th style="width: 10%">类型</th>'); }
  if ($list['entity_id'])     { echo('      <th style="">实体</th>'); }

  echo '
    </tr>
  </thead>
  <tbody>'.PHP_EOL;

  foreach ($members as $member)
  {

    // Get the entity array using the cache
    $entity = get_entity_by_id_cache($member['entity_type'], $member['entity_id']);

    // Get the device array using the cache
    $device = device_by_id_cache($member['device_id']);

    // Get the entity_name.
    ### FIXME - This is probably duplicated effort from above. We should pass it $entity
    $entity_name = entity_name($member['entity_type'], $entity);

    echo('<tr class="'.$entity['html_row_class'].'" style="cursor: pointer;">');

    echo('<td style="width: 1px; background-color: '.$entity['table_tab_colour'].'; margin: 0px; padding: 0px"></td>');
    echo('<td style="width: 1px;"></td>');

    // If we know the device, don't show the device
    if ($list['device_id'])
    {
      echo('<td><span class="entity-title">'.generate_device_link($device).'</span></td>');
    }

    // If we're showing all entity types, print the entity type here
    if ($list['entity_type']) { echo('<td>'.nicecase($member['entity_type']).'</td>'); }

    // PRint a link to the entity
    if ($list['entity_id'])
    {
      echo('<td><span class="entity-title">'.generate_entity_link($member['entity_type'], $member['entity_id']).'</span></td>');
    }

    echo('</tr>');

  }

  echo '  </tbody>'.PHP_EOL;
  echo '</table>'.PHP_EOL;

 }

  echo '  </div>';
  echo '</div>';

?>

<div id="delete_group_modal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="delete_group" aria-hidden="true">
 <form id="edit" name="edit" method="post" class="form" action="<?php echo(generate_url(array('page' => 'groups'))); ?>">
  <input type="hidden" name="group_id" value="<?php echo($group['group_id']); ?>">

  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel"><i class="oicon-minus-circle"></i> 删除分组 <?php echo($group['group_name']); ?></h3>
  </div>
  <div class="modal-body">

  <span class="help-block">这将完全删除组和所有关联.</span>
  <fieldset>
    <div class="control-group">
      <label class="control-label" for="confirm">
        <h4>确定</h4>
      </label>
      <div class="controls">
        <label class="checkbox">
          <input type="checkbox" name="confirm" value="confirm" onchange="javascript: showWarning(this.checked);" />
          是的, 请删除该组.
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
    <h4 class="alert-heading"><i class="icon-warning-sign"></i> 警告!</h4>
    这种检查程序和关联将彻底删除!
  </div>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
    <button id="delete_button" type="submit" class="btn btn-danger" name="submit" value="delete_group" disabled><i class="icon-trash icon-white"></i> 删除分组</button>
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

  <span class="help-block">请小心编辑在这里.</span>

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

<!-- Edit group -->

<div id="edit_group_modal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
 <form id="edit" name="edit" method="post" class="form" action="">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel"><i class="oicon-sql-join-inner"></i> 编辑组详情</h3>
  </div>
  <div class="modal-body">

  <input type="hidden" name="group_id" value="<?php echo $group['group_id']; ?>">

  <fieldset>

    <div class="control-group">
      <label class="control-label" for="group_name">组名</label>
      <div class="controls">
        <input type=text name="group_name" size="32" disabled value="<?php echo($group['group_name']); ?>" placeholder="组名"/>
      </div>
    </div>

    <div class="control-group">
      <label class="control-label" for="group_descr">概述</label>
      <div class="controls">
        <textarea class="form-control col-md-12" name="group_descr" rows="3" placeholder="分组信息."/><?php echo(htmlspecialchars($group['group_descr'])); ?></textarea>
      </div>
    </div>

  </fieldset>

  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
    <button type="submit" class="btn btn-primary" name="submit" value="group_details"><i class="icon-ok icon-white"></i> 保存修改</button>
  </div>
 </form>
</div>

