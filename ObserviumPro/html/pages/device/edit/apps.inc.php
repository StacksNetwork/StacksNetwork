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

print_warning("这个页面允许你禁用此设备的应用, 以前启用Observium的应用轮询系统的自动检测.");

# Load our list of available applications
if ($handle = opendir($config['install_dir'] . "/includes/polling/applications/"))
{
  while (false !== ($file = readdir($handle)))
  {
    if ($file != "." && $file != ".." && strstr($file, ".inc.php"))
    {
      $applications[] = str_replace(".inc.php", "", $file);
    }
  }
  closedir($handle);
}

# Check if the form was POSTed
if ($_POST['device'])
{
  $updated = 0;
  $param[] = $device['device_id'];
  foreach (array_keys($_POST) as $key)
  {
    if (substr($key,0,4) == 'app_')
    {
      $param[] = substr($key,4);
      $enabled[] = substr($key,4);
      $replace[] = "?";
    }
  }

  if (count($enabled))
  {
    $updated += dbDelete('applications', "`device_id` = ? AND `app_type` NOT IN (".implode(",",$replace).")", $param);
  } else {
    $updated += dbDelete('applications', "`device_id` = ?", array($param));
  }

  foreach (dbFetchRows( "SELECT `app_type` FROM `applications` WHERE `device_id` = ?", array($device['device_id'])) as $row)
  {
    $app_in_db[] = $row['app_type'];
  }

  foreach ($enabled as $app)
  {
    if (!in_array($app,$app_in_db))
    {
      $updated += dbInsert(array('device_id' => $device['device_id'], 'app_type' => $app), 'applications');
    }
  }

  if ($updated)
  {
    print_message("应用程序更新!");
  } else {
    print_message("无变化.");
  }
}

# Show list of apps with checkboxes

$apps_enabled = dbFetchRows("SELECT * from `applications` WHERE `device_id` = ? ORDER BY app_type", array($device['device_id']));
if (count($apps_enabled))
{
  foreach ($apps_enabled as $application)
  {
    $app_enabled[] = $application['app_type'];
  }
?>

<form id='appedit' name='appedit' method='post' action='' class='form-inline'>
  <fieldset>
  <legend>设备属性</legend>

  <input type=hidden name=device value='<?php echo $device['device_id'];?>'>
<table class='table table-striped table-bordered table-condensed table-rounded'>
  <thead>
    <tr align=center>
      <th width=100>启用</th>
      <th>应用程序</th>
    </tr>
  </thead>
  <tbody>

<?php

foreach ($applications as $app)
{
  if (in_array($app,$app_enabled))
  {
    echo("    <tr>");
    echo("      <td align=center>");
    echo("        <input type=checkbox data-toggle='switch-mini' data-on-color='primary' data-off-color='danger' checked=1 name='app_". $app ."'>");
    echo("      </td>");
    echo("      <td align=left>". nicecase($app) . "</td>");
    echo("    </tr>
");

    $row++;
  }
}
?>
  </tbody>
</table>

  <div class="form-actions">
    <button type="submit" class="btn btn-primary" name="submit" value="save"><i class="icon-ok icon-white"></i> 保存变更</button>
  </div>

</form>
<?php
} else {
  print_error("这个设备没有发现应用程序.");
}
// EOF
