<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage definitions
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

// Full list defined constants:
// OBSERVIUM_EDITION, OBSERVIUM_PRODUCT, OBSERVIUM_PRODUCT_LONG,
// OBSERVIUM_VERSION, OBSERVIUM_VERSION_LONG, OBSERVIUM_TRAIN, OBSERVIUM_URL

define('OBSERVIUM_EDITION',      'pro');
define('OBSERVIUM_PRODUCT',      'Observium');
define('OBSERVIUM_PRODUCT_LONG', 'Observium 专业版');
define('OBSERVIUM_URL',          'http://www.observium.org');

$observium_version  = "0.SVN.ERROR";

$svn_new = TRUE;
if (is_file($config['install_dir'] . '/.svn/entries'))
{
  $svn = File($config['install_dir'] . '/.svn/entries');
  if ((int)$svn[0] < 12)
  {
    // SVN version < 1.7
    $svn_rev = trim($svn[10]);
    list($svn_date) = explode("T", trim($svn[9]));
    $svn_new = FALSE;

    if (preg_match('/stable/', trim($svn[4]), $matches))
    {
      $svn_train = 'stable';
    } elseif (preg_match('/trunk/', trim($svn[4]), $matches))
    {
      $svn_train = 'current';
    }
  }
}

if ($svn_new)
{
  // SVN version >= 1.7
  $svn = shell_exec($config['svn'] . ' info ' . $config['install_dir']);

  if (preg_match('/stable/', $svn, $matches))
  {
    $svn_train = 'stable';
  } elseif (preg_match('/trunk/', $svn, $matches))
  {
    $svn_train = 'current';
  }

  if (preg_match('/Last\ Changed\ Rev:\ ([0-9]+)\s*Last\ Changed\ Date:\ ([0-9\-]+)/m', $svn, $matches))
  {
    $svn_rev = $matches[1];
    $svn_date = $matches[2];
  }
}

if (!empty($svn_rev))
{
  list($svn_year, $svn_month, $svn_day) = explode("-", $svn_date);
  $observium_version = "0." . ($svn_year-2000) . "." . ($svn_month+0) . "." . $svn_rev;

  define('OBSERVIUM_TRAIN', $svn_train);
  $observium_version_long = $observium_version . ' (' . OBSERVIUM_TRAIN . ')';
} else {
  define('OBSERVIUM_TRAIN', 'unknown');
  $observium_version_long = $observium_version;
}

// Define versions
define('OBSERVIUM_VERSION',      $observium_version);
define('OBSERVIUM_VERSION_LONG', $observium_version_long);

unset($observium_version, $observium_version_long);

// EOF
