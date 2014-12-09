#!/usr/bin/env php
<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage cli
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

chdir(dirname($argv[0]));

include("includes/defaults.inc.php");
include("config.php");
include("includes/definitions.inc.php");
include("includes/functions.inc.php");

$scriptname = basename($argv[0]);

$options = getopt("h:d");

$cli = TRUE;

if (isset($options['d']))
{
  $debug = TRUE;
}

$localhost = get_localhost();

print_message("%g".OBSERVIUM_PRODUCT." ".OBSERVIUM_VERSION."\n%W测试E-mail配置%n\n", 'color');

print_message("See mail backend options here: http://www.observium.org/wiki/Configuration_Options#Email_backend_settings\n");
// Warning about obsolete configs.
if (print_obsolete_config('email')) { echo PHP_EOL; }

if ($options['h'])
{
  $params = array();
  print_message("我的主机名: %g$localhost%n", 'color');
  if (!strpos($localhost, '.'))
  {
    print_message('  %y主机名不是 FQDN%n, 这可能会在后台发送SMTP电子邮件时导致问题', 'color');
  }

  /*
  // Convert obsolete config options to new.
  foreach (array('backend', 'from', 'sendmail_path', 'smtp_host', 'smtp_port',
                 'smtp_timeout', 'smtp_secure', 'smtp_auth', 'smtp_username', 'smtp_password') as $tmp_param)
  {
    if (isset($config['email_'.$tmp_param]))
    {
      $config['email'][$tmp_param] = $config['email_'.$tmp_param];
      $tmp_message .= sprintf("  %-43s rename to: %s", '$config[\'email_'.$tmp_param.'\'],', '%W$config[\'email\'][\''.$tmp_param.'\']%n'.PHP_EOL);
    }
  }
  if (isset($config['alerts']['email']['default']))
  {
    $config['email']['default'] = $config['alerts']['email']['default'];
    $tmp_message .= "  \$config['alerts']['email']['default'],      重命名为: %W\$config['email']['default']%n\n";
  }
  if (isset($config['alerts']['email']['default_only']))
  {
    $config['email']['default_only'] = $config['alerts']['email']['default_only'];
    $tmp_message .= "  \$config['alerts']['email']['default_only'], 重命名为: %W\$config['email']['default_only']%n\n";
  }
  if (isset($config['alerts']['email']['enable']))
  {
    $config['email']['enable'] = $config['alerts']['email']['enable'];
    $tmp_message .= "  \$config['alerts']['email']['enable'],       重命名为: %W\$config['email']['enable']%n\n";
  }
  if ($tmp_message)
  {
    print_message("\n%r您使用的是过时的配置选项, 将它们重命名在 config.php:%n\n".$tmp_message, 'color');
  }
  */

  // Prefly checks
  $option = "(\$config['email']['enable'])";
  if (isset($config['email']['enable']) && !$config['email']['enable'])
  {
    print_message("E-mails %rDISABLED%n globally $option", 'color');
  } else {
    print_message("E-mails %gENABLED%n globally $option", 'color');
  }

  $backend = strtolower(trim($config['email']['backend']));
  $option = "(\$config['email']['backend'])";
  switch ($backend)
  {
    case 'sendmail':
      print_message("E-mails use %gSENDMAIL%n backend $option", 'color');
      print_message("  sendmail path: [".(is_file($config['email']['sendmail_path']) ? '%g': '%r').$config['email']['sendmail_path']."%n]", 'color');
      break;
    case 'smtp':
      print_message("E-mails use %gSMTP%n backend $option", 'color');
      if ($config['email']['smtp_secure'] == 'ssl')
      {
        if ($config['email']['smtp_port'] == 25)
        {
          $config['email']['smtp_port'] = 465; // Default port for SSL
        }
      }
      print_message("  smtp host: [%g".$config['email']['smtp_host']."%n]", 'color');
      print_message("  smtp port: [%g".$config['email']['smtp_port']."%n]", 'color');
      if ($config['email']['smtp_secure'])
      {
        print_message("  smtp secure: [%g".strtoupper($config['email']['smtp_secure'])."%n]", 'color');
      }
      print_message("  smtp timeout: [%g".$config['email']['smtp_timeout']."%n]", 'color');
      if ($config['email']['smtp_auth'])
      {
        print_message("  smtp auth: [%WTRUE%n]", 'color');
        print_message("  smtp username: [".$config['email']['smtp_username']."]");
        print_message("  smtp password: [".$config['email']['smtp_password']."]");
      } else {
        print_message("  smtp auth: [%WFALSE%n]", 'color');
      }
      break;
    case 'mail':
    default:
      print_message("E-mails use %gPHP-builtin MAIL%n backend $option", 'color');
  }
  if ($config['email']['default_only'])
  {
    $option = "(\$config['email']['default_only'])";
    print_message("E-mails send %gonly to default%n email $option", 'color');
  }
  if ($config['email']['default'])
  {
    $option = "(\$config['email']['default'])";
    print_message("E-mails use these default recipient(s) $option:\n  %g".$config['email']['default']."%n", 'color', FALSE);
  }
  if (empty($config['email']['from']))
  {
    $config['email']['from'] = 'Observium <observium@'.$localhost.'>'; // Default "From:"
  }
  foreach (parse_email($config['email']['from']) as $from => $from_name)
  {
    $from = (empty($from_name) ? $from : '"'.$from_name.'" <'.$from.'>'); // From:
    break; // use only first entry
  }
  $option = "(\$config['email']['from'])";
  print_message("E-mails send from $option:\n  %g".$from."%n", 'color', FALSE);
  print_message("E-mails send to recipients based on default recipient from config and/or device sysContact.");
  if (is_numeric($options['h']))
  {
    $where = "`device_id` = ?";
    $params[] = $options['h'];
  } else {
    $where = "`hostname` LIKE ?";
    $params[] = str_replace('*','%', $options['h']);
  }

  $query = "SELECT * FROM `devices` WHERE $where";

  $currentuser = posix_getpwuid(posix_geteuid());

  $message = "这是一个Observium的测试通知, 请求于 '" . $currentuser['name'] . "' 运行在 '" . $localhost . "'.";

  foreach (dbFetchRows($query, $params) as $device)
  {
    // most parts copied from includes/alerting/email.inc.php
    if ($config['email']['default_only'])
    {
      // default only mail
      $email = $config['email']['default'];
    } else {
      // default device contact
      if (get_dev_attrib($device,'override_sysContact_bool'))
      {
        $email = get_dev_attrib($device,'override_sysContact_string');
      }
      else if (parse_email($device['sysContact']))
      {
        $email = $device['sysContact'];
      } else {
        $email = $config['email']['default'];
      }

      // lookup additional email addresses for first device random alert_id
      $alert_id = dbFetchCell('SELECT `alert_test_id` FROM `alert_table` WHERE `device_id` = ?', array($device['device_id']));
      $sql  = "SELECT `contact_descr`, `contact_endpoint` FROM `alert_contacts`";
      $sql .= " WHERE `contact_disabled` = 0 AND `contact_method` = 'email'";
      $sql .= " AND `contact_id` IN";
      $sql .= " (SELECT `alert_contact_id` FROM `alert_contacts_assoc` WHERE `alert_checker_id` = ?);";

      foreach (dbFetchRows($sql, array($alert_id)) as $entry)
      {
        $email .= "," . $entry['contact_descr'] . " <" . $entry['contact_endpoint'] . ">";
      }
    }
    $emails = parse_email($email);

    if ($emails)
    {
      $rcpts_full = array();
      foreach ($emails as $to => $to_name)
      {
        $rcpts_full[] = (empty($to_name) ? $to : '"'.trim($to_name).'" <'.$to.'>');
      }
      $rcpts_full = implode(', ', $rcpts_full);
      print_message("尝试发送测试通知 %W" . $device['hostname'] . "%n 到这些邮箱:\n  %g$rcpts_full%n", 'color', FALSE);

      // Create multipart (plain+html) message
      $template_html = '<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
  </head>
  <body>
    <tt>{{MESSAGE}}</tt><br />
  </body>
</html>';
      // Use template here just for testing
      $message_multipart = array('text' => simple_template('{{MESSAGE}}',  array('MESSAGE' => $message)),
                                 'html' => simple_template($template_html, array('MESSAGE' => $message)));
      $status = alert_notify($device, "TEST: [".$device['hostname']."]",  $message_multipart, $alert_id);
    } else {
      // no one recipient
      print_message("%r有一些收件人%n 为找到 %W" . $device['hostname'] . "%n.\n  所有设备上设置SNMP设备或默认收件人: \$config['email']['default']", 'color');
    }

    print_message("通知 ".$device['hostname'].($status ? ' %gSENT' : ' %rNOT sent')."%n.", 'color');
  }
} else {
  print_message("使用方法:
$scriptname -h device [-d debug]

SYNTAX:
-h <设备id> | <设备名称的通配符>  发送测试电子邮件管理员所述设备.
-d                                           Enable debug mode.

%r无效的参数!%n", 'color');
}

// EOF
