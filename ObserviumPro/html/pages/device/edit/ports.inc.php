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

if ($vars['ignoreport'])
{
  if ($_SESSION['userlevel'] == '10')
  {
    include("includes/port-edit.inc.php");
  }
}

if ($updated && $update_message)
{
  print_message($update_message);
} elseif ($update_message) {
  print_error($update_message);
}

?>

<form id="ignoreport" name="ignoreport" method="post" action="" class="form form-inline">
<fieldset>
  <legend>端口属性</legend>

  <input type="hidden" name="ignoreport" value="yes">
  <input type="hidden" name="device" value="<?php echo $device['device_id']; ?>">

<table class="table table-striped table-bordered table-condensed table-rounded">
  <thead>
    <tr>
      <th style="width: 70px;">if索引</th>
      <th style="width: 200px;">端口</th>
      <th style="width: 145px;">if类型/状态</th>
      <th style="width: 110px;">轮询</th>
      <th style="width: 110px;">报警</th>
      <!-- <th style="width: 110px;">%阈值</th>   -->
      <!-- <th style="width: 110px;">BPS阈值</th> -->
      <!-- <th style="width: 110px;">PPS阈值</th> -->
      <th style="width: 110px;">64bit</th>
    </tr>
    <tr>
      <th><button class="btn btn-mini btn-primary" type="submit" value="Save" title="保存当前端口禁用/忽略设置"><i class="icon-ok icon-white"></i> 保存</button></th>
      <th><!-- <button class="btn btn-mini btn-danger" type="submit" value="Reset" id="form-reset" title="复位形式以前保存的设置"><i class="oicon-remove oicon-white"></i> 重置</button> --></th>
      <th><button class="btn btn-mini" type="submit" value="Alerted"  id="alerted-toggle" title="当前所有端口切换报警提醒">启用 & 异常</button>
          <button class="btn btn-mini" type="submit" value="Disabled" id="down-select"    title="禁用提醒当前所有下行端口">禁用</button></th>
      <th><button class="btn btn-mini" type="submit" value="Toggle"   id="disable-toggle" title="所有端口切换轮询">切换</button>
          <button class="btn btn-mini" type="submit" value="Select"   id="disable-select" title="禁用所有端口轮询">所有</button></th>
      <th><button class="btn btn-mini" type="submit" value="Toggle"   id="ignore-toggle"  title="触发报警的所有端口">切换</button>
          <button class="btn btn-mini" type="submit" value="Select"   id="ignore-select"  title="所有端口禁用报警">所有</button></th>
      <th></th>

<!--      <th></th>
      <th></th>
      <td></th> -->
    </tr>
  </thead>

<script>
$(document).ready(function() {
  $('#disable-toggle').click(function(event) {
    // invert selection on all disable buttons
    event.preventDefault();
    $('[id^="disabled_"]').each(function() {
      var id = $(this).attr('id');
      // get the interface number from the object name
      var port_id = id.split('_')[1];
      // find its corresponding checkbox and toggle it
      $('[id="disabled_' + port_id + '"]').bootstrapSwitch('toggleState');
    });
  });
  $('#ignore-toggle').click(function(event) {
    // invert selection on all ignore buttons
    event.preventDefault();
    $('[id^="ignore_"]').each(function() {
      var id = $(this).attr('id');
      // get the interface number from the object name
      var port_id = id.split('_')[1];
      // find its corresponding checkbox and toggle it
      $('[id="ignore_' + port_id + '"]').bootstrapSwitch('toggleState');
    });
  });
  $('#alerted-toggle').click(function(event) {
    // toggle ignore buttons for all ports which are in class red
    event.preventDefault();
    $('.error').each(function() {
      var name = $(this).attr('name');
      if (name) {
        // get the interface number from the object name
        var port_id = name.split('_')[1];
        // find its corresponding checkbox and toggle it
        $('[id="ignore_' + port_id + '"]').bootstrapSwitch('state', true);
      }
    });
  });

  $('#disable-select').click(function(event) {
    // select all disable buttons
    event.preventDefault();
    $('[id^="disabled_"]').bootstrapSwitch('state', true);
  });
  $('#ignore-select').click(function(event) {
    // select all ignore buttons
    event.preventDefault();
    $('[id^="ignore_"]').bootstrapSwitch('state', true);
  });
  $('#down-select').click(function(event) {
    // select ignore buttons for all ports which are down
    event.preventDefault();
    $('[name^="operstatus_"]').each(function() {
      var name = $(this).attr('name');
      var text = $(this).text();
      if (name && text == 'down' || name && text == 'lowerLayerDown') {
        // get the interface number from the object name
        var port_id = name.split('_')[1];
        // find its corresponding checkbox and toggle it
        $('[id="ignore_' + port_id + '"]').bootstrapSwitch('state', true);
      }
    });
  });

  $('#form-reset').click(function(event) {
    // reset objects in the form to their previous values
    event.preventDefault();
    $('#ignoreport')[0].reset();
  });
});
</script>

<?php

foreach (dbFetchRows("SELECT * FROM `ports` WHERE `deleted` = '0' AND `device_id` = ? ORDER BY `ifIndex` ", array($device['device_id'])) as $port)
{
  humanize_port($port);

  ///print_vars($port);

  echo('<tr class="'.$port['row_class'].'">');
  echo("<td>". $port['ifIndex']."</td>");
  echo("<td>".rewrite_ifname($port['label'])."<br />".htmlentities($port['ifAlias'])."</td>");
  echo("<td>".$port['human_type']."<br />");

  echo('<span>'.htmlentities($port['admin_status']).'</span> / <span name="operstatus_'.$port['port_id'].'" class="'.$port['row_class'].'">'. htmlentities($port['ifOperStatus']) .'</span></td>');

  echo('<td style="vertical-align: middle;">');
  echo("<input type=checkbox data-toggle='switch-revert' id='disabled_".$port['port_id']."' name='disabled_".$port['port_id']."'".($port['disabled'] ? ' checked' : '').">");
  echo("<input type=hidden name='olddis_".$port['port_id']."' value=".($port['disabled'] ? 1 : 0).">");
  echo("</td>");

  echo('<td style="vertical-align: middle;">');
  echo("<input type=checkbox data-toggle='switch-revert' id='ignore_".$port['port_id']."' name='ignore_".$port['port_id']."'".($port['ignore'] ? ' checked' : '').">");
  echo("<input type=hidden name='oldign_".$port['port_id']."' value=".($port['ignore'] ? 1 : 0).">");
  echo("</td>");

#  echo('<td>  <input class="input-mini" name="threshold_perc_in-'.$port['port_id'].'" size="3" value="'.$port['threshold_perc_in'].'"></input>');
#  echo('<br /><input class="input-mini" name="threshold_perc_out-'.$port['port_id'].'" size="3" value="'.$port['threshold_perc_out'].'"></input></td>');
#  echo('<td>  <input class="input-mini" name="threshold_bps_in-'.$port['port_id'].'" size="3" value="'.$port['threshold_bps_in'].'"></input>');
#  echo('<br /><input class="input-mini" name="threshold_bps_out-'.$port['port_id'].'" size="3" value="'.$port['threshold_bps_out'].'"></input></td>');
#  echo('<td>  <input class="input-mini" name="threshold_pps_in-'.$port['port_id'].'" size="3" value="'.$port['threshold_pps_in'].'"></input>');
#  echo('<br /><input class="input-mini" name="threshold_pps_out-'.$port['port_id'].'" size="3" value="'.$port['threshold_pps_out'].'"></input></td>');

  echo '<td style="vertical-align: middle;">';
  if ($port['port_64bit'] == 1)
  {
    echo '<span class="label label-success">64bit</span>';
  }
  else if ($port['port_64bit'] == 0)
  {
    echo '<span class="label label-warning">32bit</span>';
  } else {
    echo '<span class="label">未选中</span>';
  }

  echo '</td></tr>'.PHP_EOL;

  $row++;
}
?>
</table>
</fieldset>
  <div class="form-actions">
    <button type="submit" class="btn btn-primary" name="submit" value="save"><i class="icon-ok icon-white"></i> 保存修改</button>
  </div>
</form>
<?php

// EOF
