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

include($config['html_dir']."/includes/alerting-navbar.inc.php");

// Global write permissions required.
if ($_SESSION['userlevel'] < 10)
{
  include("includes/error-no-perm.inc.php");
} else {
  // Regenerate alerts

  echo '<div class="well">';
  foreach (dbFetchRows("SELECT * FROM `devices`") as $device)
  {
    $result = update_device_alert_table($device);
    print_message($result['message'], $result['class']);
  }

  echo '</div>';
}

unset($vars['action']);

// EOF
