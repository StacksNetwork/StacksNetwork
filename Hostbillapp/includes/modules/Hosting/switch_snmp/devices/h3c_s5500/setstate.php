<?php

/**
 * Set switch port state
 *
 * Under $state; HostBill will load state we need to set port into.
 * if($state) {
 *    //link it UP
 * } else {
 *    //link it DOWN
 * }
 *
 * Under $port variable HostBill will load port in question.
 * For instance: $port = '3';
 * So cycle power of port 3:
 * OID: .1.3.6.1.2.1.2.2.1.7.3
 *
 *
 * Connection details loaded from related App are available in $app array.
 * $app['ip'] - holds Switch ip address
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
    $return = $snmp->Set('.1.3.6.1.4.1.25506.1.5.' . $port, 'i', 1);
} else {
    $return = $snmp->Set('.1.3.6.1.4.1.25506.1.5.' . $port, 'i', 2);
}

if (!$return) {
    throw new Exception('无法设置新的交换机状态');
}