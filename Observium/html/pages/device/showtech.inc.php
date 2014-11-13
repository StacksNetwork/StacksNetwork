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

if ($_SESSION['userlevel'] == "10") // Admin page only
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

echo "最近轮询: <b>" . format_unixtime($ptime['start']) .'</b> (took '.$ptime['duration'].'s) - <a href="' . generate_url(array('page' => 'device', 'device' => $device['device_id'], 'tab' => 'perf')) . '">详情</a><p />';

$dtime = dbFetchRow('SELECT * FROM `devices_perftimes` WHERE `operation` = "discover" AND `device_id` = ? ORDER BY `start` DESC LIMIT 1', array($device['device_id']));

echo "最新发现: <b>" . format_unixtime($dtime['start']) .'</b> (took '.$dtime['duration'].'s) - <a href="' . generate_url(array('page' => 'device', 'device' => $device['device_id'], 'tab' => 'perf')) . '">详情</a><p />';

?>

      </div>
    </div>

    <div class="well info_box">
      <div class="title"><a href="<?php echo(generate_url(array('page' => 'device', 'device' => $device['device_id'], 'tab' => 'showconfig'))); ?>">
        <i class="oicon-blocks"></i> 过期</a></div>
      <div class="content">
<?php
    $device_config_file = get_rancid_filename($device['hostname'], 1);

    echo('<p />');

    if ($device_config_file)
    {
      print_success("对设备的配置文件被发现; 将显示为7级或更高的用户.");
    } else {
      print_warning("设备配置文件没有找到.");
    }
?>
      </div>
    </div>
<?php

/*
    <div class="well info_box">
      <div class="title"><a href="<?php echo(generate_url(array('page' => 'device', 'device' => $device['device_id'], 'tab' => 'latency'))); ?>">
        <i class="oicon-blocks"></i> Smokeping</a></div>
      <div class="content">
// FIXME TBD (but smokeping detection logic is not in a function currently, but in device.inc.php and possibly other files)
      </div>
    </div>
  </div>
*/
?>

</div>

    <div class="well info_box">
      <div class="title"><a href="<?php echo(generate_url(array('page' => 'device', 'device' => $device['device_id'], 'tab' => 'graphs'))); ?>">
        <i class="oicon-blocks"></i> 设备流量图</a></div>
      <div class="content">

        <table class="table table-rounded table-bordered table-striped">
        <tr><th>流量图类型</th><th style="width: 80px;">包含文件</th><th style="width: 80px;">包含阵列</th></tr>
<?php
  foreach(dbFetchRows("SELECT * FROM device_graphs WHERE device_id = ? ORDER BY graph", array($device['device_id'])) as $graph_entry)
  {
    echo('<tr><td>'.$graph_entry['graph'].'</td>');

    if (is_file('includes/graphs/device/'.$graph_entry['graph'].'.inc.php'))
    { echo('<td><i class="icon-ok-sign green"></i></td>'); } else { echo('<td><i class="icon-remove-sign red"></i></td>'); }

    if (is_array($config['graph_types']['device'][$graph_entry['graph']]))
    { echo('<td><i class="icon-ok-sign green"></i></td>'); } else { echo('<td><i class="icon-remove-sign red"></i></td>'); }

    echo('<td>'.print_r($config['graph_types']['device'][$graph_entry['graph']], TRUE).'</td>');

    echo('</tr>');

  }
?>

        </table>
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
