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

if ($entry = get_alert_entry_by_id($vars['alert_entry']))
{

 if ($entry['device_id'] != $device['device_id']) { print_error("该警报内容ID不匹配这个设备.");
 } else {
  // Run actions

  if ($vars['submit'] == 'update-alert-entry')
  {

    if (isset($vars['ignore_until_ok']) && $vars['ignore_until_ok'] == 'on' && $entry['ignore_until_ok'] != '1')
    {
      $update_state['ignore_until_ok'] = '1';
    } elseif (!isset($vars['ignore_until_ok']) && $entry['ignore_until_ok'] != '0' ) {
      $update_state['ignore_until_ok'] = '0';
    }

    // 2019-12-05 23:30:00

    if (isset($vars['ignore_until']) && $vars['ignore_until_enable'] == 'on' )
    {
      $update_state['ignore_until'] = $vars['ignore_until'];
    } else {
      $update_state['ignore_until'] = array('NULL');
    }

    if (is_array($update_state))
    {
      $up_s = dbUpdate($update_state, 'alert_table', '`alert_table_id` =  ?', array($vars['alert_entry']));
    }

    // Refresh array because we've changed the database.
    $entry = get_alert_entry_by_id($vars['alert_entry']);
  }

  // End actions

  humanize_alert_entry($entry);

  $alert_rules = cache_alert_rules();
  $alert       = $alert_rules[$entry['alert_test_id']];
  $state       = json_decode($entry['state'], TRUE);
  $conditions  = json_decode($alert['conditions'], TRUE);
  $entity      = get_entity_by_id_cache($entry['entity_type'], $entry['entity_id']);

//  r($entry);
//  r($alert);

?>

<form id="update_alert_entry" name="update_alert_entry" method="post" action="">

<div class="row">
  <div class="col-md-4">
    <div class="widget">
      <div class="widget-header">
        <i class="oicon-bell"></i> <h3>报警详情</h3>
      </div>
      <div class="widget-content">
        <table class="table table-condensed table-bordered table-striped table-rounded">
          <tbody>
            <tr><th>类型</th><td><?php echo '<i class="' . $config['entities'][$alert['entity_type']]['icon'] . '"></i> ' . nicecase($entry['entity_type']); ?></td></tr>
            <tr><th>对象</th><td><?php echo generate_entity_link($entry['entity_type'], $entry['entity_id'], $entity['entity_name']); ?></td></tr>
            <tr><th>检测器</th><td><a href="<?php echo generate_url(array('page' => 'alert_check', 'alert_test_id' => $alert['alert_test_id'])); ?>"><?php echo $alert['alert_name']; ?></a></td></tr>
            <tr><th>错误信息</th><td><?php echo $alert['alert_message']; ?></td></tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <div class="col-md-4">
    <div class="widget">
      <div class="widget-header">
        <i class="oicon-time"></i> <h3>状态</h3>
      </div>
      <div class="widget-content">

        <table class="table table-condensed table-bordered table-striped table-rounded">
          <tr><th>状态</th><td><span class="<?php echo $entry['class']; ?>"><?php echo $entry['last_message']; ?></span></td></tr>
          <tr><th>最新监测</th><td><?php echo $entry['checked']; ?></span></td></tr>
          <tr><th>最新变化</th><td><?php echo $entry['changed']; ?></span></td></tr>
          <tr><th>最新报警</th><td><?php echo $entry['alerted']; ?></span></td></tr>
          <tr><th>最近恢复</th><td><?php echo $entry['recovered']; ?></span></td></tr>
        </table>
      </div>
    </div>
  </div>

  <div class="col-md-4">
    <div class="widget widget">
      <div class="widget-header">
        <i class="oicon-gear"></i> <h3>设置</h3>
      </div>
      <div class="widget-content">
        <table class="table table-condensed table-bordered table-striped table-rounded">
          <tr><th>忽略直至</th>
            <td>
              <div class="input-prepend" id="ignore_until" style="margin-bottom: 0;">
                <span class="add-on btn"><i data-time-icon="icon-time" data-date-icon="icon-calendar" class="icon-time"></i></span>
                <input type="text" style="width: 150px;" data-format="yyyy-MM-dd hh:mm:ss" name="ignore_until" id="ignore_until" value="<?php echo($entry['ignore_until'] ? $entry['ignore_until'] : ''); ?>">
              </div>
                <input type=checkbox name="ignore_until_enable" <?php echo($entry['ignore_until'] ? 'checked' : ''); ?>>
            </td>
          </tr>
          <tr><th>忽略设置完成</th>
            <td>
              <input type=checkbox data-toggle="switch-mini" data-on-color="danger" data-off-color="primary" name="ignore_until_ok" <?php echo($entry['ignore_until_ok'] ? 'checked' : ''); ?>>
            </td>
          </tr>
        </table>
        </div>
      </div>
      <button type="submit" style="margin: 5px;" class="btn btn-primary pull-right" name="submit" value="update-alert-entry"><i class="icon-ok icon-white"></i> 保存更改</button>
    </div>
  </div>
</form>

<script type="text/javascript">
      $(document).ready(function() {
        $('#ignore_until').datetimepicker({
          //pickSeconds: false,
          dateFormat: "MM-dd-yyyy",
          timeFormat: "HH:mm",
          dateTimeFormat: "MM-dd-yyyy HH:mm:ss"
         });
       });
</script>

<table class="table table-hover table-condensed table-bordered table-striped">

<tr><th>
<h4>可用性历史</h4>
</th></tr>

<tr><td>
<?php
  $graph_array['id']     = $entry['alert_table_id'];
  $graph_array['type']   = 'alert_status';
  print_graph_row($graph_array);
?>
</td></tr>
</table>

<?php
 }
} else {
  print_error("非常遗憾, 该警报内容ID似乎不存在于数据库中!");
}

// EOF
