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

if ($_SESSION['userlevel'] == 10) // Admin page only
{

?>

<div class="row">
  <div class="col-md-12">
    <div class="well info_box">
      <div class="title"><a href="<?php echo(generate_url(array('page' => 'device', 'device' => $device['device_id'], 'tab' => 'perf'))); ?>">
        <i class="oicon-clock"></i> 持续时间</a></div>
      <div class="content">

<?php
  $ptime = dbFetchRow('SELECT * FROM `devices_perftimes` WHERE `operation` = "poll" AND `device_id` = ? ORDER BY `start` DESC LIMIT 1', array($device['device_id']));

  echo "最后一次轮询: <b>" . format_unixtime($ptime['start']) .'</b> (took '.$ptime['duration'].'s) - <a href="' . generate_url(array('page' => 'device', 'device' => $device['device_id'], 'tab' => 'perf')) . '">详情</a><p />';

  $dtime = dbFetchRow('SELECT * FROM `devices_perftimes` WHERE `operation` = "discover" AND `device_id` = ? ORDER BY `start` DESC LIMIT 1', array($device['device_id']));

  echo "最后一次发现: <b>" . format_unixtime($dtime['start']) .'</b> (took '.$dtime['duration'].'s) - <a href="' . generate_url(array('page' => 'device', 'device' => $device['device_id'], 'tab' => 'perf')) . '">详情</a><p />';
?>

      </div>
    </div>

    <div class="well info_box">
      <div class="title"><a href="<?php echo(generate_url(array('page' => 'device', 'device' => $device['device_id'], 'tab' => 'showconfig'))); ?>">
        <i class="oicon-blocks"></i> RANCID</a></div>
      <div class="content">
<?php
  if (count($config['rancid_configs']))
  {
    $device_config_file = get_rancid_filename($device['hostname'], 1);

    echo('<p />');

    if ($device_config_file)
    {
      print_success("发现设备配置文件; 7级以上的用户将可以查看.");
    } else {
      print_warning("未发现设备配置文件.");
    }
  } else {
    print_warning("没有任何RANCID的目录配置.");
  }
?>
      </div>
    </div>

    <div class="well info_box">
      <div class="title"><a href="<?php echo(generate_url(array('page' => 'device', 'device' => $device['device_id'], 'tab' => 'latency'))); ?>">
        <i class="oicon-blocks"></i> Smokeping</a></div>
      <div class="content">
<?php
  if ($config['smokeping']['dir'] != '')
  {
    $smokeping_files = get_smokeping_files(1);

    echo('<p />');

    if ($smokeping_files['incoming'][$device['hostname']])
    {
      print_success("RRD发现进向流量延迟.");
    } else {
      print_error("RRD未发现进向流量延迟.");
    }

    if ($smokeping_files['outgoing'][$device['hostname']])
    {
      print_success("RRD发现出向流量延迟.");
    } else {
      print_error("RRD未发现出向流量延迟.");
    }
  } else {
    print_warning("没有配置Smokeping目录.");
  }
?>
      </div>
    </div>
  </div>

</div>

    <div class="well info_box">
      <div class="title"><a href="<?php echo(generate_url(array('page' => 'device', 'device' => $device['device_id'], 'tab' => 'graphs'))); ?>">
        <i class="oicon-blocks"></i> 设备图形</a></div>
      <div class="content">

        <table class="table table-rounded table-bordered table-striped">
        <tr><th>图形类型</th><th style="width: 80px;">具有文件</th><th style="width: 80px;">具有数组</th><th style="width: 80px;">启用</th></tr>
<?php
  foreach ($device['graphs'] as $graph_entry)
  {
    echo('<tr><td>'.$graph_entry['graph'].'</td>');

    if (is_file('includes/graphs/device/'.$graph_entry['graph'].'.inc.php'))
    { echo('<td><i class="icon-ok-sign green"></i></td>'); } else { echo('<td><i class="icon-remove-sign red"></i></td>'); }

    if (is_array($config['graph_types']['device'][$graph_entry['graph']]))
    { echo('<td><i class="icon-ok-sign green"></i></td>'); } else { echo('<td><i class="icon-remove-sign red"></i></td>'); }

    if ($graph_entry['enabled'])
    { echo('<td><i class="icon-ok-sign green"></i></td>'); } else { echo('<td><i class="icon-remove-sign red"></i></td>'); }

    echo('<td>'.print_r($config['graph_types']['device'][$graph_entry['graph']], TRUE).'</td>');

    echo('</tr>');
  }
?>
        </table>
      </div>
    <div class="well info_box">
<?php

print_vars($device);

?>
    </div>
    </div>
  </div>

<?php
}
else
{
  include("includes/error-no-perm.inc.php");
}

// EOF
