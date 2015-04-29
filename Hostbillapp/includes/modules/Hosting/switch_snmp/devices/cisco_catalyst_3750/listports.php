<?php
/**
 * HostBill will load this file when it will need to list available Ports in Switch over SNMP
 *
 * Load available ports into $ports array - HostBill will read from it.
 * I.e.:
 * $ports = array(
 *  "1" => "Port name #1",
 *  "2" => "Port name #2"
 * );
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

$ports = array();

/**
 * We're using helper here, but you can use default snmp functions for php
 * http://www.php.net/manual/en/ref.snmp.php
 */

$snmp = HBLoader::LoadComponent('Net/SNMP_wrapper');
$snmp->Connect($app['ip'],161,$app['read'],10,0); //set timeout to 10sec., retries to 0

$tree = $snmp->GetTree('.1.3.6.1.2.1.2.2.1.2');
if(is_array($tree) && !empty ($tree)) {
    foreach($tree as $k=>$itm) {
        $key = explode('.',$k);
        $key = array_pop($key);
        $ports[$key]=str_ireplace(array('STRING: ','"'), '', $itm);
    }
}
