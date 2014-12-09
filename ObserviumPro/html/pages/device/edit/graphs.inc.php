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

print_message("这个页面允许您启用或禁用某些图的一个设备检测.");

$graphs_db = array();
foreach (dbFetchRows("SELECT `graph`,`enabled` FROM `device_graphs` WHERE `device_id` = ?", array($device['device_id'])) as $entry)
{
  $graph   = $entry['graph'];
  $section = $config['graph_types']['device'][$graph]['section'];
  $graphs_db[$graph] = (bool)$entry['enabled'];
  // Another array sorted by sections
  $graphs_sections[$section][$graph] = (bool)$entry['enabled'];
}

$graph = $_POST['toggle_graph'];
if ($graph && isset($graphs_db[$graph]) &&
    !in_array($config['graph_types']['device'][$graph]['section'], array('poller', 'system')))
{
  $value = (int)!$graphs_db[$graph]; // Toggle current 'enabled' value
  $updated = dbUpdate(array('enabled' => $value), 'device_graphs', '`device_id` = ? AND `graph` = ?', array($device['device_id'], $graph));
  if ($updated)
  {
    print_success("Graph '$graph' ".($value ? 'enabled' : 'disabled').'.');
    $graphs_sections[$config['graph_types']['device'][$graph]['section']][$graph] = (bool)$value;
  }
}

?>

<div class="row"> <!-- begin row -->

  <div class="col-md-6"> <!-- begin poller options -->

<fieldset>
  <legend>设备图像</legend>
</fieldset>

<table class="table table-bordered table-striped table-condensed table-rounded">
  <thead>
    <tr>
      <th>名称</th>
      <th>说明</th>
      <th>部分</th>
      <th style="width: 80;">状态</th>
      <th style="width: 80;"></th>
    </tr>
  </thead>
  <tbody>

<?php

foreach ($graphs_sections as $section => $entry)
{
  foreach ($entry as $graph => $enabled)
  {
    echo('<tr><td><strong>'.$graph.'</strong></td><td>');
    echo($config['graph_types']['device'][$graph]['descr'].'</td><td>');
    echo(nicecase($section).'</td><td>');

    if (!$enabled)
    {
      $attrib_status = '<span class="text-danger">disabled</span>';
      $toggle = '启用';
      $btn_class = 'btn-success';
    } else {
      $attrib_status = '<span class="text-success">enabled</span>';
      $toggle = "禁用";
      $btn_class = "btn-danger";
    }

    echo($attrib_status.'</td><td>');

    if (!in_array($section, array('poller', 'system')))
    {
      echo('<form id="toggle_graph" name="toggle_graph" style="margin: 0px;" method="post" action="">
      <input type="hidden" name="toggle_graph" value="'.$graph.'">
      <button type="submit" class="btn btn-mini '.$btn_class.'" name="Submit">'.$toggle.'</button></form>');
    } else {
      echo('<span class="btn btn-mini disabled">请求</span>');
    }

    echo('</td></tr>');
  }
}
?>
  </tbody>
</table>

</div> <!-- end poller options -->

  </div> <!-- end row -->
</div> <!-- end container -->
<?php

// EOF
