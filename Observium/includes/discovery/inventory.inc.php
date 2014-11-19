<?php

$valid['inventory'] = array();

echo("Inventory: ");

include("includes/discovery/entity-physical.inc.php");
include("includes/discovery/hr-device.inc.php");

$include_dir = "includes/discovery/inventory";
include("includes/include-dir-mib.inc.php");

if ($debug && count($valid['inventory'])) { print_vars($valid['inventory']); }
check_valid_inventory($device, $valid['inventory']);

// EOF
