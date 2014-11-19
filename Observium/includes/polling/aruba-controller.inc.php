<?php

// FIXME -- this code sucks, what the fuck. -- adama

if ($device['type'] == 'wireless' && $device['os'] == 'arubaos')
{
  global $config;

  echo("Aruba Controller: ");

  // Build array of APs in the database

  $query  = 'SELECT *, A.`accesspoint_id` AS `accesspoint_id` FROM `accesspoints` AS A';
  $query .= ' LEFT JOIN `accesspoints-state` AS S ON A.`accesspoint_id` = S.`accesspoint_id`';
  $query .= ' WHERE `device_id` = ?';

  $aps_db = dbFetchRows($query, array($device['device_id']));
  foreach ($aps_db as $ap) { $aps[$ap['mac_addr']][$ap['radio_number']] = $ap; }

  unset($aps_db); unset($ap);

  /// Build SNMP Cache Array

  //stuff about the controller
  $switch_info_oids = array('wlsxSwitchRole','wlsxSwitchMasterIp');
  $switch_counter_oids = array('wlsxSwitchTotalNumAccessPoints.0','wlsxSwitchTotalNumStationsAssociated.0');

  $switch_apinfo_oids = array('wlsxWlanRadioEntry','wlanAPChInterferenceIndex');
  $switch_apname_oids = array('wlsxWlanRadioEntry.16');
  $aruba_oids = array_merge($switch_info_oids,$switch_counter_oids);

  echo("Caching Oids: ");
  foreach ($aruba_oids as $oid) { echo("$oid "); $aruba_stats = snmpwalk_cache_oid($device, $oid, $aruba_stats, "WLSX-SWITCH-MIB", mib_dirs(array("aruba"))); }
  foreach ($switch_apinfo_oids as $oid) { echo("$oid "); $aruba_apstats = snmpwalk_cache_oid_num($device, $oid, $aruba_apstats, "WLSX-WLAN-MIB", mib_dirs(array("aruba"))); }
  foreach ($switch_apname_oids as $oid) { echo("$oid "); $aruba_apnames = snmpwalk_cache_oid_num($device, $oid, $aruba_apnames, "WLSX-WLAN-MIB", mib_dirs(array("aruba"))); }

  echo("\n");

  $rrdfile = $host_rrd . "/aruba-controller".safename(".rrd");
  if (!is_file($rrdfile))
  {
    rrdtool_create($rrdfile,"DS:NUMAPS:GAUGE:600:0:12500000000 DS:NUMCLIENTS:GAUGE:600:0:12500000000 ");
  }

  $cont_rrd_update="$polled:".$aruba_stats[0]['wlsxSwitchTotalNumAccessPoints'].":".$aruba_stats[0]['wlsxSwitchTotalNumStationsAssociated'];
  $ret = rrdtool_update($rrdfile, $cont_rrd_update);

  // also save the info about how many clients in the same place as the wireless module
  $wificlientsrrd  = $config['rrd_dir'] . "/" . $device['hostname'] . "/" . safename("wificlients-radio1.rrd");

  if (!is_file($wificlientsrrd))
  {
    rrdtool_create($wificlientsrrd,"DS:wificlients:GAUGE:600:-273:10000 ");
  }

  rrdtool_update($wificlientsrrd,"N:".$aruba_stats[0]['wlsxSwitchTotalNumStationsAssociated']);

  $graphs['wifi_clients'] = TRUE;

  foreach ($aruba_apnames as $key => $value)
  {
    $radioid       = str_replace("1.3.6.1.4.1.14823.2.2.1.5.2.1.5.1.16.","",$key);
    $name          = $value[''];
    $type          = $aruba_apstats["1.3.6.1.4.1.14823.2.2.1.5.2.1.5.1.2.$radioid"][''];
    $channel       = $aruba_apstats["1.3.6.1.4.1.14823.2.2.1.5.2.1.5.1.3.$radioid"]['']+0;
    $txpow         = $aruba_apstats["1.3.6.1.4.1.14823.2.2.1.5.2.1.5.1.4.$radioid"]['']+0;
    $radioutil     = $aruba_apstats["1.3.6.1.4.1.14823.2.2.1.5.2.1.5.1.6.$radioid"]['']+0;
    $numasoclients = $aruba_apstats["1.3.6.1.4.1.14823.2.2.1.5.2.1.5.1.7.$radioid"]['']+0;
    $nummonclients = $aruba_apstats["1.3.6.1.4.1.14823.2.2.1.5.2.1.5.1.8.$radioid"]['']+0;
    $numactbssid   = $aruba_apstats["1.3.6.1.4.1.14823.2.2.1.5.2.1.5.1.9.$radioid"]['']+0;
    $nummonbssid   = $aruba_apstats["1.3.6.1.4.1.14823.2.2.1.5.2.1.5.1.10.$radioid"]['']+0;
    $interference  = $aruba_apstats["1.3.6.1.4.1.14823.2.2.1.5.3.1.6.1.11.$radioid"]['']+0;

    $radionum      = substr($radioid,strlen($radioid)-1,1);

    if ($debug)
    {
      echo("* radioid: $radioid\n");
      echo("  radionum: $radionum\n");
      echo("  name: $name\n");
      echo("  type: $type\n");
      echo("  channel: $channel\n");
      echo("  txpow: $txpow\n");
      echo("  radioutil: $radioutil\n");
      echo("  numasoclients: $numasoclients\n");
      echo("  interference: $interference\n");

    }

    // if there is a numeric channel, assume the rest of the data is valid, I guess
    if (is_numeric($channel))
    {
      $rrd_file = $config['rrd_dir'] . "/" . $device['hostname'] ."/" .safename("arubaap-$name.$radionum.rrd");
      if (!is_file($rrd_file))
      {
        $dslist="DS:channel:GAUGE:600:0:200 ";
        $dslist.="DS:txpow:GAUGE:600:0:200 ";
        $dslist.="DS:radioutil:GAUGE:600:0:100 ";
        $dslist.="DS:nummonclients:GAUGE:600:0:500 ";
        $dslist.="DS:nummonbssid:GAUGE:600:0:200 ";
        $dslist.="DS:numasoclients:GAUGE:600:0:500 ";
        $dslist.="DS:interference:GAUGE:600:0:2000 ";
        rrdtool_create($rrd_file, "$dslist ");
      }

      rrdtool_update($rrd_file,  "$polled:".$channel.":".$txpow.":".$radioutil.":".$nummonclients.":".$nummonbssid.":".$numasoclients.":".$interference);
    }

    //generate the mac address
    $macparts=explode(".",$radioid,-1);
    $mac="";
    foreach ($macparts as $part) {
      $mac.=sprintf("%02x",$part).":";
    }
    $mac=rtrim($mac,":");

    $foundid=0;

    if (is_array($aps[$mac][$radionum]))
    {
      $ap_id = $aps[$mac][$radionum]['accesspoint_id'];
      dbUpdate(array('mac_addr' => $mac, 'deleted' => 0 ), 'accesspoints', '`accesspoint_id` = ?', Array($foundid));
      echo(".");
    } else {
      $ap_id = dbInsert(array('device_id' => $device['device_id'], 'name' => $name,'radio_number'=>$radionum, 'type'=>$type,'mac_addr'=>$mac, 'deleted' => '0'), 'accesspoints');
      echo("+");
    }

    if($aps[$mac][$radionum]['channel'] == NULL)
    {
       dbInsert(array('accesspoint_id' => $ap_id, 'channel'=>$channel,'txpow'=>$txpow,'radioutil'=>$radioutil,'numasoclients'=>$numasoclients,'nummonclients'=>$nummonclients,'numactbssid'=>$numactbssid,
                'nummonbssid'=>$nummonbssid,'interference'=>$interference), 'accesspoints-state');
    } else {
       dbUpdate(array('channel'=>$channel,'txpow'=>$txpow,'radioutil'=>$radioutil,'numasoclients'=>$numasoclients,'nummonclients'=>$nummonclients,
               'numactbssid'=>$numactbssid,'nummonbssid'=>$nummonbssid,'interference'=>$interference), 'accesspoints-state', '`accesspoint_id` = ?', Array($ap_id));
    }


  }

  //mark APs which are not on this controller anymore as deleted
  //learn to use foreach you fucking flaming spaztard! - adama
  for ($z=0;$z<sizeof($ap_db);$z++) {
    if (!isset($ap_db[$z]['seen']) && $ap_db[$z]['deleted']==0) {
      dbUpdate(array('deleted'=>1), 'accesspoints', '`accesspoint_id` = ?', Array($ap_db[$z]['accesspoint_id']));
    }

  }

}

?>
