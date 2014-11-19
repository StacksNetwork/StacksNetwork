<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage poller
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

$hardware = rewrite_calix_hardware($poll_device['sysObjectID']);

if (strstr($hardware, 'E7'))
{
  /**
    E7-Calix-MIB::e7SystemId.0 = STRING: "PHIPAALLOXT#1265"
    E7-Calix-MIB::e7SystemLocation.0 = STRING: "Philadelphia, PA"
    E7-Calix-MIB::e7SystemAutoUpgrade.0 = INTEGER: yes(1)
    E7-Calix-MIB::e7SystemTelnetServer.0 = INTEGER: yes(1)
    E7-Calix-MIB::e7SystemUnsecuredWeb.0 = INTEGER: no(0)
    E7-Calix-MIB::e7SystemPasswordExpiry.0 = INTEGER: 30
    E7-Calix-MIB::e7SystemDnsPrimary.0 = IpAddress: 192.168.1.2
    E7-Calix-MIB::e7SystemDnsSecondary.0 = IpAddress: 192.168.2.2
    E7-Calix-MIB::e7SystemTimezone.0 = STRING: "US/Pacific"
    E7-Calix-MIB::e7SystemChassisSerialNumber.0 = Wrong Type (should be OCTET STRING): Counter64: 71308303059
    E7-Calix-MIB::e7SystemChassisMacAddress.0 = STRING: 0:2:35:9e:46:af
    E7-Calix-MIB::e7SystemTime.0 = STRING:  04:00:23
    E7-Calix-MIB::e7SystemDate.0 = STRING: 2013-12-07
   */
  $serial = snmp_get($device, '.1.3.6.1.4.1.6321.1.2.2.2.1.7.10.0', '-Oqvn');
  ///FIXME: $version, $features
}
elseif (strstr($hardware, 'E5'))
{
  ///FIXME: $version, $features, $serial
}
elseif (strstr($hardware, 'C7'))
{
  ///FIXME: $version, $features, $serial
}

//$version = str_replace('"','', $version);
//$features = str_replace('"','', $features);
$serial = str_replace('"','', $serial);

// EOF
