<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage poller
 * @copyright  (C) 2006-2015 Adam Armstrong
 *
 */

/// We should walk, so we can discover here too.

// 'BGP4-MIB', 'CISCO-BGP4-MIB', 'BGP4-V2-MIB-JUNIPER', 'FORCE10-BGP4-V2-MIB'
if ($config['enable_bgp'] && is_device_mib($device, 'BGP4-MIB')) // Note, BGP4-MIB is main MIB, without it, the rest will not be checked
{
  echo("BGP Peers: ");

  // Get Local ASN
  $bgpLocalAs = snmp_get($device, 'bgpLocalAs.0', '-OUQvn', 'BGP4-MIB', mib_dirs());

  $bgp_oids  = array('bgpPeerState', 'bgpPeerAdminStatus', 'bgpPeerInUpdates', 'bgpPeerOutUpdates',
                     'bgpPeerInTotalMessages', 'bgpPeerOutTotalMessages', 'bgpPeerFsmEstablishedTime',
                     'bgpPeerInUpdateElapsedTime', 'bgpPeerLocalAddr', 'bgpPeerIdentifier');
  $cbgp_oids = array('cbgpPeerAcceptedPrefixes', 'cbgpPeerDeniedPrefixes', 'cbgpPeerPrefixAdminLimit',
                     'cbgpPeerPrefixThreshold', 'cbgpPeerPrefixClearThreshold', 'cbgpPeerAdvertisedPrefixes',
                     'cbgpPeerSuppressedPrefixes', 'cbgpPeerWithdrawnPrefixes');
  $vendor_oids = array(
    // Juniper BGP4-V2 MIB
    'BGP4-V2-MIB-JUNIPER' => array('vendor_PeerTable'               => 'jnxBgpM2PeerTable',
                                   'vendor_PeerState'               => 'jnxBgpM2PeerState',
                                   'vendor_PeerAdminStatus'         => 'jnxBgpM2PeerStatus', //'jnxBgpM2CfgPeerAdminStatus' not exist in JunOS
                                   'vendor_PeerInUpdates'           => 'jnxBgpM2PeerInUpdates',
                                   'vendor_PeerOutUpdates'          => 'jnxBgpM2PeerOutUpdates',
                                   'vendor_PeerInTotalMessages'     => 'jnxBgpM2PeerInTotalMessages',
                                   'vendor_PeerOutTotalMessages'    => 'jnxBgpM2PeerOutTotalMessages',
                                   'vendor_PeerFsmEstablishedTime'  => 'jnxBgpM2PeerFsmEstablishedTime',
                                   'vendor_PeerInUpdateElapsedTime' => 'jnxBgpM2PeerInUpdatesElapsedTime',
                                   'vendor_PeerLocalAs'             => 'jnxBgpM2PeerLocalAs',
                                   'vendor_PeerLocalAddr'           => 'jnxBgpM2PeerLocalAddr',
                                   'vendor_PeerIdentifier'          => 'jnxBgpM2PeerIdentifier',
                                   'vendor_PeerRemoteAs'            => 'jnxBgpM2PeerRemoteAs',
                                   'vendor_PeerRemoteAddr'          => 'jnxBgpM2PeerRemoteAddr',
                                   'vendor_PeerRemoteAddrType'      => 'jnxBgpM2PeerRemoteAddrType',
                                   'vendor_PeerIndex'               => 'jnxBgpM2PeerIndex',
                                   'vendor_PeerAcceptedPrefixes'    => 'jnxBgpM2PrefixInPrefixesAccepted',
                                   'vendor_PeerDeniedPrefixes'      => 'jnxBgpM2PrefixInPrefixesRejected',
                                   'vendor_PeerAdvertisedPrefixes'  => 'jnxBgpM2PrefixOutPrefixes',
                                   'vendor_PrefixCountersSafi'      => 'jnxBgpM2PrefixCountersSafi'),
    // Force10 BGP4-V2 MIB
    'FORCE10-BGP4-V2-MIB' => array('vendor_PeerTable'               => 'f10BgpM2PeerTable',
                                   'vendor_PeerState'               => 'f10BgpM2PeerState',
                                   'vendor_PeerAdminStatus'         => 'f10BgpM2PeerStatus',
                                   'vendor_PeerInUpdates'           => 'f10BgpM2PeerInUpdates',
                                   'vendor_PeerOutUpdates'          => 'f10BgpM2PeerOutUpdates',
                                   'vendor_PeerInTotalMessages'     => 'f10BgpM2PeerInTotalMessages',
                                   'vendor_PeerOutTotalMessages'    => 'f10BgpM2PeerOutTotalMessages',
                                   'vendor_PeerFsmEstablishedTime'  => 'f10BgpM2PeerFsmEstablishedTime',
                                   'vendor_PeerInUpdateElapsedTime' => 'f10BgpM2PeerInUpdatesElapsedTime',
                                   'vendor_PeerLocalAs'             => 'f10BgpM2PeerLocalAs',
                                   'vendor_PeerLocalAddr'           => 'f10BgpM2PeerLocalAddr',
                                   'vendor_PeerIdentifier'          => 'f10BgpM2PeerIdentifier',
                                   'vendor_PeerRemoteAs'            => 'f10BgpM2PeerRemoteAs',
                                   'vendor_PeerRemoteAddr'          => 'f10BgpM2PeerRemoteAddr',
                                   'vendor_PeerRemoteAddrType'      => 'f10BgpM2PeerRemoteAddrType',
                                   'vendor_PeerIndex'               => 'f10BgpM2PeerIndex',
                                   'vendor_PeerAcceptedPrefixes'    => 'f10BgpM2PrefixInPrefixesAccepted',
                                   'vendor_PeerDeniedPrefixes'      => 'f10BgpM2PrefixInPrefixesRejected',
                                   'vendor_PeerAdvertisedPrefixes'  => 'f10BgpM2PrefixOutPrefixes',
                                   'vendor_PrefixCountersSafi'      => 'f10BgpM2PrefixCountersSafi'),
  );

  $vendor_mib = FALSE;
  foreach ($vendor_oids as $v_mib => $v_array)
  {
    if (is_device_mib($device, $v_mib))
    {
      $vendor_mib = $v_mib; // Set to current vendor mib
      foreach ($v_array as $v => $val) { $$v = $val; }

      if ($v_mib === 'BGP4-V2-MIB-JUNIPER' && $bgpLocalAs === '0')
      {
        // On JunOS BGP4-MIB::bgpLocalAs.0 is always '0'.
        $j_bgpLocalAs = trim(snmp_walk($device, 'jnxBgpM2PeerLocalAs', '-OUQvn', 'BGP4-V2-MIB-JUNIPER'));
        list($bgpLocalAs) = explode("\n", $j_bgpLocalAs);
      }
      break;
    }
  }

  if (is_numeric($bgpLocalAs) && $bgpLocalAs != '0')
  {
    $bgpLocalAs = snmp_dewrap32bit($bgpLocalAs); // Dewrap for 32bit ASN
    echo("AS$bgpLocalAs ".PHP_EOL);

    $cisco_version = FALSE;
    if (is_device_mib($device, 'CISCO-BGP4-MIB'))
    {
      $cisco_version = 1;
      // Check Cisco cbgpPeer2Table first
      $cisco_peers = snmpwalk_cache_oid($device, 'cbgpPeer2State', array(), 'CISCO-BGP4-MIB', mib_dirs('cisco'));
      if (count($cisco_peers) > 0)
      {
        $cisco_version = 2;
      }
    }

    // Cache data
    echo("Caching: ");
    if ($cisco_version === 2)
    {
      echo(" CISCO-BGP4-MIB ");
      foreach ($bgp_oids as $bgp_oid)
      {
        $c_oid = str_replace(array('bgpPeer', 'Identifier'), array('cbgpPeer2', 'RemoteIdentifier'), $bgp_oid);
        $cisco_peers = snmpwalk_cache_oid($device, $c_oid, $cisco_peers, 'CISCO-BGP4-MIB', mib_dirs('cisco'));
      }
    } else {
      echo(" BGP4-MIB ");
      foreach ($bgp_oids as $bgp_oid)
      {
        $bgp_peers = snmpwalk_cache_multi_oid($device, $bgp_oid, $bgp_peers, 'BGP4-MIB', mib_dirs());
      }
    }

    if ($vendor_mib)
    {
      // Vendor specific IPv4/IPv6 BGP4 MIB
      echo(" $vendor_mib ");

      // Fetch BGP counters for vendor specific MIBs
      $vendor_bgp = snmpwalk_cache_oid_num2($device, $vendor_PeerIdentifier,          array(), $vendor_mib);
      if (count($vendor_bgp) > 0)
      {
        $vendor_bgp = snmpwalk_cache_oid_num2($device, $vendor_PeerRemoteAddr,          $vendor_bgp, $vendor_mib);
        //$vendor_bgp = snmpwalk_cache_oid_num2($device, $vendor_PeerRemoteAddrType,      $vendor_bgp, $vendor_mib);
        $vendor_bgp = snmpwalk_cache_oid_num2($device, $vendor_PeerLocalAddr,           $vendor_bgp, $vendor_mib);
        //$vendor_bgp = snmpwalk_cache_oid_num2($device, $vendor_PeerIndex,               $vendor_bgp, $vendor_mib);
        $vendor_bgp = snmpwalk_cache_oid_num2($device, $vendor_PeerState,               $vendor_bgp, $vendor_mib);
        $vendor_bgp = snmpwalk_cache_oid_num2($device, $vendor_PeerAdminStatus,         $vendor_bgp, $vendor_mib);
        $vendor_bgp = snmpwalk_cache_oid_num2($device, $vendor_PeerInUpdates,           $vendor_bgp, $vendor_mib);
        $vendor_bgp = snmpwalk_cache_oid_num2($device, $vendor_PeerOutUpdates,          $vendor_bgp, $vendor_mib);
        $vendor_bgp = snmpwalk_cache_oid_num2($device, $vendor_PeerInTotalMessages,     $vendor_bgp, $vendor_mib);
        $vendor_bgp = snmpwalk_cache_oid_num2($device, $vendor_PeerOutTotalMessages,    $vendor_bgp, $vendor_mib);
        $vendor_bgp = snmpwalk_cache_oid_num2($device, $vendor_PeerFsmEstablishedTime,  $vendor_bgp, $vendor_mib);
        $vendor_bgp = snmpwalk_cache_oid_num2($device, $vendor_PeerInUpdateElapsedTime, $vendor_bgp, $vendor_mib);
        // rewrite to pretty array.
        foreach ($vendor_bgp as $entry)
        {
          $v_ip = hex2ip($entry[$vendor_PeerRemoteAddr]);
          $entry[$vendor_PeerLocalAddr] = hex2ip($entry[$vendor_PeerLocalAddr]);
          $vendor_peers[$v_ip] = $entry;
        }

        // Fetch vendor specific counters
        $vendor_counters = snmpwalk_cache_oid($device, $vendor_PeerAcceptedPrefixes,            array(), $vendor_mib);
        $vendor_counters = snmpwalk_cache_oid($device, $vendor_PeerDeniedPrefixes,     $vendor_counters, $vendor_mib);
        $vendor_counters = snmpwalk_cache_oid($device, $vendor_PeerAdvertisedPrefixes, $vendor_counters, $vendor_mib);
      } else {
        $vendor_mib = FALSE;
      }
    }

    if ($cisco_version)
    {
      $c_prefixes = array();
      foreach ($cbgp_oids as $cbgp_oid)
      {
        $c_oid = ($cisco_version === 2) ? str_replace('cbgpPeer', 'cbgpPeer2', $cbgp_oid) : $cbgp_oid;
        $c_prefixes = snmpwalk_cache_oid($device, $c_oid, $c_prefixes, 'CISCO-BGP4-MIB', mib_dirs('cisco'));
      }
    }

    #print_vars($bgp_peers);
  }

  $sql  = 'SELECT *, `bgpPeers`.bgpPeer_id as bgpPeer_id ';
  $sql .= 'FROM `bgpPeers` ';
  $sql .= 'LEFT JOIN `bgpPeers-state` ON `bgpPeers`.bgpPeer_id = `bgpPeers-state`.bgpPeer_id ';
  $sql .= 'WHERE `device_id` = ?';

  foreach (dbFetchRows($sql, array($device['device_id'])) as $peer)
  {
    $peer_ip = $peer['bgpPeerRemoteAddr'];
    $remote_ip = (strstr($peer_ip, ':')) ? Net_IPv6::compress($peer_ip) : $peer_ip; // Compact IPv6. Used only for log.

    echo("Checking BGP peer: ".$peer_ip." ");

    if (!strstr($peer_ip, ':') && $cisco_version !== 2)
    {
      // Common IPv4 BGP4 MIB
      foreach ($bgp_oids as $bgp_oid)
      {
        $$bgp_oid = $bgp_peers[$peer_ip][$bgp_oid];
      }
    }
    else if ($cisco_version === 2)
    {
      // Cisco BGP4 V2 MIB
      $c_index = (strstr($peer_ip, ':')) ? 'ipv6.' . ip2hex($peer_ip, ':') : 'ipv4.' . $peer_ip;
      foreach ($bgp_oids as $bgp_oid)
      {
        $c_oid = str_replace(array('bgpPeer', 'Identifier'), array('cbgpPeer2', 'RemoteIdentifier'), $bgp_oid);
        if ($bgp_oid == 'bgpPeerLocalAddr') { $cisco_peers[$c_index][$c_oid] = hex2ip($cisco_peers[$c_index][$c_oid]);}
        $$bgp_oid = $cisco_peers[$c_index][$c_oid];
      }
    }
    else if ($vendor_mib)
    {
      foreach ($bgp_oids as $bgp_oid)
      {
        $vendor_oid = $vendor_oids[$vendor_mib][str_replace('bgp', 'vendor_', $bgp_oid)];
        $$bgp_oid = $vendor_peers[$peer_ip][$vendor_oid];
      }
    }
    print_debug(PHP_EOL."Peer: $peer_ip (State = $bgpPeerState, AdminStatus = $bgpPeerAdminStatus)");

    // FIXME I left the eventlog code for now, as soon as alerts send an entry to the eventlog this can go.
    if ($bgpPeerFsmEstablishedTime)
    {
      if (!(is_array($config['alerts']['bgp']['whitelist']) && !in_array($peer['bgpPeerRemoteAs'], $config['alerts']['bgp']['whitelist'])) && ($bgpPeerFsmEstablishedTime < $peer['bgpPeerFsmEstablishedTime'] || $bgpPeerState != $peer['bgpPeerState']))
      {
        if ($peer['bgpPeerState'] == $bgpPeerState)
        {
          log_event('BGP Session flapped: ' . $remote_ip . ' (AS' . $peer['bgpPeerRemoteAs'] . '), time '. formatUptime($bgpPeerFsmEstablishedTime) . ' ago', $device, 'bgp_peer', $peer['bgpPeer_id']);
        }
        else if ($bgpPeerState == "established")
        {
          log_event('BGP Session Up: ' . $remote_ip . ' (AS' . $peer['bgpPeerRemoteAs'] . '), time '. formatUptime($bgpPeerFsmEstablishedTime) . ' ago', $device, 'bgp_peer', $peer['bgpPeer_id'], 'warning');
        }
        else if ($peer['bgpPeerState'] == "established")
        {
          log_event('BGP Session Down: ' . $remote_ip . ' (AS' . $peer['bgpPeerRemoteAs'] . '), time '. formatUptime($bgpPeerFsmEstablishedTime) . ' ago.', $device, 'bgp_peer', $peer['bgpPeer_id'], 'warning');
        }
      }
    }

    check_entity('bgp_peer', $peer, array('bgpPeerState' => $bgpPeerState, 'bgpPeerAdminStatus' => $bgpPeerAdminStatus, 'bgpPeerFsmEstablishedTime' => $bgpPeerFsmEstablishedTime));

    $polled = time();
    $polled_period = $polled - $peer['bgpPeer_polled'];

    print_debug("[ polled $polled -> period $polled_period ]");

    $peer_rrd = 'bgp-' . $peer_ip . '.rrd';

    $create_rrd = "DS:bgpPeerOutUpdates:COUNTER:600:U:100000000000 \
                   DS:bgpPeerInUpdates:COUNTER:600:U:100000000000 \
                   DS:bgpPeerOutTotal:COUNTER:600:U:100000000000 \
                   DS:bgpPeerInTotal:COUNTER:600:U:100000000000 \
                   DS:bgpPeerEstablished:GAUGE:600:0:U ";

    rrdtool_create($device, $peer_rrd, $create_rrd);

    rrdtool_update($device, $peer_rrd, "N:$bgpPeerOutUpdates:$bgpPeerInUpdates:$bgpPeerOutTotalMessages:$bgpPeerInTotalMessages:$bgpPeerFsmEstablishedTime");

    // Update states
    $peer['update'] = array();
    foreach (array('bgpPeerState', 'bgpPeerAdminStatus', 'bgpPeerLocalAddr', 'bgpPeerIdentifier') as $oid)
    {
      if ($$oid != $peer[$oid]) { $peer['update'][$oid] = $$oid; }
    }

    if (count($peer['update']))
    {
      dbUpdate($peer['update'], 'bgpPeers', '`bgpPeer_id` = ?', array($peer['bgpPeer_id']));
    }

    // Update metrics
    $metrics = array('bgpPeerInUpdates', 'bgpPeerOutUpdates','bgpPeerInTotalMessages','bgpPeerOutTotalMessages');
    foreach ($metrics as $oid)
    {
      $peer['state'][$oid] = $$oid;
      if (isset($peer[$oid]) && $peer[$oid] != "0")
      {
        $peer['state'][$oid.'_delta'] = $peer['state'][$oid] - $peer[$oid];
        $peer['state'][$oid.'_rate']  = $oid_diff / $polled_period;
        if ($peer['state'][$oid.'_rate'] < 0)
        {
          $peer['state'][$oid.'_rate'] = '0';
          echo("$oid 回退.");
        }

        if ($config['statsd']['enable'] == TRUE)
        {
          // Update StatsD/Carbon
          StatsD::gauge(str_replace(".", "_", $device['hostname']).'.'.'bgp'.'.'.str_replace(".", "_", $peer_ip).'.'.$oid, $$oid);
        }
      }
    }

    if (!is_numeric($peer['bgpPeer_polled'])) {
      dbInsert(array('bgpPeer_id' => $peer['bgpPeer_id']), 'bgpPeers-state');
    }
    $peer['state']['bgpPeerFsmEstablishedTime'] = $bgpPeerFsmEstablishedTime;
    $peer['state']['bgpPeerInUpdateElapsedTime'] = $bgpPeerInUpdateElapsedTime;
    $peer['state']['bgpPeer_polled'] = $polled;
    dbUpdate($peer['state'], 'bgpPeers-state', '`bgpPeer_id` = ?', array($peer['bgpPeer_id']));

    if ($cisco_version || $vendor_mib)
    {
      // Poll each AFI/SAFI for this peer
      $peer_afis = dbFetchRows('SELECT * FROM bgpPeers_cbgp WHERE `device_id` = ? AND bgpPeerRemoteAddr = ?', array($device['device_id'], $peer_ip));
      foreach ($peer_afis as $peer_afi)
      {
        $afi = $peer_afi['afi'];
        $safi = $peer_afi['safi'];
        print_debug("$afi $safi");

        if ($cisco_version)
        {
          $c_index = ($cisco_version === 2) ? "$c_index.$afi.$safi" : "$peer_ip.$afi.$safi";
          foreach ($cbgp_oids as $cbgp_oid)
          {
            $c_oid = ($cisco_version === 2) ? str_replace('cbgpPeer', 'cbgpPeer2', $cbgp_oid) : $cbgp_oid;
            #$c_prefixes = snmpwalk_cache_oid($device, $c_oid, $c_prefixes, 'CISCO-BGP4-MIB', mib_dirs('cisco'));
            $$cbgp_oid = $c_prefixes[$c_index][$c_oid];
          }
        }

        if ($vendor_mib)
        {
          // Missing: cbgpPeerAdminLimit cbgpPeerPrefixThreshold cbgpPeerPrefixClearThreshold cbgpPeerSuppressedPrefixes cbgpPeerWithdrawnPrefixes

          // See posible AFI/SAFI here: https://www.juniper.net/techpubs/en_US/junos12.3/topics/topic-map/bgp-multiprotocol.html
          $afis['ipv4'] = '1';
          $afis['ipv6'] = '2';
          $safis = array('unicast' => 1,
                         'multicast' => 2,
                         'vpn' => 128);

          //$peer_index = $vendor_peers[$peer_ip][$vendor_PeerIndex];
          $peer_index = $peer_afi['bgpPeerIndex'];
          $index = (isset($vendor_counters[$peer_index.'.'.$afi.'.'.$safis[$safi]])) ? $peer_index.'.'.$afi.'.'.$safis[$safi] : $peer_index.'.'.$afis[$afi].'.'.$safis[$safi];

          $cbgpPeerAcceptedPrefixes   = $vendor_counters[$index][$vendor_PeerAcceptedPrefixes];
          $cbgpPeerDeniedPrefixes     = $vendor_counters[$index][$vendor_PeerDeniedPrefixes];
          $cbgpPeerAdvertisedPrefixes = $vendor_counters[$index][$vendor_PeerAdvertisedPrefixes];
        }

        // Update cbgp states
        $peer['c_update']['AcceptedPrefixes']     = $cbgpPeerAcceptedPrefixes;
        $peer['c_update']['DeniedPrefixes']       = $cbgpPeerDeniedPrefixes;
        $peer['c_update']['PrefixAdminLimit']     = $cbgpPeerPrefixAdminLimit;
        $peer['c_update']['PrefixThreshold']      = $cbgpPeerPrefixThreshold;
        $peer['c_update']['PrefixClearThreshold'] = $cbgpPeerPrefixClearThreshold;
        $peer['c_update']['AdvertisedPrefixes']   = $cbgpPeerAdvertisedPrefixes;
        $peer['c_update']['SuppressedPrefixes']   = $cbgpPeerSuppressedPrefixes;
        $peer['c_update']['WithdrawnPrefixes']    = $cbgpPeerWithdrawnPrefixes;
        if (dbFetchCell('SELECT COUNT(`cbgp_id`) FROM `bgpPeers_cbgp-state` WHERE `cbgp_id` = ?', array($peer_afi['cbgp_id'])) == 0)
        {
          dbInsert(array('cbgp_id' => $peer_afi['cbgp_id']), 'bgpPeers_cbgp-state');
        }
        dbUpdate($peer['c_update'], 'bgpPeers_cbgp-state', '`cbgp_id` = ?', array($peer_afi['cbgp_id']));

        // Update cbgp StatsD

        if ($config['statsd']['enable'] == TRUE)
        {
          foreach (array('AcceptedPrefixes', 'DeniedPrefixes', 'AdvertisedPrefixes', 'SuppressedPrefixes', 'WithdrawnPrefixes') as $oid)
          {
            // Update StatsD/Carbon
            $r_oid = 'cbgpPeer'.$oid;
            StatsD::gauge(str_replace(".", "_", $device['hostname']).'.'.'bgp' . '.' . str_replace(".", "_", $peer_ip).".$afi.$safi" . '.' . $oid, $$r_oid);
          }
        }

        // Update cbgp RRD
        $cbgp_rrd = "cbgp-$peer_ip.$afi.$safi.rrd";

        $rrd_create = "DS:AcceptedPrefixes:GAUGE:600:U:100000000000 \
                       DS:DeniedPrefixes:GAUGE:600:U:100000000000 \
                       DS:AdvertisedPrefixes:GAUGE:600:U:100000000000 \
                       DS:SuppressedPrefixes:GAUGE:600:U:100000000000 \
                       DS:WithdrawnPrefixes:GAUGE:600:U:100000000000 ";
        rrdtool_create($device, $cbgp_rrd, $rrd_create);

        rrdtool_update($device, $cbgp_rrd, "N:$cbgpPeerAcceptedPrefixes:$cbgpPeerDeniedPrefixes:$cbgpPeerAdvertisedPrefixes:$cbgpPeerSuppressedPrefixes:$cbgpPeerWithdrawnPrefixes");
      } # while
    } # os_group=cisco | vendors
    echo(PHP_EOL);

  } // End While loop on peers
} // End check for BGP support

// Clean
unset($bgp_peers, $vendor_peers, $vendor_mib, $cisco_version, $cisco_peers, $c_prefixes);

// EOF
