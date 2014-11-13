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

// FIXME - do this in a function and/or do it in graph-realtime.php

if(!isset($vars['interval'])) {
  if ($device['os'] == "linux") {
    $vars['interval'] = "15";
  } else {
    $vars['interval'] = "2";
  }
}

$navbar['class'] = "navbar-narrow";
$navbar['brand'] = "轮询间隔时间";

foreach (array(0.25, 1, 2, 5, 15, 60) as $interval)
{
  if ($vars['interval'] == $interval) { $navbar['options'][$interval]['class'] = "active"; }
  $navbar['options'][$interval]['url'] = generate_url($link_array,array('view'=>'realtime','interval'=>$interval));
  $navbar['options'][$interval]['text'] = $interval."s";
}

print_navbar($navbar);

?>

<div align="center" style="margin: 30px;">
<object data="graph-realtime.php?type=bits&id=<?php echo($port['port_id'] . "&interval=".$vars['interval']); ?>" type="image/svg+xml" width="1000" height="400">
<param name="src" value="graph.php?type=bits&id=<?php echo($port['port_id'] . "&interval=".$vars['interval']); ?>" />
您的浏览器不支持型SVG! 您需要使用Firefox或下载Adobe SVG插件.
</object>
</div>
<?php

// EOF
