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

$pagetitle[] = "路由";

if ($_GET['optb'] == "graphs" || $_GET['optc'] == "graphs") { $graphs = "graphs"; } else { $graphs = "nographs"; }

// $routing is populated by cache-data.inc.php

$navbar['brand'] = "路由";
$navbar['class'] = "navbar-narrow";

foreach ($routing as $type => $value)
{
  if ($value['count'] > 0)
  {
    if (!$vars['protocol']) { $vars['protocol'] = $type; }
    if ($vars['protocol'] == $type) { $navbar['options'][$type]['class'] = "active"; }

    $navbar['options'][$type]['url']  = generate_url(array('page' => 'routing', 'protocol' => $type));
    $navbar['options'][$type]['text'] = nicecase($type).' ('.$value['count'].')';
  }
}
print_navbar($navbar);

switch ($vars['protocol'])
{
  case 'bgp':
  case 'vrf':
  case 'cef':
  case 'ospf':
    include('pages/routing/'.$vars['protocol'].'.inc.php');
    break;
  default:
    bug();
    break;
}

// EOF
