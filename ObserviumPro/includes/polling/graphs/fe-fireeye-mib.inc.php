<?php

//FE-FIREEYE-MIB::feActiveVMs.0 = 5

$table_defs['FE-FIREEYE-MIB']['fe'] = array(
  'file'          => 'fireeye-activevms.rrd',
  'call_function' => 'snmp_get',
  'mib'           => 'FE-FIREEYE-MIB',
  'mib_dir'       => 'fireeye',
  'table'         => 'feApplicationInfo',
  'ds_rename'     => array('feActiveVMs' => 'vms'),
  'graphs'        => array('fe_active_vms'),
  'oids'          => array(
     'feActiveVMs'   => array('descr'  => 'Active VMs', 'ds_type' => 'GAUGE', 'ds_min' => '0'),
  )
);

// EOF
