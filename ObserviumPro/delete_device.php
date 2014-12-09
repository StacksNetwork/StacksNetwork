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
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

chdir(dirname($argv[0]));

include("includes/defaults.inc.php");
include("config.php");
include("includes/definitions.inc.php");
include("includes/functions.inc.php");

$scriptname = basename($argv[0]);

print_message("%g".OBSERVIUM_PRODUCT." ".OBSERVIUM_VERSION."\n%W删除设备%n\n", 'color');

// Remove a host and all related data from the system
if ($argv[1])
{
  $host = strtolower($argv[1]);
  $id = getidbyname($host);
  $delete_rrd = (isset($argv[2]) && strtolower($argv[2]) == 'rrd') ? TRUE : FALSE;

  // Test if a valid id was fetched from getidbyname.
  if (isset($id) && is_numeric($id))
  {
    print_warning(delete_device($id, $delete_rrd));
    print_success("设备 $host 已删除.");
  } else {
    print_error("设备 $host 不存在!");
  }

} else {
    print_message("%n
USAGE:
$scriptname <hostname> [rrd]

EXAMPLE:
%WKeep RRDs%n:   $scriptname <hostname>
%WRemove RRDs%n: $scriptname <hostname> rrd

%r无效的参数!%n", 'color', FALSE);
}

// EOF
