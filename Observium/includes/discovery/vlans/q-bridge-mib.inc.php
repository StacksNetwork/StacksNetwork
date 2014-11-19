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

echo(" Q-BRIDGE-MIB ");

$vlanversion = snmp_get($device, "dot1qVlanVersionNumber.0", "-Oqv", "Q-BRIDGE-MIB");

if ($vlanversion == 'version1')
{
  echo("VLAN $vlanversion ");

  $vtpdomain_id = "1";
  //$q_bridge_index = snmpwalk_cache_oid($device, "dot1qPortVlanTable", array(), "Q-BRIDGE-MIB");
  $vlans = snmpwalk_cache_oid($device, "dot1qVlanStaticTable", array(), "Q-BRIDGE-MIB");

  foreach ($vlans as $vlan_id => $vlan)
  {
    if ($device['os'] == 'ftos')
    {
      $vlan_id = rewrite_ftos_vlanid($device, $vlan_id);
    }
    unset ($vlan_update);

    if (is_array($vlans_db[$vtpdomain_id][$vlan_id]) && $vlans_db[$vtpdomain_id][$vlan_id]['vlan_name'] != $vlan['dot1qVlanStaticName'])
    {
      $vlan_update['vlan_name'] = $vlan['dot1qVlanStaticName'];
    }

    if (is_array($vlans_db[$vtpdomain_id][$vlan_id]) && $vlans_db[$vtpdomain_id][$vlan_id]['vlan_status'] != $vlan['dot1qVlanStaticRowStatus'])
    {
      $vlan_update['vlan_status'] = $vlan['dot1qVlanStaticRowStatus'];
    }

    echo(" $vlan_id");
    if (is_array($vlan_update))
    {
      dbUpdate($vlan_update, 'vlans', 'vlan_id = ?', array($vlans_db[$vtpdomain_id][$vlan_id]['vlan_id']));
      echo("U");
    } elseif (is_array($vlans_db[$vtpdomain_id][$vlan_id]))
    {
      echo(".");
    } else {
      dbInsert(array('device_id' => $device['device_id'], 'vlan_domain' => $vtpdomain_id, 'vlan_vlan' => $vlan_id, 'vlan_name' => $vlan['dot1qVlanStaticName'], 'vlan_type' => array('NULL')), 'vlans');
      echo("+");
    }
    $device['vlans'][$vtpdomain_id][$vlan_id] = $vlan_id;

    //Set Q-BRIDGE ports Vlan table (not work on FTOS for now)
    if ($device['os'] != 'ftos')
    {
      $parts = explode(' ', $vlan['dot1qVlanStaticEgressPorts']);
      $binary = '';
      foreach ($parts as $part)
      {
        $binary .= zeropad(decbin($part),8);
      }
      for ($i = 0; $i < strlen($binary); $i++)
      {
        if ($binary[$i])
        {
          $port = get_port_by_index_cache($device, $i);
          if (isset($ports_vlans_db[$port['port_id']][$vlan_id]))
          {
            $ports_vlans[$port['port_id']][$vlan_id] = $ports_vlans_db[$port['port_id']][$vlan_id]['port_vlan_id'];
            echo("P.");
          } else {
            $db_w = array('device_id' => $device['device_id'],
                          'port_id'   => $port['port_id'],
                          'vlan'      => $vlan_id);
            $id = dbInsert($db_w, 'ports_vlans');
            echo("P+");
            $ports_vlans[$port['port_id']][$vlan_id] = $id;
          }
        }
      }
    }
  }
}

// EOF
