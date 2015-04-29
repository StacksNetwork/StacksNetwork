<?php

$t = HBConfig::getConfig('HBTempatesC').DS.'testdeviceports.json';
if(!file_exists($t)) {
    $state = true;
} else {
    $ports = json_decode(file_get_contents($t),true);
    $state= $ports[$port];
    
}