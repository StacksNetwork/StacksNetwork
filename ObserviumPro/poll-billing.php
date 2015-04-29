#!/usr/bin/env php
<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage billing
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2015 Adam Armstrong
 *
 */

chdir(dirname($argv[0]));

include_once("includes/defaults.inc.php");
include_once("config.php");
// FIXME - implement cli switches, debugging, etc.
$options = getopt("b:dn");

include_once("includes/definitions.inc.php");
include("includes/functions.inc.php");

$params = array();

$iter = "0";

echo("启动轮询会话 ... \n\n");

if ($options['b'])
{
  $params = array();
  if (is_numeric($options['b']))
  {
    $where = "AND `bill_id` = ?";
    $doing = $options['b'];
    $params[] = $options['b'];
  }
}

if (!isset($query))
{
  $query = "SELECT * FROM `bills` WHERE TRUE $where ORDER BY `bill_id` ASC";
}

foreach (dbFetchRows($query, $params) as $bill)
{
  echo("Bill : ".$bill['bill_name']."\n");
  # replace old bill_gb with bill_quota (we're now storing bytes, not gigabytes)
  if ($bill['bill_type'] == "quota" && !is_numeric($bill['bill_quota']))
  {
    $bill['bill_quota'] = $bill['bill_gb'] * $config['billing']['base'] * $config['billing']['base'];
    dbUpdate(array('bill_quota' => $bill['bill_quota']), 'bills', '`bill_id` = ?', array($bill['bill_id']));
    echo("Quota -> ".$bill['bill_quota']);
  }
  poll_bill($bill);
  $iter++;
}

function poll_bill($bill)
{
  global $options;

  $ports = dbFetchRows("SELECT * FROM `bill_ports` as P, `ports` as I, `devices` as D WHERE P.bill_id=? AND I.port_id = P.port_id AND D.device_id = I.device_id", array($bill['bill_id']));
  if (OBS_DEBUG) { print_vars($ports); }
  foreach ($ports as $port)
  {
    echo("\nPolling ".$port['ifDescr']." on ".$port['hostname']."\n");
    $now = time();
    if (is_numeric($port['bill_port_polled'])) { $period = $now - $port['bill_port_polled']; }
    echo("time: ".$now."|".$port['bill_port_polled']." period:".$period."\n");

    if ($port['snmp_version'] == "1" || $port['port_64bit'] == "0") {
      // SNMPv1 - Use non 64-bit counters
      $oids = "IF-MIB::ifInOctets.".$port['ifIndex']." IF-MIB::ifOutOctets.".$port['ifIndex'];
      $data = snmp_get_multi($port, $oids, "-OQUs", "IF-MIB");
      $data = $data[$port['ifIndex']];
      $data = array('in' => $data['ifInOctets'], 'out' => $data['ifOutOctets']);
    } else {
      // Not SNMPv1 - Use 64-bit counters
      $oids = "IF-MIB::ifHCInOctets.".$port['ifIndex']." IF-MIB::ifHCOutOctets.".$port['ifIndex'];
      $data = snmp_get_multi($port, $oids, "-OQUs", "IF-MIB");
      $data = $data[$port['ifIndex']];
      $data = array('in' => $data['ifHCInOctets'], 'out' => $data['ifHCOutOctets']);

      // Fallback on 32-bit counters if 64-bit fails
      // This is disabled because the only possible outcome is retarded data.
      // if (empty($data['in']) && empty($data['out'])) {
      //  $oids = "IF-MIB::ifInOctets.".$port['ifIndex']." IF-MIB::ifOutOctets.".$port['ifIndex'];
      //  $data = snmp_get_multi($port, $oids, "-OQUs", "IF-MIB");
      //  $data = $data[$port['ifIndex']];
      //  $data = array('in' => $data['ifInOctets'], 'out' => $data['ifOutOctets']);
      // }

      if (OBS_DEBUG > 1) { print_vars($data); }
    }

    if (is_numeric($data['in']) && is_numeric($data['out']))
    {
      echo($period ."|".$port['bill_port_counter_in']."|".$port['bill_port_counter_out']."|".$data['in']."|".$port['bill_port_counter_in']."\n");
      // The port returned counters
      if (is_numeric($period) && is_numeric($port['bill_port_counter_in']) && is_numeric($port['bill_port_counter_out']) && $data['in'] >= $port['bill_port_counter_in'] && $data['out'] >= $port['bill_port_counter_out'])
      {
        // Counters are higher or equal to before, seems legit.
        $in_delta  = $data['in']  - $port['bill_port_counter_in'];
        $out_delta = $data['out'] - $port['bill_port_counter_out'];
        echo("计数器有效, 等边三角形.\n");
      } elseif (is_numeric($period) && is_numeric($port['bill_port_counter_in']) && is_numeric($port['bill_port_counter_out'])) {
        // Counters are lower, we must have wrapped. We'll take the measurement as the amount for this period.
        $in_delta  = $data['in'];
        $out_delta = $data['out'];
        echo("计数器处于, 非等边三角形中.\n");
      } else {
        // First update. delta is zero, only insert counters.
        echo("没有现成的计数器.\n");
        $in_delta  = 0;
        $out_delta = 0;
      }

      if ($in_delta == $data['in'] || $in_delta == $data['in'])
      {
        // Deltas are equal to counters. Clearly fail.
        echo("等边三角形计数器. 重启.");
        $in_delta  = 0;
        $out_delta = 0;
      }

      $update = array('bill_port_polled' => $now, 'bill_port_period' => $period,
                      'bill_port_counter_in' => $data['in'], 'bill_port_counter_out' => $data['out'],
                      'bill_port_delta_in' => $in_delta, 'bill_port_delta_out' => $out_delta,
                      );
      if (!isset($options['n'])) { // We haven't been told not to update the database
        dbUpdate($update, 'bill_ports', '`bill_id` = ? AND `port_id` = ?', array($port['bill_id'], $port['port_id']));
      } else {
        echo ("Would have Updated: \n");
        print_r($update);
      }

      echo("数据:  in(N:".$data['in']."|P:".$port['bill_port_counter_in'].") delta:".$in_delta."\n");
      echo("      out(N:".$data['out']."|P:".$port['bill_port_counter_out'].") delta:".$out_delta."\n");

      $bill_delta     += $in_delta + $out_delta;
      $bill_in_delta  += $in_delta;
      $bill_out_delta += $out_delta;

      echo("deltas: i:".$bill_in_delta." o:".$bill_out_delta." t:".$bill_delta."\n");

    } else {
      // No counters were returned
      // We don't need to update the database.
      echo("无数据.\n");
    }

    // Don't insert per-port stats, as it's not really all that useful and has been broken for a long long time.
#    dbInsert(array('port_id' => $port['port_id'], 'timestamp' => $now, 'counter' => $data['in'], 'delta' => $in_delta), 'bill_port_in_data');
#    dbInsert(array('port_id' => $port['port_id'], 'timestamp' => $now, 'counter' => $data['out'], 'delta' => $out_delta), 'bill_port_out_data');

  }

  echo("账单处理中...\n");
  $now = time();
  if (is_numeric($bill['bill_polled'])) { $period = $now - $bill['bill_polled']; }
  echo("time: ".$now."|".$bill['bill_polled']." period:".$period."\n\n\n");

  if ($period <= '0')
  {
    $bill_delta = '0';
    $bill_in_delta = '0';
    $bill_out_delta = '0';
  }
  if (!isset($options['n'])) { // We haven't been told not to update the database
    dbUpdate(array('bill_polled' => $now), 'bills', '`bill_id` = ?', array($port['bill_id']));
  }

  if ($period < "0" || !is_numeric($period)) {
    logfile("BILLING: negative period! id:".$bill['bill_id']." period:$period delta:$bill_delta in_delta:$bill_in_delta out_delta:$bill_out_delta");
  } else {
    if (!isset($options['n'])) { // We haven't been told not to update the database
      dbInsert(array('bill_id' => $bill['bill_id'], 'timestamp' => array("NOW()"), 'period' => $period, 'delta' => $bill_delta, 'in_delta' => $bill_in_delta, 'out_delta' => $bill_out_delta), 'bill_data');
    } else {
      echo("Would have inserted: \n");
      print_r(array('bill_id' => $bill['bill_id'], 'timestamp' => array("NOW()"), 'period' => $period, 'delta' => $bill_delta, 'in_delta' => $bill_in_delta, 'out_delta' => $bill_out_delta));
    }
  }
}

if ($argv[1]) { poll_bill($argv[1]); }

// EOF
