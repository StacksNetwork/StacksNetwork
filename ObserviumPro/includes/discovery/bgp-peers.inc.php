<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage discovery
 * @copyright  (C) 2006-2015 Adam Armstrong
 *
 */

// 'BGP4-MIB', 'CISCO-BGP4-MIB', 'BGP4-V2-MIB-JUNIPER', 'FORCE10-BGP4-V2-MIB'
if ($config['enable_bgp'] && is_device_mib($device, 'BGP4-MIB')) // Note, BGP4-MIB is main MIB, without it, the rest will not be checked
{
  echo("BGP会话: ");

  // Get Local ASN
  $bgpLocalAs = snmp_get($device, 'bgpLocalAs.0', '-OUQvn', 'BGP4-MIB', mib_dirs());

  $vendor_oids = array(
    // Juniper BGP4-V2 MIB
    'BGP4-V2-MIB-JUNIPER' => array('vendor_PeerTable'          => 'jnxBgpM2PeerTable',
                                   'vendor_PeerRemoteAs'       => 'jnxBgpM2PeerRemoteAs',
                                   'vendor_PeerRemoteAddr'     => 'jnxBgpM2PeerRemoteAddr',
                                   'vendor_PeerLocalAddr'      => 'jnxBgpM2PeerLocalAddr',
                                   'vendor_PeerIdentifier'     => 'jnxBgpM2PeerIdentifier',
                                   'vendor_PeerIndex'          => 'jnxBgpM2PeerIndex',
                                   'vendor_PeerRemoteAddrType' => 'jnxBgpM2PeerRemoteAddrType',
                                   'vendor_PrefixCountersSafi' => 'jnxBgpM2PrefixCountersSafi'),
    // Force10 BGP4-V2 MIB
    'FORCE10-BGP4-V2-MIB' => array('vendor_PeerTable'          => 'f10BgpM2PeerTable',
                                   'vendor_PeerRemoteAs'       => 'f10BgpM2PeerRemoteAs',
                                   'vendor_PeerRemoteAddr'     => 'f10BgpM2PeerRemoteAddr',
                                   'vendor_PeerLocalAddr'      => 'f10BgpM2PeerLocalAddr',
                                   'vendor_PeerIdentifier'     => 'f10BgpM2PeerIdentifier',
                                   'vendor_PeerIndex'          => 'f10BgpM2PeerIndex',
                                   'vendor_PeerRemoteAddrType' => 'f10BgpM2PeerRemoteAddrType',
                                   'vendor_PrefixCountersSafi' => 'f10BgpM2PrefixCountersSafi'),
  );

  $vendor_mib = FALSE;
  foreach ($vendor_oids as $v_mib => $v_array)
  {
    if (is_device_mib($device, $v_mib))
    {
      $vendor_mib = $v_mib; // Set to current vendor mib
      echo(" $v_mib ");
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
  // Discover BGP peers

  /// NOTE. PeerIdentifier != PeerRemoteAddr

  if (is_numeric($bgpLocalAs) && $bgpLocalAs != '0')
  {
    $bgpLocalAs = snmp_dewrap32bit($bgpLocalAs); // Dewrap for 32bit ASN
    echo("AS$bgpLocalAs ".PHP_EOL);

    if ($bgpLocalAs != $device['bgpLocalAs'])
    {
      if (!$device['bgpLocalAs'])
      {
        log_event('BGP本地ASN已添加: AS' . $bgpLocalAs, $device, 'device', $device['device_id']);
      }
      elseif (!$bgpLocalAs)
      {
        log_event('BGP本地ASN已删除: AS' . $device['bgpLocalAs'], $device, 'device', $device['device_id']);
      }
      else
      {
        log_event('BGP ASN已更改: AS' . $device['bgpLocalAs'] . ' -> AS' . $bgpLocalAs, $device, 'device', $device['device_id']);
      }
      dbUpdate(array('bgpLocalAs' => $bgpLocalAs) , 'devices', 'device_id = ?', array($device['device_id']));
      print_message('更新ASN (从 '.$device['bgpLocalAs']." -> $bgpLocalAs)");
    }
    echo(" BGP4-MIB ");

    $cisco_version = FALSE;
    if (is_device_mib($device, 'CISCO-BGP4-MIB'))
    {
      $cisco_version = 1;
      // Check Cisco cbgpPeer2Table
      $cisco_peers = snmpwalk_cache_oid($device, 'cbgpPeer2RemoteAs', array(), 'CISCO-BGP4-MIB', mib_dirs('cisco'));
      if (count($cisco_peers) > 0)
      {
        echo(" CISCO-BGP4-MIB ");
        $cisco_version = 2;
        $cisco_peers = snmpwalk_cache_oid($device, 'cbgpPeer2LocalAddr',        $cisco_peers, 'CISCO-BGP4-MIB', mib_dirs('cisco'));
        $cisco_peers = snmpwalk_cache_oid($device, 'cbgpPeer2RemoteIdentifier', $cisco_peers, 'CISCO-BGP4-MIB', mib_dirs('cisco'));

        print_debug("CISCO-BGP4-MIB Peers: ");
        foreach ($cisco_peers as $peer_ip => $entry)
        {
          list(,$peer_ip) = explode('.', $peer_ip, 2);
          $peer_ip  = hex2ip($peer_ip);
          $local_ip = hex2ip($entry['cbgpPeer2LocalAddr']);
          if ($peer_ip  == '0.0.0.0') { $peer_ip  = ''; }
          $peer_as  = $entry['cbgpPeer2RemoteAs'];
          if (!isset($p_list[$peer_ip][$peer_as]) && $peer_ip != '')
          {
            $p_list[$peer_ip][$peer_as] = 1;
            $peerlist[] = array('id' => $entry['cbgpPeer2RemoteIdentifier'], 'local_ip' => $local_ip, 'ip' => $peer_ip, 'as' => $peer_as);
            print_debug("发现对等IP: $peer_ip (AS$peer_as, 本地IP: $local_ip)");
          } //else { echo('nope'); }
        }
      }
    }

    if ($cisco_version !== 2)
    {
      // All MIBs exept CISCO-BGP4-MIB
      $peers_data = snmpwalk_cache_oid($device, 'bgpPeerRemoteAs', array(), 'BGP4-MIB', mib_dirs());
      $peers_data = snmpwalk_cache_oid($device, 'bgpPeerRemoteAddr', $peers_data, 'BGP4-MIB', mib_dirs());
      $peers_data = snmpwalk_cache_oid($device, 'bgpPeerLocalAddr', $peers_data, 'BGP4-MIB', mib_dirs());
      $peers_data = snmpwalk_cache_oid($device, 'bgpPeerIdentifier', $peers_data, 'BGP4-MIB', mib_dirs());
      print_debug("BGP4-MIB Peers: ");
      foreach ($peers_data as $peer)
      {
        $peer_as  = snmp_dewrap32bit($peer['bgpPeerRemoteAs']); // Dewrap for 32bit ASN
        $peer_ip  = $peer['bgpPeerRemoteAddr'];
        $local_ip = $peer['bgpPeerLocalAddr'];
        if ($peer_ip  == '0.0.0.0') { $peer_ip  = ''; }
        if (!isset($p_list[$peer_ip][$peer_as]) && $peer_ip != '')
        {
          print_debug("发现对等IP: $peer_ip (AS$peer_as, 本地IP: $local_ip)");
          $peerlist[] = array('id' => $peer['bgpPeerIdentifier'], 'local_ip' => $local_ip, 'ip' => $peer_ip, 'as' => $peer_as);
          $p_list[$peer_ip][$peer_as] = 1;
        }
      }
    }

    if ($vendor_mib)
    {
      $vendor_bgp = snmpwalk_cache_oid_num2($device, $vendor_PeerRemoteAs, array(), $vendor_mib);
      if (count($vendor_bgp) > 0)
      {
        echo(" $vendor_mib ");
        $vendor_bgp = snmpwalk_cache_oid_num2($device, $vendor_PeerRemoteAddr, $vendor_bgp, $vendor_mib);
        $vendor_bgp = snmpwalk_cache_oid_num2($device, $vendor_PeerLocalAddr,  $vendor_bgp, $vendor_mib);
        $vendor_bgp = snmpwalk_cache_oid_num2($device, $vendor_PeerIdentifier, $vendor_bgp, $vendor_mib);

        print_debug("$vendor_mib Peers: ");
        foreach ($vendor_bgp as $entry)
        {
          $peer_ip  = hex2ip($entry[$vendor_PeerRemoteAddr]);
          $local_ip = hex2ip($entry[$vendor_PeerLocalAddr]);
          if ($peer_ip  == '0.0.0.0') { $peer_ip  = ''; }
          $peer_as = $entry[$vendor_PeerRemoteAs];
          if (!isset($p_list[$peer_ip][$peer_as]) && $peer_ip != '')
          {
            $p_list[$peer_ip][$peer_as] = 1;
            $peerlist[] = array('id' => $entry[$vendor_PeerIdentifier], 'local_ip' => $local_ip, 'ip' => $peer_ip, 'as' => $peer_as);
            print_debug("发现对等IP: $peer_ip (AS$peer_as, 本地IP: $local_ip)");
          }
        }
      } else {
        $vendor_mib = FALSE; // Unset vendor_mib since not found on device
      }
    } # Vendors

  } else {
    echo("No BGP on host");
    if (is_numeric($device['bgpLocalAs']))
    {
      log_event('BGP ASN已删除: AS' . $device['bgpLocalAs'], $device, 'bgp');
      dbUpdate(array('bgpLocalAs' => array('NULL')) , 'devices', 'device_id = ?', array($device['device_id']));
      print_message('删除ASN ('.$device['bgpLocalAs'].')');
    } # End if
  } # End if

  // Process discovered peers

  if (isset($peerlist))
  {
    // Walk vendor oids
    if ($vendor_mib)
    {
      //$vendor_bgp = snmpwalk_cache_oid_num2($device, $vendor_PeerRemoteAs,       $vendor_bgp, $vendor_mib);
      //$vendor_bgp = snmpwalk_cache_oid_num2($device, $vendor_PeerRemoteAddr,     $vendor_bgp, $vendor_mib);
      $vendor_bgp = snmpwalk_cache_oid_num2($device, $vendor_PeerRemoteAddrType, $vendor_bgp, $vendor_mib);
      $vendor_bgp = snmpwalk_cache_oid_num2($device, $vendor_PeerIndex,          $vendor_bgp, $vendor_mib);
      $vendor_counters = snmpwalk_cache_oid($device, $vendor_PrefixCountersSafi,     array(), $vendor_mib);
    }

    foreach ($peerlist as $peer)
    {
      $astext = get_astext($peer['as']);
      $reverse_dns = gethostbyaddr6($peer['ip']);
      if ($reverse_dns == $peer['ip']) { unset($reverse_dns); }

      if (dbFetchCell('SELECT COUNT(*) FROM `bgpPeers` WHERE `device_id` = ? AND `bgpPeerRemoteAddr` = ?', array($device['device_id'], $peer['ip'])) < '1')
      {
        $params = array('device_id' => $device['device_id'], 'bgpPeerIdentifier' => $peer['id'], 'bgpPeerRemoteAddr' => $peer['ip'], 'bgpPeerLocalAddr' => $peer['local_ip'], 'bgpPeerRemoteAS' => $peer['as'], 'astext' => $astext, 'reverse_dns' => $reverse_dns);
        dbInsert($params, 'bgpPeers');
        echo('+');
      } else {
        dbUpdate(array('bgpPeerRemoteAs' => $peer['as'], 'astext' => $astext, 'reverse_dns' => $reverse_dns, 'bgpPeerLocalAddr' => $peer['local_ip'], 'bgpPeerIdentifier' => $peer['id']) , 'bgpPeers', 'device_id = ? AND bgpPeerRemoteAddr = ?', array($device['device_id'], $peer['ip']));
        echo('.');
      }

      // Autodiscovery for ibgp neighbours
      if ($config['autodiscovery']['bgp'] && $peer['as'] == $device['bgpLocalAs'])
      {
        discover_new_device($peer['ip'], 'bgp', 'BGP', $device);
      }
    } # Foreach

    // AFI/SAFI for specific vendors
    if ($cisco_version || $vendor_mib)
    {
      unset($af_list);

      if ($cisco_version)
      {
        // Get afi/safi and populate cbgp on cisco ios (xe/xr)

        if ($cisco_version === 2)
        {
          $af_data = snmpwalk_cache_oid($device, 'cbgpPeer2AddrFamilyName', $cbgp, 'CISCO-BGP4-MIB', mib_dirs('cisco'));
        } else {
          $af_data = snmpwalk_cache_oid($device, 'cbgpPeerAddrFamilyName', $cbgp, 'CISCO-BGP4-MIB', mib_dirs('cisco'));
        }

        foreach ($af_data as $af => $entry)
        {
          if ($cisco_version === 2)
          {
            list(,$af) = explode('.', $af, 2);
            $text = $entity['cbgpPeer2AddrFamilyName'];
          } else {
            $text = $entity['cbgpPeerAddrFamilyName'];
          }
          $afisafi = explode('.', $af);
          $c = count($afisafi);
          $afi = $afisafi[$c - 2];
          $safi = $afisafi[$c - 1];
          $peer_ip = hex2ip(str_replace(".$afi.$safi", '', $af));
          print_debug("对等IP: $peer_ip, AFI: $afi, SAFI: $safi");
          if ($afi && $safi)
          {
            $af_list[$peer_ip][$afi][$safi] = 1;
            if (dbFetchCell('SELECT COUNT(*) FROM `bgpPeers_cbgp` WHERE `device_id` = ? AND `bgpPeerRemoteAddr` = ? AND `afi` = ? AND `safi` = ?', array($device['device_id'], $peer_ip, $afi, $safi)) == 0)
            {
              $params = array('device_id' => $device['device_id'], 'bgpPeerRemoteAddr' => $peer_ip, 'afi' => $afi, 'safi' => $safi);
              dbInsert($params, 'bgpPeers_cbgp');
            }
          }
        }
      } # cisco_version

      if ($vendor_mib)
      {
        // See posible AFI/SAFI here: https://www.juniper.net/techpubs/en_US/junos12.3/topics/topic-map/bgp-multiprotocol.html
        $afis['ipv4'] = '1';
        $afis['ipv6'] = '2';
        $safis = array(1 => 'unicast',
                       2 => 'multicast',
                       128 => 'vpn');

        foreach ($vendor_bgp as $entry)
        {
          $peer_ip = hex2ip($entry[$vendor_PeerRemoteAddr]);
          $peer_as = $entry[$vendor_PeerRemoteAs];
          $index = $entry[$vendor_PeerIndex];
          $afi = $entry[$vendor_PeerRemoteAddrType];

          foreach ($safis as $i => $safi)
          {
            if (isset($vendor_counters[$index.'.'.$afi.".$i"]) || isset($vendor_counters[$index.'.'.$afis[$afi].".$i"]))
            {
              if (is_numeric($afi)) { $afi = $afis[$afi]; }
              print_debug("INDEX: $index, AS: $peer_as, IP: $peer_ip, AFI: $afi, SAFI: $safi");
              if (OBS_DEBUG > 1) { var_dump($entry); }
              $af_list[$peer_ip][$afi][$safi] = 1;
              if (dbFetchCell('SELECT COUNT(*) FROM `bgpPeers_cbgp` WHERE `device_id` = ? AND `bgpPeerRemoteAddr` = ? AND `afi` = ? AND `safi` = ?', array($device['device_id'], $peer_ip, $afi, $safi)) == 0)
              {
                $params = array('device_id' => $device['device_id'], 'bgpPeerRemoteAddr' => $peer_ip, 'bgpPeerIndex' => $index, 'afi' => $afi, 'safi' => $safi);
                dbInsert($params, 'bgpPeers_cbgp');
              }
              else if ($index >= 0)
              {
                // Update Index
                $params = array('device_id' => $device['device_id'], 'bgpPeerRemoteAddr' => $peer_ip, 'afi' => $afi, 'safi' => $safi);
                dbUpdate(array('bgpPeerIndex' => $index), 'bgpPeers_cbgp', 'device_id = ? AND `bgpPeerRemoteAddr` = ? AND `afi` = ? AND `safi` = ?', array($device['device_id'], $peer_ip, $afi, $safi));
              }
            }
          }
        }
      } # Vendors

      // Remove deleted AFI/SAFI
      unset($afi, $safi, $peer_ip);
      $query = 'SELECT * FROM bgpPeers_cbgp WHERE `device_id` = ?';
      foreach (dbFetchRows($query, array($device['device_id'])) as $entry)
      {
        $peer_ip = $entry['bgpPeerRemoteAddr'];
        $afi = $entry['afi'];
        $safi = $entry['safi'];
        $cbgp_id = $entry['cbgp_id'];
        if (!isset($af_list[$peer_ip][$afi][$safi]))
        {
          dbDelete('bgpPeers_cbgp', '`cbgp_id` = ?', array($cbgp_id));
          dbDelete('bgpPeers_cbgp-state', '`cbgp_id` = ?', array($cbgp_id));
        }
      } # AF list
    } # os=cisco|some vendors

  } # isset

  // Delete removed peers
  unset($peer_ip, $peer_as);
  $query = 'SELECT * FROM bgpPeers WHERE device_id = ?';
  foreach (dbFetchRows($query, array($device['device_id'])) as $entry)
  {
    $peer_ip = $entry['bgpPeerRemoteAddr'];
    $peer_as = $entry['bgpPeerRemoteAs'];

    if (!isset($p_list[$peer_ip][$peer_as]))
    {
      dbDelete('bgpPeers', '`bgpPeer_id` = ?', array($entry['bgpPeer_id']));
      dbDelete('bgpPeers-state', '`bgpPeer_id` = ?', array($entry['bgpPeer_id']));
      echo("-");
    }
  }

  unset($p_list, $peerlist, $vendor_mib, $cisco_version, $cisco_peers);

  echo(PHP_EOL);
}

// EOF
