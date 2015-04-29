<?php

/**
 * Get current state of port in Switch
 *
 * Under $port variable HostBill will load port in question.
 * For instance: $port = '1/g1';
 * So look for port 1/g1 state
 * console> show interfaces status ethernet 1/g1
 *
 * Load current state into $state variable.
 * Where:
 * $state = true; means port is ON
 * $state = false; means port is OFF
 *
 * Connection details loaded from related App are available in $app array.
 * $app['ip'] - holds PDU ip address
 * $app['username'] - holds switch telnet username
 * $app['password'] - holds switch telnet password
 *
 *
 * If you wish to return error, throw new Exception.
 * like: throw new Exception('Something unexpected happen');
 */
$telnet = HBLoader::LoadComponent('Net/Telnet');

$telnet->SetConnection(array('host'=>$app['ip'],'timeout'=>10));
$telnet->connect();
$telnet->login(array(
            'login' => $app['username'],
            'password' => $app['password'],
            'login_prompt'=>"\r\nUser:",
            'password_prompt'=>'Password:',
            'login_success' => 'console>',
            'login_fail'    => '',
            'prompt'        => 'console>',
    )
);

$p=$telnet->cmd('show interfaces status ethernet '.$port);
$telnet->disconnect();

if(strpos($p, 'Down')!==false) {
    $state = false;
} elseif (strpos($p, 'Up')!==false) {
    $state = true;
} else {
    throw new Exception('Unable to get valid status for port '.$port);
}