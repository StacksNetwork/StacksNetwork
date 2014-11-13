<?php

// Generate some statistics to send along with the version request.
//
// These stats are used to allow us to prioritise development resources
// to target features and devices that are used the most.

// Overall Ports/Devices statistics
$stats['ports']          = dbFetchCell("SELECT count(*) FROM ports");
$stats['devices']        = dbFetchCell("SELECT count(*) FROM devices");
$stats['edition']        = EDITION;

// Per-feature statistics
$stats['sensors']        = dbFetchCell("SELECT count(*) FROM `sensors`");
$stats['services']       = dbFetchCell("SELECT count(*) FROM `services`");
$stats['applications']   = dbFetchCell("SELECT count(*) FROM `applications`");
$stats['bgp']            = dbFetchCell("SELECT count(*) FROM `bgpPeers`");
$stats['ospf']           = dbFetchCell("SELECT count(*) FROM `ospf_ports`");
$stats['eigrp']          = dbFetchCell("SELECT count(*) FROM `eigrp_ports`");
$stats['ipsec_tunnels']  = dbFetchCell("SELECT count(*) FROM `ipsec_tunnels`");
$stats['munin_plugins']  = dbFetchCell("SELECT count(*) FROM `munin_plugins`");
$stats['pseudowires']    = dbFetchCell("SELECT count(*) FROM `pseudowires`");
$stats['vrfs']           = dbFetchCell("SELECT count(*) FROM `vrfs`");
$stats['vminfo']         = dbFetchCell("SELECT count(*) FROM `vminfo`");
$stats['users']          = dbFetchCell("SELECT count(*) FROM `users`");
$stats['bills']          = dbFetchCell("SELECT count(*) FROM `bills`");

$stats['poller_time']    = dbFetchCell("SELECT SUM(`last_polled_timetaken`) FROM devices");
$stats['php_version']    = phpversion();

// Old version
$stats['os_version']     = trim(shell_exec($config['install_dir']."/scripts/distro"));
// New version
$stats['os_text']         = trim(shell_exec($config['install_dir']."/scripts/os"));

foreach (explode("||", $stats['os_text']) as $part)
{
  list($a, $b) = explode("=", $part);
  $stats['os'][$a] = $b;
}

#list($stats['os']['os'], $stats['os']['os_ver'], $stats['os']['arch'], $stats['os']['distro'], $stats['os']['distro_ver']) = explode("|", $stats['os_text']);

// sysObjectID for Generic devices
foreach (dbFetch("SELECT sysObjectID, COUNT( * ) as count FROM  `devices` WHERE `os` = 'generic' GROUP BY `sysObjectID`") as $data)
{
  $stats['generics'][$data['sysObjectID']] = $data['count'];
}

// Per-OS counts
foreach (dbFetch("SELECT COUNT(*) AS count,os from devices group by `os`") as $data)
{
  $stats['devicetypes'][$data['os']] = $data['count'];
}

// Per-type counts
foreach (dbFetch("SELECT COUNT(*) AS `count`, `type` FROM `devices` GROUP BY `type`") as $data)
{
  $stats['types'][$data['type']] = $data['count'];
}

// Per-apptype counts
foreach (dbFetch("SELECT COUNT(*) AS `count`, `app_type` FROM `applications` GROUP BY `app_type`") as $data)
{
  $stats['app_types'][$data['app_type']] = $data['count'];
}

// Serialize and base64 encode stats array for transportation
$stat_serial = serialize($stats);
$stat_base64 = base64_encode($stat_serial);

$url = "http://update.observium.org/latest.php?i=".$stats['ports']."&d=".$stats['devices']."&v=".$config['version']."&stats=".$stat_base64;
$data = get_http_request($url);

if ($data)
{
  list($omnipotence, $year, $month, $revision) = explode(".", $data);
  list($cur, $tag) = explode("-", $config['version']);
  list($cur_omnipotence, $cur_year, $cur_month, $cur_revision) = explode(".", $cur);

  if ($argv[1] == "--cron" || isset($options['q']))
  {
    $fd = fopen($config['log_file'],'a');
    fputs($fd,$string . "\n");
    fclose($fd);

    shell_exec("echo $omnipotence.$year.$month.$month > ".$config['rrd_dir']."/version.txt ");
  } else {
    if ($cur != $data)
    {
      echo("Current Revision : $cur_revision\n");

      if ($revision > $cur_revision)
      {
        echo("最新版本   : $revision\n");
      }

      //if ($omnipotence > $cur_omnipotence)
      //{
      //  echo("最新版本     : $omnipotence.$year.$month.$revision\n");
      //} elseif ($year > $cur_year) {
      //  echo("最新版本     : $omnipotence.$year.$month.$revision\n");
      //} elseif ($month > $cur_month) {
      //  echo("最新版本     : $omnipotence.$year.$month.$revision\n");
      //} elseif ($revision > $cur_revision) {
      //  echo("最新版本     : $omnipotence.$year.$month.$revision\n");
      //}
    }
  }
}

// EOF
