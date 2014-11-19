<?php

$vp_rows = dbFetchRows("SELECT * FROM `ports` AS P, `juniAtmVp` AS J WHERE P.`device_id` = ? AND J.port_id = P.port_id", array($device['device_id']));

if (count($vp_rows))
{
  $vp_cache = array();
  $vp_cache = snmpwalk_cache_multi_oid($device, "juniAtmVpStatsInCells",        $vp_cache, "Juniper-UNI-ATM-MIB", mib_dirs("junose"));
  $vp_cache = snmpwalk_cache_multi_oid($device, "juniAtmVpStatsInPackets",      $vp_cache, "Juniper-UNI-ATM-MIB", mib_dirs("junose"));
  $vp_cache = snmpwalk_cache_multi_oid($device, "juniAtmVpStatsInPacketOctets", $vp_cache, "Juniper-UNI-ATM-MIB", mib_dirs("junose"));
  $vp_cache = snmpwalk_cache_multi_oid($device, "juniAtmVpStatsInPacketErrors", $vp_cache, "Juniper-UNI-ATM-MIB", mib_dirs("junose"));
  $vp_cache = snmpwalk_cache_multi_oid($device, "juniAtmVpStatsOutCells",       $vp_cache, "Juniper-UNI-ATM-MIB", mib_dirs("junose"));
  $vp_cache = snmpwalk_cache_multi_oid($device, "juniAtmVpStatsOutPackets",     $vp_cache, "Juniper-UNI-ATM-MIB", mib_dirs("junose"));
  $vp_cache = snmpwalk_cache_multi_oid($device, "juniAtmVpStatsOutPacketOctets", $vp_cache, "Juniper-UNI-ATM-MIB", mib_dirs("junose"));
  $vp_cache = snmpwalk_cache_multi_oid($device, "juniAtmVpStatsOutPacketErrors", $vp_cache, "Juniper-UNI-ATM-MIB", mib_dirs("junose"));

  echo("Checking JunOSe ATM vps: ");

  foreach ($vp_rows as $vp)
  {
    echo(".");

    $oid = $vp['ifIndex'].".".$vp['vp_id'];

    if ($debug) { echo("$oid "); }

    $t_vp = $vp_cache[$oid];

    $vp_update = $t_vp['juniAtmVpStatsInCells'].":".$t_vp['juniAtmVpStatsOutCells'];
    $vp_update .= ":".$t_vp['juniAtmVpStatsInPackets'].":".$t_vp['juniAtmVpStatsOutPackets'];
    $vp_update .= ":".$t_vp['juniAtmVpStatsInPacketOctets'].":".$t_vp['juniAtmVpStatsOutPacketOctets'];
    $vp_update .= ":".$t_vp['juniAtmVpStatsInPacketErrors'].":".$t_vp['juniAtmVpStatsOutPacketErrors'];

    $rrd  = $config['rrd_dir'] . "/" . $device['hostname'] . "/" . safename("vp-" . $vp['ifIndex'] . "-".$vp['vp_id'].".rrd");

    if ($debug) { echo("$rrd "); }

    if (!is_file($rrd))
    {
      rrdtool_create ($rrd, " \
      DS:incells:DERIVE:600:0:125000000000 \
      DS:outcells:DERIVE:600:0:125000000000 \
      DS:inpackets:DERIVE:600:0:125000000000 \
      DS:outpackets:DERIVE:600:0:125000000000 \
      DS:inpacketoctets:DERIVE:600:0:125000000000 \
      DS:outpacketoctets:DERIVE:600:0:125000000000 \
      DS:inpacketerrors:DERIVE:600:0:125000000000 \
      DS:outpacketerrors:DERIVE:600:0:125000000000 \
      ");
    }

    rrdtool_update($rrd,"N:$vp_update");
  }

  echo("\n");

  unset($vp_cache);
}

?>
