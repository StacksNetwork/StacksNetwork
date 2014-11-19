<?php

if (!$os)
{
  if (preg_match("/^LANCOM/", $sysDescr)) { $os = "lcos"; }
}

// EOF
