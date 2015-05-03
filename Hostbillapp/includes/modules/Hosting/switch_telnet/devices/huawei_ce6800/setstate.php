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
 * For instance: $port = '1/g2';
 * So cycle power of port 1/g2:
 *
 *
 * Connection details loaded from related App are available in $app array.
 * $app['ip'] - holds PDU ip address
 * $app['username'] - holds switch telnet username
 * $app['password'] - holds switch telnet password
 *
 * If you wish to return error, throw new Exception.
 * like: throw new Exception('Something unexpected happen');
 */

$telnet = HBLoader::LoadComponent('Net/Telnet');

$telnet->SetConnection(array('host'=>$app['ip'],'timeout'=>20,'debug'=>true));
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

$telnet->prompt('console#');
$telnet->cmd('enable');

$telnet->prompt('console(config)#');
$telnet->cmd('configure');

$telnet->prompt('console(config-if-'.$port.')#');
 $telnet->cmd('interface ethernet '.$port);

if($state) {
    $telnet->cmd('no shutdown');
} else {
    $telnet->cmd('shutdown');
}

$telnet->disconnect();

if(strpos($p, 'Down')!==false) {
    $status = false;
} elseif (strpos($p, 'Up')!==false) {
    $status = true;
} else {
    throw new Exception('无法获取有效的端口状态, 端口: '.$port);
}