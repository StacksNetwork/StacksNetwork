<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage webui
 * @copyright  (C) 2006-2015 Adam Armstrong
 *
 */

echo("EMAILING");

// Find local hostname
$localhost = get_localhost();

// -this is legacy code-, but i'll leave it here to not break existing
// installations (is it really?)
// yes, really. I use default_only! --mike
// it's very usefull for small system or temporary send all alerts to one mail address.
if (!isset($cache['emails'][$alert_id]))
{
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

    // lookup additional email addresses that need a notification
    $sql = "SELECT `contact_descr`, `contact_endpoint` FROM `alert_contacts`";
    $sql .= " WHERE `contact_disabled` = 0 AND `contact_method` = 'email'";
    $sql .= " AND `contact_id` IN";
    $sql .= " (SELECT `alert_contact_id` FROM `alert_contacts_assoc` WHERE `alert_checker_id` = ?);";

    foreach (dbFetchRows($sql, array($alert_id)) as $entry)
    {
      $email .= "," . $entry['contact_descr'] . " <" . $entry['contact_endpoint'] . ">";
    }
  }

  $cache['emails'][$alert_id] = parse_email($email);
}
$emails = $cache['emails'][$alert_id];
// end get email contacts

if ($emails)
{
  if (OBS_DEBUG) { print_r($emails); }

  // Mail backend params
  $backend = strtolower(trim($config['email']['backend']));
  switch ($backend)
  {
    case 'sendmail':
      $params['sendmail_path'] = $config['email']['sendmail_path'];
      break;
    case 'smtp':
      $params['host']      = $config['email']['smtp_host'];
      $params['port']      = $config['email']['smtp_port'];
      if ($config['email']['smtp_secure'] == 'ssl')
      {
        $params['host']    = 'ssl://'.$config['email']['smtp_host'];
        if ($config['email']['smtp_port'] == 25)
        {
          $params['port']  = 465; // Default port for SSL
        }
      }
      $params['timeout']   = $config['email']['smtp_timeout'];
      $params['auth']      = $config['email']['smtp_auth'];
      $params['username']  = $config['email']['smtp_username'];
      $params['password']  = $config['email']['smtp_password'];
      $params['localhost'] = $localhost;
      if (OBS_DEBUG) { $params['debug'] = TRUE; }
      break;
    case 'mail':
    default:
      $backend = 'mail'; // Default mailer backend
  }

  // Time sent RFC 2822
  $time_rfc = date('r', time());

  // Mail headers
  $headers = array();
  if (empty($config['email']['from']))
  {
    $config['email']['from'] = 'Observium <observium@'.$localhost.'>'; // Default "From:"
  }
  foreach (parse_email($config['email']['from']) as $from => $from_name)
  {
    $headers['From'] = (empty($from_name) ? $from : '"'.$from_name.'" <'.$from.'>'); // From:
    $headers['Return-Path'] = $from;
    break; // use only first entry
  }
  $rcpts = $rcpts_full = array();
  foreach ($emails as $to => $to_name)
  {
    $rcpts_full[] = (empty($to_name) ? $to : '"'.trim($to_name).'" <'.$to.'>');
    $rcpts[]      = $to;
  }
  $rcpts_full = implode(', ', $rcpts_full);
  $rcpts      = implode(', ', $rcpts);
  $headers['To']           = $rcpts_full;   // To:
  $headers['Subject']      = $title;        // Subject:
  $headers['X-Priority']   = 3;             // Mail priority
  $headers['X-Mailer']     = OBSERVIUM_PRODUCT.' '.OBSERVIUM_VERSION; // X-Mailer:
  $headers['Message-ID']   = '<' . md5(uniqid(time())) . '@' . $localhost . '>';
  $headers['Date']         = $time_rfc;

  // Mail body
  if (!is_array($message))
  {
    // Convert old style plain or html message body to array for use with MIME parts
    $old_message = $message;
    $message = array();
    if (stripos($old_message, '<body') !== FALSE)
    {
      $message['html'] = $old_message;
    } else {
      $message['text'] = $old_message;
    }
  }
  //$time_sent = date($config['timestamp_format']);
  $time_sent = $time_rfc;
  // Creating the Mime message
  $mime = new Mail_mime(array('head_charset' => 'utf-8',
                              'text_charset' => 'utf-8',
                              'html_charset' => 'utf-8',
                              'eol' => PHP_EOL));
  foreach ($message as $part => $part_body)
  {
    switch ($part)
    {
      case 'text':
      case 'txt':
      case 'plain':
        $part_body .= "\n\nE-mail 发送给: $rcpts\n";
        $part_body .= "E-mail 发送时间: $time_sent\n\n";
        $part_body .= "-- \n".OBSERVIUM_PRODUCT_LONG.' '.OBSERVIUM_VERSION. "\nhttp://observium.org/\n";
        $mime->setTXTBody($part_body);
        break;
      case 'html':
        $part_footer = "\n<br /><p style=\"font-size: 11px;\">E-mail 发送给: $rcpts<br />\n";
        $part_footer .= "E-mail 发送时间: $time_sent</p>\n";
        $part_footer .= '<div style="font-size: 11px; color: #999;">-- <br /><a href="'.OBSERVIUM_URL.'">'.OBSERVIUM_PRODUCT_LONG.' '.OBSERVIUM_VERSION."</a></div>\n";
        if (stripos($part_body, '</body>'))
        {
          $part_body = str_ireplace('</body>', $part_footer.'</body>', $part_body);
        } else {
          $part_body .= $part_footer;
        }
        $mime->setHTMLBody($part_body);
        break;
      //case 'image':
      //  break;
      //case 'attachment':
      //  break;
    }
  }
  $body = $mime->get();

  // prepare headers
  foreach ($headers as $name => $value)
  {
    $headers[$name] = $mime->encodeHeader($name, $value, 'utf-8', 'quoted-printable');
  }
  $headers = $mime->headers($headers);
  //var_dump($headers);

  // Create mailer instance
  $mail =& Mail::factory($backend, $params);
  // Sending email
  $status = $mail->send($rcpts, $headers, $body);

  if (PEAR::isError($status))
  {
    print_message('%r邮箱系统错误%n: ' . $status->getMessage(), 'color');
  } else {
    $notify_status = TRUE;
  }
}

// EOF
