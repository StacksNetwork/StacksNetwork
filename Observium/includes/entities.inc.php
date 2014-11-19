<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage functions
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

function get_entity_by_id_cache($type, $id)
{
  global $cache;

  if ($type !== 'port')
  {
    list($entity_table, $entity_id_field, $entity_name_field) = entity_type_translate($type);
  }

  if (is_array($cache[$type][$id]))
  {
    return $cache[$type][$id];
  } else {
    switch($type)
    {
      case "port":
        $entity = get_port_by_id($id);
        break;
      default:
        $entity = dbFetchRow("SELECT * FROM `".$entity_table."` WHERE `".$entity_id_field."` = ?", array($id));
        if (function_exists('humanize_'.$type)) { $do = 'humanize_'.$type; $do($entity); }
        break;
    }
    if (is_array($entity))
    {
      entity_rewrite($type, $entity);
      $cache[$type][$id] = $entity;
      return $entity;
    }
  }

  return FALSE;
}

function entity_type_translate($entity_type)
{
  $data = entity_type_translate_array($entity_type);
  return array($data['table'], $data['id_field'], $data['name_field'], $data['ignore_field']);
}

// Returns a text name from an entity type and an id
// A little inefficient.
function entity_name($type, $entity)
{
  global $config, $entity_cache;

  if (is_numeric($entity))
  {
    $entity = get_entity_by_id_cache($type, $entity);
  }

  $translate = entity_type_translate_array($type);

  $text = $entity[$translate['name_field']];

  return($text);
}

// Returns a text name from an entity type and an id
// A little inefficient.
function entity_short_name($type, $entity)
{
  global $config, $entity_cache;

  if (is_numeric($entity))
  {
    $entity = get_entity_by_id_cache($type, $entity);
  }

  $translate = entity_type_translate_array($type);

  $text = $entity[$translate['name_field']];

  return($text);
}

// Returns a text description from an entity type and an id
// A little inefficient.
function entity_descr($type, $entity)
{
  global $config, $entity_cache;

  if (is_numeric($entity))
  {
    $entity = get_entity_by_id_cache($type, $entity);
  }

  $translate = entity_type_translate_array($type);

  $text = $entity[$translate['entity_descr_field']];

  return($text);
}

/**
 * Translate an entity type to the relevant table and the identifier field name
 *
 * @param string entity_type
 * @return string entity_table
 * @return string entity_id
*/

function entity_type_translate_array($entity_type)
{
  global $config;

  foreach (array('id_field', 'name_field', 'info_field', 'table', 'ignore_field', 'disable_field', 'deleted_field', 'icon', 'graph') AS $field)
  {
    if (isset($config['entities'][$entity_type][$field]))
    {
      $data[$field] = $config['entities'][$entity_type][$field];
    }
    elseif(isset($config['entities']['default'][$field]))
    {
      $data[$field] = $config['entities']['default'][$field];
    }
  }

  return $data;
}

function entity_rewrite($type, &$entity)
{
  $translate = entity_type_translate_array($type);

  switch($type)
  {
    case "bgp_peer":
      if (Net_IPv6::checkIPv6($entity['bgpPeerRemoteAddr']))
      {
        $addr = Net_IPv6::compress($entity['bgpPeerRemoteAddr']);
      } else {
        $addr = $entity['bgpPeerRemoteAddr'];
      }

      $entity['entity_name']      = "AS".$entity['bgpPeerRemoteAs'] ." ". $addr;
      $entity['entity_shortname'] = $addr;

      $entity['entity_descr']     = $entity['astext'];
      break;
    default:
      // By default, fill $entity['entity_name'] with name_field contents.
      if (isset($translate['name_field'])) { $entity['entity_name'] = $entity[$translate['name_field']]; }

      // By default, fill $entity['entity_shortname'] with shortname_field contents. Fallback to entity_name when field name is not set.
      if (isset($translate['shortname_field'])) { $entity['entity_shortname'] = $entity[$translate['name_field']]; } else { $entity['entity_shortname'] = $entity['entity_name']; }

      // By default, fill $entity['entity_descr'] with descr_field contents.
      if (isset($translate['descr_field'])) { $entity['entity_descr'] = $entity[$translate['descr_field']]; }
      break;
  }
}

function generate_entity_link($type, $entity, $text=NULL, $graph_type=NULL)
{
  global $config, $entity_cache;

  if (is_numeric($entity))
  {
    $entity = get_entity_by_id_cache($type, $entity);
  }

  switch($type)
  {
    case "mempool":
      if (empty($text)) { $text = $entity['mempool_descr']; }
      $link = generate_link($text, array('page' => 'device', 'device' => $entity['device_id'], 'tab' => 'health', 'metric' => 'mempool'));
      break;
    case "processor":
      if (empty($text)) { $text = $entity['processor_descr']; }
      $link = generate_link($text, array('page' => 'device', 'device' => $entity['device_id'], 'tab' => 'health', 'metric' => 'processor'));
      break;
    case "sensor":
      if (empty($text)) { $text = $entity['sensor_descr']; }
      $link = generate_link($text, array('page' => 'device', 'device' => $entity['device_id'], 'tab' => 'health', 'metric' => $entity['sensor_class']));
      break;
    case "toner":
      if (empty($text)) { $text = $entity['toner_descr']; }
      $link = generate_link($text, array('page' => 'device', 'device' => $entity['device_id'], 'tab' => 'printing'));
      break;
    case "port":
      $link = generate_port_link($entity, $text, $graph_type);
      break;
    case "storage":
      if (empty($text)) { $text = $entity['storage_descr']; }
      $link = generate_link($text, array('page' => 'device', 'device' => $entity['device_id'], 'tab' => 'health', 'metric' => 'storage'));
      break;
    case "bgp_peer":
      if (Net_IPv6::checkIPv6($entity['bgpPeerRemoteAddr']))
      {
        $addr = Net_IPv6::compress($entity['bgpPeerRemoteAddr']);
      } else {
        $addr = $entity['bgpPeerRemoteAddr'];
      }
      if (empty($text)) { $text = $addr ." (AS".$entity['bgpPeerRemoteAs'] .")"; }
      $link = generate_link($text, array('page' => 'device', 'device' => $entity['device_id'], 'tab' => 'routing', 'proto' => 'bgp'));
      break;
    case "netscaler_vsvr":
      if (empty($text)) { $text = $entity['vsvr_label']; }
      $link = generate_link($text, array('page' => 'device', 'device' => $entity['device_id'], 'tab' => 'loadbalancer', 'type' => 'netscaler_vsvr', 'vsvr' => $entity['vsvr_id']));
      break;
    case "netscaler_svc":
      if (empty($text)) { $text = $entity['svc_label']; }
      $link = generate_link($text, array('page' => 'device', 'device' => $entity['device_id'], 'tab' => 'loadbalancer', 'type' => 'netscaler_services', 'svc' => $entity['svc_id']));
      break;

    default:
      $link = $entity[$type.'_id'];
  }
  return($link);
}

// EOF
