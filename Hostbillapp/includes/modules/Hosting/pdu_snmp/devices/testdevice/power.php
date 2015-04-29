<?php

$t = HBConfig::getConfig('HBTempatesC').DS.'testdeviceports.json';
if(!file_exists($t)) {
    $return = true;
} else {
    $ports = json_decode(file_get_contents($t),true);
    $ports[$port]=$state;
    file_put_contents($t, json_encode($ports));
    $return = true;
}