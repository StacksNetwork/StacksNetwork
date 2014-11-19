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

if (in_array($device['os'], array('linux', 'endian', 'openwrt', 'ddwrt')))
{
  list(,,$version) = explode (" ", $poll_device['sysDescr']);

  $kernel = $version;

  // Distro "extend" support
  $features = trim(snmp_get($device, ".1.3.6.1.4.1.2021.7890.1.3.1.1.6.100.105.115.116.114.111", "-Oqv", "UCD-SNMP-MIB", mib_dirs()),'" ');

  if (!$features) // No "extend" support, try "exec" support
  {
    $features = trim(snmp_get($device, ".1.3.6.1.4.1.2021.7890.1.101.1", "-Oqv", "UCD-SNMP-MIB", mib_dirs()),'" ');
  }

  // Unset features if we're just getting an error.
  if (!$features || strpos($features, "/usr/bin/distro") !== FALSE)
  {
    unset($features);
  } else {
    list($distro, $distro_ver) = explode(" ", $features);
  }

  // Use agent DMI data if available
  if (isset($agent_data['dmi']))
  {
    if ($agent_data['dmi']['system-product-name'])
    {
      $hw = ($agent_data['dmi']['system-manufacturer'] ? $agent_data['dmi']['system-manufacturer'] . ' ' : '') . $agent_data['dmi']['system-product-name'];

      // Clean up "Dell Computer Corporation" and "Intel Corporation"
      $hw = str_replace(" Computer Corporation", "", $hw);
      $hw = str_replace(" Corporation", "", $hw);
    }

    if ($agent_data['dmi']['system-serial-number'])
    {
      $serial = $agent_data['dmi']['system-serial-number'];
    }

    if ($agent_data['dmi']['baseboard-asset-tag'])
    {
      $asset_tag = $agent_data['dmi']['baseboard-asset-tag'];
    }
  }

  if (is_array($entPhysical) && !$hw)
  {
    $hw = $entPhysical['entPhysicalDescr'];
    if (!empty($entPhysical['entPhysicalSerialNum']))
    {
      $serial = $entPhysical['entPhysicalSerialNum'];
    }
  }

  if (!$hw)
  {
    // Detect Dell hardware via OpenManage SNMP
    $hw = trim(snmp_get($device, "chassisModelName.1", "-Oqv", "MIB-Dell-10892", mib_dirs('dell')),'" ');

    if ($hw)
    {
      $hw        = "Dell " . $hw;
      $serial    = trim(snmp_get($device, "chassisServiceTagName.1", "-Oqv", "MIB-Dell-10892", mib_dirs('dell')),'" ');
      $asset_tag = trim(snmp_get($device, "chassisAssetTagName.1", "-Oqv", "MIB-Dell-10892", mib_dirs('dell')),'" ');
    }
  }

  if (!$hw)
  {
    // Detect HP hardware via hp-snmp-agents
    $hw = trim(snmp_get($device, "cpqSiProductName.0", "-Oqv", "CPQSINFO-MIB", mib_dirs('hp')),'" ');

    if ($hw)
    {
      $hw        = "HP " . $hw;
      $serial    = trim(snmp_get($device, "cpqSiSysSerialNum.0", "-Oqv", "CPQSINFO-MIB", mib_dirs('hp')),'" ');
      $asset_tag = trim(snmp_get($device, "cpqSiAssetTag.0", "-Oqv", "CPQSINFO-MIB", mib_dirs('hp')),'" ');
    }
  }

  $hardware = rewrite_unix_hardware($poll_device['sysDescr'], $hw);
}
elseif ($device['os'] == "aix")
{
  list($hardware,,$os_detail,) = explode("\n", $poll_device['sysDescr']);
  list(,$version) = explode(":", $os_detail);
}
elseif ($device['os'] == "freebsd")
{
  preg_match('/FreeBSD ([\d\.]+-[\w\d-]+)/i', $poll_device['sysDescr'], $matches);
  $kernel = $matches[1];
  $hardware = rewrite_unix_hardware($poll_device['sysDescr']);
}
elseif ($device['os'] == "dragonfly")
{
  list(,,$version,,,$features) = explode (" ", $poll_device['sysDescr']);
  $hardware = rewrite_unix_hardware($poll_device['sysDescr']);
}
elseif ($device['os'] == "netbsd")
{
  list(,,$version,,,$features) = explode (" ", $poll_device['sysDescr']);
  $features = str_replace("(", "", $features);
  $features = str_replace(")", "", $features);
  $hardware = rewrite_unix_hardware($poll_device['sysDescr']);
}
elseif ($device['os'] == "openbsd" || $device['os'] == "solaris" || $device['os'] == "opensolaris")
{
  list(,,$version,$features) = explode (" ", $poll_device['sysDescr']);
  $features = str_replace("(", "", $features);
  $features = str_replace(")", "", $features);
  $hardware = rewrite_unix_hardware($poll_device['sysDescr']);
}
elseif ($device['os'] == "darwin")
{
  list(,,$version) = explode (" ", $poll_device['sysDescr']);
  $hardware = rewrite_unix_hardware($poll_device['sysDescr']);
}
elseif ($device['os'] == "monowall" || $device['os'] == "pfsense") /// FIXME. No definitions for this os. || $device['os'] == "Voswall")
{
  list(,,$version,,, $kernel) = explode(" ", $poll_device['sysDescr']);
  $distro = $device['os'];
  $hardware = rewrite_unix_hardware($poll_device['sysDescr']);
}
elseif ($device['os'] == "freenas" || $device['os'] == "nas4free")
{
  preg_match('/Software: FreeBSD ([\d\.]+-[\w\d-]+)/i', $poll_device['sysDescr'], $matches);
  $version = $matches[1];
  $hardware = rewrite_unix_hardware($poll_device['sysDescr']);
}
elseif ($device['os'] == "qnap")
{
  $hardware = $entPhysical['entPhysicalName'];
  $version  = $entPhysical['entPhysicalFirmwareRev'];
  $serial   = $entPhysical['entPhysicalSerial'];
}
elseif ($device['os'] == "dsm")
{
//  This only gets us the build, not the actual version number, so won't use this.. yet.
//  list(,,,$version,) = explode(" ",$poll_device['sysDescr'],5);
//  $version = "Build " . trim($version,'#');

  $hrSystemInitialLoadParameters = trim(snmp_get($device, "hrSystemInitialLoadParameters.0", "-Osqnv"));

  $options = explode(" ",$hrSystemInitialLoadParameters);

  foreach ($options as $option)
  {
    list($key,$value) = explode("=",$option,2);
    if ($key == "syno_hw_version")
    {
      $hardware = $value;
    }
  }
}

// 'os' script data via SNMP "exec" support
$os_data = str_replace('"', "", snmp_get($device, ".1.3.6.1.4.1.2021.36602.1.1.1.4.1.2.2.111.115.1", "-Oqv"));

// check if we got a SCRIPTVER back
if(strpos($os_data, "SCRIPTVER"))
{
  foreach (explode("||", $os_data) as $part)
  {
    list($a, $b) = explode("=", $part);
    $stats['os'][$a] = $b;
  }

  print_vars($stats);

  $distro     = $stats['os']['DISTRO'];
  $distro_ver = $stats['os']['DISTROVER'];
  $kernel     = $stats['os']['KERNEL'];
  $arch       = $stats['os']['ARCH'];

  unset($features);
}

unset($hw);

// EOF
