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

// FIXME svn stuff still using optc etc, won't work, needs updating!

if ($_SESSION['userlevel'] >= 5)
{
  // Note. $device_config_file defined in device.inc.php

  print_optionbar_start();

  $show_menu = '<strong>设置</strong> &#187; ';

  if (!$vars['rev']) {
    $show_menu .= '<span class="pagemenu-selected">';
    $show_menu .= generate_link('Latest',array('page'=>'device','device'=>$device['device_id'],'tab'=>'showconfig'));
    $show_menu .= '</span>';
  } else {
    $show_menu .= generate_link('Latest',array('page'=>'device','device'=>$device['device_id'],'tab'=>'showconfig'));
  }

  if (check_extension_exists('svn'))
  {
    $sep     = ' | ';
    $svnlogs = svn_log($device_config_file, SVN_REVISION_HEAD, NULL, 8);
    $revlist = array();

    foreach ($svnlogs as $svnlog)
    {
      $show_menu .= $sep;
      $revlist[] = $svnlog['rev'];

      if ($vars['rev'] == $svnlog['rev']) { $show_menu .= '<span class="pagemenu-selected">'; }
      $linktext = 'r' . $svnlog['rev'] . ' <small>' . format_timestamp($svnlog['date']) . '</small>';
      $show_menu .= generate_link($linktext,array('page'=>'device','device'=>$device['device_id'],'tab'=>'showconfig','rev'=>$svnlog['rev']));

      if ($vars['rev'] == $svnlog['rev']) { $show_menu .= '</span>' . PHP_EOL; }
    }
  }

  echo($show_menu);

  print_optionbar_end();

  if (check_extension_exists('svn') && in_array($vars['rev'], $revlist))
  {
    list($diff, $errors) = svn_diff($device_config_file, $vars['rev']-1, $device_config_file, $vars['rev']);
    if (!$diff)
    {
      $text = '没有区别';
    } else {
      $text = '';
      while (!feof($diff)) { $text .= fread($diff, 8192); }
      fclose($diff);
      fclose($errors);
    }
  } else {
    $fh = fopen($device_config_file, 'r') or die("Can't open file");
    $text = fread($fh, filesize($device_config_file));
    fclose($fh);
  }

  if ($config['rancid_ignorecomments'])
  {
    $lines = explode('\n',$text);
    for ($i = 0;$i < count($lines);$i++)
    {
      if ($lines[$i][0] == '#') { unset($lines[$i]); }
    }
    $text = join('\n',$lines);
  }

  $text = '<pre class="prettyprint linenums">' . PHP_EOL . $text;
  $text .= '</pre>' . PHP_EOL;
  $text .= '<script type="text/javascript">window.prettyPrint && prettyPrint();</script>' . PHP_EOL;
  echo($text);
}

$pagetitle[] = '设置';

// EOF
