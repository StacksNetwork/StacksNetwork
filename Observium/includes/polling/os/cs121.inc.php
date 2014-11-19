<?php

// Uses UPS-MIB
include("includes/polling/os/ups-mib.inc.php");

// Version returned as "n/a" above, override with version form sysDescr
preg_match('/CS121 v(.*)/', $poll_device['sysDescr'], $matches);

$version = trim($matches[1]);

// EOF
