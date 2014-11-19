<?php

if (!$os)
{
  # RouterOS <= 4
  # sysDescr.0 = STRING: router
  if ($sysDescr == "router")
  {
    if (is_numeric(snmp_get($device, "SNMPv2-SMI::enterprises.14988.1.1.4.3.0", "-Oqv", "")))
    {
      $os = "routeros";
    }
  }
  # Routeros >= 5
  # sysDescr.0 = STRING: RouterOS RB493AH
  if (preg_match("/^RouterOS/", $sysDescr)) { $os = "routeros"; }
}

// EOF
