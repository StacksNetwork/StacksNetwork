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

$query = 'SELECT * FROM `sensors`,`sensors-state` WHERE `sensors-state`.`sensor_id` = `sensors`.`sensor_id`
          AND `device_id` = ? ORDER BY `sensor_type`,`sensor_class`,`sensor_index`;';
$sensors = dbFetchRows($query, array($device['device_id']));

$warn_enable = FALSE; // For enable edit warn limits, set this to TRUE

if ($_POST['submit'] == "update-sensors" && $_SESSION['userlevel'] == '10')
{
  $did_update = FALSE;
  $update_array = array();
  foreach ($sensors as $sensor)
  {
    humanize_sensor($sensor);

    if (!$sensor['sensor_state'])
    {
      // Normal sensors
      $fields_switch = array('sensor_ignore', 'sensor_custom_limit');
      if ($warn_enable)
      {
        $fields_limit = array('sensor_limit', 'sensor_limit_warn', 'sensor_limit_low_warn', 'sensor_limit_low');
      } else {
        $fields_limit = array('sensor_limit', 'sensor_limit_low');
      }
    } else {
      // State sensors not allow edit limits
      $fields_switch = array('sensor_ignore');
      $fields_limit = array();
    }
    // Switch selectors
    foreach ($fields_switch as $field)
    {
      $_POST['sensors'][$sensor['sensor_id']][$field] = ($_POST['sensors'][$sensor['sensor_id']][$field] == 'on' ? '1' : '0');
      if ($_POST['sensors'][$sensor['sensor_id']][$field] != $sensor[$field])
      {
        $update_array[$field] = $_POST['sensors'][$sensor['sensor_id']][$field];
      }
    }

    // Limits
    if ($_POST['sensors'][$sensor['sensor_id']]['sensor_custom_limit'])
    {
      foreach ($fields_limit as $field)
      {
        $_POST['sensors'][$sensor['sensor_id']][$field] = (!is_numeric($_POST['sensors'][$sensor['sensor_id']][$field]) ? array('NULL') : (float)$_POST['sensors'][$sensor['sensor_id']][$field]);
        $sensor[$field] = (!is_numeric($sensor[$field]) ? array('NULL') : (float)$sensor[$field]);
        if ($_POST['sensors'][$sensor['sensor_id']][$field] !== $sensor[$field])
        {
          $update_array[$field] = $_POST['sensors'][$sensor['sensor_id']][$field];
        }
      }
    }

    if (count($update_array))
    {
      dbUpdate($update_array, 'sensors', '`sensor_id` = ?', array($sensor['sensor_id']));
      $msg = 'Sensor Limits updated (custom): '.mres($sensor['sensor_class']).' '.mres($sensor['sensor_type']).' '. mres($sensor['sensor_id']).' '.mres($sensor['sensor_descr']).' ';
      if ($update_array['sensor_limit_low']) { $msg .= '[L: '.$update_array['sensor_limit_low'].']'; }
      if ($update_array['sensor_limit_low_warn']) { $msg .= '[Lw: '.$update_array['sensor_limit_low_warn'].']'; }
      if ($update_array['sensor_limit_warn']) { $msg .= '[Hw: '.$update_array['sensor_limit_warn'].']'; }
      if ($update_array['sensor_limit']) { $msg .= '[H: '.$update_array['sensor_limit'].']'; }
      log_event($msg, $device, 'sensor', $sensor['sensor_id']);
      $did_update = TRUE;
    }
    unset($update_array);
  }

  // Query updated sensors array
  if ($did_update) { $sensors = dbFetchRows($query, array($device['device_id'])); }
}

//print_vars($_POST);

?>

<form id='update-sensors' name='update-sensors' method='post' action=''>
<fieldset>
  <legend>Sensor Properties</legend>

<table class="table table-bordered table-striped table-condensed">
  <thead>
    <tr>
      <th width="60">Index</th>
      <th width="120">MIB Type</th>
      <th width="100">Class</th>
      <th>Descr</th>
      <th width="60">Current</th>
      <th width="60">Min</th>
<?php if ($warn_enable) { ?>
      <th width="60" nowrap>Min Warn</th>
      <th width="60" nowrap>Max Warn</th>
<?php } ?>
      <th width="60">Max</th>
      <th width="50" nowrap>Custom Limits</th>
      <th width="50">Alerts</th>
    </tr>
  </thead>
  <tbody>

<?php
$row=1;
foreach ($sensors as $sensor)
{
  humanize_sensor($sensor);

  if ($sensor['sensor_state'])
  {
    $sensor_value = $sensor['state_name'];
    $limit_class = 'input-mini hidden';
    $limit_switch_class = 'switch switch-mini deactivate';
  } else {
    $sensor_value = $sensor['human_value'];
    $limit_class = 'input-mini';
    $limit_switch_class = 'switch switch-mini';
  }

  echo('<tr>');
  echo('<td>'.htmlentities($sensor['sensor_index']).'</td>');
  echo('<td>'.$sensor['sensor_type'].'</td>');
  echo('<td>'.$sensor['sensor_class'].'</td>');
  echo('<td>'.htmlentities($sensor['sensor_descr']).'</td>');
  echo('<td><span class="'.$sensor['state_class'].'">' . $sensor_value . $sensor['sensor_symbol'] . '</span></td>');
  echo('<td><input class="'.$limit_class.'" name="sensors['.$sensor['sensor_id'].'][sensor_limit_low]" size="4" value="'.htmlentities($sensor['sensor_limit_low']).'"></input></td>');
  if ($warn_enable)
  {
    echo('<td><input class="'.$limit_class.'" name="sensors['.$sensor['sensor_id'].'][sensor_limit_low_warn]" size="4" value="'.htmlentities($sensor['sensor_limit_low_warn']).'"></input></td>');
    echo('<td><input class="'.$limit_class.'" name="sensors['.$sensor['sensor_id'].'][sensor_limit_warn]" size="4" value="'.htmlentities($sensor['sensor_limit_warn']).'"></input></td>');
  }
  echo('<td><input class="'.$limit_class.'" name="sensors['.$sensor['sensor_id'].'][sensor_limit]" size="4" value="'.htmlentities($sensor['sensor_limit']).'"></input></td>');
  echo('<td><div id="sensors['.$sensor['sensor_id'].'][sensor_custom_limit]" class="'.$limit_switch_class.'" data-on-label="Yes" data-off-label="No">
             <input type=checkbox name="sensors['.$sensor['sensor_id'].'][sensor_custom_limit]"'.($sensor['sensor_custom_limit'] ? "checked" : "").'></div></td>');
  echo('<td><div id="sensors['.$sensor['sensor_id'].'][sensor_ignore]" class="switch switch-mini" data-on="danger" data-off="success" data-on-label="No" data-off-label="Yes">
             <input type=checkbox name="sensors['.$sensor['sensor_id'].'][sensor_ignore]"'.($sensor['sensor_ignore'] ? "checked" : "").'></div></td>');
  echo('</tr>');
}

unset($warn_enable);

?>

</tbody>
</table>
</fieldset>

  <div class="form-actions">
    <button type="submit" class="btn btn-primary" name="submit" value="update-sensors"><i class="icon-ok icon-white"></i> Save Changes</button>
  </div>
</form>
<?php

// EOF
