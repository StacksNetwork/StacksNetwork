<?php

switch ($vars['sort'])
{
  case 'traffic':
    $select .= ',`ifOctets_rate`';
    break;
  case 'traffic_in':
    $select .= ',`ifInOctets_rate`';
    break;
  case 'traffic_out':
    $select .= ',`ifOutOctets_rate`';
    break;
  case 'traffic_perc_in':
    $select .= ',`ifInOctets_perc`';
    break;
  case 'traffic_perc_out':
    $select .= ',`ifOutOctets_perc`';
    break;
  case 'traffic_perc':
    $select .= ', `ifOutOctets_perc`+`ifInOctets_perc` AS `ifOctets_perc`';
    break;
  case 'packets':
    $select .= ',`ifUcastPkts_rate`';
    break;
  case 'packets_in':
    $select .= ',`ifInUcastOctets_rate`';
    break;
  case 'packets_out':
    $select .= ',`ifOutUcastOctets_rate`';
    break;
  case 'errors':
    $select .= ',`ifErrors_rate`';
    break;
  case 'speed':
    $select .= ',`ifSpeed`';
    break;
  case 'port':
    $select .= ',`ifDescr`';
    break;
  case 'media':
    $select .= ',`ifType`';
    break;
  case 'descr':
    $select .= ',`ifAlias`';
    break;
  case 'mac':
    $select .= ',`ifPhysAddress`';
    break;
  case 'device':
    $select .= ',`devices`.`hostname`';
    break;
  default:
    $select .= ',`ifIndex`';
}

?>
