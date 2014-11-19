<?php

// Unable to detect via sysObjecID - device returns UPS-MIB base oid.

if (!$os)
{
  if (strpos($sysDescr, 'CS121 v') !== FALSE) { $os = "cs121"; } 
}

// EOF
