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

include_once("../../includes/defaults.inc.php");
include_once("../../config.php");
include_once("../../includes/definitions.inc.php");

include($config['install_dir'] . "/includes/common.inc.php");
include($config['install_dir'] . "/includes/dbFacile.php");
include($config['install_dir'] . "/includes/rewrites.inc.php");
include($config['install_dir'] . "/includes/entities.inc.php");
include($config['html_dir'] . "/includes/functions.inc.php");
include($config['html_dir'] . "/includes/authenticate.inc.php");

if (!$_SESSION['authenticated']) { echo("unauthenticated"); exit; }

if (is_numeric($_GET['device_id']))
{
  foreach (dbFetch("SELECT * FROM ports WHERE device_id = ? AND deleted = 0", array($_GET['device_id'])) as $interface)
  {
    $string = addslashes($interface['ifDescr']." - ".$interface['ifAlias']); # FIXME wtf mres? is it supposed to escape javascript stuff?
    echo("obj.options[obj.options.length] = new Option('".$string."','".$interface['port_id']."');\n");
    #echo("obj.options[obj.options.length] = new Option('".$interface['ifDescr']." - ".$interface['ifAlias']."','".$interface['port_id']."');\n");
  }
}

?>
