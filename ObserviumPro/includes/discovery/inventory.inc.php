<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage discovery
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

$valid['inventory'] = array();

echo("清单: ");

$include_dir = "includes/discovery/inventory";
include($config['install_dir']."/includes/include-dir-mib.inc.php");

if ($debug && count($valid['inventory'])) { print_vars($valid['inventory']); }
check_valid_inventory($device, $valid['inventory']);

// EOF
