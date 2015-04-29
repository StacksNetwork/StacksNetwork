<?php

/**
 * Get current state of port in PDU device.
 *
 * Under $port variable HostBill will load port in question.
 * For instance: $port = '3';
 * So look for port 3 state:
 * OID: .1.3.6.1.4.1.34097.3.1.1.7.3
 *
 * Load current state into $state variable.
 * Where:
 * $state = true; means port is ON
 * $state = false; means port is OFF
 *
 * Connection details loaded from related App are available in $app array.
 * $app['ip'] - holds PDU ip address
 * $app['read'] - holds SNMP read community, default "public"
 * $app['write'] - holds SNMP write community, default "private"
 *
 *
 * If you wish to return error, throw new Exception.
 * like: throw new Exception('Something unexpected happen');
 */

$snmp = HBLoader::LoadComponent('Net/SNMP_wrapper');
$snmp->Connect($app['ip'],161,$app['read']);

$state = $snmp->Get('.1.3.6.1.4.1.318.1.1.12.3.5.1.1.4.'.$port);
if(!$state) {
    throw new Exception("Unable to fetch current port state from PDU");
}
$state = str_ireplace('INTEGER: ','',$state);
if($state=='1') {
    $state=true;
} else {
    $state=false;
}
