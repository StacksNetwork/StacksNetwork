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
  print_warning("这是您的Observium配置转存文件夹, 如果需要调整请编辑 <strong>config.php</strong> 文件.");
  echo("<pre>");
  print_vars($config);
  echo("</pre>");
} else {
  include("includes/error-no-perm.inc.php");
}

// EOF
