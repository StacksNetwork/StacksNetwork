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

foreach (dbFetchRows("SELECT * FROM `ports` WHERE `deleted` = '1'") as $port)
{
  echo("<div style='font-weight: bold;'>Deleting port " . $port['port_id'] . " - " . $port['ifDescr']);
  delete_port($port['port_id']);
  echo("</div>");
}

// EOF
