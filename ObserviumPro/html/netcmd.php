<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage webinterface
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2015 Adam Armstrong
 *
 */

ini_set('allow_url_fopen', 0);
ini_set('display_errors', 0);

include_once("../includes/defaults.inc.php");
include_once("../config.php");
include_once("../includes/definitions.inc.php");
include("includes/functions.inc.php");
include("../includes/functions.inc.php");
include("includes/authenticate.inc.php");

if (!$_SESSION['authenticated']) { echo("未经授权"); exit; }

if ($_GET['query'] && $_GET['cmd'])
{
  $host = $_GET['query'];
  $ip = '';
  if (Net_IPv4::validateIP($host))
  {
    $ip = $host;
    $ip_version = 4;
  }
  elseif (Net_IPv6::checkIPv6($host))
  {
    $ip = $host;
    $ip_version = 6;
  }
  else
  {
    $ip = gethostbyname($host);
    if ($ip && $ip != $host)
    {
      $ip_version = 4;
    } else {
      $ip = gethostbyname6($host, FALSE);
      if ($ip)
      {
        $ip_version = 6;
      }
    }
  }
  if ($ip)
  {
    switch ($_GET['cmd'])
    {
      case 'whois':
        $cmd = $config['whois'] . " $ip | grep -v \%";
        break;
      case 'ping':
        $cmd = ($ip_version == 4) ? $config['fping'] : $config['fping6'];
        $cmd .= " -c 5 $ip";
        break;
      case 'tracert':
      case 'traceroute':
      case 'mtr':
        $cmd = $config['mtr'] . " -r -c 5 $ip";
        break;
      case 'nmap':
        if ($_SESSION['userlevel'] != '10')
        {
            echo("权限不足");
        } else {
            $cmd = $config['nmap'] . " $ip";
        }
        break;
    }

    if (!empty($cmd))
    {
      $output = `$cmd`;
    }
  }
}

$output = trim($output);
echo("<pre>$output</pre>");

// EOF
