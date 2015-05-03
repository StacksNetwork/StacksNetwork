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

//SONICWALL-FIREWALL-IP-STATISTICS-MIB::sonicMaxConnCacheEntries.0 = Counter32: 7500
//SONICWALL-FIREWALL-IP-STATISTICS-MIB::sonicCurrentConnCacheEntries.0 = Counter32: 21

$table_defs['SONICWALL-FIREWALL-IP-STATISTICS-MIB']['sonicwallFwStats'] = array(
  //'file'          => 'sonicwall-firewall-ip-statistics-mib_sonicwallfwstats.rrd', // auto-generated
  'call_function' => 'snmp_get_multi',
  'mib'           => 'SONICWALL-FIREWALL-IP-STATISTICS-MIB',
  //'mib_dir'       => 'sonicwall',      // Already in OS definitions
  'table'         => 'sonicwallFwStats', // Table sonicwallFwStats have already polled RAM and CPU oids, use snmp_get_multi()
  'ds_rename'     => array('sonic' => '', 'Entries' => ''),
  'graphs'        => array('sonicwall_sessions'),
  'oids'          => array(
    'sonicMaxConnCacheEntries'      => array('descr'  => 'Maximum number of connection cache entries allowed through the firewall', 'ds_type' => 'GAUGE', 'ds_min' => '0'),
    'sonicCurrentConnCacheEntries'  => array('descr'  => 'Number of active connection cache entries through the firewall', 'ds_type' => 'GAUGE', 'ds_min' => '0'),
  )
);

// EOF