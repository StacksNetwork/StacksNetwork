<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage poller
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2015 Adam Armstrong
 *
 */

unset($poll_device, $cache['devices']['uptime'][$device['device_id']]);

$snmpdata = snmp_get_multi($device, "sysUpTime.0 sysLocation.0 sysContact.0 sysName.0", "-OQUs", "SNMPv2-MIB", mib_dirs());
$polled = time();
$poll_device = $snmpdata[0];

$poll_device['sysDescr']     = snmp_get($device, "sysDescr.0", "-Oqv", "SNMPv2-MIB", mib_dirs());
$poll_device['sysObjectID']  = snmp_get($device, "sysObjectID.0", "-Oqvn", "SNMPv2-MIB", mib_dirs());
if (strpos($poll_device['sysObjectID'], 'Wrong Type') !== FALSE)
{
  // Wrong Type (should be OBJECT IDENTIFIER): "1.3.6.1.4.1.25651.1.2"
  list(, $poll_device['sysObjectID']) = explode(':', $poll_device['sysObjectID']);
  $poll_device['sysObjectID'] = '.'.trim($poll_device['sysObjectID'], ' ."');
}
$poll_device['snmpEngineID'] = snmp_cache_snmpEngineID($device);
$poll_device['sysName'] = strtolower($poll_device['sysName']);

if (isset($agent_data['uptime'])) { list($agent_data['uptime']) = explode(' ', $agent_data['uptime']); }
if (is_numeric($agent_data['uptime']) && $agent_data['uptime'] > 0)
{
  $uptime = round($agent_data['uptime']);
  $uptime_msg = "正在使用 UNIX 代理运行时间";
} else  {
  if ($device['os'] != 'windows' && $device['snmp_version'] != 'v1' && is_device_mib($device, 'HOST-RESOURCES-MIB'))
  {
    $hrSystemUptime = snmp_get($device, "hrSystemUptime.0", "-Oqv", "HOST-RESOURCES-MIB", mib_dirs());
    $hrSystemUptime = timeticks_to_sec($hrSystemUptime);
  } else{
    $hrSystemUptime = FALSE;
  }
  if (is_numeric($hrSystemUptime) && $hrSystemUptime > 0)
  {
    $agent_uptime = $uptime; // Move uptime into agent_uptime

    // HOST-RESOURCES-MIB::hrSystemUptime.0 = Wrong Type (should be Timeticks): 1632295600
    // HOST-RESOURCES-MIB::hrSystemUptime.0 = Timeticks: (63050465) 7 days, 7:08:24.65
    $polled = time();
    $uptime     = $hrSystemUptime;
    $uptime_msg = "正在使用 SNMP 代理 hrSystemUptime";

  } else {
    // SNMPv2-MIB::sysUpTime.0 = Timeticks: (2542831) 7:03:48.31
    $uptime = timeticks_to_sec($poll_device['sysUpTime']);
    $uptime_msg = "正在使用 SNMP 代理 sysUpTime";

    // Last check snmpEngineTime and fix if needed uptime (sysUpTime 68 year rollover issue)
    // SNMP-FRAMEWORK-MIB::snmpEngineTime.0 = INTEGER: 72393514 seconds
    $snmpEngineTime = snmp_get($device, "snmpEngineTime.0", "-OUqv", "SNMP-FRAMEWORK-MIB", mib_dirs());
    if (is_numeric($snmpEngineTime) && $snmpEngineTime > 0)
    {
      if ($device['os'] == 'aos' && strlen($snmpEngineTime) > 8)
      {
        // Some Alcatel have bug with snmpEngineTime
        // See: http://jira.observium.org/browse/OBSERVIUM-763
        $snmpEngineTime = 0;
      }
      else if ($device['os'] == 'ironware')
      {
        // Check if version correct like "07.4.00fT7f3"
        $ironware_version = explode('.', $device['version']);
        if (count($ironware_version) > 2 && $ironware_version[0] > 0 && version_compare($device['version'], '5.1.0') === -1)
        {
          // IronWare before Release 05.1.00b have bug (firmware returning snmpEngineTime * 10)
          // See: http://jira.observium.org/browse/OBSERVIUM-1199
          $snmpEngineTime = $snmpEngineTime / 10;
        }
      }

      if ($snmpEngineTime > $uptime)
      {
        $polled = time();
        $uptime = $snmpEngineTime;
        $uptime_msg = "正在使用 SNMP 代理 snmpEngineTime";
      }
    }
  }
}
print_debug("$uptime_msg ($uptime sec. => ".formatUptime($uptime).")");

if (is_numeric($uptime) && $uptime > 0) // it really is very impossible case for $uptime equals to zero
{
  // Notify only if current uptime less than one week (eg if changed from sysUpTime to snmpEngineTime)
  $rebooted = 0;
  if ($uptime < 604800)
  {
    $uptime_diff = $device['uptime'] - $uptime;
    if ($uptime_diff > 60)
    {
      // If difference betwen old uptime ($device['uptime']) and new ($uptime)
      // greater than 60 sec, than device truly rebooted
      $rebooted = 1;
    }
    else if ($device['uptime'] < 300 && abs($uptime_diff) < 280)
    {
      // This is rare, boundary case, when device rebooted multiple times betwen polling runs
      $rebooted = 1;
    }

    // APC hack, show wrong rebooted after 49 days, 17h (+|- 5min), uptime 4294800 sec.
    if ($rebooted && $device['os'] == 'apc' &&
        $device['uptime'] > 4294500 && $device['uptime'] < 4295100)
    {
      $rebooted = 0;
    }

    if ($rebooted)
    {
      log_event('设备已经重启: 位于 '.formatUptime($device['uptime']), $device, 'device', $device['device_id'], 4);
    }
  }

  $uptime_rrd = "uptime.rrd";

  rrdtool_create($device, $uptime_rrd, "DS:uptime:GAUGE:600:0:U ");
  rrdtool_update($device, $uptime_rrd, "N:".$uptime);

  $graphs['uptime'] = TRUE;

  print_message("运行时间: ".formatUptime($uptime));

  $update_array['uptime'] = $uptime;
  $cache['devices']['uptime'][$device['device_id']]['uptime'] = $uptime;
  $cache['devices']['uptime'][$device['device_id']]['polled'] = $polled;
} else {
  print_warning("设备没有正常运行时间计数器或运行时间等于零.");
}

// Rewrite sysLocation if there is a mapping array or DB override
$poll_device['sysLocation'] = rewrite_location($poll_device['sysLocation']);

$poll_device['sysContact']  = str_replace(array('\"', '"') ,"", $poll_device['sysContact']);

if ($poll_device['sysContact'] == "未设置")
{
  $poll_device['sysContact'] = "";
}

// Check if snmpEngineID changed
if ($poll_device['snmpEngineID'] && $poll_device['snmpEngineID'] != $device['snmpEngineID'])
{
  $update_array['snmpEngineID'] = $poll_device['snmpEngineID'];
  if ($device['snmpEngineID'])
  {
    // snmpEngineID changed frome one to other
    log_event('snmpEngineID 变更: '.$device['snmpEngineID'].' -> '.$poll_device['snmpEngineID'].' (可能是更换设备). 该设备将被重新发现.', $device, 'device', $device['device_id'], 4);
    // Reset device discover time for full re-discovery
    dbUpdate(array('last_discovered' => array('NULL')), 'devices', '`device_id` = ?', array($device['device_id']));
  } else {
    log_event("snmpEngineID -> ".$poll_device['snmpEngineID'], $device, 'device', $device['device_id']);
  }
}

$oids = array('sysObjectID', 'sysContact', 'sysName', 'sysDescr');
foreach ($oids as $oid)
{
  if ($poll_device[$oid] != $device[$oid])
  {
    $update_array[$oid] = ($poll_device[$oid] ? $poll_device[$oid] : array('NULL'));
    log_event("$oid -> '".$poll_device[$oid]."'", $device, 'device', $device['device_id']);
  }
}

$geo_detect = FALSE;
if ($device['location'] != $poll_device['sysLocation'])
{
  // Reset geolocation when location changes - triggers re-geolocation
  $geo_detect = TRUE;

  $update_array['location'] = $poll_device['sysLocation'];
  log_event("位置 -> '".$poll_device['sysLocation']."'", $device, 'device', $device['device_id']);
}

if ($config['geocoding']['enable'])
{
  $db_version = get_db_version(); // Need for detect old geo DB schema

  if ($db_version < 169)
  {
    // FIXME. remove this part in r7000
    if ($geo_detect)
    {
      $update_array['location_lat'] = array('NULL');
      $update_array['location_lon'] = array('NULL');
    }
    $geo_db = array();
    foreach ($device as $k => $value)
    {
      if (strpos($k, 'location') !== FALSE)
      {
        $geo_db[$k] = $value; // GEO array for compatibility
      }
    }
  } else {
    $geo_db = dbFetchRow("SELECT * FROM `devices_locations` WHERE `device_id` = ?", array($device['device_id']));
    if (OBS_DEBUG > 1 && count($geo_db)) { print_vars($geo_db); }
  }
  $geo_db['hostname'] = $device['hostname']; // Hostname required for detect by DNS

  if (!(is_numeric($geo_db['location_lat']) && is_numeric($geo_db['location_lon'])))
  {
    // Redetect geolocation if coordinates still empty, no more frequently than once a day
    $geo_updated = $config['time']['now'] - strtotime($geo_db['location_updated']);
    $geo_detect = $geo_detect || ($geo_updated > 86400);
  }

  $geo_detect = $geo_detect || ($poll_device['sysLocation'] && $device['location'] != $poll_device['sysLocation']);
  $geo_detect = $geo_detect || ($geo_db['location_geoapi'] != strtolower($config['geocoding']['api']));
  $geo_detect = $geo_detect || ($geo_db['location_manual'] && (!$geo_db['location_country'] || $geo_db['location_country'] == 'Unknown'));

  if ($geo_detect)
  {
    $update_geo = get_geolocation($poll_device['sysLocation'], $geo_db);
    if (OBS_DEBUG && count($update_geo)) { print_vars($update_geo); }
    if (is_numeric($update_geo['location_lat']) && is_numeric($update_geo['location_lon']) && $update_geo['location_country'] != 'Unknown')
    {
      $geo_msg  = 'Geolocation ('.strtoupper($update_geo['location_geoapi']).') -> ';
      $geo_msg .= '['.sprintf('%f', $update_geo['location_lat']) .', ' .sprintf('%f', $update_geo['location_lon']) .'] ';
      $geo_msg .= country_from_code($update_geo['location_country']).' (Country), '.$update_geo['location_state'].' (State), ';
      $geo_msg .= $update_geo['location_county'] .' (County), ' .$update_geo['location_city'] .' (City)';
    } else {
      $geo_msg  = FALSE;
    }
    if ($db_version < 169)
    {
      // FIXME. remove this part in r7000
      $update_array = array_merge($update_array, $update_geo);
      log_event("Geolocation -> $geo_msg", $device, 'device', $device['device_id']);
    } else {
      if (is_numeric($geo_db['location_id']))
      {
        foreach($update_geo as $k => $value)
        {
          if ($geo_db[$k] == $value) { unset($update_geo[$k]); }
        }
        if ($update_geo)
        {
          dbUpdate($update_geo, 'devices_locations', '`location_id` = ?', array($geo_db['location_id']));
          if ($geo_msg) { log_event($geo_msg, $device, 'device', $device['device_id']); }
        } // else not changed
      } else {
        $update_geo['device_id'] = $device['device_id'];
        dbInsert($update_geo, 'devices_locations');
        if ($geo_msg) { log_event($geo_msg, $device, 'device', $device['device_id']); }
      }
    }
  }
}

unset($geo_detect, $geo_db, $update_geo);

// EOF
