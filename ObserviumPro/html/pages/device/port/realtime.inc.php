<?php

/**
 * Observium Network Management and Monitoring System
 * Copyright (C) 2006-2014, Adam Armstrong - http://www.observium.org
 *
 * @package    observium
 * @subpackage webui
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2015 Adam Armstrong
 *
 */

if (!isset($vars['interval']))
{
  if (isset($config['os'][$device['os']]['realtime']))
  {
    $vars['interval'] = $config['os'][$device['os']]['realtime'];
  } else {
    $vars['interval'] = $config['realtime_interval'];
  }
}

$navbar['class'] = "navbar-narrow";
$navbar['brand'] = "轮询间隔";

foreach (array(0.25, 1, 2, 5, 10, 15, 30, 60) as $interval)
{
  if ($vars['interval'] == $interval) { $navbar['options'][$interval]['class'] = "active"; }
  $navbar['options'][$interval]['url'] = generate_url($link_array,array('view'=>'realtime','interval'=>$interval));
  $navbar['options'][$interval]['text'] = $interval."s";
}

print_navbar($navbar);

$realtime_link = 'graph-realtime.php?type=bits&amp;id=' . $port['port_id'] . '&amp;interval='.$vars['interval'];
if (OBS_DEBUG)
{
  $realtime_link .= '&amp;debug=yes';
}
?>

<div style="margin: 30px; text-align: center;">
<object data="<?php echo($realtime_link); ?>" type="image/svg+xml" width="1000" height="400">
<param name="src" value="graph.php?type=bits&amp;id=<?php echo($port['port_id'] . "&amp;interval=".$vars['interval']); ?>" />
您的浏览器不支持SVG! 你需要使用Firefox或Chrome,或下载Adobe SVG插件.
</object>
</div>
<?php

// EOF
