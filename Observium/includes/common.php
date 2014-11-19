<?php

// Common Functions

// Debugging Include.
if (file_exists($config['install_dir']."/includes/debug/ref.inc.php")) { include($config['install_dir']."/includes/debug/ref.inc.php"); $ref_loaded = TRUE; }

// Get current DB Schema version
function get_db_version()
{
  return dbFetchCell('SELECT `version` FROM `dbSchema`');
}

/**
 * Percent Colour
 *
 *   This function returns a colour based on a 0-100 value
 *   It scales from green to red from 0-100 as default.
 *
 * @param integer $percent
 * @param integer $brightness
 * @param integer $max
 * @param integer $min
 * @param integer $thirdColorHex
 * @return string
 */

function percent_class($percent)
{
  if ($percent < "25")
  {
    $class = "info";
  } elseif ($percent < "50") {
    $class = "";
  } elseif ($percent < "75") {
    $class = "success";
  } elseif ($percent < "90") {
    $class = "warning";
  } else {
    $class = "danger";
  }

  return $class;
}

function percent_colour($value, $brightness = 128, $max = 100, $min = 0, $thirdColourHex = '00')
{
    if ($value > $max) { $value = $max; }
    if ($value < $min) { $value = $min; }

    // Calculate first and second colour (Inverse relationship)
    $first = (1-($value/$max))*$brightness;
    $second = ($value/$max)*$brightness;

    // Find the influence of the middle Colour (yellow if 1st and 2nd are red and green)
    $diff = abs($first-$second);
    $influence = ($brightness-$diff)/2;
    $first = intval($first + $influence);
    $second = intval($second + $influence);

    // Convert to HEX, format and return
    $firstHex = str_pad(dechex($first),2,0,STR_PAD_LEFT);
    $secondHex = str_pad(dechex($second),2,0,STR_PAD_LEFT);

    return '#'.$secondHex . $firstHex . $thirdColourHex;

    // alternatives:
    // return $thirdColourHex . $firstHex . $secondHex;
    // return $firstHex . $thirdColourHex . $secondHex;
}

// Observium's SQL debugging. Choses nice output depending upon web or cli
function print_sql($query)
{

  if ($GLOBALS['cli'])
  {
    print_vars($query);
  } else {
    if (class_exists('SqlFormatter'))
    {
      // Hide it under a "database icon" popup.
      #echo overlib_link('#', '<i class="oicon-databases"> </i>', SqlFormatter::highlight($query));
      echo '<p>',SqlFormatter::highlight($query),'</p>';
    } else {
      print_vars($query);
    }
  }
}

// Observium's variable debugging. Choses nice output depending upon web or cli
function print_vars($vars)
{

  if ($GLOBALS['cli'])
  {
    if (function_exists('rt'))
    {
      print_r($vars);
      rt($vars);
    } else {
      print_r($vars);
    }
  } else {
    if (function_exists('r'))
    {
      r($vars);
    } else {
      print_r($vars);
    }
  }
}

function timeticks_to_sec($timetick, $float = FALSE)
{
  $timetick = str_replace('(', '', $timetick);
  $timetick = str_replace(')', '', $timetick);
  $timetick_array = explode(':', $timetick);
  if (count($timetick_array) == 1 && is_numeric($timetick))
  {
    $secs = $timetick;
    $microsecs = 0;
  } else {
    list($days, $hours, $mins, $secs) = $timetick_array;
    list($secs, $microsecs) = explode('.', $secs);

    $hours += $days  * 24;
    $mins  += $hours * 60;
    $secs  += $mins  * 60;
  }
  $time   = ($float ? (float)$secs + $microsecs/100 : (int)$secs);

  return $time;
}

# If a device is up, return its uptime, otherwise return the
# time since the last time we were able to poll it.  This
# is not very accurate, but better than reporting what the
# uptime was at some time before it went down.
function deviceUptime($device, $format="long")
{
  if ($device['status'] == 0) {
    if ($device['last_polled'] == 0) {
      return "Never polled";
    }
    $since = time() - strtotime( $device['last_polled'] );
    return "Down " . formatUptime( $since, $format );
  } else {
    return formatUptime($device['uptime'], $format);
  }
}

function formatUptime($diff, $format = "long")
{
  $diff = (int)$diff;
  if ($diff === 0) { return '0s'; }

  $yearsDiff = floor($diff/31536000);
  $diff -= $yearsDiff*31536000;
  $daysDiff = floor($diff/86400);
  $diff -= $daysDiff*86400;
  $hrsDiff = floor($diff/60/60);
  $diff -= $hrsDiff*60*60;
  $minsDiff = floor($diff/60);
  $diff -= $minsDiff*60;
  $secsDiff = $diff;

  $uptime = '';

  if ($format == 'long')
  {
    if ($yearsDiff > 0) { $uptime .= $yearsDiff . ' 年, '; }
    if ($daysDiff > 0)  { $uptime .= $daysDiff  . ' 天' . ($daysDiff != 1 ? '' : '') . ', '; }
    if ($hrsDiff > 0)   { $uptime .= $hrsDiff   . '小时 '; }
    if ($minsDiff > 0)  { $uptime .= $minsDiff  . '分 '; }
    if ($secsDiff > 0)  { $uptime .= $secsDiff  . '秒 '; }
  } else {
    $count = 6;
    if ($format == 'short-3') { $count = 3; }
    elseif ($format == 'short-2' || $format == 'shorter') { $count = 2; }

    if ($yearsDiff > 0) { $u['y'] = $yearsDiff; }
    if ($daysDiff > 0)  { $u['d'] = $daysDiff; }
    if ($hrsDiff > 0)   { $u['h'] = $hrsDiff; }
    if ($minsDiff > 0)  { $u['m'] = $minsDiff; }
    if ($secsDiff > 0)  { $u['s'] = $secsDiff; }

    foreach ($u as $period => $value)
    {
      $uptime .= $value.$period.' ';
      $count--;
      if ($count == 0) { break; }
    }
  }

  return trim($uptime);
}

function humanspeed($speed)
{
  $speed = formatRates($speed);
  if ($speed == "") { $speed = "-"; }
  return $speed;
}

function formatCiscoHardware(&$device, $short = false)
{
  if ($device['os'] == "ios")
  {
    if ($device['hardware'])
    {
      if (preg_match("/^WS-C([A-Za-z0-9]+).*/", $device['hardware'], $matches))
      {
        if (!$short)
        {
           $device['hardware'] = "Cisco " . $matches[1] . " (" . $device['hardware'] . ")";
        }
        else
        {
           $device['hardware'] = "Cisco " . $matches[1];
        }
      }
      elseif (preg_match("/^CISCO([0-9]+)$/", $device['hardware'], $matches))
      {
        $device['hardware'] = "Cisco " . $matches[1];
      }
    }
    else
    {
      if (preg_match("/Cisco IOS Software, C([A-Za-z0-9]+) Software.*/", $device['sysDescr'], $matches))
      {
        $device['hardware'] = "Cisco " . $matches[1];
      }
      elseif (preg_match("/Cisco IOS Software, ([0-9]+) Software.*/", $device['sysDescr'], $matches))
      {
        $device['hardware'] = "Cisco " . $matches[1];
      }
    }
  }
}

function formatMac($mac)
{
  $mac = preg_replace("/(..)(..)(..)(..)(..)(..)/", "\\1:\\2:\\3:\\4:\\5:\\6", $mac);
  // Convert fake MACs to IP
  if (preg_match('/ff:fe:([a-f\d]+):([a-f\d]+):([a-f\d]+):([a-f\d]{1,2})/', $mac, $matches))
  {
    if ($matches[1] == '0' && $matches[2] == '0')
    {
      $mac = hexdec($matches[3]).'.'.hexdec($matches[4]).'.X.X'; // Cisco, why you convert 192.88.99.1 to 0:0:c0:58 (should be c0:58:63:1)
    } else {
      $mac = hexdec($matches[1]).'.'.hexdec($matches[2]).'.'.hexdec($matches[3]).'.'.hexdec($matches[4]);
    }
  }

  return $mac;
}

function format_number_short($number, $sf)
{
  // This formats a number so that we only send back three digits plus an optional decimal point.
  // Example: 723.42 -> 723    72.34 -> 72.3    2.23 -> 2.23

  list($whole, $decimal) = explode (".", $number);

  if (strlen($whole) >= $sf || !is_numeric($decimal))
  {
    $number = $whole;
  } elseif(strlen($whole) < $sf) {
    $diff = $sf - strlen($whole);
    $number = $whole .".".substr($decimal, 0, $diff);
  }
  return $number;
}

function external_exec($command)
{
  global $exec_status;

  $exec_status = array('command' => $command);

  print_debug($command);

  $descriptorspec = array(
    //0 => array('pipe', 'r'), // stdin
    1 => array('pipe', 'w'), // stdout
    2 => array('pipe', 'w')  // stderr
  );

  $process = proc_open($command, $descriptorspec, $pipes);
  stream_set_blocking($pipes[2], 0); // Set nonblocking STDERR (very, very speeds up executing)
  if (is_resource($process))
  {
    $exec_status['stderr'] = stream_get_contents($pipes[2]);
    if ($exec_status['stderr'])
    {
      $output = FALSE;
    } else {
      $output = stream_get_contents($pipes[1]);
    }
    fclose($pipes[1]);
    fclose($pipes[2]);
    $exec_status['exitcode'] = proc_close($process);
  } else {
    fclose($pipes[1]);
    fclose($pipes[2]);
    proc_terminate($process);
    $output = FALSE;
    $exec_status['stderr'] = '';
    $exec_status['exitcode'] = -1;
  }
  $exec_status['stdout'] = $output;
  print_debug($output);

  return $output;
}

function is_cli()
{
  if (php_sapi_name() == 'cli' && empty($_SERVER['REMOTE_ADDR']))
  {
    return TRUE;
  } else {
    return FALSE;
  }
}

function print_debug($text)
{
  if ($GLOBALS['debug'])
  {
    print_message($text, 'debug');
  }
}

function print_error($text)
{
  print_message($text, 'error');
}

function print_warning($text)
{
  print_message($text, 'warning');
}

function print_success($text)
{
  print_message($text, 'success');
}

function print_message($text, $type='')
{
  global $config;

  $type = trim(strtolower($type));
  switch ($type)
  {
    case 'success':
      $color = array('cli'       => '%g',                 // green
                     'cli_color' => FALSE,                // by default cli coloring disabled
                     'class'     => 'alert alert-success'); // green
      $icon  = 'oicon-tick-circle';
      break;
    case 'warning':
      $color = array('cli'       => '%b',                 // blue
                     'cli_color' => FALSE,                // by default cli coloring disabled
                     'class'     => 'alert');             // yellow
      $icon  = 'oicon-bell';
      break;
    case 'error':
      $color = array('cli'       => '%r',                 // red
                     'cli_color' => FALSE,                // by default cli coloring disabled
                     'class'     => 'alert alert-error'); // red
      $icon  = 'oicon-exclamation-red';
      break;
    case 'debug':
      $color = array('cli'       => '%r',                 // red
                     'cli_color' => FALSE,                // by default cli coloring disabled
                     'class'     => 'alert alert-error'); // red
      $icon  = 'oicon-exclamation-red';
      break;
    case 'color':
      $color = array('cli'       => '',                  // none
                     'cli_color' => TRUE,                // allow using coloring
                     'class'     => 'alert alert-info'); // blue
      $icon  = 'oicon-information';
      break;
    default:
      $color = array('cli'       => '%W',                // bold
                     'cli_color' => FALSE,               // by default cli coloring disabled
                     'class'     => 'alert alert-info'); // blue
      $icon  = 'oicon-information';
      break;
  }

  if (is_cli())
  {
    include_once($config['install_dir'] . "/includes/pear/Console/Color2.php");

    $msg = new Console_Color2();
    print $msg->convert($color['cli'].$text."%n\n", $color['cli_color']);
  } else {
    $msg = '<div class="'.$color['class'].'">';
    if ($type != 'warning' && $type != 'error')
    {
      $msg .= '<button type="button" class="close" data-dismiss="alert">&times;</button>';
    }
    $msg .= '
      <div class="pull-left" style="padding:0 5px 0 0"><i class="'.$icon.'"></i></div>
      <div>'.nl2br($text).'</div>
    </div>';
    echo($msg);
  }
}

// Check if php extension exist, than warn or fail
function check_extension_exists($extension, $text = FALSE, $fatal = FALSE)
{
  $exist = FALSE;
  $extension = strtolower($extension);
  $extension_functions = array(
    'mbstring' => 'mb_detect_encoding',
    'mcrypt'   => 'mcrypt_encrypt',
    'ldap'     => 'ldap_connect',
    'session'  => 'session_name',
    'svn'      => 'svn_log'
  );
  
  if (isset($extension_functions[$extension]) && @function_exists($extension_functions[$extension]))
  {
    $exist = TRUE;
  }
  elseif (@extension_loaded($extension))
  {
    $exist = TRUE;
  }
  
  if (!$exist)
  {
    // Print error (only if $text not equals to FALSE)
    if ($text === '' || $text === TRUE)
    {
      // Generic message
      print_error("The $extension extension is missing. Please check your PHP configuration.");
    }
    elseif ($text !== FALSE)
    {
      // Custom message
      print_error("The $extension extension is missing. $text");
    }
    
    // Exit if $fatal set to TRUE
    if ($fatal) { exit; }
  }
  
  return $exist;
}

function delete_port($int_id)
{
  global $config;

  $interface = dbFetchRow("SELECT * FROM `ports` AS P, `devices` AS D WHERE P.port_id = ? AND D.device_id = P.device_id", array($int_id));

  $interface_tables = array('adjacencies', 'ipaddr', 'ip6adjacencies', 'ip6addr', 'mac_accounting', 'bill_ports', 'pseudowires', 'ports');

  foreach ($interface_tables as $table)
  {
    dbDelete($table, "`port_id` =  ?", array($int_id));
  }

  dbDelete('links', "`local_port_id` =  ?", array($int_id));
  dbDelete('links', "`remote_port_id` =  ?", array($int_id));
  dbDelete('bill_ports', "`port_id` =  ?", array($int_id));

  $rrdfile = get_port_rrdfilename($interface, $interface);
  unlink($rrdfile);
}

function sgn($int)
{
  if ($int < 0)
  {
    return -1;
  } elseif ($int == 0) {
    return 0;
  } else {
    return 1;
  }
}

function get_sensor_rrd($device, $sensor)
{
  global $config;

  # For IPMI, sensors tend to change order, and there is no index, so we prefer to use the description as key here.
  if ($config['os'][$device['os']]['sensor_descr'] || $sensor['poller_type'] == "ipmi")
  {
    $rrd_file = $config['rrd_dir']."/".$device['hostname']."/".safename("sensor-".$sensor['sensor_class']."-".$sensor['sensor_type']."-".$sensor['sensor_descr'] . ".rrd");
  } else {
    $rrd_file = $config['rrd_dir']."/".$device['hostname']."/".safename("sensor-".$sensor['sensor_class']."-".$sensor['sensor_type']."-".$sensor['sensor_index'] . ".rrd");
  }

  return($rrd_file);
}

// Get port array by ID (using cache)
function get_port_by_id_cache($port_id)
{
  return get_entity_by_id_cache('port', $port_id);
}

// Get port array by ID (with port state)
// NOTE get_port_by_id(ID) != get_port_by_id_cache(ID)
function get_port_by_id($port_id)
{
  if (is_numeric($port_id))
  {
    $port = dbFetchRow("SELECT * FROM `ports` LEFT JOIN `ports-state` ON `ports`.`port_id` = `ports-state`.`port_id`  WHERE `ports`.`port_id` = ?", array($port_id));
  }

  if (is_array($port))
  {
    $port['port_id'] = $port_id; // It corrects the situation, when `ports-state` is empty
    humanize_port($port);
    return $port;
  }

  return FALSE;
}

// Get port array by ifIndex (using cache)
function get_port_by_index_cache($device_id, $ifIndex)
{
  global $cache;

  if (isset($cache['port_index'][$device_id][$ifIndex]) && is_numeric($cache['port_index'][$device_id][$ifIndex]))
  {
    $id = $cache['port_index'][$device_id][$ifIndex];
  } else {
    $id = dbFetchCell("SELECT `port_id` FROM `ports` WHERE `device_id` = ? AND `ifIndex` = ? LIMIT 1", array($device_id, $ifIndex));
    if (is_numeric($id)) { $cache['port_index'][$device_id][$ifIndex] = $id; }
  }

  $port = get_port_by_id_cache($id);
  if (is_array($port)) { return $port; }

  return FALSE;
}

// Get port array by ifIndex
function get_port_by_ifIndex($device_id, $ifIndex)
{
  $port = dbFetchRow("SELECT * FROM `ports` WHERE `device_id` = ? AND `ifIndex` = ? LIMIT 1", array($device_id, $ifIndex));

  if (is_array($port))
  {
    humanize_port($port);
    return $port;
  }

  return FALSE;
}

// Get port ID by ifDescr (i.e. 'TenGigabitEthernet1/1') or ifName (i.e. 'Te1/1')
function get_port_id_by_ifDescr($device_id, $ifDescr)
{
  $port_id = dbFetchCell("SELECT `port_id` FROM `ports` WHERE `device_id` = ? AND (`ifDescr` = ? OR `ifName` = ?) LIMIT 1", array($device_id, $ifDescr, $ifDescr));

  if (is_numeric($port_id))
  {
    return $port_id;
  } else {
    return FALSE;
  }
}

// Get port ID by ifAlias (interface description)
function get_port_id_by_ifAlias($device_id, $ifAlias)
{
  $port_id = dbFetchCell("SELECT `port_id` FROM `ports` WHERE `device_id` = ? AND `ifAlias` = ? LIMIT 1", array($device_id, $ifAlias));

  if (is_numeric($port_id))
  {
    return $port_id;
  } else {
    return FALSE;
  }
}

// Get port ID by customer params (see http://www.observium.org/wiki/Interface_Description_Parsing)
function get_port_id_by_customer($customer)
{
  $where = ' WHERE 1';
  if (is_array($customer))
  {
    foreach ($customer as $var => $value)
    {
      if ($value != '')
      {
        switch ($var)
        {
          case 'device':
          case 'device_id':
            $where .= ' AND `device_id` = ?';
            $param[] = $value;
            break;
          case 'type':
          case 'descr':
          case 'circuit':
          case 'speed':
          case 'notes':
            $where .= ' AND `port_descr_'.$var.'` = ?';
            $param[] = $value;
            break;
        }
      }
    }
  } else {
    return FALSE;
  }

  $query = 'SELECT `port_id` FROM `ports` '.$where.' LIMIT 1';
  $port_id = dbFetchCell($query, $param);

  if (is_numeric($port_id))
  {
    return $port_id;
  } else {
    return FALSE;
  }
}

function get_all_devices($device, $type = "")
{
  global $cache;

  // FIXME needs access control checks!
  // FIXME respect $type (server, network, etc) -- needs an array fill in topnav.

  if (isset($cache['devices']['hostname']))
  {
    $devices = array_keys($cache['devices']['hostname']);
  }
  else
  {
    foreach (dbFetchRows("SELECT `hostname` FROM `devices`") as $data)
    {
      $devices[] = $data['hostname'];
    }
  }

  return $devices;
}

function getImage($device)
{
  global $config;

  $device['os'] = strtolower($device['os']);

  if ($device['icon'] && file_exists($config['html_dir'] . "/images/os/" . $device['icon'] . ".png"))
  {
    $image = '<img src="' . $config['base_url'] . '/images/os/' . $device['icon'] . '.png" alt="" />';
  }
  elseif ($config['os'][$device['os']]['icon'] && file_exists($config['html_dir'] . "/images/os/" . $config['os'][$device['os']]['icon'] . ".png"))
  {
    $image = '<img src="' . $config['base_url'] . '/images/os/' . $config['os'][$device['os']]['icon'] . '.png" alt="" />';
  } else {
    if (file_exists($config['html_dir'] . '/images/os/' . $device['os'] . '.png'))
    {
      $image = '<img src="' . $config['base_url'] . '/images/os/' . $device['os'] . '.png" alt="" />';
    }
    if ($device['os'] == "linux")
    {
      $distro = strtolower(trim($device['distro']));
      if (file_exists($config['html_dir'] . "/images/os/".safename($distro) . ".png"))
      {
        $image = '<img src="' . $config['base_url'] . '/images/os/' . htmlentities($distro) . '.png" alt="" />';
      }
    }
  }

  return $image;
}

function get_application_by_id($application_id)
{
  if (is_numeric($application_id))
  {
    $application = dbFetchRow("SELECT * FROM `applications` WHERE `app_id` = ?", array($application_id));
  }
  if (is_array($application))
  {
    return $application;
  } else {
    return FALSE;
  }
}

function get_sensor_by_id($sensor_id)
{
  if (is_numeric($sensor_id))
  {
    $sensor = dbFetchRow("SELECT * FROM `sensors` WHERE `sensor_id` = ?", array($sensor_id));
  }
  if (is_array($sensor))
  {
    return $sensor;
  } else {
    return FALSE;
  }
}

function get_device_id_by_port_id($port_id)
{
  if (is_numeric($port_id))
  {
    $device_id = dbFetchCell("SELECT `device_id` FROM `ports` WHERE `port_id` = ?", array($port_id));
  }
  if (is_numeric($device_id))
  {
    return $device_id;
  } else {
    return FALSE;
  }
}

function get_device_id_by_app_id($app_id)
{
  if (is_numeric($app_id))
  {
    $device_id = dbFetchCell("SELECT `device_id` FROM `applications` WHERE `app_id` = ?", array($app_id));
  }
  if (is_numeric($device_id))
  {
    return $device_id;
  } else {
    return FALSE;
  }
}

function ifclass($ifOperStatus, $ifAdminStatus)
{
  $ifclass = "interface-upup";
  if ($ifAdminStatus == "down") { $ifclass = "gray"; }
  if ($ifAdminStatus == "up")
  {
    if ($ifOperStatus == "down") { $ifclass = "red"; }
    if ($ifOperStatus == "lowerLayerDown") { $ifclass = "orange"; }
    if ($ifOperStatus == "monitoring") { $ifclass = "green"; }
    if ($ifOperStatus == "up") { $ifclass = ""; }
  }

  return $ifclass;
}

function device_by_name($name, $refresh = 0)
{
  // FIXME - cache name > id too.
  return device_by_id_cache(getidbyname($name), $refresh);
}

function accesspoint_by_id($ap_id, $refresh = '0')
{
  $ap = dbFetchRow("SELECT * FROM `accesspoints` WHERE `accesspoint_id` = ?", array($ap_id));

  return $ap;
}

function device_by_id_cache($device_id, $refresh = '0')
{
  global $cache;

  if (!$refresh && isset($cache['devices']['id'][$device_id]) && is_array($cache['devices']['id'][$device_id]))
  {
    $device = $cache['devices']['id'][$device_id];
  } else {
    $device = dbFetchRow("SELECT * FROM `devices` WHERE `device_id` = ?", array($device_id));
    humanize_device($device);
    $cache['devices']['id'][$device_id] = $device;
  }
  return $device;
}

function truncate($substring, $max = 50, $rep = '...')
{
  if (strlen($substring) < 1) { $string = $rep; } else { $string = $substring; }
  $leave = $max - strlen ($rep);
  if (strlen($string) > $max) { return substr_replace($string, $rep, $leave); } else { return $string; }
}

function mres($string)
{ // short function wrapper because the real one is stupidly long and ugly. aesthetics.
  return mysql_real_escape_string($string);
}

function getifhost($id)
{
  return dbFetchCell("SELECT `device_id` from `ports` WHERE `port_id` = ?", array($id));
}

function gethostbyid($id)
{
  global $cache;

  if (isset($cache['devices']['id'][$id]['hostname']))
  {
    $hostname = $cache['devices']['id'][$id]['hostname'];
  }
  else
  {
    $hostname = dbFetchCell("SELECT `hostname` FROM `devices` WHERE `device_id` = ?", array($id));
  }

  return $hostname;
}

function strgen ($length = 16)
{
  $entropy = array(0,1,2,3,4,5,6,7,8,9,'a','A','b','B','c','C','d','D','e',
  'E','f','F','g','G','h','H','i','I','j','J','k','K','l','L','m','M','n',
  'N','o','O','p','P','q','Q','r','R','s','S','t','T','u','U','v','V','w',
  'W','x','X','y','Y','z','Z');
  $string = "";

  for ($i=0; $i<$length; $i++)
  {
    $key = mt_rand(0,61);
    $string .= $entropy[$key];
  }

  return $string;
}

function getpeerhost($id)
{
  return dbFetchCell("SELECT `device_id` from `bgpPeers` WHERE `bgpPeer_id` = ?", array($id));
}

function getifindexbyid($id)
{
  return dbFetchCell("SELECT `ifIndex` FROM `ports` WHERE `port_id` = ?", array($id));
}

function getifbyid($id)
{
  return dbFetchRow("SELECT * FROM `ports` WHERE `port_id` = ?", array($id));
}

function getifdescrbyid($id)
{
  return dbFetchCell("SELECT `ifDescr` FROM `ports` WHERE `port_id` = ?", array($id));
}

function getidbyname($hostname)
{
  global $cache;

  if (isset($cache['devices']['hostname'][$hostname]))
  {
    $id = $cache['devices']['hostname'][$hostname];
  } else
  {
    $id = dbFetchCell("SELECT `device_id` FROM `devices` WHERE `hostname` = ?", array($hostname));
  }

  return $id;
}

function gethostosbyid($id)
{
  global $cache;

  if (isset($cache['devices']['id'][$id]['os']))
  {
    $os = $cache['devices']['id'][$id]['os'];
  }
  else
  {
    $os = dbFetchCell("SELECT `os` FROM `devices` WHERE `device_id` = ?", array($id));
  }

  return $os;
}

function safename($name)
{
  return preg_replace('/[^a-zA-Z0-9,._\-]/', '_', $name);
}

function zeropad($num, $length = 2)
{
  while (strlen($num) < $length)
  {
    $num = '0'.$num;
  }

  return $num;
}

function set_dev_attrib($device, $attrib_type, $attrib_value)
{
  if (dbFetchCell("SELECT COUNT(*) FROM devices_attribs WHERE `device_id` = ? AND `attrib_type` = ?", array($device['device_id'],$attrib_type)))
  {
    $return = dbUpdate(array('attrib_value' => $attrib_value), 'devices_attribs', 'device_id=? and attrib_type=?', array($device['device_id'], $attrib_type));
  }
  else
  {
    $return = dbInsert(array('device_id' => $device['device_id'], 'attrib_type' => $attrib_type, 'attrib_value' => $attrib_value), 'devices_attribs');
  }
  return $return;
}

function get_dev_attribs($device_id)
{
  $attribs = array();
  foreach (dbFetchRows("SELECT * FROM devices_attribs WHERE `device_id` = ?", array($device_id)) as $entry)
  {
    $attribs[$entry['attrib_type']] = $entry['attrib_value'];
  }
  return $attribs;
}

function get_dev_entity_state($device)
{
  $state = array();
  foreach (dbFetchRows("SELECT * FROM `entPhysical-state` WHERE `device_id` = ?", array($device)) as $entity)
  {
    $state['group'][$entity['group']][$entity['entPhysicalIndex']][$entity['subindex']][$entity['key']] = $entity['value'];
    $state['index'][$entity['entPhysicalIndex']][$entity['subindex']][$entity['group']][$entity['key']] = $entity['value'];
  }

  return $state;
}

function get_dev_attrib($device, $attrib_type)
{
  if ($row = dbFetchRow("SELECT attrib_value FROM devices_attribs WHERE `device_id` = ? AND `attrib_type` = ?", array($device['device_id'], $attrib_type)))
  {
    return $row['attrib_value'];
  }
  else
  {
    return NULL;
  }
}

function del_dev_attrib($device, $attrib_type)
{
  return dbDelete('devices_attribs', "`device_id` = ? AND `attrib_type` = ?", array($device['device_id'], $attrib_type));
}

function formatRates($value, $round = '2', $sf = '3')
{
   $value = format_si($value, $round, $sf) . "bps";
   return $value;
}

function formatStorage($value, $round = '2', $sf = '3')
{
   $value = format_bi($value, $round) . "B";
   return $value;
}

function format_si($value, $round = '2', $sf = '3')
{
  if ($value < "0")
  {
    $neg = 1;
    $value = $value * -1;
  }

  if ($value >= "0.1")
  {
    $sizes = Array('', 'k', 'M', 'G', 'T', 'P', 'E');
    $ext = $sizes[0];
    for ($i = 1; (($i < count($sizes)) && ($value >= 1000)); $i++) { $value = $value / 1000; $ext  = $sizes[$i]; }
  }
  else
  {
    $sizes = Array('', 'm', 'u', 'n');
    $ext = $sizes[0];
    for ($i = 1; (($i < count($sizes)) && ($value != 0) && ($value <= 0.1)); $i++) { $value = $value * 1000; $ext  = $sizes[$i]; }
  }

  if ($neg) { $value = $value * -1; }

  return format_number_short(round($value, $round),$sf).$ext;
}

function format_bi($value, $round = '2', $sf = '3')
{
  if ($value < "0")
  {
    $neg = 1;
    $value = $value * -1;
  }
  $sizes = Array('', 'k', 'M', 'G', 'T', 'P', 'E');
  $ext = $sizes[0];
  for ($i = 1; (($i < count($sizes)) && ($value >= 1024)); $i++) { $value = $value / 1024; $ext  = $sizes[$i]; }

  if ($neg) { $value = $value * -1; }

  return format_number_short(round($value, $round), $sf).$ext;
}

function format_number($value, $base = '1000', $round=2, $sf=3)
{
  if ($base == '1000')
  {
    return format_si($value, $round, $sf);
  } else {
    return format_bi($value, $round, $sf);
  }
}

function is_valid_hostname($hostname)
{
  // The Internet standards (Request for Comments) for protocols mandate that
  // component hostname labels may contain only the ASCII letters 'a' through 'z'
  // (in a case-insensitive manner), the digits '0' through '9', and the hyphen
  // ('-'). The original specification of hostnames in RFC 952, mandated that
  // labels could not start with a digit or with a hyphen, and must not end with
  // a hyphen. However, a subsequent specification (RFC 1123) permitted hostname
  // labels to start with digits. No other symbols, punctuation characters, or
  // white space are permitted. While a hostname may not contain other characters,
  // such as the underscore character (_), other DNS names may contain the underscore

  return ctype_alnum(str_replace('_','',str_replace('-','',str_replace('.','',$hostname))));
}

// get $host record from /etc/hosts
function ipFromEtcHosts($host) {
  foreach (new SplFileObject('/etc/hosts') as $line) {
    $d = preg_split('/\s/', $line, -1, PREG_SPLIT_NO_EMPTY);
    if (empty($d) || substr(reset($d), 0, 1) == '#') continue;
    $ip = array_shift($d);
    $hosts = array_map('strtolower', $d);
    if (in_array(strtolower($host), $hosts)) return $ip;
  }
  return FALSE;
}

function gethostbyname6($host, $try_a = false) {
  // get AAAA record for $host
  // if $try_a is true, if AAAA fails, it tries for A
  // the first match found is returned
  // otherwise returns false

  $dns = gethostbynamel6($host, $try_a);
  if ($dns == false) {
    return false;
  } else {
    return $dns[0];
  }
}

function gethostbynamel6($host, $try_a = false) {
  // get AAAA records for $host,
  // if $try_a is true, if AAAA fails, it tries for A
  // results are returned in an array of ips found matching type
  // otherwise returns false

  $ip6 = array();
  $ip4 = array();

  // First try /etc/hosts
  /// FIXME. Mike: it is necessary to use nsswitch, but I yet didn't think up as.
  $etc = ipFromEtcHosts($host);
  if ($etc && strstr($etc, ':')) $ip6[] = $etc;

  if ($try_a == true) {
    if ($etc && strstr($etc, '.')) $ip4[] = $etc;
    $dns = dns_get_record($host, DNS_A + DNS_AAAA);
  } else {
    $dns = dns_get_record($host, DNS_AAAA);
  }

  foreach ($dns as $record) {
    switch ($record['type']) {
      case 'A':
        $ip4[] = $record['ip'];
        break;
      case 'AAAA':
        $ip6[] = $record['ipv6'];
        break;
    }
  }

  if (count($ip6) < 1) {
    if ($try_a == true) {
      if (count($ip4) < 1) {
        return false;
      } else {
        return $ip4;
      }
    } else {
      return false;
    }
  } else {
    return $ip6;
  }
}

function add_service($device, $service, $descr)
{
  $insert = array('device_id' => $device['device_id'], 'service_ip' => $device['hostname'], 'service_type' => $service,
                  'service_changed' => array('UNIX_TIMESTAMP(NOW())'), 'service_desc' => $descr, 'service_param' => "", 'service_ignore' => "0");

  echo dbInsert($insert, 'services');
}

function get_port_rrdfilename($device, $interface, $suffix = "")
{
  global $config;

  if ($device['hostname'] == "")
  {
    die(" Error: hostname for device is empty\n");
  }

  $device_identifier = strtolower($config['os'][$device['os']]['port_rrd_identifier']);

  // default to ifIndex
  $this_port_identifier = $interface['ifIndex'];

  if ($device_identifier == "ifname" && $interface['ifName'] != "")
  {
    $this_port_identifier = strtolower(str_replace("/", "-", $interface['ifName']));
  }

  if ($suffix == "")
  {
    return sprintf("%s/%s/port-%s.rrd", trim($config['rrd_dir']), trim($device['hostname']), $this_port_identifier);
  }
  else
  {
    return sprintf("%s/%s/port-%s-%s.rrd", trim($config['rrd_dir']), trim($device['hostname']), $this_port_identifier, $suffix);
  }
}

function get_http_request($request)
{
  global $config, $debug;

  $response = '';

  $opts = array('http' => array('timeout' => '20'));
  if (isset($config['http_proxy']) && $config['http_proxy'])
  {
    $opts['http']['proxy'] = 'tcp://' . $config['http_proxy'];
    $opts['http']['request_fulluri'] = TRUE;
  }
  // Basic proxy auth
  if (isset($config['proxy_user']) && $config['proxy_user'] && isset($config['proxy_password']))
  {
    $auth = base64_encode($config['proxy_user'].':'.$config['proxy_password']);
    $opts['http']['header'] = 'Proxy-Authorization: Basic '.$auth;
  }

  $context = stream_context_create($opts);
  $response = file_get_contents($request, FALSE, $context);

  return $response;
}

/**
 * Format date string.
 *
 * This function convert date/time string to format from
 * config option $config['timestamp_format'].
 * If date/time not detected in string, function return original string.
 * Example conversions to format 'd-m-Y H:i':
 * '2012-04-18 14:25:01' -> '18-04-2012 14:25'
 * 'Star wars' -> 'Star wars'
 *
 * @param string $str
 * @return string
 */
function format_timestamp($str)
{
  global $config;

  if (($timestamp = strtotime($str)) === false)
  {
    return $str;
  } else {
    return date($config['timestamp_format'], $timestamp);
  }
}

/**
 * Format unixtime.
 *
 * This function convert date/time string to format from
 * config option $config['timestamp_format'].
 * Can take an optional format parameter, which is passed to date();
 *
 * @param string $time
 * @param string $format
 * @return string
 */

function format_unixtime($time, $format = NULL)
{
  global $config;

  if ($format != NULL)
  {
    return date($format, $time);
  } else {
    return date($config['timestamp_format'], $time);
  }
}

// EOF
