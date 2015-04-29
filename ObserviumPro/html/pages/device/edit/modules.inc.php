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

include($config['install_dir'] . '/includes/polling/functions.inc.php');

if($vars['toggle_poller'] && isset($config['poller_modules'][$vars['toggle_poller']]))
{
  $module = $vars['toggle_poller'];
  if (isset($attribs['poll_'.$module]) && $attribs['poll_'.$module] != $config['poller_modules'][$module])
  {
    del_dev_attrib($device, 'poll_' . $module);
  } elseif ($config['poller_modules'][$module] == 0) {
    set_dev_attrib($device, 'poll_' . $module, "1");
  } else {
    set_dev_attrib($device, 'poll_' . $module, "0");
  }
  $attribs = get_dev_attribs($device['device_id']);
}

if($vars['toggle_ports'] && isset($config[$vars['toggle_ports']]) && strpos($vars['toggle_ports'], 'enable_ports_') === 0)
{
  $module = $vars['toggle_ports'];
  if (isset($attribs[$module]) && $attribs[$module] != $config[$module])
  {
    del_dev_attrib($device, $module);
  } elseif ($config[$module] == 0) {
    set_dev_attrib($device, $module, "1");
  } else {
    set_dev_attrib($device, $module, "0");
  }
  $attribs = get_dev_attribs($device['device_id']);
}

if($vars['toggle_discovery'] && isset($config['discovery_modules'][$vars['toggle_discovery']]))
{
  $module = $vars['toggle_discovery'];
  if (isset($attribs['discover_'.$module]) && $attribs['discover_'.$module] != $config['discovery_modules'][$module])
  {
    del_dev_attrib($device, 'discover_' . $module);
  } elseif ($config['discovery_modules'][$module] == 0) {
    set_dev_attrib($device, 'discover_' . $module, "1");
  } else {
    set_dev_attrib($device, 'discover_' . $module, "0");
  }
  $attribs = get_dev_attribs($device['device_id']);
}
?>

<div class="row"> <!-- begin row -->

  <div class="col-md-6"> <!-- begin poller options -->

<fieldset>
  <legend>轮询模块</legend>
</fieldset>

<table class="table table-bordered table-striped table-condensed table-rounded">
  <thead>
    <tr>
      <th>模块</th>
      <th style="width: 80px;">全局</th>
      <th style="width: 80px;">设备</th>
      <th style="width: 80px;"></th>
    </tr>
  </thead>
  <tbody>

<?php
foreach ($config['poller_modules'] as $module => $module_status)
{
  $attrib_set = isset($attribs['poll_'.$module]);

  echo('<tr><td><strong>'.$module.'</strong></td><td>');
  echo(($module_status ? '<span class="text-success">enabled</span>' : '<span class="text-danger">disabled</span>'));
  echo('</td><td>');

  $attrib_status = '<span class="text-danger">disabled</span>'; $toggle = '启用';
  $btn_class = 'btn-success'; $btn_toggle = 'value="Toggle"';
  if (poller_module_excluded($device, $module))
  {
    $attrib_status = '<span class="text-disabled">excluded</span>'; $toggle = "排除";
    $btn_class = ''; $btn_toggle = 'disabled="disabled"';
  }
  elseif (($attrib_set && $attribs['poll_'.$module]) || (!$attrib_set && $module_status))
  {
    $attrib_status = '<span class="text-success">enabled</span>'; $toggle = "禁用"; $btn_class = "btn-danger";
  }

  echo($attrib_status.'</td><td>');

  echo('<form id="toggle_poller" name="toggle_poller" method="post" action="">
  <input type="hidden" name="toggle_poller" value="'.$module.'">
  <button type="submit" class="btn btn-mini '.$btn_class.'" name="提交" '.$btn_toggle.'>'.$toggle.'</button>
</form>');

  echo('</td></tr>');
}
?>
  </tbody>
</table>

</div> <!-- end poller options -->

<div class="col-md-6"> <!-- begin ports options -->

<fieldset>
  <legend>端口轮询方案</legend>
</fieldset>

<table class="table table-bordered table-striped table-condensed table-rounded">
  <thead>
    <tr>
      <th>模块</th>
      <th style="width: 80px;">全局</th>
      <th style="width: 80px;">设备</th>
      <th style="width: 80px;"></th>
    </tr>
  </thead>
  <tbody>

<?php
foreach (array_keys($config) as $module)
{
  if (strpos($module, 'enable_ports_') === FALSE) { continue; }

  $module_status = $config[$module];
  $attrib_set = isset($attribs[$module]);

  echo('<tr><td><strong>'.str_replace('enable_ports_', '', $module).'</strong></td><td>');
  echo(($module_status ? '<span class="text-success">enabled</span>' : '<span class="text-danger">disabled</span>'));
  echo('</td><td>');

  $attrib_status = '<span class="text-danger">disabled</span>'; $toggle = 'Enable';
  $btn_class = 'btn-success'; $btn_toggle = 'value="Toggle"';
  if ($module == 'enable_ports_junoseatmvp' && $device['os'] != 'junose') /// FIXME. see here includes/discovery/junose-atm-vp.inc.php
  {
    $attrib_status = '<span class="text-disabled">excluded</span>'; $toggle = "Excluded";
    $btn_class = ''; $btn_toggle = 'disabled="disabled"';
  }
  elseif (($attrib_set && $attribs[$module]) || (!$attrib_set && $module_status))
  {
    $attrib_status = '<span class="text-success">enabled</span>'; $toggle = "Disable"; $btn_class = "btn-danger";
  }

  echo($attrib_status . '</td><td>');

  echo('<form id="toggle_ports" name="toggle_ports" method="POST" action="">
  <input type="hidden" name="toggle_ports" value="'.$module.'">
  <button type="submit" class="btn btn-mini '.$btn_class.'" name="Submit" '.$btn_toggle.'>'.$toggle.'</button>
</form>');

  echo('</td></tr>');
}
?>
  </tbody>
</table>

</div> <!-- end ports options -->

<div class="col-md-6"> <!-- begin discovery options -->

<fieldset>
  <legend>自动发现模块</legend>
</fieldset>

<table class="table table-bordered table-striped table-condensed table-rounded">
  <thead>
    <tr>
      <th>模块</th>
      <th style="width: 80px;">全局</th>
      <th style="width: 80px;">设备</th>
      <th style="width: 80px;"></th>
    </tr>
  </thead>
  <tbody>

<?php
foreach ($config['discovery_modules'] as $module => $module_status)
{
  $attrib_set = isset($attribs['discover_'.$module]);

  echo('<tr><td><strong>'.$module.'</strong></td><td>');
  echo(($module_status ? '<span class="text-success">enabled</span>' : '<span class="text-danger">disabled</span>'));
  echo('</td><td>');

  $attrib_status = '<span class="text-danger">disabled</span>'; $toggle = 'Enable';
  $btn_class = 'btn-success'; $btn_toggle = 'value="Toggle"';
  if (($attrib_set && $attribs['discover_'.$module]) || (!$attrib_set && $module_status))
  {
    $attrib_status = '<span class="text-success">enabled</span>'; $toggle = "Disable"; $btn_class = "btn-danger";
  }

  echo($attrib_status . '</td><td>');

  echo('<form id="toggle_discovery" name="toggle_discovery" method="post" action="">
  <input type="hidden" name="toggle_discovery" value="'.$module.'">
  <button type="submit" class="btn btn-mini '.$btn_class.'" name="Submit" '.$btn_toggle.'>'.$toggle.'</button>
</form>');

  echo('</td></tr>');
}
?>
  </tbody>
</table>

</div> <!-- end discovery options -->

  </div> <!-- end row -->
<?php

// EOF
