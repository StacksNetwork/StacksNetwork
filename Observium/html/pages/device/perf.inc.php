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

?>
        <img src="graph.php?type=device_poller_perf&device=<?php echo($device['device_id']) ?>&operation=poll&width=1095&height=150&from=<?php echo($config['time']['week']); ?>&to=<?php echo($config['time']['now']); ?>" />

<div class="row">
  <div class="col-md-6">
    <div class="well info_box">
      <div class="title">
        <i class="oicon-blocks"></i> 模块属性</div>
      <div class="content">

<table class="table table-hover table-striped table-bordered table-condensed table-rounded">
  <thead>
    <tr>
      <th>模块</th>
      <th colspan="2">Duration</th>
    </tr>
  </thead>
  <tbody>
<?php

arsort($device['state']['poller_mod_perf']);

foreach ($device['state']['poller_mod_perf'] as $module => $time)
{
 if ($time > 0.001)
 {

   $perc = round($time / $device['last_polled_timetaken'] * 100, 2, 2);

  echo('    <tr>
      <td>'.$module.'</td>
      <td>'.$time.'s</td>
      <td>'.$perc.'%</td>
    </tr>');
  }
}

?>
      </tbody>
    </table>
  </div>
</div>
</div>

<div class="col-md-6">
    <div class="well info_box">
      <div class="title">
        <i class="oicon-blocks"></i> 整体性能</div>
      <div class="content">

<table class="table table-hover table-striped table-bordered table-condensed table-rounded">
  <thead>
    <tr>
      <th>时间</th>
      <th>持续时间</th>
    </tr>
  </thead>
  <tbody>
<?php

$times = dbFetchRows("SELECT * FROM `devices_perftimes` WHERE `operation` = 'poll' AND `device_id` = ? ORDER BY `start` DESC LIMIT 100", array($device['device_id']));

foreach ($times as $time)
{

  echo('    <tr>
      <td>'.format_unixtime($time['start']).'</td>
      <td>'.$time['duration'].'s</td>
    </tr>');

}

?>
  </tbody>
</table>
</div>
<div class="col-md-6">

<h4  style="margin-bottom: 10px;">发现时间</h4>

<table class="table table-hover table-striped table-bordered table-condensed table-rounded">
  <thead>
    <tr>
      <th>时间</th>
      <th>持续时间</th>
      <th>状态</th>
    </tr>
  </thead>
  <tbody>
<?php

$times = dbFetchRows('SELECT * FROM `devices_perftimes` WHERE `operation` = "discover" AND `device_id` = ? ORDER BY `start` DESC LIMIT 100', array($device['device_id']));

foreach ($times as $time)
{

  echo('    <tr>
      <td>'.format_unixtime($time['start']).'</td>
      <td>'.$time['duration'].'s</td>
      <td></td>
    </tr>');

}

?>
  </tbody>
</table>

</div>
</div>
<?php
// EOF
