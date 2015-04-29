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

include_once("../includes/defaults.inc.php");
include_once("../config.php");
include_once("../includes/definitions.inc.php");
include($config['install_dir'] . "/includes/functions.inc.php");
include($config['html_dir'] . "/includes/functions.inc.php");

// Preflight checks

if (!is_dir($config['rrd_dir']))
{
  print_error("RRD 目录丢失 ({$config['rrd_dir']}).  绘图可能会失败.");
}

if (!is_dir($config['log_dir']))
{
  print_error("日志目录丢失 ({$config['log_dir']}).  登录可能会失败.");
}

if (!is_dir($config['temp_dir']))
{
  print_error("临时目录丢失 ({$config['temp_dir']}).  绘图可能会失败.");
}

if (!is_writable($config['temp_dir']))
{
  print_error("临时目录不可写 ({$config['tmp_dir']}).  绘图可能会失败.");
}

if (ini_get('register_globals'))
{
  $notifications[] = array('text' => 'register_globals enabled in php.ini. Disable it!', 'severity' => 'alert');
}
// verify if PHP supports session, die if it does not
check_extension_exists('session', '', TRUE);

ob_start();

?>

<!DOCTYPE html>
<html lang="en">
<head>
  <base href="<?php echo($config['base_url']); ?>" />
  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
  <link href="css/bootstrap-select.css" rel="stylesheet" type="text/css" />
  <link href="css/bootstrap-hacks.css" rel="stylesheet" type="text/css" />
  <link href="css/jquery.qtip.min.css" rel="stylesheet" type="text/css" />
  <link href="css/sprite.css" rel="stylesheet" type="text/css" />
  <link href="css/flags.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="js/jquery.min.js"></script>
  <script type="text/javascript" src="js/jquery-ui.min.js"></script>
  <script type="text/javascript" src="js/jquery.bootstrap-growl.js"></script>

<?php /* html5.js below from https://github.com/aFarkas/html5shiv */ ?>
  <!--[if lt IE 9]><script src="js/html5shiv.min.js"></script><![endif]-->
<?php
// If the php-ref scripts are installed, load up the bits needed
if ($ref_loaded)
{
?>
  <script type="text/javascript" src="js/ref.js"></script>
  <link   href="css/ref.css" rel="stylesheet" type="text/css" />
<?php
}

$runtime_start = utime();

ini_set('allow_url_fopen', 0);
ini_set('display_errors', 0);

$_SERVER['PATH_INFO'] = (isset($_SERVER['PATH_INFO']) ? $_SERVER['PATH_INFO'] : $_SERVER['ORIG_PATH_INFO']);

$vars = get_vars(); // Parse vars from GET/POST/URI
// print_vars($vars);

if ($vars['page'] == 'device')
{
  // Code prettify (but it's still horrible)
  if ($vars['tab'] == 'showconfig')
  {
    echo('
    <script type="text/javascript" src="js/google-code-prettify.js"></script>
    <link   href="css/google-code-prettify.css" rel="stylesheet" type="text/css" />');
  }
  // DHTML expandable tree
  if ($vars['tab'] == 'entphysical')
  {
    echo('
    <script type="text/javascript" src="js/mktree.js"></script>
    <link   href="css/mktree.css" rel="stylesheet" type="text/css" />');
  }
}

include($config['html_dir'] . "/includes/authenticate.inc.php");

if ($vars['widescreen'] == "yes") { $_SESSION['widescreen'] = 1; unset($vars['widescreen']); }
if ($vars['widescreen'] == "no")  { unset($_SESSION['widescreen']); unset($vars['widescreen']); }

if ($vars['big_graphs'] == "yes") { $_SESSION['big_graphs'] = 1; unset($vars['big_graphs']); }
if ($vars['big_graphs'] == "no")  { unset($_SESSION['big_graphs']); unset($vars['big_graphs']); }

// Load the settings for Multi-Tenancy. - FIXME i don't think we still support this, nor that it really works well. could/should be done in config.php by who needs this.
if (isset($config['branding']) && is_array($config['branding']))
{
  if ($config['branding'][$_SERVER['SERVER_NAME']])
  {
    foreach ($config['branding'][$_SERVER['SERVER_NAME']] as $confitem => $confval)
    {
      eval("\$config['" . $confitem . "'] = \$confval;");
    }
  } else {
    foreach ($config['branding']['default'] as $confitem => $confval)
    {
      eval("\$config['" . $confitem . "'] = \$confval;");
    }
  }
}

// page_title_prefix is displayed, unless page_title is set
if ($config['page_title']) { $config['page_title_prefix'] = $config['page_title']; }

$page_refresh = print_refresh($vars); // $page_refresh used in navbar for refresh menu

?>
  <title><?php echo($config['page_title_prefix'] . ($config['page_title_prefix'] != '' && $config['page_title_suffix'] != '' ? ' - ' : '') . $config['page_title_suffix']); ?></title>
  <link rel="shortcut icon" href="<?php echo($config['favicon']);  ?>" />
<?php

$feeds = array('eventlog');
//if ($config['enable_syslog']) { $feeds[] = 'syslog'; }
foreach ($feeds as $feed)
{
  $feed_href = generate_feed_url(array('feed' => $feed));
  if ($feed_href) echo($feed_href.PHP_EOL);
}

if ($_SESSION['widescreen']) { echo('<link rel="stylesheet" href="css/styles-wide.css" type="text/css" />'); }

echo '</head>';

if($vars['bare'] == 'yes')
{
  echo '<body style="padding-top: 10px;">';
} else {
  echo '<body>';
}

// Determine type of web browser.
$browser = detect_browser();
if ($browser == 'mobile' || $browser == 'tablet') { $_SESSION['touch'] = 'yes'; }
if ($vars['touch'] == "yes") { $_SESSION['touch'] = 'yes'; }
if ($vars['touch'] == "no") { unset($_SESSION['touch'], $vars['touch']); }

if ($_SESSION['authenticated'])
{
  // Do various queries which we use in multiple places
  include($config['html_dir'] . "/includes/cache-data.inc.php");

  // Include navbar
  if ($vars['bare'] != "yes") { include($config['html_dir'] . "/includes/navbar.inc.php"); }

}
?>

  <div class="container">

<?php

if ($_SESSION['authenticated'])
{
  if ($_SESSION['userlevel'] > 7)
  {
    // Warn about lack of mcrypt unless told not to.
    if ($config['login_remember_me'])
    {
      check_extension_exists('mcrypt', '这个扩展所需要使用的"记住我"的功能. 请在Ubuntu和Debian或RHEL/CentOS安装PHP5 mcrypt包. 另外,, 您可以设置禁用此功能 $config[\'login_remember_me\'] = FALSE; 你的配置文件内.');
    }

    // Warn about need DB schema update
    $db_version = get_db_version();
    $db_version = sprintf("%03d", $db_version+1);
    if (is_file($config['install_dir'] . "/update/$db_version.sql") || is_file($config['install_dir'] . "/update/$db_version.php"))
    {
      print_warning("您的数据库模式陈旧, 需要更新. 在服务器控制台:
                  <pre style="padding: 3px" class="small">' . $config['install_dir'] . '/discovery.php -u</pre>', 'severity' => 'alert');
    }
    unset($db_version);

    // Warning about obsolete config on some pages
    if (OBS_DEBUG ||
        in_array($vars['tab'], array('data', 'perf', 'edit', 'showtech')) ||
        in_array($vars['page'], array('pollerlog', 'settings', 'preferences')))
    {
      // FIXME move to notification center?
      print_obsolete_config();
    }
  }

  // Authenticated. Print a page.
  if (isset($vars['page']) && !strstr("..", $vars['page']) && is_file($config['html_dir']."/pages/" . $vars['page'] . ".inc.php"))
  {
    include($config['html_dir']."/pages/" . $vars['page'] . ".inc.php");
  } else {
    if (isset($config['front_page']) && is_file($config['html_dir']."/".$config['front_page']))
    {
      include($config['front_page']);
    } else {
      include($config['html_dir']."/pages/front/default.php");
    }
  }

} else {
  // Not Authenticated. Print login.
  include($config['html_dir']."/pages/logon.inc.php");

  exit;
}

$runtime_end = utime(); $runtime = $runtime_end - $runtime_start;
$gentime = substr($runtime, 0, 5);
$fullsize = memory_get_usage();
unset($cache);
$cachesize = $fullsize - memory_get_usage();
if ($cachesize < 0) { $cachesize = 0; } // Silly PHP!

?>
</div>

<div class="navbar navbar-fixed-bottom">
  <div class="navbar-inner">
    <div class="container">
      <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
        <span class="oicon-bar"></span>
        <span class="oicon-bar"></span>
        <span class="oicon-bar"></span>
      </a>
      <div class="nav-collapse">
        <ul class="nav">
          <li class="divider-vertical" style="margin:0;"></li>

          <li class="dropdown"><a href="<?php echo OBSERVIUM_URL; ?>" class="dropdown-toggle" data-hover="dropdown" data-toggle="dropdown"><?php echo OBSERVIUM_PRODUCT . ' ' . OBSERVIUM_VERSION_LONG; ?></a>
            <div class="dropdown-menu" style="padding: 10px;">
              <div style="max-width: 145px;"><img src="images/login-hamster-large.png" alt="" /></div>

            </div>
          </li>
          <li class="divider-vertical" style="margin:0;"></li>
        </ul>

        <ul class="nav pull-right">
          <!--<li><a id="poller_status"></a></li>-->

          <li class="divider-vertical" style="margin:0;"></li>
          <li class="dropdown">
            <?php
            if (count($notifications)) // FIXME level 10 only, maybe? (answer: just do not add notifications for this users. --mike)
            {
            ?>
            <a href="<?php echo(generate_url(array('page'=>'overview'))); ?>" class="dropdown-toggle" data-hover="dropdown" data-toggle="dropdown">
              <i class="oicon-exclamation-red"></i> <b class="caret"></b></a>
            <div class="dropdown-menu" style="padding: 10px; width: 800px;">
              <table class="table table-borderxed table-condensed-more table-rounded table-striped">
              <tr><th>通知中心</th></tr>
<?php
foreach ($notifications as $notification)
{
  // FIXME handle severity parameter with colour or icon?
  echo('<tr><td width="100%" class="'.$notification['severity'].'">' . $notification['text'] . '</td></tr>');
}
?>
              </table>
            </div>
            <?php
            } else {
              // Dim the icon to 20% opacity, makes the red pretty much blend in to the navbar
              ?>
            <a href="<?php echo(generate_url(array('page'=>'overview'))); ?>" alt="Notification center" class="dropdown-toggle" data-hover="dropdown" data-toggle="dropdown">
              <i style="opacity: 0.2; filter: alpha(opacity=20);" class="oicon-tick-circle"></i></a>
              <?php
            }
            ?>
          </li>

          <li class="divider-vertical" style="margin:0;"></li>
          <li class="dropdown">
            <a href="<?php echo(generate_url(array('page'=>'overview'))); ?>" class="dropdown-toggle" data-hover="dropdown" data-toggle="dropdown">
              <i class="oicon-time"></i> <?php echo($gentime); ?>s <b class="caret"></b></a>
            <div class="dropdown-menu" style="padding: 10px;">
              <table class="table table-bordered table-condensed-more table-rounded table-striped">
                <tr>
                  <th>Page</th><td><?php echo($gentime); ?>s</td>
                </tr>
                <tr>
                  <th>Cache</th><td><?php echo($cache_time); ?>s</td>
                </tr>

              </table>
              <table class="table table-bordered table-condensed-more table-rounded table-striped">
                <tr>
                  <th colspan=2>MySQL</th>
                </tr>
                <tr>
                  <th>Cell</th><td><?php echo(($db_stats['fetchcell']+0).'/'.round($db_stats['fetchcell_sec']+0,4).'s'); ?></td>
                </tr>
                <tr>
                  <th>Row</th><td><?php echo(($db_stats['fetchrow']+0).'/'.round($db_stats['fetchrow_sec'],4).'s'); ?></td>
                </tr>
                <tr>
                  <th>Rows</th><td><?php echo(($db_stats['fetchrows']+0).'/'.round($db_stats['fetchrows_sec']+0,4).'s'); ?></td>
                </tr>
                <tr>
                  <th>Column</th><td><?php echo(($db_stats['fetchcol']+0).'/'.round($db_stats['fetchcol_sec']+0,4).'s'); ?></td>
                </tr>
              </table>
              <table class="table table-bordered table-condensed-more table-rounded table-striped">
                <tr>
                  <th colspan=2>Memory</th>
                </tr>
                <tr>
                  <th>Cached</th><td><?php echo formatStorage($cachesize); ?></td>
                </tr>
                <tr>
                  <th>Page</th><td><?php echo formatStorage($fullsize); ?></td>
                </tr>
                <tr>
                  <th>Peak</th><td><?php echo formatStorage(memory_get_peak_usage()); ?></td>
                </tr>
              </table>
            </div>
          </li>

<?php if ($config['profile_sql'] == TRUE) // FIXME level 10 only?
{
?>
          <li class="dropdown">
            <a href="<?php echo(generate_url(array('page'=>'overview'))); ?>" class="dropdown-toggle" data-hover="dropdown" data-toggle="dropdown">
              <i class="oicon-databases"></i> <b class="caret"></b></a>
            <div class="dropdown-menu" style="padding: 10px; width: 1150px;">

              <table class="table table-bordered table-condensed-more table-rounded table-striped">

  <?php

  $sql_profile = array_sort($sql_profile, 'time', 'SORT_DESC');
  $sql_profile = array_slice($sql_profile, 0, 15);
  foreach ($sql_profile AS $sql_query)
  {
    echo '<tr><td>', $sql_query['time'], '</td><td>';
    print_sql($sql_query['sql']);
    echo '</td></tr>';
  }

  ?>
              </table>
            </div>
          </li>
<?php
} // End profile_sql
?>

       </ul>
      </div>
    </div>
  </div>
</div>

<?php
if (is_array($page_title))
{
  // if prefix is set, put it in front
  if ($config['page_title_prefix']) { array_unshift($page_title,$config['page_title_prefix']); }

  // if suffix is set, put it in the back
  if ($config['page_title_suffix']) { $page_title[] = $config['page_title_suffix']; }

  // create and set the title
  $title = join(" - ",$page_title);

  echo('<script type="text/javascript">document.title = "'.$title.'";</script>');
}

//  <script type="text/javascript">
//  $(document).ready(function()
//  {
//    $('#poller_status').load('ajax_poller_status.php');
//  });
//
//  var auto_refresh = setInterval(
//    function ()
//    {
//      $('#poller_status').load('ajax_poller_status.php');
//    }, 10000); // refresh every 10000 milliseconds
//  </script>

?>
  <script type="text/javascript">
  <!-- Begin
  function popUp(URL)
  {
    day = new Date();
    id = day.getTime();
    eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=1,location=0,statusbar=0,        menubar=0,resizable=1,width=550,height=600');");
  }
  // End -->
  </script>

  <script src="js/bootstrap.min.js"></script>

<?php

  // No dropdowns on touch gadgets
  if ($_SESSION['touch'] != 'yes')
  {
    echo '<script type="text/javascript" src="js/twitter-bootstrap-hover-dropdown.min.js"></script>';
  }
  // Same as in overlib_link()
  if ($config['web_mouseover'] && detect_browser() != 'mobile')
  {
    echo '<script type="text/javascript" src="js/jquery.qtip.min.js"></script>';
  }

?>

  <script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
  <script type="text/javascript" src="js/bootstrap-select.min.js"></script>
  <script type="text/javascript">$('.selectpicker').selectpicker();</script>

  <script type="text/javascript" src="js/bootstrap-switch.min.js"></script>
  <script type="text/javascript" src="js/observium.js"></script>

  </body>
</html>
