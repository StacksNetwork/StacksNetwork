<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage housekeeping
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

$cutoff = age_to_unixtime($config['housekeeping']['deleted_ports']['age']);

if ($cutoff)
{
  $where  = "`deleted` = 1 AND UNIX_TIMESTAMP(`ifLastChange`) < $cutoff";
  $ports  = dbFetchRows("SELECT `port_id` FROM `ports` WHERE $where");
  $count  = count($ports);
  if ($count)
  {
    if ($prompt)
    {
      $answer = print_prompt("$count ports marked as 'DELETED' older than " . format_unixtime($cutoff) . " will be deleted");
    }
    if ($answer)
    {
      foreach ($ports as $entry)
      {
        delete_port($entry['port_id']);
      }
      print_debug("Deleted ports housekeeping: deleted $count entries");
      logfile("housekeeping.log", "Deleted ports: deleted $count entries older than " . format_unixtime($cutoff));
    }
  }
  else if ($prompt)
  {
    print_message("No deleted ports found older than " . format_unixtime($cutoff));
  }
} else {
  print_message("Deleted ports housekeeping disabled in configuration.");
}

// EOF
