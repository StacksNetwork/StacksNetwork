<?php

/**
 * Observium Network Management and Monitoring System
 * Copyright (C) 2006-2014, Adam Armstrong - http://www.observium.org
 *
 * @package    observium
 * @subpackage webui
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

?>
<h2>用户管理: 认证日志</h2>
<?php

include("usermenu.inc.php");

if ($_SESSION['userlevel'] == '10')
{
  // Pagination
  $vars['pagination'] = TRUE;
  if (!$vars['pagesize']) { $vars['pagesize'] = "100"; }
  if (!$vars['pageno']) { $vars['pageno'] = "1"; }

  print_authlog($vars);

  $pagetitle[] = 'Authlog';

  echo("  </tbody>\n");
  echo("</table>\n");
} else {
  include("includes/error-no-perm.inc.php");
}

// EOF
