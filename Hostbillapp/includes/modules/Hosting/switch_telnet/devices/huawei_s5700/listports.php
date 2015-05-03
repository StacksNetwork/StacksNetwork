<?php

/**
 * HostBill will load this file when it will need to list available Ports in Switch over Telnet
 *
 * Load available ports into $ports array - HostBill will read from it.
 * I.e.:
 * $ports = array(
 *  "1" => "Port name #1",
 *  "2" => "Port name #2"
 * );
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
$ports = array();

/**
 * We're using our helper here, its loosely based on:
 * https://github.com/jnorell/Net_Telnet
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
$telnet->page_prompt('--More--');
$p=$telnet->cmd('show interfaces status');
$telnet->disconnect();

/**
 * extract port names from lines like:
Port   Type                            Duplex  Speed    Neg  Link  Flow Control
-----  ------------------------------  ------  -------  ---- ----- ------------
1/g1   Gigabit - Level                 Full    1000     Auto Up     Active
1/g2   Gigabit - Level                 N/A     Unknown  Auto Down   Inactive   
 */

$px=array();
if(preg_match_all('/([0-9]\/[a-z]{1,2}[0-9]+)[\s]+/', $p, $arr)) {
    $px = array_map('trim',$arr[0]);
}
foreach($px as $v) {
    $ports[$v]=$v;
}
