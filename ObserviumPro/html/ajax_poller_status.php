<?php
/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage ajax
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2015 Adam Armstrong
 *
 */

/* DEBUG enabled in definitions
if (isset($_GET['debug']) && $_GET['debug'])
{
  ini_set('display_errors', 1);
  ini_set('display_startup_errors', 1);
  ini_set('log_errors', 0);
  ini_set('allow_url_fopen', 0);
  ini_set('error_reporting', E_ALL);
}
*/

include_once("../includes/defaults.inc.php");
include_once("../config.php");
include_once("../includes/definitions.inc.php");

include($config['install_dir'] . "/includes/common.inc.php");
include($config['install_dir'] . "/includes/dbFacile.php");
include($config['install_dir'] . "/includes/rewrites.inc.php");
include($config['install_dir'] . "/includes/entities.inc.php");
include($config['html_dir'] . "/includes/functions.inc.php");
include($config['html_dir'] . "/includes/authenticate.inc.php");

if (!$_SESSION['authenticated']) { echo("未经验证"); exit; }

exec("ps aux | grep -i 'poller.php' | grep -v grep", $output);
if (empty($output)) {
  echo "轮询空闲";
} else {
  echo('<img style="margin-top: -2px;" src="images/loading.gif" /> 轮询运行中');
}

?>
