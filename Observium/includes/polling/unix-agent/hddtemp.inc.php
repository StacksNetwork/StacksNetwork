<?php

global $agent_sensors;

if ($agent_data['hddtemp'] != '|')
{
  $disks = explode('||',trim($agent_data['hddtemp'],'|'));

  if (count($disks))
  {
    echo "hddtemp: ";
    foreach ($disks as $disk)
    {
      list($blockdevice,$descr,$value,$unit) = explode('|',$disk,4);
      # FIXME: should not use diskcount as index; drive serial preferred but hddtemp does not supply it.
      # Device name itself is just as useless as the actual position however.
      # In case of change in index, please provide an rrd-rename upgrade-script.
      ++$diskcount;
      discover_sensor($valid['sensor'], 'temperature', $device, '', $diskcount, 'hddtemp', "$blockdevice: $descr", '1', '1', NULL, NULL, NULL, NULL, $value, 'agent');
      $agent_sensors['temperature']['hddtemp'][$diskcount] = array('description' => "$blockdevice: $descr", 'current' => $value, 'index' => $diskcount);
    }
    echo "\n";
  }
}

?>
