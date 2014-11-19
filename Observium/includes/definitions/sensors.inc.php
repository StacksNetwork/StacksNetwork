<?php

/// FIXME. $config['sensor_states'] >> $config['sensor']['states']

// Sensor state names

// CISCO-ENVMON-MIB
// See: http://tools.cisco.com/Support/SNMP/do/BrowseOID.do?local=en&translate=Translate&typeName=CiscoEnvMonState
$config['sensor_states']['cisco-envmon-state'][1] = array('name' => 'normal',         'event' => 'up');
$config['sensor_states']['cisco-envmon-state'][2] = array('name' => 'warning',        'event' => 'warning');
$config['sensor_states']['cisco-envmon-state'][3] = array('name' => 'critical',       'event' => 'alert');
$config['sensor_states']['cisco-envmon-state'][4] = array('name' => 'shutdown',       'event' => 'down');
$config['sensor_states']['cisco-envmon-state'][5] = array('name' => 'notPresent',     'event' => 'ignore');
$config['sensor_states']['cisco-envmon-state'][6] = array('name' => 'notFunctioning', 'event' => 'ignore');

// CISCO-ENTITY-SENSOR-MIB
$config['sensor_states']['cisco-entity-state'][1] = array('name' => 'true',         'event' => 'up');
$config['sensor_states']['cisco-entity-state'][2] = array('name' => 'false',        'event' => 'alert');

// FASTPATH-BOXSERVICES-PRIVATE-MIB
// Note: this is for the official Broadcom FastPath Box Services MIB. The idiots at Netgear modified this MIB, swapping
// status values around for no reason at all. That won't work. The tree is under a different OID, but if someone ever wants
// to implement support for their MIB, don't use this same 'fastpath-boxservices-private-state' as it will be incorrect.
$config['sensor_states']['fastpath-boxservices-private-state'][1] = array('name' => 'notPresent',  'event' => 'ignore');
$config['sensor_states']['fastpath-boxservices-private-state'][2] = array('name' => 'operational', 'event' => 'up');
$config['sensor_states']['fastpath-boxservices-private-state'][3] = array('name' => 'failed',      'event' => 'alert');

// RADLAN-HWENVIRONMENT
$config['sensor_states']['radlan-hwenvironment-state'][1] = array('name' => 'normal',         'event' => 'up');
$config['sensor_states']['radlan-hwenvironment-state'][2] = array('name' => 'warning',        'event' => 'alert');
$config['sensor_states']['radlan-hwenvironment-state'][3] = array('name' => 'critical',       'event' => 'alert');
$config['sensor_states']['radlan-hwenvironment-state'][4] = array('name' => 'shutdown',       'event' => 'alert');
$config['sensor_states']['radlan-hwenvironment-state'][5] = array('name' => 'notPresent',     'event' => 'ignore');
$config['sensor_states']['radlan-hwenvironment-state'][6] = array('name' => 'notFunctioning', 'event' => 'alert');

// AC-SYSTEM-MIB
$config['sensor_states']['ac-system-fan-state'][0] = array('name' => 'cleared',       'event' => 'up');
$config['sensor_states']['ac-system-fan-state'][1] = array('name' => 'indeterminate', 'event' => 'ignore');
$config['sensor_states']['ac-system-fan-state'][2] = array('name' => 'warning',       'event' => 'warning');
$config['sensor_states']['ac-system-fan-state'][3] = array('name' => 'minor',         'event' => 'up');
$config['sensor_states']['ac-system-fan-state'][4] = array('name' => 'major',         'event' => 'warning');
$config['sensor_states']['ac-system-fan-state'][5] = array('name' => 'critical',      'event' => 'alert');
$config['sensor_states']['ac-system-power-state'][1] = array('name' => 'cleared',       'event' => 'up');
$config['sensor_states']['ac-system-power-state'][2] = array('name' => 'indeterminate', 'event' => 'ignore');
$config['sensor_states']['ac-system-power-state'][3] = array('name' => 'warning',       'event' => 'warning');
$config['sensor_states']['ac-system-power-state'][4] = array('name' => 'minor',         'event' => 'up');
$config['sensor_states']['ac-system-power-state'][5] = array('name' => 'major',         'event' => 'warning');
$config['sensor_states']['ac-system-power-state'][6] = array('name' => 'critical',      'event' => 'alert');

// ACME-ENVMON-MIB
$config['sensor_states']['acme-env-state'][2] = array('name' => 'normal',         'event' => 'up');
$config['sensor_states']['acme-env-state'][3] = array('name' => 'minor',          'event' => 'alert');
$config['sensor_states']['acme-env-state'][4] = array('name' => 'major',          'event' => 'alert');
$config['sensor_states']['acme-env-state'][5] = array('name' => 'critical',       'event' => 'alert');
$config['sensor_states']['acme-env-state'][5] = array('name' => 'shutdown',       'event' => 'down');
$config['sensor_states']['acme-env-state'][7] = array('name' => 'notPresent',     'event' => 'ignore');
$config['sensor_states']['acme-env-state'][8] = array('name' => 'notFunctioning', 'event' => 'alert');

// DELL-Vendor-MIB
$config['sensor_states']['dell-vendor-state'][1] = array('name' => 'normal',         'event' => 'up');
$config['sensor_states']['dell-vendor-state'][2] = array('name' => 'warning',        'event' => 'alert');
$config['sensor_states']['dell-vendor-state'][3] = array('name' => 'critical',       'event' => 'alert');
$config['sensor_states']['dell-vendor-state'][4] = array('name' => 'shutdown',       'event' => 'alert');
$config['sensor_states']['dell-vendor-state'][5] = array('name' => 'notPresent',     'event' => 'ignore');
$config['sensor_states']['dell-vendor-state'][6] = array('name' => 'notFunctioning', 'event' => 'alert');

// SPAGENT-MIB
$config['sensor_states']['spagent-state'][1] = array('name' => 'noStatus',     'event' => 'ignore');
$config['sensor_states']['spagent-state'][2] = array('name' => 'normal',       'event' => 'up');
$config['sensor_states']['spagent-state'][4] = array('name' => 'highCritical', 'event' => 'alert');
$config['sensor_states']['spagent-state'][6] = array('name' => 'lowCritical',  'event' => 'warning');
$config['sensor_states']['spagent-state'][7] = array('name' => 'sensorError',  'event' => 'alert');
$config['sensor_states']['spagent-state'][8] = array('name' => 'relayOn',      'event' => 'up');
$config['sensor_states']['spagent-state'][9] = array('name' => 'relayOff',     'event' => 'up');

// PowerNet-MIB
$config['sensor_states']['powernet-status-state'][1] = array('name' => 'fail',     'event' => 'alert');
$config['sensor_states']['powernet-status-state'][2] = array('name' => 'ok',       'event' => 'up');

$config['sensor_states']['powernet-sync-state'][1] = array('name' => 'inSync',     'event' => 'up');
$config['sensor_states']['powernet-sync-state'][2] = array('name' => 'outOfSync',  'event' => 'alert');

$config['sensor_states']['powernet-mupscontact-state'][1] = array('name' => 'unknown', 'event' => 'warning');
$config['sensor_states']['powernet-mupscontact-state'][2] = array('name' => 'noFault', 'event' => 'up');
$config['sensor_states']['powernet-mupscontact-state'][3] = array('name' => 'fault',   'event' => 'alert');

// TRAPEZE-NETWORKS-SYSTEM-MIB
$config['sensor_states']['trapeze-state'][1] = array('name' => 'other',         'event' => 'warning');
$config['sensor_states']['trapeze-state'][2] = array('name' => 'unknown',       'event' => 'warning');
$config['sensor_states']['trapeze-state'][3] = array('name' => 'ac-failed',     'event' => 'alert');
$config['sensor_states']['trapeze-state'][4] = array('name' => 'dc-failed',     'event' => 'alert');
$config['sensor_states']['trapeze-state'][5] = array('name' => 'ac-ok-dc-ok',   'event' => 'up');

// GEIST-MIB-V3
$config['sensor_states']['geist-mib-v3-door-state'][1] = array('name' => 'closed', 'event' => 'up');
$config['sensor_states']['geist-mib-v3-door-state'][99] = array('name' => 'open',  'event' => 'alert');
$config['sensor_states']['geist-mib-v3-digital-state'][1] = array('name' => 'off', 'event' => 'alert');
$config['sensor_states']['geist-mib-v3-digital-state'][99] = array('name' => 'on',  'event' => 'up');
$config['sensor_states']['geist-mib-v3-smokealarm-state'][1] = array('name' => 'clear', 'event' => 'up');
$config['sensor_states']['geist-mib-v3-smokealarm-state'][99] = array('name' => 'smoky',  'event' => 'alert');
$config['sensor_states']['geist-mib-v3-climateio-state'][0] = array('name' => '0V', 'event' => 'up');
$config['sensor_states']['geist-mib-v3-climateio-state'][99] = array('name' => '5V',  'event' => 'up');
$config['sensor_states']['geist-mib-v3-climateio-state'][100] = array('name' => '5V',  'event' => 'up');
$config['sensor_states']['geist-mib-v3-relay-state'][0] = array('name' => 'off', 'event' => 'up');
$config['sensor_states']['geist-mib-v3-relay-state'][1] = array('name' => 'on',  'event' => 'up');

// GEIST-V4-MIB
$config['sensor_states']['geist-v4-mib-io-state'][0] = array('name' => '0V', 'event' => 'up');
$config['sensor_states']['geist-v4-mib-io-state'][100] = array('name' => '5V',  'event' => 'up');

// CPQHLTH-MIB
$config['sensor_states']['cpqhlth-state'][1] = array('name' => 'other',                       'event' => 'ignore');
$config['sensor_states']['cpqhlth-state'][2] = array('name' => 'ok',                          'event' => 'up');
$config['sensor_states']['cpqhlth-state'][3] = array('name' => 'degraded',                    'event' => 'warning');
$config['sensor_states']['cpqhlth-state'][4] = array('name' => 'failed',                      'event' => 'alert');

// CPQIDA-MIB
$config['sensor_states']['cpqida-cntrl-state'][1] = array('name' => 'other',                  'event' => 'ignore');
$config['sensor_states']['cpqida-cntrl-state'][2] = array('name' => 'ok',                     'event' => 'up');
$config['sensor_states']['cpqida-cntrl-state'][3] = array('name' => 'generalFailure',         'event' => 'alert');
$config['sensor_states']['cpqida-cntrl-state'][4] = array('name' => 'cableProblem',           'event' => 'alert');
$config['sensor_states']['cpqida-cntrl-state'][5] = array('name' => 'poweredOff',             'event' => 'alert');

$config['sensor_states']['cpqida-smart-state'][1] = array('name' => 'other',                  'event' => 'ignore');
$config['sensor_states']['cpqida-smart-state'][2] = array('name' => 'ok',                     'event' => 'up');
$config['sensor_states']['cpqida-smart-state'][3] = array('name' => 'replaceDrive',           'event' => 'alert');
$config['sensor_states']['cpqida-smart-state'][4] = array('name' => 'replaceDriveSSDWearOut', 'event' => 'warning');

// SYNOLOGY-SYSTEM-MIB
$config['sensor_states']['synology-status-state'][1] = array('name' => 'Normal',              'event' => 'up');
$config['sensor_states']['synology-status-state'][2] = array('name' => 'Failed',              'event' => 'alert');

// SYNOLOGY-DISK-MIB
$config['sensor_states']['synology-disk-state'][1] = array('name' => 'Normal',                'event' => 'up');
$config['sensor_states']['synology-disk-state'][2] = array('name' => 'Initialized',           'event' => 'warning');
$config['sensor_states']['synology-disk-state'][3] = array('name' => 'NotInitialized',        'event' => 'warning');
$config['sensor_states']['synology-disk-state'][4] = array('name' => 'SystemPartitionFailed', 'event' => 'alert');
$config['sensor_states']['synology-disk-state'][5] = array('name' => 'Crashed',               'event' => 'alert');

// FIXME. $config['sensor_types'] >> $config['sensor']['types']

// The order these are entered here defines the order they are shown in the web interface
$config['sensor_types']['temperature'] = array( 'symbol' => 'C',   'text' => 'Celsius',   'icon' => 'oicon-thermometer-high');
$config['sensor_types']['humidity']    = array( 'symbol' => '%',   'text' => 'Percent',   'icon' => 'oicon-water');
$config['sensor_types']['fanspeed']    = array( 'symbol' => 'RPM', 'text' => 'RPM',       'icon' => 'oicon-weather-wind');
$config['sensor_types']['airflow']     = array( 'symbol' => 'CFM', 'text' => 'Airflow',   'icon' => 'oicon-weather-wind');
$config['sensor_types']['voltage']     = array( 'symbol' => 'V',   'text' => 'Volts',     'icon' => 'oicon-voltage');
$config['sensor_types']['current']     = array( 'symbol' => 'A',   'text' => 'Amperes',   'icon' => 'oicon-current');
$config['sensor_types']['power']       = array( 'symbol' => 'W',   'text' => 'Watts',     'icon' => 'oicon-power');
///FIXME should get its own oicon-apower
$config['sensor_types']['apower']      = array( 'symbol' => 'VA',  'text' => 'VoltAmpere','icon' => 'oicon-power');
$config['sensor_types']['frequency']   = array( 'symbol' => 'Hz',  'text' => 'Hertz',     'icon' => 'oicon-frequency');
$config['sensor_types']['dbm']         = array( 'symbol' => 'dBm', 'text' => 'dBm',       'icon' => 'oicon-arrow-incident-red');
///FIXME. Need other icon like 'oicon-battery'
$config['sensor_types']['capacity']    = array( 'symbol' => '%',   'text' => 'Percent',   'icon' => 'oicon-asterisk');
//$config['sensor_types']['load']        = array( 'symbol' => '%',   'text' => 'Percent',   'icon' => 'oicon-asterisk');
$config['sensor_types']['runtime']     = array( 'symbol' => 'min', 'text' => 'Minutes',   'icon' => 'oicon-chart-up');

$config['sensor_types']['state']       = array( 'symbol' => '',    'text' => '',          'icon' => 'oicon-status');

// Cache this OIDs when polling
$config['sensor']['cache_oids']['netscaler-health']      = array('.1.3.6.1.4.1.5951.4.1.1.41.7.1.2');
$config['sensor']['cache_oids']['cisco-entity-sensor']   = array('.1.3.6.1.4.1.9.9.91.1.1.1.1.4');
$config['sensor']['cache_oids']['cisco-envmon']          = array('.1.3.6.1.4.1.9.9.13.1');
$config['sensor']['cache_oids']['cisco-envmon-state']    = array('.1.3.6.1.4.1.9.9.13.1');
$config['sensor']['cache_oids']['entity-sensor']         = array('.1.3.6.1.2.1.99.1.1.1.4');
$config['sensor']['cache_oids']['equallogic']            = array('.1.3.6.1.4.1.12740.2.1.6.1.3.1', '.1.3.6.1.4.1.12740.2.1.7.1.3.1');

// IPMI sensor type mappings
$config['ipmi_unit']['Volts']     = 'voltage';
$config['ipmi_unit']['degrees C'] = 'temperature';
$config['ipmi_unit']['RPM']       = 'fanspeed';
$config['ipmi_unit']['Watts']     = 'power';
$config['ipmi_unit']['CFM']       = 'airflow';
$config['ipmi_unit']['discrete']  = '';

// End includes/definitions/sensors.inc.php
