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

$version = preg_replace("/(.+)\ version\ (.+)\ \(SN:\ (.+)\,\ (.+)\)/", "\\1||\\2||\\3||\\4", $poll_device['sysDescr']);
list($hardware,$version,$serial,$features) = explode("||", $version);

$hardware = rewrite_junos_hardware($poll_device['sysObjectID']);

$sessrrd  = $config['rrd_dir'] . "/" . $device['hostname'] . "/screenos_sessions.rrd";

$snmpdata = snmp_get_multi($device, "nsResSessAllocate.0 nsResSessMaxium.0 nsResSessFailed.0", "-OQUs", "NETSCREEN-RESOURCE-MIB", mib_dirs("netscreen"));
$sessalloc = $snmpdata[0]['nsResSessAllocate'];
$sessmax = $snmpdata[0]['nsResSessMaxium'];
$sessfailed = $snmpdata[0]['nsResSessFailed'];

if (!is_file($sessrrd))
{
   rrdtool_create($sessrrd, "  \
     DS:allocate:GAUGE:600:0:3000000 \
     DS:max:GAUGE:600:0:3000000 \
     DS:failed:GAUGE:600:0:1000 ");
}

rrdtool_update("$sessrrd", "N:$sessalloc:$sessmax:$sessfailed");

$graphs['screenos_sessions'] = TRUE;

// EOF
