<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage billing
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

// DOCME needs phpdoc block
// TESTME needs unit testing
function format_bytes_billing($value)
{
  global $config;

  return format_number($value, $config['billing']['base'])."B";
}

// DOCME needs phpdoc block
// TESTME needs unit testing
function format_bytes_billing_short($value)
{
  global $config;

  return format_number($value, $config['billing']['base'], 2, 3);
}

// DOCME needs phpdoc block
// TESTME needs unit testing
function getDates($dayofmonth, $months=0)
{
  $dayofmonth = zeropad($dayofmonth);
  $year = date('Y');
  $month = date('m');

  if (date('d') >= $dayofmonth) // Billing day is past, so it is next month
  {
    $date_end   = date_create($year.'-'.$month.'-'.$dayofmonth);
    $date_start = date_create($year.'-'.$month.'-'.$dayofmonth);
    date_add($date_end,   date_interval_create_from_date_string('1 月'));
  } else { // Billing day will happen this month, therefore started last month
    $date_end   = date_create($year.'-'.$month.'-'.$dayofmonth);
    $date_start = date_create($year.'-'.$month.'-'.$dayofmonth);
    date_sub($date_start, date_interval_create_from_date_string('1 月'));
  }

  if ($months > 0)
  {
    date_sub($date_start, date_interval_create_from_date_string($months.' 月'));
    date_sub($date_end,   date_interval_create_from_date_string($months.' 月'));
  }

#  date_sub($date_start, date_interval_create_from_date_string('1 月'));
  date_sub($date_end, date_interval_create_from_date_string('1 天'));

  $date_from = date_format($date_start, 'Ymd') . "000000";
  $date_to   = date_format($date_end, 'Ymd') . "235959";

  date_sub($date_start, date_interval_create_from_date_string('1 月'));
  date_sub($date_end, date_interval_create_from_date_string('1 月'));

  $last_from = date_format($date_start, 'Ymd') . "000000";
  $last_to   = date_format($date_end, 'Ymd') . "235959";

  $return['0'] = $date_from;
  $return['1'] = $date_to;
  $return['2'] = $last_from;
  $return['3'] = $last_to;

  return($return);
}

// DOCME needs phpdoc block
// TESTME needs unit testing
function getValues($port)
{
  global $config, $device;

  if ($device['snmp_version'] == "1") {
    $oids = "IF-MIB::ifInOctets.".$port['ifIndex']." IF-MIB::ifOutOctets.".$port['ifIndex'];
  } else {
    $oids = "IF-MIB::ifHCInOctets.".$port['ifIndex']." IF-MIB::ifHCOutOctets.".$port['ifIndex'];
  }

  $data = snmp_get_multi($port, $oids, "-OQUs", "IF-MIB");
  $data = $data[$port['ifIndex']];

  if (is_numeric($data['ifHCInOctets']) && is_numeric($data['ifHCOutOctets']))
  {
    return array('in' => $data['ifHCInOctets'], 'out' => $data['ifHCOutOctets']);
  }
  elseif (is_numeric($data['ifInOctets']) && is_numeric($data['ifOutOctets']))
  {
    return array('in' => $data['ifInOctets'], 'out' => $data['ifOutOctets']);
  } else {
    return FALSE;
  }
}

// DOCME needs phpdoc block
// TESTME needs unit testing
function getLastPortCounter($port_id,$inout)
{
  $row = dbFetchRow("SELECT counter,delta FROM `bill_port_".$inout."_data` WHERE `port_id` = ? ORDER BY timestamp DESC LIMIT 0,1", array($port_id));
  if (is_numeric($row['delta']))
  {
    $return['counter'] = $row['counter'];
    $return['delta'] = $row['delta'];
    $return['state'] = "ok";
  } else {
    $return['state'] = "failed";
  }
  return($return);
}

// DOCME needs phpdoc block
// TESTME needs unit testing
function getLastMeasurement($bill_id)
{
  $row = dbFetchRow("SELECT timestamp,delta,in_delta,out_delta FROM bill_data WHERE bill_id = ? ORDER BY timestamp DESC LIMIT 0,1", array($bill_id));

  print_vars($row);

  if (is_numeric($row['delta']))
  {
    $return['delta']     = $row['delta'];
    $return['delta_in']  = $row['delta_in'];
    $return['delta_out'] = $row['delta_out'];
    $return['timestamp'] = $row['timestamp'];
    $return['state'] = "ok";
  } else {
    $return['state'] = "failed";
  }

  return($return);
}

// DOCME needs phpdoc block
// TESTME needs unit testing
function get95thin($bill_id,$datefrom,$dateto)
{
  $mq_sql = "SELECT count(delta) FROM bill_data WHERE bill_id = ?";
  $mq_sql .= " AND timestamp > ? AND timestamp <= ?";
  $measurements = dbFetchCell($mq_sql, array($bill_id, $datefrom, $dateto));
  $measurement_95th = round($measurements /100 * 95) - 1;

  $q_95_sql = "SELECT (in_delta / period * 8) AS rate FROM bill_data  WHERE bill_id = ?";
  $q_95_sql .= " AND timestamp > ? AND timestamp <= ? ORDER BY rate ASC";
  $a_95th = dbFetchColumn($q_95_sql, array($bill_id, $datefrom, $dateto));
  $m_95th = $a_95th[$measurement_95th];

  return(round($m_95th, 2));
}

// DOCME needs phpdoc block
// TESTME needs unit testing
function get95thout($bill_id,$datefrom,$dateto)
{
  $mq_sql = "SELECT count(delta) FROM bill_data WHERE bill_id = ?";
  $mq_sql .= " AND timestamp > ? AND timestamp <= ?";
  $measurements = dbFetchCell($mq_sql, array($bill_id, $datefrom, $dateto));
  $measurement_95th = round($measurements /100 * 95) - 1;

  $q_95_sql = "SELECT (out_delta / period * 8) AS rate FROM bill_data  WHERE bill_id = ?";
  $q_95_sql .= " AND timestamp > ? AND timestamp <= ? ORDER BY rate ASC";

  $a_95th = dbFetchColumn($q_95_sql, array($bill_id, $datefrom, $dateto));
  $m_95th = $a_95th[$measurement_95th];

  return(round($m_95th, 2));
}

// DOCME needs phpdoc block
// TESTME needs unit testing
function getRates($bill_id,$datefrom,$dateto)
{
  $mq_sql = "SELECT count(delta) FROM bill_data ";
  $mq_sql .= " WHERE bill_id = ?";
  $mq_sql .= " AND timestamp > ? AND timestamp <= ?";
  $measurements = dbFetchCell($mq_sql, array($bill_id, $datefrom, $dateto));
  $measurement_95th = round($measurements /100 * 95) - 1;

  $q_95_sql = "SELECT delta FROM bill_data  WHERE bill_id = ?";
  $q_95_sql .= " AND timestamp > ? AND timestamp <= ? ORDER BY delta ASC";

  $a_95th = dbFetchColumn($q_95_sql, array($bill_id, $datefrom, $dateto));
  $m_95th = $a_95th[$measurement_95th];

  $sum_data = getSum($bill_id,$datefrom,$dateto);
  $mtot = $sum_data['total'];
  $mtot_in = $sum_data['inbound'];
  $mtot_out = $sum_data['outbound'];
  $ptot = $sum_data['period'];

  $data['rate_95th_in'] = get95thIn($bill_id,$datefrom,$dateto);
  $data['rate_95th_out'] = get95thOut($bill_id,$datefrom,$dateto);

  if ($data['rate_95th_out'] > $data['rate_95th_in'])
  {
    $data['rate_95th'] = $data['rate_95th_out'];
    $data['dir_95th'] = 'out';
  } else {
    $data['rate_95th'] = $data['rate_95th_in'];
    $data['dir_95th'] = 'in';
  }

  $data['total_data']      = $mtot;
  $data['total_data_in']   = $mtot_in;
  $data['total_data_out']  = $mtot_out;
  $data['rate_average']    = $mtot / $ptot * 8;
  $data['rate_average_in']   = $mtot_in / $ptot * 8;
  $data['rate_average_out']  = $mtot_in / $ptot * 8;

#  print_vars($data);

  return($data);
}

// DOCME needs phpdoc block
// TESTME needs unit testing
function getTotal($bill_id,$datefrom,$dateto)
{
  $mtot = dbFetchCell("SELECT SUM(delta) FROM bill_data WHERE bill_id = ? AND timestamp > ? AND timestamp <= ?", array($bill_id, $datefrom, $dateto));
  return($mtot);
}

// DOCME needs phpdoc block
// TESTME needs unit testing
function getSum($bill_id,$datefrom,$dateto)
{
  $sum = dbFetchRow("SELECT SUM(period) as period, SUM(delta) as total, SUM(in_delta) as inbound, SUM(out_delta) as outbound FROM bill_data WHERE bill_id = ? AND timestamp > ? AND timestamp <= ?", array($bill_id, $datefrom, $dateto));
  return($sum);
}

// DOCME needs phpdoc block
// TESTME needs unit testing
function getPeriod($bill_id,$datefrom,$dateto)
{
  $ptot = dbFetchCell("SELECT SUM(period) FROM bill_data WHERE bill_id = ? AND timestamp > ? AND timestamp <= ?", array($bill_id, $datefrom, $dateto));
  return($ptot);
}

// EOF
