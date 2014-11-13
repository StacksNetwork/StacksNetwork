<?php

/// FIXME. Need rewrite: do not save unencrypted passwords (in $_SESSION)

@ini_set("session.gc_maxlifetime","0");    // Session will not expire until the browser is closed
@ini_set("session.hash_function", "1");    // Use sha1 to generate the session ID
@ini_set('session.referer_check', '');     // This config was causing so much trouble with Chrome
@ini_set("session.name", "OBSID");         // Session name
@ini_set('session.use_cookies', '1');      // Use cookies to store the session id on the client side
@ini_set('session.use_only_cookies', '1'); // This prevents attacks involved passing session ids in URLs
@ini_set("session.use_trans_sid", "0");    // Disable SID (no session id in url)

$lifetime        = time()+60*60*24*14;     // Session lifetime (14 days)
$lifetime_id     = 20;                     // Session ID lifetime (time before regenerate id, 20 sec)
$cookie_path     = '/';                    // Cookie path
$cookie_domain   = '';                     // RFC 6265, to have a "host-only" cookie is to NOT set the domain attribute.
/// FIXME. Some old browsers not supports secure/httponly cookies params.
$cookie_https    = is_ssl();
$cookie_httponly = TRUE;

session_set_cookie_params(0, $cookie_path, $cookie_domain, $cookie_https, $cookie_httponly);
session_write_close();
session_start();
if (isset($_SESSION['starttime']))
{
  if (time() - $_SESSION['starttime'] >= $lifetime_id)
  {
    // ID Lifetime expired, regenerate
    session_regenerate_id(TRUE);
    $_SESSION['starttime'] = time();
  }
} else {
  $_SESSION['starttime'] = time();
}

// Fallback to MySQL auth as default
if (!isset($config['auth_mechanism']))
{
  $config['auth_mechanism'] = "mysql";
}

$auth_file = $config['html_dir'].'/includes/authentication/' . $config['auth_mechanism'] . '.inc.php';
if (is_file($auth_file))
{
  if (isset($_SESSION['auth_mechanism']) && $_SESSION['auth_mechanism'] != $config['auth_mechanism'])
  {
    // Logout if AUTH mechanism changed
    session_logout();
    header('Location: '.$config['base_url']);
    $auth_message = 'ERROR: auth_mechanism changed!';
    exit();
  } else {
    $_SESSION['auth_mechanism'] = $config['auth_mechanism'];
  }
  include($auth_file);
}
else
{
  session_logout();
  header('Location: '.$config['base_url']);
  $auth_message = 'ERROR: no valid auth_mechanism defined!';
  exit();
}

if ($vars['page'] == "logout" && $_SESSION['authenticated'])
{
  if (auth_can_logout())
  {
    session_logout(function_exists('auth_require_login'));
    $auth_message = "Logged Out";
  }
  header('Location: '.$config['base_url']);
  exit();
}

$mcrypt_exists = check_extension_exists('mcrypt');
$user_unique_id = md5($_SERVER['REMOTE_NAME'] . $_SERVER['REMOTE_ADDR'] . $_SERVER['HTTP_USER_AGENT']);

if (!$_SESSION['authenticated'] && isset($_GET['username']) && isset($_GET['password']))
{
  $_SESSION['username'] = $_GET['username'];
  $_SESSION['password'] = $_GET['password'];
}
else if (!$_SESSION['authenticated'] && isset($_POST['username']) && isset($_POST['password']))
{
  $_SESSION['username'] = $_POST['username'];
  $_SESSION['password'] = $_POST['password'];
}
else if ($mcrypt_exists && !$_SESSION['authenticated'] && isset($_COOKIE['ckey']))
{
  $ckey = dbFetchRow("SELECT * FROM `users_ckeys` WHERE `user_uniq` = ? AND `user_ckey` = ? LIMIT 1",
                          array($user_unique_id, $_COOKIE['ckey']));
  if (is_array($ckey))
  {
    if ($ckey['expire'] > time())
    {
      $_SESSION['username']     = $ckey['username'];
      $_SESSION['password']     = decrypt($ckey['user_encpass'], $_COOKIE['dkey']);
      $_SESSION['user_ckey_id'] = $ckey['user_ckey_id'];
      $_SESSION['cookie_auth']  = TRUE;
    }
  }
}

if ($_COOKIE['password']) { setcookie("password", NULL); }
if ($_COOKIE['username']) { setcookie("username", NULL); }
if ($_COOKIE['user_id'] ) { setcookie("user_id",  NULL); }

$auth_success = 0;

if (isset($_SESSION['username']))
{
  // Auth from COOKIEs
  if ($_SESSION['cookie_auth'])
  {
    $_SESSION['authenticated'] = TRUE;
    dbUpdate("UPDATE `users_ckeys` SET `expire` = ? WHERE `users_ckey_id` = ?", array(time()+$lifetime, $_SESSION['user_ckey_id']));
    //dbInsert(array('user' => $_SESSION['username'], 'address' => $_SERVER["REMOTE_ADDR"], 'result' => 'Logged in with COOKIE'), 'authlog');
    unset($_SESSION['user_ckey_id']);
  }
  
  // Auth from login/password
  if (!$_SESSION['authenticated'] && (authenticate($_SESSION['username'], $_SESSION['password']) || (auth_usermanagement() && auth_user_level($_SESSION['origusername']) >= 10)))
  {
    $_SESSION['authenticated'] = TRUE;
    dbInsert(array('user' => $_SESSION['username'], 'address' => $_SERVER["REMOTE_ADDR"], 'result' => '登录'), 'authlog');
    
    // Add feeds & api keys after first auth
    if ($mcrypt_exists && !get_user_pref($_SESSION['user_id'], 'atom_key'))
    {
      set_user_pref($_SESSION['user_id'], 'atom_key', md5(strgen()));
    }
    
    // Generate keys for cookie auth
    if (isset($_POST['remember']) && $mcrypt_exists)
    {
      $ckey = md5(strgen());
      $dkey = md5(strgen());
      $encpass = encrypt($_SESSION['password'], $dkey);
      dbDelete('users_ckeys', "`username` = ? AND `expire` < ?", array($_SESSION['username'], time())); // Remove old ckeys from DB
      dbInsert(array('user_encpass' => $encpass, 'expire' => time()+$lifetime, 'username' => $_SESSION['username'], 'user_uniq' => $user_unique_id, 'user_ckey' => $ckey), 'users_ckeys');
      setcookie("ckey", $ckey, $lifetime, $cookie_path, $cookie_domain, $cookie_https, $cookie_httponly);
      setcookie("dkey", $dkey, $lifetime, $cookie_path, $cookie_domain, $cookie_https, $cookie_httponly);
      unset($_SESSION['user_ckey_id']);
    }
    
    header("Location: ".$_SERVER['REQUEST_URI']);
    /// exit(); Tom, not exit here!
  }

  if ($_SESSION['authenticated'])
  {
    if (!is_numeric($_SESSION['userlevel']) || !is_numeric($_SESSION['user_id']))
    {
      $_SESSION['userlevel'] = auth_user_level($_SESSION['username']);
      $_SESSION['user_id']   = auth_user_id($_SESSION['username']);
    }
    
    $permissions = permissions_cache($_SESSION['user_id']);
  }
  elseif (isset($_SESSION['username']))
  {
    $auth_message = "验证失败";
    dbInsert(array('user' => $_SESSION['username'], 'address' => $_SERVER["REMOTE_ADDR"], 'result' => '验证失败'), 'authlog');
    session_logout(function_exists('auth_require_login'));
  }
}

///r($_SESSION);
///r($_COOKIE);

function session_logout($relogin = FALSE)
{
  dbInsert(array('user' => $_SESSION['username'], 'address' => $_SERVER["REMOTE_ADDR"], 'result' => '注销'), 'authlog');
  if (isset($_COOKIE['ckey'])) dbDelete('users_ckeys', "`username` = ? AND `user_ckey` = ?", array($_SESSION['username'], $_COOKIE['ckey'])); // Remove old ckeys from DB
  // Unset cookies
  $cookie_params = session_get_cookie_params();
  $past = time() - 3600;
  foreach ($_COOKIE as $cookie => $value)
  {
    if (empty($cookie_params['domain']))
    {
      setcookie($cookie, '', $past, $cookie_params['path']);
    } else {
      setcookie($cookie, '', $past, $cookie_params['path'], $cookie_params['domain']);
    }
  }
  unset($_COOKIE);
  
  // Unset session
  if ($relogin)
  {
    // Reset session and relogin (for example: HTTP auth)
    $_SESSION['relogin'] = TRUE;
    unset($_SESSION['authenticated'], $_SESSION['username'], $_SESSION['password']);
  } else {
    session_destroy();
    unset($_SESSION);
  }
}

// EOF
