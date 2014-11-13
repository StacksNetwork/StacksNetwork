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

if ($_SESSION['userlevel'] == '10')
{
  print_warning("这个是您的系统设置副本, 如果需要调整请修改 <strong>config.php</strong> 文件.");
  echo("<pre>");
  print_vars($config);
  echo("</pre>");
} else {
  include("includes/error-no-perm.inc.php");
}

// EOF
