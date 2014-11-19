<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage discovery
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

// FIXME Rename code can go in r6000.

echo(" PowerNet-MIB ");

#### UPS #############################################################################################

$inputs = snmp_get($device, "upsPhaseNumInputs.0", "-Ovq", "PowerNet-MIB", mib_dirs('apc'));
$outputs = snmp_get($device, "upsPhaseNumOutputs.0", "-Ovq", "PowerNet-MIB", mib_dirs('apc'));

echo("Caching OIDs: ");
$cache['apc'] = array();

// Check if we have values for these, if not, try other code paths below.
if ($inputs || $outputs)
{
  foreach (array("upsPhaseInputTable", "upsPhaseOutputTable", "upsPhaseInputPhaseTable", "upsPhaseOutputPhaseTable") as $table)
  {
    echo("$table ");
    $cache['apc'] = snmpwalk_cache_multi_oid($device, $table, $cache['apc'], "PowerNet-MIB", mib_dirs('apc'));
  }

  // Process each input, per phase
  for ($i = 1;$i <= $inputs;$i++)
  {
    $name   = $cache['apc'][$i]['upsPhaseInputName'];
    $phases = $cache['apc'][$i]['upsPhaseNumInputPhases'];
    $tindex = $cache['apc'][$i]['upsPhaseInputTableIndex'];
    $itype  = $cache['apc'][$i]['upsPhaseInputType'];

    if ($itype == "bypass") { $name = "Bypass"; } // Override "Input 2" in case of bypass.

    for ($p = 1;$p <= $phases;$p++)
    {
      $descr    = "$name Phase $p";

      $oid      = ".1.3.6.1.4.1.318.1.1.1.9.2.3.1.6.$tindex.1.$p";
      $value    = $cache['apc']["$tindex.1.$p"]['upsPhaseInputCurrent'];

      if ($value != '' && $value != -1)
      {
        discover_sensor($valid['sensor'], 'current', $device, $oid, "upsPhaseInputCurrent.$tindex.1.$p", 'apc', $descr, 10, 1, NULL, NULL, NULL, NULL, $value / 10);

        ## Rename code for older revisions
        $old_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-current-apc-6.$tindex.1.$p.rrd");
        $new_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-current-apc-upsPhaseInputCurrent.$tindex.1.$p.rrd");
        if (is_file($old_rrd)) { rename($old_rrd,$new_rrd); print_warning("Moved RRD"); }
      }

      $oid      = ".1.3.6.1.4.1.318.1.1.1.9.2.3.1.3.$tindex.1.$p";
      $value    = $cache['apc']["$tindex.1.$p"]['upsPhaseInputVoltage'];

      if ($value != '' && $value != -1)
      {
        discover_sensor($valid['sensor'], 'voltage', $device, $oid, "upsPhaseInputVoltage.$tindex.1.$p", 'apc', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);

        ## Rename code for older revisions
        $old_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-voltage-apc-2.3.1.3.$tindex.1.$p.rrd");
        $new_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-voltage-apc-upsPhaseInputVoltage.$tindex.1.$p.rrd");
        if (is_file($old_rrd)) { rename($old_rrd,$new_rrd); print_warning("Moved RRD"); }
      }
    }

    // Frequency is reported only once per input
    $descr = $name;
    $index = "upsPhaseInputFrequency.$tindex";
    $oid   = ".1.3.6.1.4.1.318.1.1.1.9.2.2.1.4.$tindex";
    $value = $cache['apc'][$i]['upsPhaseInputFrequency'];

    if ($value != '' && $value != -1)
    {
      discover_sensor($valid['sensor'], 'frequency', $device, $oid, $index, 'apc', $descr, 10, 1, NULL, NULL, NULL, NULL, $value / 10);
    }
  }

  // Process each output, per phase
  for ($o = 1;$o <= $outputs;$o++)
  {
    $name = "Output"; if ($outputs > 1) { $name .= " $o"; } // Output doesn't have a name in the MIB, add number if >1
    $phases = $cache['apc'][$o]['upsPhaseNumOutputPhases'];
    $tindex = $cache['apc'][$o]['upsPhaseOutputTableIndex'];

    for ($p = 1; $p <= $phases; $p++)
    {
      $descr     = "$name Phase $p";

      $oid      = ".1.3.6.1.4.1.318.1.1.1.9.3.3.1.4.$tindex.1.$p";
      $value    = $cache['apc']["$tindex.1.$p"]['upsPhaseOutputCurrent'];

      if ($value != '' && $value != -1)
      {
        discover_sensor($valid['sensor'], 'current', $device, $oid, "upsPhaseOutputCurrent.$tindex.1.$p", 'apc', $descr, 10, 1, NULL, NULL, NULL, NULL, $value / 10);

        ## Rename code for older revisions
        $old_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-current-apc-4.$tindex.1.$p.rrd");
        $new_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-current-apc-upsPhaseOutputCurrent.$tindex.1.$p.rrd");
        if (is_file($old_rrd)) { rename($old_rrd,$new_rrd); print_warning("Moved RRD"); }
      }

      $oid      = ".1.3.6.1.4.1.318.1.1.1.9.3.3.1.3.$tindex.1.$p";
      $value    = $cache['apc']["$tindex.1.$p"]['upsPhaseOutputVoltage'];

      if ($value != '' && $value != -1)
      {
        discover_sensor($valid['sensor'], 'voltage', $device, $oid, "upsPhaseOutputVoltage.$tindex.1.$p", 'apc', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);

        ## Rename code for older revisions
        $old_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-voltage-apc-3.3.1.3.$tindex.1.$p.rrd");
        $new_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-voltage-apc-upsPhaseOutputVoltage.$tindex.1.$p.rrd");
        if (is_file($old_rrd)) { rename($old_rrd,$new_rrd); print_warning("Moved RRD"); }
      }
    }

    // Frequency is reported only once per output
    $descr = $name;
    $oid   = ".1.3.6.1.4.1.318.1.1.1.9.3.2.1.4.$tindex";
    $value = $cache['apc'][$o]['upsPhaseOutputFrequency'];

    if ($value != '' && $value != -1)
    {
      discover_sensor($valid['sensor'], 'frequency', $device, $oid, "upsPhaseOutputFrequency.$tindex", 'apc', $descr, 10, 1, NULL, NULL, NULL, NULL, $value / 10);
    }
  }
}
else
{
  // Try older UPS tables: "HighPrec" table first, with fallback to "Adv".
  foreach (array("upsHighPrecInput", "upsHighPrecOutput", "upsAdvInput", "upsAdvOutput") as $table)
  {
    echo("$table ");
    $cache['apc'] = snmpwalk_cache_multi_oid($device, $table, $cache['apc'], "PowerNet-MIB", mib_dirs('apc'));
  }

  foreach ($cache['apc'] as $index => $entry)
  {
    if (isset($entry['upsHighPrecInputLineVoltage']))
    {
      $oid   = ".1.3.6.1.4.1.318.1.1.1.3.3.1.$index";
      $descr = "Input";
      $value = $entry['upsHighPrecInputLineVoltage'];

      if ($value != '' && $value != -1)
      {
        ## Rename code for older revisions
        $old_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-voltage-apc-3.3.1.$index.rrd");
        $new_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-voltage-apc-upsHighPrecInputLineVoltage.$index.rrd");
        if (is_file($old_rrd)) { rename($old_rrd,$new_rrd); print_warning("Moved RRD"); }

        discover_sensor($valid['sensor'], 'voltage', $device, $oid, "upsHighPrecInputLineVoltage.$index", 'apc', $descr, 10, 1, NULL, NULL, NULL, NULL, $value / 10);
      }

      $oid   = ".1.3.6.1.4.1.318.1.1.1.3.3.4.$index";
      $descr = "Input";
      $value = $entry['upsHighPrecInputFrequency'];

      if ($value != '' && $value != -1)
      {
        ## Rename code for older revisions
        $old_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-frequency-apc-3.3.4.$index.rrd");
        $new_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-frequency-apc-upsHighPrecInputFrequency.$index.rrd");
        if (is_file($old_rrd)) { rename($old_rrd,$new_rrd); print_warning("Moved RRD"); }

        discover_sensor($valid['sensor'], 'frequency', $device, $oid, "upsHighPrecInputFrequency.$index", 'apc', $descr, 10, 1, NULL, NULL, NULL, NULL, $value / 10);
      }

      $oid   = ".1.3.6.1.4.1.318.1.1.1.4.3.1.$index";
      $descr = "Output";
      $value = $entry['upsHighPrecOutputVoltage'];

      if ($value != '' && $value != -1)
      {
        ## Rename code for older revisions
        $old_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-voltage-apc-4.3.1.$index.rrd");
        $new_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-voltage-apc-upsHighPrecOutputVoltage.$index.rrd");
        if (is_file($old_rrd)) { rename($old_rrd,$new_rrd); print_warning("Moved RRD"); }

        discover_sensor($valid['sensor'], 'voltage', $device, $oid, "upsHighPrecOutputVoltage.$index", 'apc', $descr, 10, 1, NULL, NULL, NULL, NULL, $value / 10);
      }

      $oid = ".1.3.6.1.4.1.318.1.1.1.4.3.4.$index";
      $descr = "Output";
      $value = $entry['upsHighPrecOutputCurrent'];

      if ($value != '' && $value != -1)
      {
        ## Rename code for older revisions
        $old_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-current-apc-4.3.4.$index.rrd");
        $new_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-current-apc-upsHighPrecOutputCurrent.$index.rrd");
        if (is_file($old_rrd)) { rename($old_rrd,$new_rrd); print_warning("Moved RRD"); }

        discover_sensor($valid['sensor'], 'current', $device, $oid, "upsHighPrecOutputCurrent.$index", 'apc', $descr, 10, 1, NULL, NULL, NULL, NULL, $value / 10);
      }

      $oid   = ".1.3.6.1.4.1.318.1.1.1.4.3.2.$index";
      $descr = "Output";
      $value = $entry['upsHighPrecOutputFrequency'];

      if ($value != '' && $value != -1)
      {
        ## Rename code for older revisions
        $old_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-frequency-apc-4.3.2." . $index . ".rrd");
        $new_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-frequency-apc-upsHighPrecOutputFrequency." . $index . ".rrd");
        if (is_file($old_rrd)) { rename($old_rrd,$new_rrd); print_warning("Moved RRD"); }

        discover_sensor($valid['sensor'], 'frequency', $device, $oid, "upsHighPrecOutputFrequency.$index", 'apc', $descr, 10, 1, NULL, NULL, NULL, NULL, $value / 10);
      }

      $oid   = ".1.3.6.1.4.1.318.1.1.1.4.3.3.$index";
      $descr = "Output Load";
      $value = $entry['upsHighPrecOutputLoad'];

      if ($value != '' && $value != -1)
      {
        discover_sensor($valid['sensor'], 'capacity', $device, $oid, "upsHighPrecOutputLoad.$index", 'apc', $descr, 10, 1, NULL, NULL, 70, 85, $value / 10);
      }
    }
    elseif (isset($entry['upsAdvInputLineVoltage']))
    {
      // Fallback to lower precision table if HighPrec table is not available and Adv table is.
      $oid   = ".1.3.6.1.4.1.318.1.1.1.3.2.1.$index";
      $descr = "Input";
      $value = $entry['upsAdvInputLineVoltage'];

      if ($value != '' && $value != -1)
      {
        ## Rename code for older revisions
        $old_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-voltage-apc-3.2.1." . $index . ".rrd");
        $new_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-voltage-apc-upsAdvInputLineVoltage." . $index . ".rrd");
        if (is_file($old_rrd)) { rename($old_rrd,$new_rrd); print_warning("Moved RRD"); }

        discover_sensor($valid['sensor'], 'voltage', $device, $oid, "upsAdvInputLineVoltage.$index", 'apc', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
      }

      $oid   = ".1.3.6.1.4.1.318.1.1.1.3.2.4.$index";
      $descr = "Input";
      $value = $entry['upsAdvInputFrequency'];

      if ($value != '' && $value != -1)
      {
        ## Rename code for older revisions
        $old_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-frequency-apc-3.2.4." . $index . ".rrd");
        $new_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-frequency-apc-upsAdvInputFrequency." . $index . ".rrd");
        if (is_file($old_rrd)) { rename($old_rrd,$new_rrd); print_warning("Moved RRD"); }

        discover_sensor($valid['sensor'], 'frequency', $device, $oid, "upsAdvInputFrequency.$index", 'apc', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
      }

      $oid   = ".1.3.6.1.4.1.318.1.1.1.4.2.1.$index";
      $value = $entry['upsAdvOutputVoltage'];
      $descr = "Output";

      if ($value != '' && $value != -1)
      {
        ## Rename code for older revisions
        $old_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-voltage-apc-4.2.1." . $index . ".rrd");
        $new_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-voltage-apc-upsAdvOutputVoltage." . $index . ".rrd");
        if (is_file($old_rrd)) { rename($old_rrd,$new_rrd); print_warning("Moved RRD"); }

        discover_sensor($valid['sensor'], 'voltage', $device, $oid, "upsAdvOutputVoltage.$index", 'apc', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
      }

      $oid   = ".1.3.6.1.4.1.318.1.1.1.4.2.4.$index";
      $descr = "Output";
      $value = $entry['upsAdvOutputCurrent'];

      if ($value != '' && $value != -1)
      {
        ## Rename code for older revisions
        $old_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-current-apc-4.2.4." . $index . ".rrd");
        $new_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-current-apc-upsAdvOutputCurrent." . $index . ".rrd");
        if (is_file($old_rrd)) { rename($old_rrd,$new_rrd); print_warning("Moved RRD"); }

        discover_sensor($valid['sensor'], 'current', $device, $oid, "upsAdvOutputCurrent.$index", 'apc', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
      }

      $oid   = ".1.3.6.1.4.1.318.1.1.1.4.2.2.$index";
      $descr = "Output";
      $value = $entry['upsAdvOutputFrequency'];

      if ($value != '' && $value != -1)
      {
        ## Rename code for older revisions
        $old_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-frequency-apc-4.2.2." . $index . ".rrd");
        $new_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-frequency-apc-upsAdvOutputFrequency." . $index . ".rrd");
        if (is_file($old_rrd)) { rename($old_rrd,$new_rrd); print_warning("Moved RRD"); }

        discover_sensor($valid['sensor'], 'frequency', $device, $oid, "upsAdvOutputFrequency.$index", 'apc', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
      }

      $oid   = ".1.3.6.1.4.1.318.1.1.1.4.2.3.$index";
      $descr = "Output Load";
      $value = $entry['upsAdvOutputLoad'];

      if ($value != '' && $value != -1)
      {
        discover_sensor($valid['sensor'], 'capacity', $device, $oid, "upsAdvOutputLoad.$index", 'apc', $descr, 10, 1, NULL, NULL, 70, 85, $value);
      }
    }
  }
}

// Try UPS battery tables: "HighPrec" table first, with fallback to "Adv".
$cache['apc'] = array();

foreach (array("upsHighPrecBattery", "upsAdvBattery") as $table)
{
  echo("$table ");
  $cache['apc'] = snmpwalk_cache_multi_oid($device, $table, $cache['apc'], "PowerNet-MIB", mib_dirs('apc'));
}

foreach ($cache['apc'] as $index => $entry)
{
  $descr = "Battery";

  if ($entry['upsHighPrecBatteryTemperature'] && $entry['upsHighPrecBatteryTemperature'] != -1)
  {
    $oid   = ".1.3.6.1.4.1.318.1.1.1.2.3.2.$index";
    $value = $entry['upsHighPrecBatteryTemperature'];

    discover_sensor($valid['sensor'], 'temperature', $device, $oid, "upsHighPrecBatteryTemperature.$index", 'apc', $descr, 10, 1, NULL, NULL, NULL, NULL, $value / 10);
  } elseif ($entry['upsAdvBatteryTemperature'] && $entry['upsAdvBatteryTemperature'] != -1)
  {
    $oid   = ".1.3.6.1.4.1.318.1.1.1.2.2.2.$index";
    $value = $entry['upsAdvBatteryTemperature'];

    ## Rename code for older revisions
    $old_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-temperature-apc-" . $index . ".rrd");
    $new_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-temperature-apc-upsAdvBatteryTemperature." . $index . ".rrd");
    if (is_file($old_rrd)) { rename($old_rrd,$new_rrd); print_warning("Moved RRD"); }

    discover_sensor($valid['sensor'], 'temperature', $device, $oid, "upsAdvBatteryTemperature.$index", 'apc', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
  }

  $descr = "Battery Nominal Voltage";

  if ($entry['upsHighPrecBatteryNominalVoltage'] && $entry['upsHighPrecBatteryNominalVoltage'] != -1)
  {
    $oid   = ".1.3.6.1.4.1.318.1.1.1.2.3.3.$index";
    $value = $entry['upsHighPrecBatteryNominalVoltage'];

    discover_sensor($valid['sensor'], 'voltage', $device, $oid, "upsHighPrecBatteryNominalVoltage.$index", 'apc', $descr, 10, 1, NULL, NULL, NULL, NULL, $value / 10);
  } elseif ($entry['upsAdvBatteryNominalVoltage'] && $entry['upsAdvBatteryNominalVoltage'] != -1)
  {
    $oid   = ".1.3.6.1.4.1.318.1.1.1.2.2.7.$index";
    $value = $entry['upsAdvBatteryNominalVoltage'];

    discover_sensor($valid['sensor'], 'voltage', $device, $oid, "upsAdvBatteryNominalVoltage.$index", 'apc', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
  }

  $descr = "Battery Actual Voltage";

  if ($entry['upsHighPrecBatteryActualVoltage'] && $entry['upsHighPrecBatteryActualVoltage'] != -1)
  {
    $oid   = ".1.3.6.1.4.1.318.1.1.1.2.3.4.$index";
    $value = $entry['upsHighPrecBatteryActualVoltage'];

    discover_sensor($valid['sensor'], 'voltage', $device, $oid, "upsHighPrecBatteryActualVoltage.$index", 'apc', $descr, 10, 1, NULL, NULL, NULL, NULL, $value / 10);
  } elseif ($entry['upsAdvBatteryActualVoltage'] && $entry['upsAdvBatteryActualVoltage'] != -1)
  {
    $oid   = ".1.3.6.1.4.1.318.1.1.1.2.2.8.$index";
    $value = $entry['upsAdvBatteryActualVoltage'];

    discover_sensor($valid['sensor'], 'voltage', $device, $oid, "upsAdvBatteryActualVoltage.$index", 'apc', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
  }

  $descr = "Battery";

  if ($entry['upsHighPrecBatteryCurrent'] && $entry['upsHighPrecBatteryCurrent'] != -1)
  {
    $oid   = ".1.3.6.1.4.1.318.1.1.1.2.3.5.$index";
    $value = $entry['upsHighPrecBatteryCurrent'];

    discover_sensor($valid['sensor'], 'current', $device, $oid, "upsHighPrecBatteryCurrent.$index", 'apc', $descr, 10, 1, NULL, NULL, NULL, NULL, $value / 10);
  } elseif ($entry['upsAdvBatteryCurrent'] && $entry['upsAdvBatteryCurrent'] != -1)
  {
    $oid   = ".1.3.6.1.4.1.318.1.1.1.2.2.9.$index";
    $value = $entry['upsAdvBatteryCurrent'];

    discover_sensor($valid['sensor'], 'current', $device, $oid, "upsAdvBatteryCurrent.$index", 'apc', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
  }

  $descr = "Total DC";

  if ($entry['upsHighPrecTotalDCCurrent'] && $entry['upsHighPrecTotalDCCurrent'] != -1)
  {
    $oid   = ".1.3.6.1.4.1.318.1.1.1.2.3.6.$index";
    $value = $entry['upsHighPrecTotalDCCurrent'];

    discover_sensor($valid['sensor'], 'current', $device, $oid, "upsHighPrecTotalDCCurrent.$index", 'apc', $descr, 10, 1, NULL, NULL, NULL, NULL, $value / 10);
  } elseif ($entry['upsAdvTotalDCCurrent'] && $entry['upsAdvTotalDCCurrent'] != -1)
  {
    $oid   = ".1.3.6.1.4.1.318.1.1.1.2.2.10.$index";
    $value = $entry['upsAdvTotalDCCurrent'];

    discover_sensor($valid['sensor'], 'current', $device, $oid, "upsAdvTotalDCCurrent.$index", 'apc', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
  }

  $descr = "Battery Capacity";

  if ($entry['upsHighPrecBatteryCapacity'] && $entry['upsHighPrecBatteryCapacity'] != -1)
  {
    $oid   = ".1.3.6.1.4.1.318.1.1.1.2.3.1.$index";
    $value = $entry['upsHighPrecBatteryCapacity'];

    discover_sensor($valid['sensor'], 'capacity', $device, $oid, "upsHighPrecBatteryCapacity.$index", 'apc', $descr, 10, 1, 15, 30, NULL, NULL, $value / 10);
  } elseif ($entry['upsAdvBatteryCapacity'] && $entry['upsAdvBatteryCapacity'] != -1)
  {
    $oid   = ".1.3.6.1.4.1.318.1.1.1.2.2.1.$index";
    $value = $entry['upsAdvBatteryCapacity'];

    discover_sensor($valid['sensor'], 'capacity', $device, $oid, "upsAdvBatteryCapacity.$index", 'apc', $descr, 1, 1, 15, 30, NULL, NULL, $value);
  }

  $descr = "Battery Runtime Remaining";

  if ($entry['upsAdvBatteryRunTimeRemaining'])
  {
    //Runtime store data in min
    $oid   = ".1.3.6.1.4.1.318.1.1.1.2.2.3.$index";
    $value = timeticks_to_sec($entry['upsAdvBatteryRunTimeRemaining']);
    $low_limit = snmp_get($device, "upsAdvConfigLowBatteryRunTime.$index", "-Ovq", "PowerNet-MIB", mib_dirs('apc'));
    $low_limit = timeticks_to_sec($low_limit);
    $low_limit = (is_numeric($low_limit) ? $low_limit/60 : 2);

    discover_sensor($valid['sensor'], 'runtime', $device, $oid, "upsAdvBatteryRunTimeRemaining.$index", 'apc', $descr, 60, 1, $low_limit, NULL, NULL, NULL, $value / 60);
  }
}

#### ATS #############################################################################################

$inputs = snmp_get($device, "atsNumInputs.0", "-Ovq", "PowerNet-MIB", mib_dirs('apc'));
$outputs = snmp_get($device, "atsNumOutputs.0", "-Ovq", "PowerNet-MIB", mib_dirs('apc'));

// Check if we have values for these, if not, try other code paths below.
if ($inputs || $outputs)
{
  echo(" ");
  $cache['apc'] = array();

  foreach (array("atsInputTable", "atsOutputTable", "atsInputPhaseTable", "atsOutputPhaseTable") as $table)
  {
    echo("$table ");
    $cache['apc'] = snmpwalk_cache_threepart_oid($device, $table, $cache['apc'], "PowerNet-MIB", mib_dirs('apc'), TRUE);
  }
  foreach (array("atsInputTable", "atsOutputTable") as $table)
  {
    echo("$table ");
    $cache['apc'] = snmpwalk_cache_multi_oid($device, $table, $cache['apc'], "PowerNet-MIB", mib_dirs('apc'), TRUE);
  }

  // Not tested with threephase, but I don't see any on the APC product list anyway, so...

  // FIXME - Not monitored:
  // [atsOutputLoad] => 364 (VA)
  // [atsOutputPercentLoad] => 9 (%)
  // [atsOutputPercentPower] => 9 (%)

  foreach ($cache['apc'] as $index => $entry)
  {
    $descr = $entry['atsInputName'];

    $oid   = ".1.3.6.1.4.1.318.1.1.8.5.3.3.1.3.$index.1.1";
    $value = $entry[1][1]['atsInputVoltage'];

    if ($value != '' && $value != -1)
    {
      discover_sensor($valid['sensor'], 'voltage', $device, $oid, "atsInputVoltage.$index.1.1", 'apc', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);

      ## Rename code for older revisions
      $old_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-voltage-apc-3.3.1.3." . $index . ".rrd");
      $new_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-voltage-apc-atsInputVoltage." . $index . ".1.1.rrd");
      if (is_file($old_rrd)) { rename($old_rrd,$new_rrd); print_warning("Moved RRD"); }
    }

    $oid   = ".1.3.6.1.4.1.318.1.1.8.5.3.3.1.9.$index.1.1";
    $value = $entry[1][1]['atsInputPower'];

    if ($value != '' && $value != -1)
    {
      discover_sensor($valid['sensor'], 'power', $device, $oid, "atsInputPower.$index.1.1", 'apc', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
    }

    $oid   = ".1.3.6.1.4.1.318.1.1.8.5.3.3.1.6.$index.1.1";
    $value = $entry[1][1]['atsInputCurrent'];

    if ($value != '' && $value != -1)
    {
      $limit     = snmp_get($device, "atsConfigPhaseOverLoadThreshold.1", "-Oqv", "PowerNet-MIB", mib_dirs('apc'));
      $lowlimit  = snmp_get($device, "atsConfigPhaseLowLoadThreshold.1", "-Oqv", "PowerNet-MIB", mib_dirs('apc'));
      $warnlimit = snmp_get($device, "atsConfigPhaseNearOverLoadThreshold.1", "-Oqv", "PowerNet-MIB", mib_dirs('apc'));

      discover_sensor($valid['sensor'], 'current', $device, $oid, "atsInputCurrent.$index.1.1", 'apc', $descr, 10, 1, $lowlimit, NULL, $warnlimit, $limit, $value / 10);
    }

    $oid   = ".1.3.6.1.4.1.318.1.1.8.5.3.2.1.4.$index";
    $value = $entry['atsInputFrequency'];

    if ($value != '' && $value != -1)
    {
      discover_sensor($valid['sensor'], 'frequency', $device, $oid, "atsInputFrequency.$index", 'apc', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);

      ## Rename code for older revisions
      $old_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-frequency-apc-3.2.1.4." . $index . ".rrd");
      $new_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-frequency-apc-atsInputFrequency." . $index . ".rrd");
      if (is_file($old_rrd)) { rename($old_rrd,$new_rrd); print_warning("Moved RRD"); }
    }

    $descr = "Output"; // No check for multiple output feeds, currently - I don't think this exists.

    $oid   = ".1.3.6.1.4.1.318.1.1.8.5.4.3.1.3.$index.1.1";
    $value = $entry[1][1]['atsOutputVoltage'];

    if ($value != '' && $value != -1)
    {
      discover_sensor($valid['sensor'], 'voltage', $device, $oid, "atsOutputVoltage.$index.1.1", 'apc', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);

      ## Rename code for older revisions
      $old_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-voltage-apc-4.3.1.3." . $index . ".rrd");
      $new_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-voltage-apc-atsOutputVoltage." . $index . ".1.1.rrd");
      if (is_file($old_rrd)) { rename($old_rrd,$new_rrd); print_warning("Moved RRD"); }
    }

    $oid   = ".1.3.6.1.4.1.318.1.1.8.5.4.3.1.13.$index.1.1";
    $value = $entry[1][1]['atsOutputPower'];

    if ($value != '' && $value != -1)
    {
      discover_sensor($valid['sensor'], 'power', $device, $oid, "atsOutputPower.$index.1.1", 'apc', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
    }

    $oid   = ".1.3.6.1.4.1.318.1.1.8.5.4.3.1.4.$index.1.1";
    $value = $entry[1][1]['atsOutputCurrent'];

    if ($value != '' && $value != -1)
    {
      $limit     = snmp_get($device, "atsConfigPhaseOverLoadThreshold.1", "-Oqv", "PowerNet-MIB", mib_dirs('apc'));
      $lowlimit  = snmp_get($device, "atsConfigPhaseLowLoadThreshold.1", "-Oqv", "PowerNet-MIB", mib_dirs('apc'));
      $warnlimit = snmp_get($device, "atsConfigPhaseNearOverLoadThreshold.1", "-Oqv", "PowerNet-MIB", mib_dirs('apc'));

      discover_sensor($valid['sensor'], 'current', $device, $oid, "atsOutputCurrent.$index.1.1", 'apc', $descr, 10, 1, $lowlimit, NULL, $warnlimit, $limit, $value / 10);

      ## Rename code for older revisions
      $old_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-current-apc-" . $index . ".rrd");
      $new_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-current-apc-atsOutputCurrent." . $index . ".1.1.rrd");
      if (is_file($old_rrd)) { rename($old_rrd,$new_rrd); print_warning("Moved RRD"); }
    }

    $oid   = ".1.3.6.1.4.1.318.1.1.8.5.4.2.1.4.$index";
    $value = $entry['atsOutputFrequency'];

    if ($value != '' && $value != -1)
    {
      discover_sensor($valid['sensor'], 'frequency', $device, $oid, "atsOutputFrequency.$index", 'apc', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);

      ## Rename code for older revisions
      $old_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-current-apc-4.2.1.4." . $index . ".rrd");
      $new_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-current-apc-atsOutputFrequency." . $index . ".rrd");
      if (is_file($old_rrd)) { rename($old_rrd,$new_rrd); print_warning("Moved RRD"); }
    }
  }

  // State sensors
  $cache['apc'] = array();

  foreach (array("atsStatusDeviceStatus") as $table)
  {
    echo("$table ");
    $cache['apc'] = snmpwalk_cache_multi_oid($device, $table, $cache['apc'], "PowerNet-MIB", mib_dirs('apc'), TRUE);
  }

  foreach ($cache['apc'] as $index => $entry)
  {
    $descr = "Switch Status";
    $oid   = ".1.3.6.1.4.1.318.1.1.8.5.1.10.$index";
    $value = state_string_to_numeric('powernet-status-state',$entry['atsStatusSwitchStatus']);
    discover_sensor($valid['sensor'], 'state', $device, $oid, "atsStatusSwitchStatus.$index", 'powernet-status-state', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);

    $descr = "Source A";
    $oid   = ".1.3.6.1.4.1.318.1.1.8.5.1.12.$index";
    $value = state_string_to_numeric('powernet-status-state',$entry['atsStatusSourceAStatus']);
    discover_sensor($valid['sensor'], 'state', $device, $oid, "atsStatusSourceAStatus.$index", 'powernet-status-state', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);

    $descr = "Source B";
    $oid   = ".1.3.6.1.4.1.318.1.1.8.5.1.13.$index";
    $value = state_string_to_numeric('powernet-status-state',$entry['atsStatusSourceBStatus']);
    discover_sensor($valid['sensor'], 'state', $device, $oid, "atsStatusSourceBStatus.$index", 'powernet-status-state', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);

    $descr = "Phase Sync";
    $oid   = ".1.3.6.1.4.1.318.1.1.8.5.1.14.$index";
    $value = state_string_to_numeric('powernet-sync-state',$entry['atsStatusPhaseSyncStatus']);
    discover_sensor($valid['sensor'], 'state', $device, $oid, "atsStatusPhaseSyncStatus.$index", 'powernet-sync-state', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);

    $descr = "Hardware";
    $oid   = ".1.3.6.1.4.1.318.1.1.8.5.1.16.$index";
    $value = state_string_to_numeric('powernet-status-state',$entry['atsStatusHardwareStatus']);
    discover_sensor($valid['sensor'], 'state', $device, $oid, "atsStatusHardwareStatus.$index", 'powernet-status-state', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
  }

/*
PowerNet-MIB::atsStatusRedundancyState.0 = INTEGER: atsFullyRedundant(2)
PowerNet-MIB::atsStatusOverCurrentState.0 = INTEGER: atsCurrentOK(2)
PowerNet-MIB::atsStatus5VPowerSupply.0 = INTEGER: atsPowerSupplyOK(2)
PowerNet-MIB::atsStatus24VPowerSupply.0 = INTEGER: atsPowerSupplyOK(2)
PowerNet-MIB::atsStatus24VSourceBPowerSupply.0 = INTEGER: atsPowerSupplyOK(2)
PowerNet-MIB::atsStatusPlus12VPowerSupply.0 = INTEGER: atsPowerSupplyOK(2)
PowerNet-MIB::atsStatusMinus12VPowerSupply.0 = INTEGER: atsPowerSupplyOK(2)
*/
}

#### PDU #############################################################################################

$outlets = snmp_get($device, "rPDUIdentDeviceNumOutlets.0", "-Ovq", "PowerNet-MIB", mib_dirs('apc'));
$banks   = snmp_get($device, "rPDULoadDevNumBanks.0", "-Ovq", "PowerNet-MIB", mib_dirs('apc'));
$loadDev = snmpwalk_cache_multi_oid($device, "rPDULoadDevice", array(), "PowerNet-MIB", mib_dirs('apc'));

// Check if we have values for these, if not, try other code paths below.
if ($outlets)
{
  echo(" ");

  # v2 firmware: first bank is total
  # v3 firmware: last bank is total
  # v5 firmware: looks like first bank is total
  $baseversion = 2; /// FIXME. Use preg_match
  if (stristr($device['version'], 'v3') == TRUE) { $baseversion = 3; }
  elseif (stristr($device['version'], 'v4') == TRUE) { $baseversion = 4; }
  elseif (stristr($device['version'], 'v5') == TRUE) { $baseversion = 5; }
  elseif (stristr($device['version'], 'v6') == TRUE) { $baseversion = 6; }

  $cache['apc'] = array();

  foreach (array("rPDUIdent", "rPDU2Ident") as $table)
  {
    echo("$table ");
    $cache['apc'] = snmpwalk_cache_multi_oid($device, $table, $cache['apc'], "PowerNet-MIB", mib_dirs('apc'), TRUE);
  }

  // PowerNet-MIB::rPDUIdentDeviceLinetoLineVoltage.0 = INTEGER: 400
  // PowerNet-MIB::rPDUIdentDevicePowerWatts.0 = INTEGER: 807
  // PowerNet-MIB::rPDUIdentDevicePowerFactor.0 = INTEGER: 1000 - currently not used (1000=1)
  // PowerNet-MIB::rPDUIdentDevicePowerVA.0 = INTEGER: 807 - no VA sensor type yet

  if (count($cache['apc']) == 1)
  { // Skip this section if rPDU2Ident table is present (it has index 1, so count() will be 2)
    // All data reported in rPDUIdent is duplicated in the rPDU2 tables we poll below.
    foreach ($cache['apc'] as $index => $entry)
    {
      $descr = "Input";

      /// NOTE. rPDUIdentDeviceLinetoLineVoltage - is not actual voltage from device.
      //DESCRIPTION
      //   "Getting/Setting this OID will return/set the Line to Line Voltage.
      //    This OID defaults to the nominal input line voltage in volts AC.
      //    This setting is used to calculate total power and must be configured for best accuracy.
      //    This OID does not apply to AP86XX, AP88XX, or AP89XX SKUs.
      $oid   = ".1.3.6.1.4.1.318.1.1.12.1.15.$index";
      $value = $entry['rPDUIdentDeviceLinetoLineVoltage'];

      if ($value != '' && $value != -1)
      {
        discover_sensor($valid['sensor'], 'voltage', $device, $oid, "rPDUIdentDeviceLinetoLineVoltage.$index", 'apc', 'Line-to-Line', 1, 1, 0, NULL, NULL, 440, $value);

        ## Rename code for older revisions
        $old_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-voltage-apc-" . ($index+1) . ".rrd");
        $new_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-voltage-apc-rPDUIdentDeviceLinetoLineVoltage." . $index . ".rrd");
        if (is_file($old_rrd)) { rename($old_rrd,$new_rrd); print_warning("Moved RRD"); }
      }

      $oid   = ".1.3.6.1.4.1.318.1.1.12.1.16.$index";
      $value = $entry['rPDUIdentDevicePowerWatts'];

      if ($value != '' && $value != -1)
      {
        discover_sensor($valid['sensor'], 'power', $device, $oid, "rPDUIdentDevicePowerWatts.$index", 'apc', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
      }
    }
  }

  // PowerNet-MIB::rPDU2PhaseConfigIndex.1 = INTEGER: 1
  // PowerNet-MIB::rPDU2PhaseConfigModule.1 = INTEGER: 1
  // PowerNet-MIB::rPDU2PhaseConfigNumber.1 = INTEGER: 1
  // PowerNet-MIB::rPDU2PhaseConfigOverloadRestriction.1 = INTEGER: notSupported(4)
  // PowerNet-MIB::rPDU2PhaseConfigLowLoadCurrentThreshold.1 = INTEGER: 0
  // PowerNet-MIB::rPDU2PhaseConfigNearOverloadCurrentThreshold.1 = INTEGER: 26
  // PowerNet-MIB::rPDU2PhaseConfigOverloadCurrentThreshold.1 = INTEGER: 32
  // PowerNet-MIB::rPDU2PhasePropertiesIndex.1 = INTEGER: 1
  // PowerNet-MIB::rPDU2PhasePropertiesModule.1 = INTEGER: 1
  // PowerNet-MIB::rPDU2PhasePropertiesNumber.1 = INTEGER: 1
  // PowerNet-MIB::rPDU2PhaseStatusIndex.1 = INTEGER: 1
  // PowerNet-MIB::rPDU2PhaseStatusModule.1 = INTEGER: 1
  // PowerNet-MIB::rPDU2PhaseStatusNumber.1 = INTEGER: 1
  // PowerNet-MIB::rPDU2PhaseStatusLoadState.1 = INTEGER: normal(2)
  // PowerNet-MIB::rPDU2PhaseStatusCurrent.1 = INTEGER: 28
  // PowerNet-MIB::rPDU2PhaseStatusVoltage.1 = INTEGER: 228
  // PowerNet-MIB::rPDU2PhaseStatusPower.1 = INTEGER: 57
  $cache['apc'] = array();
  foreach (array("rPDU2PhaseStatusTable", "rPDU2PhaseConfigTable") as $table)
  {
    echo("$table ");
    $cache['apc'] = snmpwalk_cache_multi_oid($device, $table, $cache['apc'], "PowerNet-MIB", mib_dirs('apc'), TRUE);
  }

  if (count($cache['apc']))
  {
    //rPDU2BankStatusIndex.1 = 1
    //rPDU2BankStatusIndex.2 = 2
    //rPDU2BankStatusModule.1 = 1
    //rPDU2BankStatusModule.2 = 1
    //rPDU2BankStatusNumber.1 = 1
    //rPDU2BankStatusNumber.2 = 2
    //rPDU2BankStatusLoadState.1 = normal
    //rPDU2BankStatusLoadState.2 = normal
    //rPDU2BankStatusCurrent.1 = 7
    //rPDU2BankStatusCurrent.2 = 27
    if ($banks > 1)
    {
      echo("rPDU2BankStatusTable ");
      $cache['banks'] = snmpwalk_cache_multi_oid($device, 'rPDU2BankStatusTable', array(), "PowerNet-MIB", mib_dirs('apc'));

      foreach ($cache['banks'] as $index => $entry)
      {
        $oid      = ".1.3.6.1.4.1.318.1.1.26.8.3.1.5.$index";
        $value    = $entry['rPDU2BankStatusCurrent'];
        $bank     = $entry['rPDU2BankStatusNumber'];
        $descr    = "Bank $bank";

        if ($value != '' && $value != -1)
        {
          discover_sensor($valid['sensor'], 'current', $device, $oid, "rPDU2BankStatusCurrent.$index", 'apc', $descr, 10, 1, NULL, NULL, NULL, NULL, $value / 10);
        }
      }
    }

    foreach ($cache['apc'] as $index => $entry)
    {
      $oid       = ".1.3.6.1.4.1.318.1.1.26.6.3.1.5.$index";
      $value     = $entry['rPDU2PhaseStatusCurrent'];
      $limit     = $entry['rPDU2PhaseConfigOverloadCurrentThreshold'];
      $lowlimit  = $entry['rPDU2PhaseConfigLowLoadCurrentThreshold'];
      $warnlimit = $entry['rPDU2PhaseConfigNearOverloadCurrentThreshold'];
      $phase     = $entry['rPDU2PhaseStatusNumber'];

      if ($loadDev[0]['rPDULoadDevNumPhases'] != 1)
      {
        $descr = "Phase $phase";
      } else {
        $descr = "Output";
      }

      if ($value != '' && $value != -1)
      {
        discover_sensor($valid['sensor'], 'current', $device, $oid, "rPDU2PhaseStatusCurrent.$index", 'apc', $descr, 10, 1, $lowlimit, NULL, $warnlimit, $limit, $value / 10);
      }

      ## Rename code for older revisions
      $old_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-current-apc-" . $index . ".rrd");
      $new_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-current-apc-rPDU2PhaseStatusCurrent." . $index . ".rrd");
      if (is_file($old_rrd)) { rename($old_rrd,$new_rrd); print_warning("Moved RRD"); }

      $oid       = ".1.3.6.1.4.1.318.1.1.26.6.3.1.6.$index";
      $value     = $entry['rPDU2PhaseStatusVoltage'];

      if ($value != '' && $value != -1)
      {
        discover_sensor($valid['sensor'], 'voltage', $device, $oid, "rPDU2PhaseStatusVoltage.$index", 'apc', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
      }

      $oid       = ".1.3.6.1.4.1.318.1.1.26.6.3.1.7.$index";
      $value     = $entry['rPDU2PhaseStatusPower'];

      if ($value != '' && $value != -1)
      {
        discover_sensor($valid['sensor'], 'power', $device, $oid, "rPDU2PhaseStatusPower.$index", 'apc', $descr, 1, 10, NULL, NULL, NULL, NULL, $value * 10);
      }

      // PowerNet-MIB::rPDU2PhaseStatusLoadState.1 = INTEGER: normal(2)
    }
  }
  else
  {
    // $baseversion == 3
    //rPDULoadStatusIndex.1 = 1
    //rPDULoadStatusIndex.2 = 2
    //rPDULoadStatusIndex.3 = 3
    //rPDULoadStatusLoad.1 = 114
    //rPDULoadStatusLoad.2 = 58
    //rPDULoadStatusLoad.3 = 58
    //rPDULoadStatusLoadState.1 = phaseLoadNormal
    //rPDULoadStatusLoadState.2 = phaseLoadNormal
    //rPDULoadStatusLoadState.3 = phaseLoadNormal
    //rPDULoadStatusPhaseNumber.1 = 1
    //rPDULoadStatusPhaseNumber.2 = 1
    //rPDULoadStatusPhaseNumber.3 = 1
    //rPDULoadStatusBankNumber.1 = 0
    //rPDULoadStatusBankNumber.2 = 1
    //rPDULoadStatusBankNumber.3 = 2
    foreach (array("rPDUStatusPhaseTable", "rPDULoadStatus", "rPDULoadPhaseConfig") as $table)
    {
      echo("$table ");
      $cache['apc'] = snmpwalk_cache_multi_oid($device, $table, $cache['apc'], "PowerNet-MIB", mib_dirs('apc'), TRUE);
    }

    foreach ($cache['apc'] as $index => $entry)
    {
      $oid       = ".1.3.6.1.4.1.318.1.1.12.2.3.1.1.2.$index";
      $value     = $entry['rPDULoadStatusLoad'];
      $limit     = $entry['rPDULoadPhaseConfigOverloadThreshold'];
      $lowlimit  = $entry['rPDULoadPhaseConfigLowLoadThreshold'];
      $warnlimit = $entry['rPDULoadPhaseConfigNearOverloadThreshold'];
      $bank      = $entry['rPDULoadStatusBankNumber'];
      $phase     = $entry['rPDUStatusPhaseNumber'];

      if (!$banks)
      {
        // No bank support on device
        if ($loadDev[0]['rPDULoadDevNumPhases'] != 1) { $descr = "Phase $phase"; } else { $descr = "Output"; }
      } else {
        // Bank support. Not sure that depends on $baseversion
        // http://jira.observium.org/browse/OBSERVIUM-772
        if ($bank == '0')
        {
          $bank = "Total";
        }
        $descr = "Bank $bank";
      }

      if ($value != '' && $value != -1)
      {
        discover_sensor($valid['sensor'], 'current', $device, $oid, "rPDULoadStatusLoad.$index", 'apc', $descr, 10, 1, $lowlimit, NULL, $warnlimit, $limit, $value / 10);
      }

      ## Rename code for older revisions
      $old_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-current-apc-" . $index . ".rrd");
      $new_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-current-apc-rPDULoadStatusLoad." . $index . ".rrd");
      if (is_file($old_rrd)) { rename($old_rrd,$new_rrd); print_warning("Moved RRD"); }

      // [rPDUStatusPhaseState] => phaseLoadNormal
      // [rPDULoadStatusLoadState] => phaseLoadNormal
      // [rPDULoadPhaseConfigAlarm] => noLoadAlarm
    }
  }

  unset($baseversion, $banks);

  // PowerNet-MIB::rPDUPowerSupply1Status.0 = INTEGER: powerSupplyOneOk(1)
  // PowerNet-MIB::rPDUPowerSupply2Status.0 = INTEGER: powerSupplyTwoNotPresent(3)
  // PowerNet-MIB::rPDUPowerSupplyAlarm.0 = INTEGER: allAvailablePowerSuppliesOK(1)

  // FIXME METERED PDU CODE BELOW IS COMPLETELY UNTESTED
  $cache['apc'] = array();

  foreach (array("rPDU2OutletMeteredStatusTable") as $table)
  {
    echo("$table ");
    $cache['apc'] = snmpwalk_cache_multi_oid($device, $table, $cache['apc'], "PowerNet-MIB", mib_dirs('apc'), TRUE);
  }

  foreach ($cache['apc'] as $index => $entry)
  {
    // rPDU2PhaseStatusVoltage DESCRIPTION:
    // "Indicates the Voltage, in Volts, of the Rack PDU phase being queried"
    $voltage   = snmp_get($device, "rPDU2PhaseStatusVoltage", "-Oqv", "PowerNet-MIB", mib_dirs('apc'));

    $oid       = ".1.3.6.1.4.1.318.1.1.12.2.3.1.1.2.$index";

    $value     = $entry['rPDU2OutletMeteredStatusCurrent'] / 10;
    $limit     = $entry['rPDU2OutletMeteredConfigOverloadCurrentThreshold'];
    $lowlimit  = $entry['rPDU2OutletMeteredConfigLowLoadCurrentThreshold'];
    $warnlimit = $entry['rPDU2OutletMeteredConfigNearOverloadCurrentThreshold'];
    $descr     = "Outlet " . $index . " - " . $entry['rPDU2OutletMeteredStatusName'];

    if ($value != '' && $value != -1)
    {
      discover_sensor($valid['sensor'], 'current', $device, $oid, "rPDU2OutletMeteredStatusCurrent.$index", 'apc', $descr, 10, 1, $lowlimit, NULL, $warnlimit, $limit, $value);
    }

    ## Rename code for older revisions
    $old_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-current-apc-" . $index . ".rrd");
    $new_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-current-apc-rPDU2OutletMeteredStatusCurrent." . $index . ".rrd");
    if (is_file($old_rrd)) { rename($old_rrd,$new_rrd); print_warning("Moved RRD"); }

    $oid       = ".1.3.6.1.4.1.318.1.1.12.2.3.1.1.2.$index";
    $value     = $entry['rPDU2OutletMeteredStatusPower'];

    if ($value != '' && $value != -1)
    {
      discover_sensor($valid['sensor'], 'power', $device, $oid, "rPDU2OutletMeteredStatusPower.$index", 'apc', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);  // FIXME *10 ?
    }
  }
}

#### MODULAR DISTRIBUTION SYSTEM #####################################################################

// FIXME This section needs a rewrite, but I can't find a device -TL

echo(" ");

$oids = snmp_walk($device, "isxModularDistSysVoltageLtoN", "-OsqnU", "PowerNet-MIB", mib_dirs('apc'));
if ($oids)
{
  echo(" Voltage In ");
  foreach (explode("\n", $oids) as $data)
  {
    list($oid,$value) = explode(" ",$data);
    $divisor = 10;
    $split_oid = explode('.',$oid);
    $phase = $split_oid[count($split_oid)-1];
    $index = "LtoN:".$phase;
    $descr = "Phase $phase Line to Neutral";

    discover_sensor($valid['sensor'], 'voltage', $device, $oid, $index, 'apc', $descr, $divisor, 1, NULL, NULL, NULL, NULL, $value);
  }
}

$oids = snmp_walk($device, "isxModularDistModuleBreakerCurrent", "-OsqnU", "PowerNet-MIB", mib_dirs('apc'));
if ($oids)
{
  echo(" Modular APC Out ");
  foreach (explode("\n", $oids) as $data)
  {
    $data = trim($data);
    if ($data)
    {
      list($oid,$value) = explode(" ", $data);
      $split_oid = explode('.',$oid);
      $phase = $split_oid[count($split_oid)-1];
      $breaker = $split_oid[count($split_oid)-2];
      $index = str_pad($breaker, 2, "0", STR_PAD_LEFT) . "-" . $phase;
      $descr = "Breaker $breaker Phase $phase";
      discover_sensor($valid['sensor'], 'current', $device, $oid, $index, 'apc', $descr, 10, 1, NULL, NULL, NULL, NULL, $value);
    }
  }

  $oids = snmp_walk($device, "isxModularDistSysCurrentAmps", "-OsqnU", "PowerNet-MIB", mib_dirs('apc'));
  foreach (explode("\n", $oids) as $data)
  {
    $data = trim($data);
    if ($data)
    {
      list($oid,$value) = explode(" ", $data);
      $split_oid = explode('.',$oid);
      $phase = $split_oid[count($split_oid)-1];
      $index = ".$phase";
      $descr = "Phase $phase overall";
      discover_sensor($valid['sensor'], 'current', $device, $oid, $index, 'apc', $descr, 10, 1, NULL, NULL, NULL, NULL, $value);
    }
  }
}

#### ENVIRONMENTAL ###################################################################################

echo(" ");

$cache['apc'] = array();

foreach (array("emsProbeStatusTable") as $table)
{
  echo("$table ");
  $cache['apc'] = snmpwalk_cache_multi_oid($device, $table, $cache['apc'], "PowerNet-MIB", mib_dirs('apc'));
}
$temp_units = snmp_get($device, "emsStatusSysTempUnits.0", "-Ovq", "PowerNet-MIB", mib_dirs('apc'));

foreach ($cache['apc'] as $index => $entry)
{
  $descr           = $entry['emsProbeStatusProbeName'];

  $status          = $entry['emsProbeStatusProbeCommStatus'];
  if ($status != 'commsEstablished') { continue; }

  // Humidity
  $value           = $entry['emsProbeStatusProbeHumidity'];
  $oid             = ".1.3.6.1.4.1.318.1.1.10.3.13.1.1.6.$index";
  $low_limit       = $entry['emsProbeStatusProbeMinHumidityThresh'];
  $low_warn_limit  = $entry['emsProbeStatusProbeLowHumidityThresh'];
  $high_warn_limit = $entry['emsProbeStatusProbeHighHumidityThresh'];
  $high_limit      = $entry['emsProbeStatusProbeMaxHumidityThresh'];

  if ($value != '' && $value > 0)
  {
    // Humidity = 0 or -1 -> Sensor not available
    discover_sensor($valid['sensor'], 'humidity', $device, $oid, "emsProbeStatusProbeHumidity.$index", 'apc', $descr, 1, 1, $low_limit, $low_warn_limit, $high_warn_limit, $high_limit , $value);
  }

  // Temperature
  $value           = $entry['emsProbeStatusProbeTemperature'];
  $oid             = ".1.3.6.1.4.1.318.1.1.10.3.13.1.1.3.$index";
  $low_limit       = $entry['emsProbeStatusProbeMinTempThresh'];
  $low_warn_limit  = $entry['emsProbeStatusProbeLowTempThresh'];
  $high_warn_limit = $entry['emsProbeStatusProbeHighTempThresh'];
  $high_limit      = $entry['emsProbeStatusProbeMaxTempThresh'];

  if ($value != '' && $value != -1)
  {
    // Temperature = -1 -> Sensor not available
    $temp_divisor = 1; $temp_multiplier = 1;
    if ($temp_units == 'fahrenheit')
    {
      $temp_divisor = 9; $temp_multiplier = 5;
      foreach (array('value', 'low_limit', 'low_warn_limit', 'high_warn_limit', 'high_limit') as $param)
      {
        $$param = f2c($$param); // Convert from fahrenheit to celsius
      }
      print_debug('TEMP sensor: Fahrenheit -> Celsius');
    }

    discover_sensor($valid['sensor'], 'temperature', $device, $oid, "emsProbeStatusProbeTemperature.$index", 'apc', $descr, $temp_divisor, $temp_multiplier, $low_limit, $low_warn_limit, $high_warn_limit, $high_limit , $value);
  }
}

$cache['apc'] = array();

// emConfigProbesTable may also be used? Perhaps on older devices? Not on mine...
foreach (array("iemConfigProbesTable", "iemStatusProbesTable") as $table)
{
  echo("$table ");
  $cache['apc'] = snmpwalk_cache_multi_oid($device, $table, $cache['apc'], "PowerNet-MIB", mib_dirs('apc'));
}
$temp_units = snmp_get($device, "iemStatusProbeTempUnits.0", "-Ovq", "PowerNet-MIB", mib_dirs('apc'));

foreach ($cache['apc'] as $index => $entry)
{
  $descr           = $entry['iemStatusProbeName'];

  // [iemStatusProbeStatus] => connected - maybe check this before walking/foreach?
  $status          = $entry['iemStatusProbeStatus'];
  //if ($status != 'connected') { continue; } ///FIXME. Tom, pls check this.

  // Humidity
  $value           = $entry['iemStatusProbeCurrentHumid'];
  $oid             = ".1.3.6.1.4.1.318.1.1.10.2.3.2.1.6.$index";
  $low_limit       = ($entry['iemConfigProbeMinHumidEnable']  != 'disabled' ? $entry['iemConfigProbeMinHumidThreshold'] : NULL);
  $low_warn_limit  = ($entry['iemConfigProbeLowHumidEnable']  != 'disabled' ? $entry['iemConfigProbeLowHumidThreshold'] : NULL);
  $high_warn_limit = ($entry['iemConfigProbeHighHumidEnable'] != 'disabled' ? $entry['iemConfigProbeHighHumidThreshold'] : NULL);
  $high_limit      = ($entry['iemConfigProbeMaxHumidEnable']  != 'disabled' ? $entry['iemConfigProbeMaxHumidThreshold'] : NULL);

  // FIXME unused values:
  // [iemConfigProbeHumidHysteresis] => -1 - usable somewhere?

  if ($value != '' && $value > 0)
  {
    // Humidity = 0 or -1 -> Sensor not available
    discover_sensor($valid['sensor'], 'humidity', $device, $oid, "iemStatusProbeCurrentHumid.$index", 'apc', $descr, 1, 1, $low_limit, $low_warn_limit, $high_warn_limit, $high_limit , $value);

    ## Rename code for older revisions
    $old_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-humidity-apc-" . $index . ".rrd");
    $new_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-humidity-apc-iemStatusProbeCurrentHumid." . $index . ".rrd");
    if (is_file($old_rrd)) { rename($old_rrd,$new_rrd); print_warning("Moved RRD"); }
  }

  // Temperature
  $value           = $entry['iemStatusProbeCurrentTemp'];
  $oid             = ".1.3.6.1.4.1.318.1.1.10.2.3.2.1.4.$index";
  $low_limit       = ($entry['iemConfigProbeMinTempEnable']  != 'disabled' ? $entry['iemConfigProbeMinTempThreshold'] : NULL);
  $low_warn_limit  = ($entry['iemConfigProbeLowTempEnable']  != 'disabled' ? $entry['iemConfigProbeLowTempThreshold'] : NULL);
  $high_warn_limit = ($entry['iemConfigProbeHighTempEnable'] != 'disabled' ? $entry['iemConfigProbeHighTempThreshold'] : NULL);
  $high_limit      = ($entry['iemConfigProbeMaxTempEnable']  != 'disabled' ? $entry['iemConfigProbeMaxTempThreshold'] : NULL);

  if ($value != '' && $value != -1)
  {
    // Temperature = -1 -> Sensor not available
    $temp_divisor = 1; $temp_multiplier = 1;
    if ($temp_units == 'fahrenheit')
    {
      $temp_divisor = 9; $temp_multiplier = 5;
      foreach (array('value', 'low_limit', 'low_warn_limit', 'high_warn_limit', 'high_limit') as $param)
      {
        $$param = f2c($$param); // Convert from fahrenheit to celsius
      }
      print_debug('TEMP sensor: Fahrenheit -> Celsius');
    }

    discover_sensor($valid['sensor'], 'temperature', $device, $oid, "iemStatusProbeCurrentTemp.$index", 'apc', $descr, $temp_divisor, $temp_multiplier, $low_limit, $low_warn_limit, $high_warn_limit, $high_limit , $value);

    ## Rename code for older revisions
    $old_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-temperature-apc-" . $index . ".rrd");
    $new_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-temperature-apc-iemStatusProbeCurrentTemp." . $index . ".rrd");
    if (is_file($old_rrd)) { rename($old_rrd,$new_rrd); print_warning("Moved RRD"); }
  }
}

// Environmental monitoring on rPDU2
$cache['apc'] = snmpwalk_cache_oid($device, "rPDU2SensorTempHumidityConfigTable", array(), "PowerNet-MIB", mib_dirs('apc'));
$cache['apc'] = snmpwalk_cache_oid($device, "rPDU2SensorTempHumidityStatusTable", $cache['apc'], "PowerNet-MIB", mib_dirs('apc'));

foreach ($cache['apc'] as $index => $entry)
{
  $descr           = $entry['rPDU2SensorTempHumidityStatusName'];

  // Humidity
  $value           = $entry['rPDU2SensorTempHumidityStatusRelativeHumidity'];
  $oid             = ".1.3.6.1.4.1.318.1.1.26.10.2.2.1.10.$index";
  $low_limit       = (isset($entry['rPDU2SensorTempHumidityConfigHumidityMinThresh']) ? $entry['rPDU2SensorTempHumidityConfigHumidityMinThresh'] : NULL);
  $low_warn_limit  = (isset($entry['rPDU2SensorTempHumidityConfigHumidityLowThresh']) ? $entry['rPDU2SensorTempHumidityConfigHumidityLowThresh'] : NULL);

  if ($value != '' && $value != -1 && $entry['rPDU2SensorTempHumidityStatusHumidityStatus'] != 'notPresent')
  {
    discover_sensor($valid['sensor'], 'humidity', $device, $oid, "rPDU2SensorTempHumidityStatusRelativeHumidity.$index", 'apc', $descr, 1, 1, $low_limit, $low_warn_limit, NULL, NULL, $value);

    ## Rename code for older revisions
    $old_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-humidity-apc-" . $index . ".rrd");
    $new_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-humidity-apc-rPDU2SensorTempHumidityStatusRelativeHumidity." . $index . ".rrd");
    if (is_file($old_rrd)) { rename($old_rrd,$new_rrd); print_warning("Moved RRD"); }
  }

  // Temperature
  $value           = $entry['rPDU2SensorTempHumidityStatusTempC'];
  $oid             = ".1.3.6.1.4.1.318.1.1.26.10.2.2.1.8.$index";
  $high_warn_limit = (isset($entry['rPDU2SensorTempHumidityConfigTempHighThreshC']) ? $entry['rPDU2SensorTempHumidityConfigTempHighThreshC'] : NULL);
  $high_limit      = (isset($entry['rPDU2SensorTempHumidityConfigTempMaxThreshC']) ? $entry['rPDU2SensorTempHumidityConfigTempMaxThreshC'] : NULL);

  if ($value != '' && $value != -1)
  {
    discover_sensor($valid['sensor'], 'temperature', $device, $oid, "rPDU2SensorTempHumidityStatusTempC.$index", 'apc', $descr, 10, 1, NULL, NULL, $high_warn_limit, $high_limit , $value / 10);

    ## Rename code for older revisions
    $old_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-temperature-apc-" . $index . ".rrd");
    $new_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-temperature-apc-rPDU2SensorTempHumidityStatusTempC." . $index . ".rrd");
    if (is_file($old_rrd)) { rename($old_rrd,$new_rrd); print_warning("Moved RRD"); }
  }
}

#### NETBOTZ #########################################################################################

echo(" ");

// PowerNet-MIB::memSensorsStatusSensorNumber.0.7 = INTEGER: 7
// PowerNet-MIB::memSensorsStatusSensorName.0.7 = STRING: "Server Room"
// PowerNet-MIB::memSensorsTemperature.0.7 = INTEGER: 69
// PowerNet-MIB::memSensorsHumidity.0.7 = INTEGER: 55

$cache['apc'] = array();

foreach (array("memSensorsStatusTable") as $table)
{
  echo("$table ");
  $cache['apc'] = snmpwalk_cache_multi_oid($device, $table, $cache['apc'], "PowerNet-MIB", mib_dirs('apc'));
}
$temp_units = snmp_get($device, "memSensorsStatusSysTempUnits.0", "-Ovq", "PowerNet-MIB", mib_dirs('apc'));

foreach ($cache['apc'] as $index => $entry)
{
  $descr = $entry['memSensorsStatusSensorName'];

  $oid = ".1.3.6.1.4.1.318.1.1.10.4.2.3.1.5.$index";
  $value = $entry['memSensorsTemperature'];

  list(,$ems_index) = explode('.', $index);

  // Exclude already added sensor from emsProbeStatusTable
  if ($value != '' && $value != -1 && !isset($valid['sensor']['temperature']['apc']["emsProbeStatusProbeTemperature.$ems_index"]))
  {
    $temp_divisor = 1; $temp_multiplier = 1;
    if ($temp_units == 'fahrenheit')
    {
      $temp_divisor = 9; $temp_multiplier = 5;
      $value = f2c($value); // Convert from fahrenheit to celsius
      print_debug('TEMP sensor: Fahrenheit -> Celsius');
    }

    ## Rename code for older revisions
    $old_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-temperature-apc-$index.rrd");
    $new_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-temperature-apc-memSensorsTemperature.$index.rrd");
    if (is_file($old_rrd)) { rename($old_rrd,$new_rrd); print_warning("Moved RRD"); }

    discover_sensor($valid['sensor'], 'temperature', $device, $oid, "memSensorsTemperature.$index", 'apc', $descr, $temp_divisor, $temp_multiplier, NULL, NULL, NULL, NULL, $value);
  }

  $oid   = ".1.3.6.1.4.1.318.1.1.10.4.2.3.1.6.$index";
  $value = $entry['memSensorsHumidity'];

  // Exclude already added sensor from emsProbeStatusTable
  if ($value != '' && $value > 0 && !isset($valid['sensor']['humidity']['apc']["emsProbeStatusProbeHumidity.$ems_index"]))
  {
    ## Rename code for older revisions
    $old_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-humidity-apc-$index.rrd");
    $new_rrd  = $config['rrd_dir'] . "/".$device['hostname']."/" . safename("sensor-humidity-apc-memSensorsHumidity.$index.rrd");
    if (is_file($old_rrd)) { rename($old_rrd,$new_rrd); print_warning("Moved RRD"); }

    discover_sensor($valid['sensor'], 'humidity', $device, $oid, "memSensorsHumidity.$index", 'apc', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
  }
}

#### INROW CHILLER ###################################################################################

// FIXME below also needs a rewrite, but no device or walk to test.

// InRow Chiller. A silly check to find out if it's the right hardware.
$oids = snmp_get($device, "airIRRCGroupSetpointsCoolMetric.0", "-OsqnU", "PowerNet-MIB", mib_dirs('apc'));
if ($oids)
{
  $temps = array();
  $temps['airIRRCUnitStatusRackInletTempMetric'] = "Rack Inlet";
  $temps['airIRRCUnitStatusSupplyAirTempMetric'] = "Supply Air";
  $temps['airIRRCUnitStatusReturnAirTempMetric'] = "Return Air";
  $temps['airIRRCUnitStatusEnteringFluidTemperatureMetric'] = "Entering Fluid";
  $temps['airIRRCUnitStatusLeavingFluidTemperatureMetric'] = "Leaving Fluid";

  foreach ($temps as $obj => $descr)
  {
    $oids = snmp_get($device, $obj . ".0", "-OsqnU", "PowerNet-MIB", mib_dirs('apc'));
    list($oid,$value) = explode(' ',$oids);
    $sensorType = substr($descr, 0, 2); // FIXME ehh, what?
    discover_sensor($valid['sensor'], 'temperature', $device, $oid, '0', $sensorType, $descr, 10, 1, NULL, NULL, NULL, NULL, $value / 10);
  }
}

#### Legacy mUpsEnvironment Sensors (AP9312TH) #######################################################

$cache['apc'] = snmp_get_multi($device, "mUpsEnvironAmbientTemperature.0 mUpsEnvironRelativeHumidity.0 mUpsEnvironAmbientTemperature2.0 mUpsEnvironRelativeHumidity2.0", "-OUQs", "PowerNet-MIB", mib_dirs('apc'));

foreach ($cache['apc'] as $index => $entry)
{
  if (is_numeric($entry['mUpsEnvironAmbientTemperature']))
  {
    $descr = "Probe 1 Temperature";
    $oid   = ".1.3.6.1.4.1.318.1.1.2.1.1.$index";
    $value = $entry['mUpsEnvironAmbientTemperature'];

    discover_sensor($valid['sensor'], 'temperature', $device, $oid, "mUpsEnvironAmbientTemperature.$index", 'apc', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
  }

  if (is_numeric($entry['mUpsEnvironRelativeHumidity']))
  {
    $descr = "Probe 1 Humidity";
    $oid   = ".1.3.6.1.4.1.318.1.1.2.1.2.$index";
    $value = $entry['mUpsEnvironRelativeHumidity'];

    discover_sensor($valid['sensor'], 'humidity', $device, $oid, "mUpsEnvironRelativeHumidity.$index", 'apc', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
  }

  if (is_numeric($entry['mUpsEnvironAmbientTemperature2']))
  {
    $descr = "Probe 2 Temperature";
    $oid   = ".1.3.6.1.4.1.318.1.1.2.1.3.$index";
    $value = $entry['mUpsEnvironAmbientTemperature2'];

    discover_sensor($valid['sensor'], 'temperature', $device, $oid, "mUpsEnvironAmbientTemperature2.$index", 'apc', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
  }

  if (is_numeric($entry['mUpsEnvironRelativeHumidity2']))
  {
    $descr = "Probe 2 Humidity";
    $oid   = ".1.3.6.1.4.1.318.1.1.2.1.4.$index";
    $value = $entry['mUpsEnvironRelativeHumidity2'];

    discover_sensor($valid['sensor'], 'humidity', $device, $oid, "mUpsEnvironRelativeHumidity2.$index", 'apc', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
  }
}

$cache['apc'] = array();

foreach (array("mUpsContactTable") as $table)
{
  echo("$table ");
  $cache['apc'] = snmpwalk_cache_multi_oid($device, $table, $cache['apc'], "PowerNet-MIB", mib_dirs('apc'));
}

foreach ($cache['apc'] as $index => $entry)
{
  if ($entry['monitoringStatus'] == "enabled")
  {
    $descr = $entry['description'];
    $oid   = ".1.3.6.1.4.1.318.1.1.2.2.2.1.5.$index";
    $value = state_string_to_numeric('powernet-mupscontact-state',$entry['currentStatus']);

    discover_sensor($valid['sensor'], 'state', $device, $oid, "currentStatus.$index", 'powernet-mupscontact-state', $descr, 1, 1, NULL, NULL, NULL, NULL, $value);
  }
}

// EOF
