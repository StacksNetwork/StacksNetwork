<?php

  // Simple poller for UCD old style CPU. will always poll the same index.

  #$system = snmp_get($device, "ssCpuSystem.0", "-OvQ", "UCD-SNMP-MIB", mib_dirs());
  #$user = snmp_get($device, "ssCpuUser.0", "-OvQ", "UCD-SNMP-MIB", mib_dirs());
  $idle = snmp_get($device, "ssCpuIdle.0", "-OvQ", "UCD-SNMP-MIB", mib_dirs());

  $proc = 100 - $idle;

// EOF
