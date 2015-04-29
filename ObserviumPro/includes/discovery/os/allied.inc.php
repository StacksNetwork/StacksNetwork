<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage discovery
 * @copyright  (C) 2006-2015 Adam Armstrong
 *
 */

if (strstr($sysObjectId, ".1.3.6.1.4.1.207."))
{
  $os = "allied";
  if (preg_match('/AW\+/', $sysDescr))
  {
    $os = "alliedwareplus";
  }
}

// EOF
