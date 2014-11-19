<?php

/// FIXME. Full rewrite and move to inventory staff

echo("hrDevice : ");

$hrDevice_oids = array('hrDeviceEntry','hrProcessorEntry');

$hrDevices = array();
foreach ($hrDevice_oids as $oid) { $hrDevices = snmpwalk_cache_oid($device, $oid, $hrDevices, "HOST-RESOURCES-MIB:HOST-RESOURCES-TYPES"); }
if ($debug && count($hrDevices)) { print_vars($hrDevices); }

if (is_array($hrDevices))
{
  $hrDevices = $hrDevices;
  foreach ($hrDevices as $hrDevice)
  {
    if (is_array($hrDevice) && is_numeric($hrDevice['hrDeviceIndex']))
    {
      if (dbFetchCell("SELECT COUNT(*) FROM `hrDevice` WHERE device_id = ? AND hrDeviceIndex = ?",array($device['device_id'], $hrDevice['hrDeviceIndex'])))
      {
        $update_array = array('hrDeviceType'   => $hrDevice['hrDeviceType'],
                              'hrDeviceDescr'  => $hrDevice['hrDeviceDescr'],
                              'hrDeviceStatus' => $hrDevice['hrDeviceStatus'],
                              'hrDeviceErrors' => $hrDevice['hrDeviceErrors']);

        if ($hrDevice['hrDeviceType'] == "hrDeviceProcessor")
        {
          $update_array['hrProcessorLoad'] = $hrDevice['hrProcessorLoad'];
        } else {
          $update_array['hrProcessorLoad'] = array('NULL');
        }
        dbUpdate($update_array, 'hrDevice', 'device_id = ? AND hrDeviceIndex = ?', array($device['device_id'], $hrDevice['hrDeviceIndex']));
        // FIXME -- check if it has updated, and print a U instead of a .
        echo(".");
      } else {
         $inserted = dbInsert(array('hrDeviceIndex' => $hrDevice['hrDeviceIndex'], 'device_id' => $device['device_id'], 'hrDeviceType' => $hrDevice['hrDeviceType'], 'hrDeviceDescr' => $hrDevice['hrDeviceDescr'], 'hrDeviceStatus' => $hrDevice['hrDeviceStatus'], 'hrDeviceErrors' => $hrDevice['hrDeviceErrors']), 'hrDevice');
         echo("+");
         if ($debug) { print_r($hrDevice); echo("$inserted inserted."); }
      }
      $valid_hrDevice[$hrDevice['hrDeviceIndex']] = 1;
    }
  }
}

foreach (dbFetchRows('SELECT * FROM `hrDevice` WHERE `device_id`  = ?', array($device['device_id'])) as $test_hrDevice)
{
  if (!$valid_hrDevice[$test_hrDevice['hrDeviceIndex']])
  {
    $deleted = dbDelete('hrDevice', '`hrDevice_id` = ?', array($test_hrDevice['hrDevice_id']));
    echo("-");
    if ($debug) { print_vars($test_hrDevice); echo($deleted . " deleted"); }
  }
}

unset($valid_hrDevice);
echo("\n");

// EOF
