<?php

$class = 'voltage';
$class_text = "Voltage";
$unit = 'V';

foreach (dbFetchRows("SELECT * FROM `sensors` WHERE `sensor_class` = ? AND `device_id` = ? AND `poller_type` = 'snmp'", array($class, $device['device_id'])) as $sensor)
{
  echo("检测 ".$class." " . $sensor['sensor_descr'] . ": ");

  $sensor_value = snmp_get($device, $sensor['sensor_oid'], "-OUqnv", "SNMPv2-MIB");

  if ($sensor['sensor_divisor'])    { $sensor_value = $sensor_value / $sensor['sensor_divisor']; }
  if ($sensor['sensor_multiplier']) { $sensor_value = $sensor_value * $sensor['sensor_multiplier']; }

  $old_rrd_file = $config['rrd_dir'] . "/" . $device['hostname'] . "/$class-" . safename($sensor['sensor_type']."-".$sensor['sensor_index']) . ".rrd";
  $rrd_file = get_sensor_rrd($device, $sensor);

  if (is_file($old_rrd_file)) { rename($old_rrd_file, $rrd_file); }

  if (!is_file($rrd_file))
  {
    rrdtool_create($rrd_file," DS:sensor:GAUGE:600:-273:1000");
  }

  echo("$sensor_value $unit\n");

  rrdtool_update($rrd_file,"N:$sensor_value");

  if ($sensor['sensor_limit_low'] != "" && $sensor['sensor_current'] > $sensor['sensor_limit_low'] && $sensor_value <= $sensor['sensor_limit_low'])
  {
    $msg  = $class_text . " 警报: " . $device['hostname'] . " " . $sensor['sensor_descr'] . " 是 " . $sensor_value . "$unit (限制 " . $sensor['sensor_limit'] . "$unit)";
    notify($device, $class_text . " 警报: " . $device['hostname'] . " " . $sensor['sensor_descr'], $msg);
    echo("报警 " . $device['hostname'] . " " . $sensor['sensor_descr'] . "\n");
    log_event($class_text.' '.$sensor['sensor_descr'] . " 根据阈值: " . $sensor_value . " $unit (< " . $sensor['sensor_limit_low'] . " $unit)", $device, $class, $sensor['sensor_id']);
  }
  else if ($sensor['sensor_limit'] != "" && $sensor['sensor_current'] < $sensor['sensor_limit'] && $sensor_value >= $sensor['sensor_limit'])
  {
    $msg  = $class_text." 警报: " . $device['hostname'] . " " . $sensor['sensor_descr'] . " 是 " . $sensor_value . "$unit (限制 " . $sensor['sensor_limit'] .= "$unit)";
    notify($device, $class_text . " 警报: " . $device['hostname'] . " " . $sensor['sensor_descr'], $msg);
    echo("报警 " . $device['hostname'] . " " . $sensor['sensor_descr'] . "\n");
    log_event($class_text." ". $sensor['sensor_descr'] . " 高于阈值: " . $sensor_value . " $unit (> " . $sensor['sensor_limit'] . " $unit)", $device, $class, $sensor['sensor_id']);
  }
  dbUpdate(array('sensor_current' => $sensor_value), 'sensors', '`sensor_id` = ', array($sensor['sensor_id']));
}

?>
