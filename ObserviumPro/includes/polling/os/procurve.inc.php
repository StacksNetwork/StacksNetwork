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

if (preg_match('/^PROCURVE (.*) - (.*)/', $poll_device['sysDescr'], $matches))
{
  // PROCURVE J9029A - PA.03.04
  // PROCURVE J9028B - PB.03.00
  $hardware = $matches[1];
  $version  = $matches[2];
}
else if (preg_match('/^(?:HP )?ProCurve (?<hardware>\w+.+?), (?:revision )?(?<version>[\w\.]+)/', $poll_device['sysDescr'], $matches))
{
  // ProCurve J4900C Switch 2626, revision H.10.67, ROM H.08.05 (/sw/code/build/fish(mkfs))
  // HP ProCurve 1810G - 24 GE, P.1.14, eCos-2.0
  $hardware = $matches['hardware'];
  $version  = $matches['version'];
}
else if (preg_match('/^(?:HP|Hewlett-Packard Company) (?<hw1>\w+) .*?(?<hw2>(?:Routing )?Switch [\w\-]+), (?:revision|Software Version) (?<version>[\w\.]+)/', $poll_device['sysDescr'], $matches))
{
  // HP J4121A ProCurve Switch 4000M, revision C.09.22, ROM C.06.01 (/sw/code/build/vgro(c09))
  // HP J9091A Switch E8212zl, revision K.15.06.0008, ROM K.15.19 (/sw/code/build/btm(K_15_06)) (Formerly ProCurve)
  // HP J9138A Switch 2520-24-PoE, revision S.15.09.0022, ROM S.14.03 (/ws/swbuildm/S_rel_hartford_qaoff/code/build/elmo(S_rel_hartford_qaoff)) (Formerly ProCurve)
  // Hewlett-Packard Company J4139A HP ProCurve Routing Switch 9304M, Software Version 08.0.01rT53 Compiled on Jul 30 2008 at 02:28:35 labeled as H2R08001r
  $hardware = $matches['hw1'].' '.$matches['hw2'];
  $version  = $matches['version'];
}

if (!$version)
{
  $altversion = trim(snmp_get($device,"hpSwitchOsVersion.0", "-Oqv", "NETSWITCH-MIB", mib_dirs('hp')), '"');
  if ($altversion) { $version = $altversion; }
}

if (!$version)
{
  $altversion = trim(snmp_get($device,"snAgImgVer.0", "-Oqv", "HP-SN-AGENT-MIB", mib_dirs('hp')), '"');
  if ($altversion) { $version = $altversion; }
}

$serial = trim(snmp_get($device, "hpHttpMgSerialNumber.0", "-Oqv", "SEMI-MIB", mib_dirs('hp')), '"');

// EOF
