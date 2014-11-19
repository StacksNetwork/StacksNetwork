<?php

if (!$os)
{
  if (strstr($sysDescr, "Barracuda NG Firewall")) { $os = "barracudangfw"; }
}

// EOF
