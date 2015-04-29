<?php
/**
 * This is just test device, do not use it for production
 */

$ports1 = array(
    'a1'=>true,
    'a2'=>true,
    'a3'=>true,
    'a4'=>true,
    'a5'=>true,
    'a6'=>true,
    'a7'=>true
);

$t = HBConfig::getConfig('HBTempatesC').DS.'testdeviceports.json';
if(!file_exists($t)) {
    file_put_contents($t, json_encode($ports1));
    $ports = $ports1;
} else {
    $ports = json_decode(file_get_contents($t),true);
    if(!$ports)
        $ports = $ports1;
}

$p = $ports;
$ports= array();
foreach($p as $k=>$state) {
    $ports[$k]=$k;
}