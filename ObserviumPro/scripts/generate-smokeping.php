#!/usr/bin/env php
<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage cli
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2015 Adam Armstrong
 *
 */

chdir(dirname($argv[0]).'/..');
$scriptname = basename($argv[0]);

include_once("includes/defaults.inc.php");
include_once("config.php");

$options = getopt("d");
if (isset($options['d'])) { array_shift($argv); } // for compatability

include_once("includes/definitions.inc.php");
include("includes/functions.inc.php");

?>
*** Targets ***

probe = FPing

menu = Top
title = Network Latency Grapher
remark = Welcome to Observium SmokePing
<?php

if (is_array($config['smokeping']['slaves']))
{
  echo('slaves = ' . implode(' ', $config['smokeping']['slaves']) . PHP_EOL);
}

?>

+ Observium
menu = Observium

<?php

foreach (dbFetchRows("SELECT hostname FROM `devices` WHERE `ignore` = 0 AND `disabled` = 0 ORDER BY hostname") as $device)
{
  echo("++ " . str_replace('.', $config['smokeping']['split_char'], $device['hostname']) . PHP_EOL);
  echo("host = " . $device['hostname'] . PHP_EOL . PHP_EOL);
}

// EOF
