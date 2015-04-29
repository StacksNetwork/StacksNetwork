<?php

/**
 * Cycle power of port in PDU device.
 *
 * Under $state; HostBill will load state we need to set port into.
 * if($state) {
 *    //power ON
 * } else {
 *    //power OFF
 * }
 *
 * Under $port variable HostBill will load port in question.
 * For instance: $port = '3';
 * So cycle power of port 3:
 * OID: .1.3.6.1.4.1.34097.3.1.1.7.3
 *
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
$snmp->Connect($app['ip'], 161, $app['write']);

if ($state) {
    $return = $snmp->Set('.1.3.6.1.4.1.13742.4.1.2.2.1.3.' . $port, 'i', 1);
} else {
    $return = $snmp->Set('.1.3.6.1.4.1.13742.4.1.2.2.1.3.' . $port, 'i', 0);
}

if (!$return) {
    throw new Exception('Unable to set new power state');
}