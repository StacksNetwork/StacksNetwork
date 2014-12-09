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

include($config['html_dir']."/includes/alerting-groups.inc.php");

// Global write permissions required.
if ($_SESSION['userlevel'] < 10)
{
  include("includes/error-no-perm.inc.php");
} else {
  // Regenerate alerts

  echo '<div class="well">';
  foreach (dbFetchRows("SELECT * FROM `devices`") AS $device)
//  foreach (dbFetchRows("SELECT * FROM `devices` WHERE device_id = 325") AS $device)
  {
    update_device_group_table($device);
  }

  echo '</div>';
}

unset($vars['action']);

