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

// Pagination
$vars['pagination'] = TRUE;

$vars['entity_type'] = 'port';
$vars['entity_id']   = $vars['port'];

// Print Alert Log
print_alert_log($vars);

$pagetitle[] = '警报日志';

// EOF
