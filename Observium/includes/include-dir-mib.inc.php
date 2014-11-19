<?php

global $debug;

// This is an include so that we don't lose variable scope.

foreach (array_unique(array_merge((array)$config['os_group'][$config['os'][$device['os']]['group']]['mibs'],(array)$config['os'][$device['os']]['mibs'])) as $mib)
{
  $include_file = $config['install_dir'] . '/' . $include_dir . '/' . strtolower($mib) . '.inc.php';
  if (is_file($include_file))
  {
    include($include_file);
  }
}

unset($include_file, $include_dir);

// EOF
