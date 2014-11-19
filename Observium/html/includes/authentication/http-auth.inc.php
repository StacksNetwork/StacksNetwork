<?php

include($config['html_dir'].'/includes/authentication/mysql.inc.php');

if (!$_SESSION['authenticated'] && !is_cli())
{
  if (isset($_SERVER['PHP_AUTH_USER']))
  {
    $username = $_SERVER['PHP_AUTH_USER'];
    $password = $_SERVER['PHP_AUTH_PW'];
  }
  elseif (isset($_SERVER['HTTP_AUTHENTICATION']))
  {
    if (strpos(strtolower($_SERVER['HTTP_AUTHENTICATION']), 'basic') === 0) list($username, $password) = explode(':', base64_decode(substr($_SERVER['HTTP_AUTHORIZATION'], 6)));
  }
  
  if ($_SESSION['relogin'] || empty($username) || !authenticate($username, $password))
  {
    auth_require_login();
  } else {
    $_SESSION['username'] = $username;
    $_SESSION['password'] = $password;
  }
}

// This function forces a login prompt
function auth_require_login()
{
  $realm = $GLOBALS['config']['login_message'];
  header('WWW-Authenticate: Basic realm="' . $realm . '"');
  header('HTTP/1.1 401 Unauthorized');
  include($GLOBALS['config']['html_dir'].'/includes/error-no-perm.inc.php');
  session_logout();
  die();
}

// EOF
