<?php

/////////////////////////////////////////////////////////
//  NO CHANGES TO THIS FILE, IT IS NOT USER-EDITABLE   //
/////////////////////////////////////////////////////////
//               YES, THAT MEANS YOU                   //
/////////////////////////////////////////////////////////

// Include OS definitions
include($config['install_dir'].'/includes/definitions/os.inc.php');

// Include Graph Type definitions
include($config['install_dir'].'/includes/definitions/graphtypes.inc.php');

// VMWare guestid => description definitions
include($config['install_dir'].'/includes/definitions/vmware_guestid.inc.php');

// Apps system definitions
include($config['install_dir'].'/includes/definitions/apps.inc.php');

// Entity type definitions
include($config['install_dir'].'/includes/definitions/entities.inc.php');

// Sensors definitions
include($config['install_dir'].'/includes/definitions/sensors.inc.php');

// Alert Graphs
## FIXME - this is ugly

$config['alert_graphs']['port']['ifInOctets_rate']       = array('type' => 'port_bits', 'id' => '@port_id');
$config['alert_graphs']['port']['ifOutOctets_rate']      = array('type' => 'port_bits', 'id' => '@port_id');
$config['alert_graphs']['port']['ifInOctets_perc']       = array('type' => 'port_percent', 'id' => '@port_id');
$config['alert_graphs']['port']['ifOutOctets_perc']      = array('type' => 'port_percent', 'id' => '@port_id');
$config['alert_graphs']['mempool']['mempool_perc']       = array('type' => 'mempool_usage', 'id' => '@mempool_id');
$config['alert_graphs']['sensor']['sensor_value']        = array('type' => 'sensor_graph', 'id' => '@sensor_id');
$config['alert_graphs']['processor']['processor_usage']  = array('type' => 'processor_usage', 'id' => '@processor_id');

// Device Types

$i = 0;
$config['device_types'][$i]['text'] = '服务器';
$config['device_types'][$i]['type'] = 'server';
$config['device_types'][$i]['icon'] = 'oicon-server';

$i++;
$config['device_types'][$i]['text'] = '工作站';
$config['device_types'][$i]['type'] = 'workstation';
$config['device_types'][$i]['icon'] = 'oicon-computer';

$i++;
$config['device_types'][$i]['text'] = '网络';
$config['device_types'][$i]['type'] = 'network';
$config['device_types'][$i]['icon'] = 'oicon-network-hub';

$i++;
$config['device_types'][$i]['text'] = '无线';
$config['device_types'][$i]['type'] = 'wireless';
$config['device_types'][$i]['icon'] = 'oicon-wi-fi-zone';

$i++;
$config['device_types'][$i]['text'] = '防火墙';
$config['device_types'][$i]['type'] = 'firewall';
$config['device_types'][$i]['icon'] = 'oicon-wall-brick';

$i++;
$config['device_types'][$i]['text'] = '电源';
$config['device_types'][$i]['type'] = 'power';
$config['device_types'][$i]['icon'] = 'oicon-plug';

$i++;
$config['device_types'][$i]['text'] = '环境';
$config['device_types'][$i]['type'] = 'environment';
$config['device_types'][$i]['icon'] = 'oicon-water';

$i++;
$config['device_types'][$i]['text'] = '负载均衡';
$config['device_types'][$i]['type'] = 'loadbalancer';
$config['device_types'][$i]['icon'] = 'oicon-arrow-split';

$i++;
$config['device_types'][$i]['text'] = '视频';
$config['device_types'][$i]['type'] = 'video';
$config['device_types'][$i]['icon'] = 'oicon-surveillance-camera';

$i++;
$config['device_types'][$i]['text'] = 'VoIP';
$config['device_types'][$i]['type'] = 'voip';
$config['device_types'][$i]['icon'] = 'oicon-telephone';

$i++;
$config['device_types'][$i]['text'] = '存储';
$config['device_types'][$i]['type'] = 'storage';
$config['device_types'][$i]['icon'] = 'oicon-database';

if (isset($config['enable_printers']) && $config['enable_printers'])
{
  $i++;
  $config['device_types'][$i]['text'] = '打印机';
  $config['device_types'][$i]['type'] = 'printer';
  $config['device_types'][$i]['icon'] = 'oicon-printer-color';
}

// Syslog colour and name translation

$config['syslog']['priorities']['0'] = array('name' => 'emergency',     'color' => '#D94640');
$config['syslog']['priorities']['1'] = array('name' => 'alert',         'color' => '#D94640');
$config['syslog']['priorities']['2'] = array('name' => 'critical',      'color' => '#D94640');
$config['syslog']['priorities']['3'] = array('name' => 'error',         'color' => '#E88126');
$config['syslog']['priorities']['4'] = array('name' => 'warning',       'color' => '#F2CA3F');
$config['syslog']['priorities']['5'] = array('name' => 'notification',  'color' => '#107373');
$config['syslog']['priorities']['6'] = array('name' => 'informational', 'color' => '#499CA6');
$config['syslog']['priorities']['7'] = array('name' => 'debugging',     'color' => '#5AA637');

for ($i = 8; $i < 16; $i++)
{
  $config['syslog']['priorities'][$i] = array('name' => 'other',        'color' => '#D2D8F9');
}

// This is used to provide pretty rewrites for lowercase things we drag out of the db and use in URLs

$config['nicecase'] = array(
    "bgp_peer" => "BGP对等",
    "cbgp_peer" => "BGP对等 (AFI/SAFI)",
    "netscaler_vsvr" => "网络统计服务器",
    "netscaler_svc" => "网络统计服务",
    "mempool" => "内存",
    "ipsec_tunnels" => "IPSec隧道",
    "vrf" => "VRFs",
    "isis" => "IS-IS",
    "cef" => "CEF",
    "eigrp" => "EIGRP",
    "ospf" => "OSPF",
    "bgp" => "BGP",
    "ases" => "ASes",
    "vpns" => "VPNs",
    "dbm" => "dBm",
    "mysql" => "MySQL",
    "powerdns" => "PowerDNS",
    "bind" => "BIND",
    "ntpd" => "NTPd",
    "powerdns-recursor" => "PowerDNS前缀",
    "freeradius" => "FreeRADIUS",
    "postfix_mailgraph" => "Postfix Mailgraph",
    "ge" => "大于或等于",
    "le" => "小于或等于",
    "notequals" => "不等于",
    "notmatch" => "不匹配",
    "diskio" => "磁盘I/O",
    "ipmi" => "IPMI",
    "snmp" => "SNMP",
    "mssql" => "SQL Server",
    "apower" => "Apparent power",
    "" => "");

// Routing types

$config['routing_types']['isis']      = array('text' => 'ISIS');
$config['routing_types']['ospf']      = array('text' => 'OSPF');
$config['routing_types']['cef']       = array('text' => 'CEF');
$config['routing_types']['bgp']       = array('text' => 'BGP');
$config['routing_types']['eigrp']     = array('text' => 'EIGRP');
$config['routing_types']['vrf']       = array('text' => 'VRFs');

// IPMI interfaces

$config['ipmi']['interfaces']['lan']     = array('text' => 'IPMI v1.5 LAN 接口');
$config['ipmi']['interfaces']['lanplus'] = array('text' => 'IPMI v2.0 RMCP+ LAN 接口');
$config['ipmi']['interfaces']['imb']     = array('text' => 'Intel IMB 接口');
$config['ipmi']['interfaces']['open']    = array('text' => 'Linux OpenIPMI 接口');

// Toner colour mapping
$config['toner']['cyan'] = array('cyan');
$config['toner']['magenta'] = array('magenta');
$config['toner']['yellow'] = array('yellow', 'giallo', 'gul');
$config['toner']['black'] = array('black', 'preto', 'nero');

////////////////////////////////
// No changes below this line //
////////////////////////////////

include($config['install_dir'].'/includes/definitions/version.inc.php');

if (isset($config['rrdgraph_def_text']))
{
  $config['rrdgraph_def_text'] = str_replace("  ", " ", $config['rrdgraph_def_text']);
  $config['rrd_opts_array'] = explode(" ", trim($config['rrdgraph_def_text']));
}

// Set default paths.
if (!isset($config['html_dir'])) { $config['html_dir'] = $config['install_dir'] . '/html'; }
if (!isset($config['rrd_dir']))  { $config['rrd_dir']  = $config['install_dir'] . '/rrd'; }
if (!isset($config['log_file'])) { $config['log_file'] = $config['install_dir'] . '/observium.log'; }
if (!isset($config['temp_dir'])) { $config['temp_dir'] = '/tmp'; }
if (!isset($config['mib_dir']))  { $config['mib_dir']  = $config['install_dir'] . '/mibs'; }

// Old variable backwards compatibility
if (!is_array($config['rancid_configs'])) { $config['rancid_configs'] = array($config['rancid_configs']); }
if (!is_array($config['auth_ldap_group'])) { $config['auth_ldap_group'] = array($config['auth_ldap_group']); }

// If we're on SSL, let's properly detect it
function is_ssl()
{
  if (isset($_SERVER['HTTPS']))
  {
    if ('on' == strtolower($_SERVER['HTTPS'])) { return TRUE; }
    if ('1' == $_SERVER['HTTPS']) { return TRUE; }
  }
  elseif (isset($_SERVER['SERVER_PORT']) && ('443' == $_SERVER['SERVER_PORT']))
  {
    return TRUE;
  }
  elseif (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && strtolower($_SERVER['HTTP_X_FORWARDED_PROTO']) == 'https')
  {
    return TRUE;
  }
  return FALSE;
}
if (is_ssl())
{
  $config['base_url'] = preg_replace('/^http:/','https:', $config['base_url']);
}

// Connect to database
$observium_link = mysql_connect($config['db_host'], $config['db_user'], $config['db_pass']);
if (!$observium_link)
{
  include_once("common.php");

  print_error("MySQL 错误: " . mysql_error());
  die;
}
$observium_db = mysql_select_db($config['db_name'], $observium_link);

// Connect to statsd

#if($config['statsd']['enable'])
#{
#  $log = new \StatsD\Client($config['statsd']['host'].':'.$config['statsd']['port']);
#}

// Set some times needed by loads of scripts (it's dynamic, so we do it here!)
$config['time']['now']        = time();
$config['time']['fourhour']   = $config['time']['now'] - 14400;    //time() - (4 * 60 * 60);
$config['time']['sixhour']    = $config['time']['now'] - 21600;    //time() - (6 * 60 * 60);
$config['time']['twelvehour'] = $config['time']['now'] - 43200;    //time() - (12 * 60 * 60);
$config['time']['day']        = $config['time']['now'] - 86400;    //time() - (24 * 60 * 60);
$config['time']['twoday']     = $config['time']['now'] - 172800;   //time() - (2 * 24 * 60 * 60);
$config['time']['week']       = $config['time']['now'] - 604800;   //time() - (7 * 24 * 60 * 60);
$config['time']['twoweek']    = $config['time']['now'] - 1209600;  //time() - (2 * 7 * 24 * 60 * 60);
$config['time']['month']      = $config['time']['now'] - 2678400;  //time() - (31 * 24 * 60 * 60);
$config['time']['twomonth']   = $config['time']['now'] - 5356800;  //time() - (2 * 31 * 24 * 60 * 60);
$config['time']['threemonth'] = $config['time']['now'] - 8035200;  //time() - (3 * 31 * 24 * 60 * 60);
$config['time']['sixmonth']   = $config['time']['now'] - 16070400; //time() - (6 * 31 * 24 * 60 * 60);
$config['time']['year']       = $config['time']['now'] - 31536000; //time() - (365 * 24 * 60 * 60);
$config['time']['twoyear']    = $config['time']['now'] - 63072000; //time() - (2 * 365 * 24 * 60 * 60);

// End includes/definitions.inc.php
