<?php

#CISCO-VPDN-MGMT-MIB::cvpdnTunnelTotal.0 = Gauge32: 0 tunnels
#CISCO-VPDN-MGMT-MIB::cvpdnSessionTotal.0 = Gauge32: 0 users
#CISCO-VPDN-MGMT-MIB::cvpdnDeniedUsersTotal.0 = Counter32: 0 attempts
#CISCO-VPDN-MGMT-MIB::cvpdnSystemTunnelTotal.l2tp = Gauge32: 437 tunnels
#CISCO-VPDN-MGMT-MIB::cvpdnSystemSessionTotal.l2tp = Gauge32: 1029 sessions
#CISCO-VPDN-MGMT-MIB::cvpdnSystemDeniedUsersTotal.l2tp = Counter32: 0 attempts
#CISCO-VPDN-MGMT-MIB::cvpdnSystemClearSessions.0 = INTEGER: none(1)

if ($device['os_group'] == "cisco")
{
  $data = snmpwalk_cache_oid($device, "cvpdnSystemEntry", NULL, "CISCO-VPDN-MGMT-MIB");

  foreach ($data as $type => $vpdn)
  {

    $rrd_filename = $config['rrd_dir'] . "/" . $device['hostname'] . "/" . safename("vpdn-".$type.".rrd");

    if (is_file($rrd_filename) || $vpdn['cvpdnSystemTunnelTotal'] || $vpdn['cvpdnSystemSessionTotal'])
    {
      if (!file_exists($rrd_filename))
      {
        rrdtool_create($rrd_filename, " DS:tunnels:GAUGE:600:0:U DS:sessions:GAUGE:600:0:U DS:denied:COUNTER:600:0:100000" );
      }

      rrdtool_update($rrd_filename, array($vpdn['cvpdnSystemTunnelTotal'], $vpdn['cvpdnSystemSessionTotal'], $vpdn['cvpdnSystemDeniedUsersTotal']));

      $graphs['vpdn_sessions_'.$type]   = TRUE;
      $graphs['vpdn_tunnels_'.$type]   = TRUE;

      echo(" Cisco VPDN ($type) ");
    }
  }
  unset($data, $vpdn, $type, $rrd_filename);
}

?>
