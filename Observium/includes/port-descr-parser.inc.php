<?php

// Very basic parser to parse classic Observium-type schemes.
// Parser should populate $port_ifAlias array with type, descr, circuit, speed and notes

function custom_port_parser($port)
{
  global $debug;

  if ($debug) { echo($port['ifAlias']); }

  list($type,$descr) = preg_split("/[\:\[\]\{\}\(\)]/", $port['ifAlias']);
  list(,$circuit) = preg_split("/[\{\}]/", $port['ifAlias']);
  list(,$notes) = preg_split("/[\(\)]/", $port['ifAlias']);
  list(,$speed) = preg_split("/[\[\]]/", $port['ifAlias']);
  $descr = trim($descr);

  $port_ifAlias = array();
  if ($type && $descr)
  {
    $type = strtolower($type);
    $port_ifAlias['type']  = $type;
    $port_ifAlias['descr'] = $descr;
    $port_ifAlias['circuit'] = $circuit;
    $port_ifAlias['speed'] = $speed;
    $port_ifAlias['notes'] = $notes;
  }

  if ($debug && count($port_ifAlias))
  {
    print_vars($port_ifAlias);
  }

  return $port_ifAlias;
}

// EOF
