<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage discovery
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

echo("VLANs:\n");

// Pre-cache the existing state of VLANs for this device from the database
unset($vlans_db, $ports_vlans_db, $ports_vlans);

$vlans_db_raw = dbFetchRows("SELECT * FROM `vlans` WHERE `device_id` = ?;", array($device['device_id']));
foreach ($vlans_db_raw as $vlan_db)
{
  $vlans_db[$vlan_db['vlan_domain']][$vlan_db['vlan_vlan']] = $vlan_db;
}

$ports_vlans_db_raw = dbFetchRow("SELECT * FROM `ports_vlans` WHERE `device_id` = ?;", array($device['device_id']));
foreach ($ports_vlans_db_raw as $vlan_db)
{
  $ports_vlans_db[$vlan_db['port_id']][$vlan_db['vlan']] = $vlan_db;
}

// Create an empty array to record what VLANs we discover this session.
$device['vlans'] = array();

// Include all discovery modules
$include_dir = "includes/discovery/vlans";
include("includes/include-dir-mib.inc.php");

// Always discover Q-BRIDGE-MIB
include("vlans/q-bridge-mib.inc.php");

foreach ($device['vlans'] as $domain_id => $vlans)
{
  foreach ($vlans as $vlan_id => $vlan)
  {
    // Pull Tables for this VLAN

    // /usr/bin/snmpbulkwalk -v2c -c kglk5g3l454@988  -OQUs  -m BRIDGE-MIB -M /opt/observium/mibs/ udp:sw2.ahf:161 dot1dStpPortEntry
    // /usr/bin/snmpbulkwalk -v2c -c kglk5g3l454@988  -OQUs  -m BRIDGE-MIB -M /opt/observium/mibs/ udp:sw2.ahf:161 dot1dBasePortEntry

    // FIXME - do this only when vlan type == ethernet?
    if (is_numeric($vlan_id) && ($vlan_id <1002 || $vlan_id > 1105)) // Ignore reserved VLAN IDs
    {
      if ($device['os_group'] == "cisco" && $device['os'] != 'ciscosb')  // This shit only seems to work on Cisco
      {
        list($ios_version) = explode('(', $device['version']);

        // vlan context not worked on Cisco IOS <= 12.1 (SNMPv3)
        if ($device['snmpver'] == 'v3' && $device['os'] == "ios" && ($ios_version * 10) <= 121)
        {
          print_error("ERROR: For VLAN context to work on this device please use SNMP v2/v1 for this device (or upgrade IOS).");
          break;
        }
        $device_context = $device;
        $device_context['snmpcontext'] = $vlan_id;
        $vlan_data = snmpwalk_cache_oid($device_context, "dot1dStpPortEntry", array(), "BRIDGE-MIB:Q-BRIDGE-MIB");

        // Detection shit snmpv3 authorization errors for contexts
        if ($exec_status['exitcode'] != 0)
        {
          unset($device_context);
          if ($device['snmpver'] == 'v3')
          {
            print_error("ERROR: For VLAN context to work on Cisco devices with SNMPv3, it is necessary to add 'match prefix' in snmp-server config.");
          } else {
            print_error("ERROR: Device does not support per-VLAN community.");
          }
          break;
        }
        $vlan_data = snmpwalk_cache_oid($device_context, "dot1dBasePortEntry", $vlan_data, "BRIDGE-MIB:Q-BRIDGE-MIB");
        unset($device_context);
      }

      echo("VLAN $vlan_id \n");

      if ($vlan_data)
      {
        echo(str_pad("dot1d id", 10).str_pad("ifIndex", 10).str_pad("Port Name", 25).
             str_pad("Priority", 10).str_pad("State", 15).str_pad("Cost", 10)."\n");
      }

      foreach ($vlan_data as $vlan_port_id => $vlan_port)
      {
        $port = get_port_by_index_cache($device, $vlan_port['dot1dBasePortIfIndex']);
        echo(str_pad($vlan_port_id, 10).str_pad($vlan_port['dot1dBasePortIfIndex'], 10).
        str_pad($port['ifDescr'],25).str_pad($vlan_port['dot1dStpPortPriority'], 10).
        str_pad($vlan_port['dot1dStpPortState'], 15).str_pad($vlan_port['dot1dStpPortPathCost'], 10));

        $db_w = array('device_id' => $device['device_id'],
                      'port_id'   => $port['port_id'],
                      'vlan'      => $vlan_id);

        $db_a = array('baseport'  => $vlan_port_id,
                      'priority'  => $vlan_port['dot1dStpPortPriority'],
                      'state'     => $vlan_port['dot1dStpPortState'],
                      'cost'      => $vlan_port['dot1dStpPortPathCost']);

        if (isset($ports_vlans_db[$port['port_id']][$vlan_id]))
        {
          $id = $ports_vlans_db[$port['port_id']][$vlan_id]['port_vlan_id'];
          dbUpdate($db_a, 'ports_vlans', "`port_vlan_id` = ?", $id);
          $ports_vlans[$port['port_id']][$vlan_id] = $id;
          echo("SU");
        } else {
          $id = dbInsert(array_merge($db_w, $db_a), 'ports_vlans');
          echo("S+");
          $ports_vlans[$port['port_id']][$vlan_id] = $id;
        }
      }
    }
  }
}

foreach ($ports_vlans_db as $port_id => $vlans)
{
  foreach ($vlans as $vlan_id => $vlan)
  {
    if (empty($ports_vlans[$port_id][$vlan_id]))
    {
      dbDelete('ports_vlans', "`port_vlan_id` = ?", array($ports_vlans_db[$port_id][$vlan_id]['port_vlan_id']));
      echo("P-");
    }
  }
}

foreach ($vlans_db as $domain_id => $vlans)
{
  foreach ($vlans as $vlan_id => $vlan)
  {
    if (empty($device['vlans'][$domain_id][$vlan_id]))
    {
      dbDelete('vlans', "`device_id` = ? AND vlan_domain = ? AND vlan_vlan = ?", array($device['device_id'], $domain_id, $vlan_id));
      echo("V-");
    }
  }
}

unset($device['vlans']);

echo("\n");

// EOF
