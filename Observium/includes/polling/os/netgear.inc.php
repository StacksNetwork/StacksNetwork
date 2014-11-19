<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage poller
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

// sysDescr:
// Linux netgear001000 2.4.27-devicescape.3 #1 Fri Jun 9 14:27:39 EDT 2006 armv5b
// NETGEAR WG302 4.1.6
// WG102-500v2

if (strpos($poll_device['sysDescr'], 'Linux') !== FALSE)
{
  $hardware = rewrite_unix_hardware($poll_device['sysDescr']);
} else {
  list($hardware, $second) = explode(' ', $poll_device['sysDescr']);
  if (strtolower($hardware) == 'netgear') { $hardware = $second; }
}

// EOF
