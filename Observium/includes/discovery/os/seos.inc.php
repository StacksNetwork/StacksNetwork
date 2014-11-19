<?php

if (!$os)
{
    if (strstr($sysDescr, "SmartEdge"))
    {
      $os = "seos";
    }
}

// EOF
