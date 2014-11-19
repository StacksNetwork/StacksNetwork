<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage authentication
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

// Warn if authentication will be impossible.
check_extension_exists('ldap', 'LDAP selected as authentication module, but PHP does not have LDAP support! Please load the PHP LDAP module.', TRUE);

// If kerberized login is used, take user from Apache to bypass login screen
if ($config['auth_ldap_kerberized'])
{
  $_SESSION['username'] = $_SERVER['REMOTE_USER'];
}

function ldap_init()
{
  global $ds, $config;

  if (!is_resource($ds))
  {
    $ds = @ldap_connect($config['auth_ldap_server'], $config['auth_ldap_port']);
    print_debug("LDAP[Connect]");
    
    if ($config['auth_ldap_starttls'] && ($config['auth_ldap_starttls'] == 'optional' || $config['auth_ldap_starttls'] == 'require'))
    {
      $tls = ldap_start_tls($ds);
      if ($config['auth_ldap_starttls'] == 'require' && $tls == FALSE)
      {
        session_logout();
        print_error("Fatal error: LDAP TLS required but not successfully negotiated [" . ldap_error($ds) . "]");
        exit;
      }
    }
    
    if ($config['auth_ldap_version'])
    {
      ldap_set_option($ds, LDAP_OPT_PROTOCOL_VERSION, $config['auth_ldap_version']);
    }
  }
}

function authenticate($username, $password)
{
  global $config, $ds;

  ldap_init();
  if ($username && $ds)
  {
    if (ldap_bind_dn($username, $password)) { return 0; }

    $binduser = ldap_dn_from_username($username);
    
    if ($binduser)
    {
      print_debug("LDAP[Authenticate][$username][$binduser]");

      // Auth via Apache Kerberos module + LDAP fallback -> automatically authenticated
      if ($config['auth_ldap_kerberized'] || ldap_bind($ds, $binduser, $password))
      {
        if (!$config['auth_ldap_group'])
        {
          return 1;
        }
        else
        {
          $userdn = ($config['auth_ldap_groupmembertype'] == 'fulldn' ? $binduser : $username);
          print_debug("LDAP[Compare][" . implode('|',$config['auth_ldap_group']) . "][".$config['auth_ldap_groupmemberattr']."][$userdn]");

          foreach($config['auth_ldap_group'] as $ldap_group)
          {
            if (ldap_compare($ds, $ldap_group, $config['auth_ldap_groupmemberattr'], $userdn))
            {
              return 1;
            } // FIXME does not support nested groups
          }
        }
      }
      else
      {
        print_debug(ldap_error($ds));
      }
    }
  }

  session_logout();
  return 0;
}

function auth_can_logout()
{
  global $config;

  // If kerberized, login is handled through apache; if not, we can log out.
  return (!$config['auth_ldap_kerberized']);
}

function auth_can_change_password($username = "")
{
  return 0;
}

function auth_change_password($username, $newpassword)
{
  // Not supported (for now)
}

function auth_usermanagement()
{
  return 0;
}

function adduser($username, $password, $level, $email = "", $realname = "", $can_modify_passwd = '1')
{
  // Not supported
  return 0;
}

function auth_user_exists($username)
{
  global $config, $ds;

  ldap_init();
  if (ldap_bind_dn()) { return 0; } // Will not work without bind user or anon bind

  $binduser = ldap_dn_from_username($username);
    
  if ($binduser)
  {
    return 1;
  }

  return 0;
}

function auth_user_level($username)
{
  global $config, $debug, $ds, $cache;

  if (!isset($cache['ldap']['level'][$username]))
  {
    $userlevel = 0;

    ldap_init();
    ldap_bind_dn();

    // Find all defined groups $username is in
    $userdn = ($config['auth_ldap_groupmembertype'] == 'fulldn' ? ldap_dn_from_username($username) : $username);
    $filter = "(&(|(cn=" . join(")(cn=", array_keys($config['auth_ldap_groups'])) . "))(" . $config['auth_ldap_groupmemberattr'] . "=" . $userdn . "))";
    if ($debug) { echo("LDAP[Filter][$filter]\n"); }
    $search = ldap_search($ds, $config['auth_ldap_groupbase'], $filter);
    $entries = ldap_get_entries($ds, $search);

    // Loop the list and find the highest level
    foreach ($entries as $entry)
    {
      $groupname = $entry['cn'][0];
      if ($config['auth_ldap_groups'][$groupname]['level'] > $userlevel)
      {
        $userlevel = $config['auth_ldap_groups'][$groupname]['level'];
      }
    }
  
    if ($debug) { echo("LDAP[Userlevel][$userlevel]\n"); }

    $cache['ldap']['level'][$username] = $userlevel;
  }

  return $cache['ldap']['level'][$username];
}

function auth_user_id($username)
{
  global $config, $debug, $ds;

  $userid = -1;

  ldap_init();
  ldap_bind_dn();

  $userdn = ($config['auth_ldap_groupmembertype'] == 'fulldn' ? ldap_dn_from_username($username) : $config['auth_ldap_prefix'] . $username . $config['auth_ldap_suffix']);
  
  $filter = "(" . str_ireplace($config['auth_ldap_suffix'], '', $userdn) . ")";
  print_debug("LDAP[Filter][$filter][" . trim($config['auth_ldap_suffix'], ', ') . "]");
  $search = ldap_search($ds, trim($config['auth_ldap_suffix'], ', '), $filter);
  $entries = ldap_get_entries($ds, $search);

  if ($entries['count'])
  {
    $userid = ldap_auth_user_id($entries[0]);
    print_debug("LDAP[UserID][$userid]");
  }

  return $userid;
}

function deluser($username)
{
  $user_id = auth_user_id($username);
  
  dbDelete('bill_perms',    "`user_id` =  ?", array($user_id));
  dbDelete('devices_perms', "`user_id` =  ?", array($user_id));
  dbDelete('ports_perms',   "`user_id` =  ?", array($user_id));
  dbDelete('users_prefs',   "`user_id` =  ?", array($user_id));
  dbDelete('users_ckeys',   "`username` =  ?", array($username));

  // Not supported
  return 0;
}

function auth_user_list()
{
  global $config, $debug, $ds;

  ldap_init();
  ldap_bind_dn();
  
  $filter = '(objectClass=' . $config['auth_ldap_objectclass'] . ')';

  print_debug("LDAP[Userlist][Filter][$filter][" . trim($config['auth_ldap_suffix'], ', ') . "]");
  $search = ldap_search($ds, trim($config['auth_ldap_suffix'], ', '), $filter);
  print_debug(ldap_error($ds));
  
  $entries = ldap_get_entries($ds, $search);

  if ($entries['count'])
  {
    for ($i = 0; $i < $entries['count']; $i++)
    {
      $username = $entries[$i][strtolower($config['auth_ldap_attr']['uid'])][0];
      $realname = $entries[$i][strtolower($config['auth_ldap_attr']['cn'])][0];
      $user_id  = ldap_auth_user_id($entries[$i]);

      $userdn = ($config['auth_ldap_groupmembertype'] == 'fulldn' ? $entries[$i]['dn'] : $username);
      
      print_debug("LDAP[Compare][" . implode('|',$config['auth_ldap_group']) . "][".$config['auth_ldap_groupmemberattr']."][$userdn]");
      
      foreach($config['auth_ldap_group'] as $ldap_group)
      {
        $authorized = 0;
        if (ldap_compare($ds, $ldap_group, $config['auth_ldap_groupmemberattr'], $userdn))
        {
          $authorized = 1;
          break;
        } // FIXME does not support nested groups
      }

      if (!isset($config['auth_ldap_group']) || $authorized)
      {
        $userlist[] = array('username' => $username, 'realname' => $realname, 'user_id' => $user_id);
      }
    }
  }

  return $userlist;
}


// Private function for this ldap module only
// Returns the textual SID for Active Directory
function ldap_bin_to_str_sid($binsid)
{
  $hex_sid = bin2hex($binsid);
  $rev = hexdec(substr($hex_sid, 0, 2));
  $subcount = hexdec(substr($hex_sid, 2, 2));
  $auth = hexdec(substr($hex_sid, 4, 12));
  $result  = "$rev-$auth";

  for ($x=0;$x < $subcount; $x++)
  {
    $subauth[$x] = hexdec(ldap_little_endian(substr($hex_sid, 16 + ($x * 8), 8)));
    $result .= "-" . $subauth[$x];
  }

  // Cheat by tacking on the S-
  return 'S-' . $result;
}

// Private function for this ldap module only
// Converts a little-endian hex-number to one, that 'hexdec' can convert
function ldap_little_endian($hex)
{
  for ($x = strlen($hex) - 2; $x >= 0; $x = $x - 2)
  {
    $result .= substr($hex, $x, 2);
  }

  return $result;
} 

// Private function for this ldap module only
// Bind with either the configured bind DN, the user's configured DN, or anonymously, depending on config.
function ldap_bind_dn($username = "", $password = "")
{
  global $config, $debug, $ds;

  ldap_init();
  if ($config['auth_ldap_binddn'])
  {
    print_debug("LDAP[Bind][" . $config['auth_ldap_binddn'] . "]");
    $bind = ldap_bind($ds, $config['auth_ldap_binddn'], $config['auth_ldap_bindpw']);
  } else {
    // Try anonymous bind if configured to do so
    if ($config['auth_ldap_bindanonymous'])
    {
      print_debug("LDAP[Bind][anonymous]");
      $bind = ldap_bind($ds);
    } else {
      if (($username == '' || $password == '') && isset($_SESSION['password']))
      {
        // Use session credintials
        $username = $_SESSION['username'];
        $password = $_SESSION['password'];
      }
      print_debug("LDAP[Bind][" . $config['auth_ldap_prefix'] . $username . $config['auth_ldap_suffix'] . "]");
      $bind = ldap_bind($ds, $config['auth_ldap_prefix'] . $username . $config['auth_ldap_suffix'], $password);
    }
  }
  
  if ($bind)
  {
    /// FIXME. Why on 'OK bind' returns 0 (== FALSE)?
    return 0;
  } else {
    print_debug("Error binding to LDAP server: " . $config['auth_ldap_server'] . ": " . ldap_error($ds));
    session_logout();
    return 1;
  }
}

// Private function for this ldap module only
function ldap_dn_from_username($username)
{
  global $config, $debug, $ds, $cache;

  if (!isset($cache['ldap']['dn'][$username]))
  {
    ldap_init();
    $filter = "(" . $config['auth_ldap_attr']['uid'] . '=' . $username . ")";
    if ($debug) { echo("LDAP[Filter][$filter][" . trim($config['auth_ldap_suffix'], ', ') . "]\n"); }
    $search = ldap_search($ds, trim($config['auth_ldap_suffix'], ', '), $filter);
    $entries = ldap_get_entries($ds, $search);

    if ($entries['count'])
    {
      $cache['ldap']['dn'][$username] = $entries[0]['dn'];
    }
  }
  
  return $cache['ldap']['dn'][$username];
}

// Private function for this ldap module only
function ldap_auth_user_id($result)
{
  global $config, $debug;

  // For AD, convert SID S-1-5-21-4113566099-323201010-15454308-1104 to 1104 as our numeric unique ID
  if ($config['auth_ldap_attr']['uidNumber'] == "objectSid")
  {
    $sid = explode('-', ldap_bin_to_str_sid($result['objectsid'][0]));
    $userid = $sid[count($sid)-1];
  } else {
    $userid = $result[strtolower($config['auth_ldap_attr']['uidNumber'])][0];
  }
  
  return $userid;
}

// EOF
