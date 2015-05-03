<?php

/* * **************************************************************************
 *
 * HostBill-Cacti API file.
 * Copyright (c) 2012 - KBKP Software S.C. All Rights Reserved.
 *
 *  This software is furnished under a license and may be used and copied
 * only  in  accordance  with  the  terms  of such  license and with the
 * inclusion of the above copyright notice.  This software  or any other
 * copies thereof may not be provided or otherwise made available to any
 * other person.  No title to and  ownership of the  software is  hereby
 * transferred.
 *
 *                  HostBill IS NOT FREE SOFTWARE
 * ***************************************************************************
 *
 * This file is part of Cacti module for HostBill it should be placed in main
 * Cacti directory.
 *
 * ***************************************************************************
 */


/**
 * General Cacti functions and declarations:
 * @see lib/database.php for db functions
 */
include("include/global.php");


/**
 * Use predefined functions to work with RRD data, ie.
 * rrdtool_function_xport
 */
include_once($config["base_path"] . "/lib/rrd.php");
error_reporting(E_ERROR | E_PARSE);

class HB_CactiAPI {

    static $data_template = "Interface - Traffic";

    /**
     * Check if given hash credentials are ok
     * @param string $hash
     * @return boolean
     */
    public function verifyLogin($hash) {
        $hash = preg_replace("/[^a-zA-Z0-9]/", "", $hash);
        $id = db_fetch_cell("SELECT id FROM user_auth WHERE MD5(CONCAT(username,password)) = '" . $hash . "' LIMIT 1");
        if (!$id)
            return false;
        return true;
    }

    /**
     * List switches/devices defined with 'Interface - Traffic' data source.
     * If possible fetch corresponding ports for each switch
     * @return array
     */
    public function listSwitches() {

        $query = "
            SELECT DISTINCT h.id, h.description, h.hostname
            FROM host h
            JOIN data_local l ON (l.host_id=h.id)
            JOIN data_template t ON (t.id=l.data_template_id)
            WHERE
            t.name = '" . self::$data_template . "'";

        $switches = db_fetch_assoc($query);
        if (!$switches)
            return false;

        foreach ($switches as &$switch) {
            $switch['ports'] = $this->listPorts($switch['id']);
        }
        return $switches;
    }

    /**
     * List ports available for given host
     * Cacti cache SNMP walk results under host_snmp_cache, so we dont need to perform
     * walks again
     * @param integer $host_id
     * @return array ie.:
     * array('11'=>array('ifDescr'=>'Ethernet ...','ifName'=>'1/0/1'))
     */
    private function listPorts($host_id) {


        $poout = db_fetch_assoc("
          SELECT snmp_index, field_name, field_value FROM host_snmp_cache
          WHERE host_id= '" . $host_id . "' AND field_name IN ('ifDescr', 'ifName' )");

        if (!$poout)
            return array();

        $ports = array();
        //transpose rows to cols
        foreach ($poout as $v) {
            $ports[$v['snmp_index']][$v['field_name']] = $v['field_value'];
        }
        return $ports;
    }

    /**
     * Get interface graph image associated with switch/port
     * @param integer $switch in host table
     * @param integer $port snmp_id in graph table
     * @return integer|boolean
     */
    private function getGraphID($switch, $port) {
        $switch = intval($switch);
        $port = intval($port);
        $graph = self::$data_template;
        $query = "SELECT g.id FROM graph_local g JOIN graph_templates t ON (t.id=g.graph_template_id)
        WHERE g.host_id='{$switch}' AND g.snmp_index='{$port}'  AND t.name LIKE '{$graph}%' LIMIT 1";
        $gid = db_fetch_assoc($query);
        if (!$gid[0]['id'])
            return false;
        return $gid[0]['id'];
    }

    /**
     * Output interface utilisation graph for given switch & ports
     * @see function rrdtool_function_graph in lib/rrd.php
     * @param integer $switch
     * @param integer $port
     * @param array $data graph data, allowed keys:
     * from - plot graph from
     * to - plot graph to
     * rra_id - use instead of from/to - plot graph based on rra
     * @return png image
     */
    public function getGraphImage($switch, $port, $data=array()) {
        //1st determine graph that switch & port have one generated for
        $graph_data_array = array();
        if (!empty($data["from"]) && $data["from"] < 1600000000) {
            $graph_data_array["graph_start"] = $data["from"];
        }

        /* override: graph end time (unix time) */
        if (!empty($data["to"]) && $data["to"] < 1600000000) {
            $graph_data_array["graph_end"] = $data["to"];
        }

        $gid = $this->getGraphID($switch, $port);
        if (!$gid)
            return false;

        print rrdtool_function_graph($gid, (array_key_exists("rra_id", $data) ? $data["rra_id"] : null), $graph_data_array);
    }

    /**
     * Fetch RRDtool graph data for given switch/port
     * @param integer $switch Switch to look graph of. ID in host table
     * @param integer $port Port to look graph of. snmp_index in host_snmp_cache
     * @param string $from Date to collect data from (unix timestamp)
     * @param string $to  Date to collect data to (unix timestamp)
     * @return array Output from rrdtool_function_xport
     *
     * @throws Exception
     * @see lib/rrd.php
     */
    public function getGraphData($switch, $port, $from, $to) {
        //small sanitization

        $from = intval($from);
        $to = intval($to);

        $gid = $this->getGraphID($switch, $port);
        if (!$gid)
            return false;

        $xport_meta = array();
        //2nd use rrdtool_function_xport on this graph
        return rrdtool_function_xport($gid, null, array("graph_start" => $from, "graph_end" => $to), $xport_meta);
    }

  


}

class HB_CactiAPI_Response {

    private static $errors = array();
    private static $output = array();

    /**
     * Add error to be sent with output
     * @param <type> $error
     */
    public static function addError($error) {
        self::$errors[] = $error;
    }

    /**
     * We're expecting JSON headers/response
     * Sometimes image though.
     */
    private static function sendHeaders($type='json') {
        if ($type == 'json')
            header('Content-type: text/json; charset=UTF-8');
        else
            header("Content-type: image/png");
    }

    /**
     * Send output
     */
    private static function sendOutput() {
        if (!empty(self::$errors))
            self::$output['errors'] = self::$errors;

        die(json_encode(self::$output));
    }

    /**
     * Process incoming request
     * @param array $request
     */
    public static function processRequest($request) {

        $api = new HB_CactiAPI();

        //verify hash
        if (!isset($request['hash'])) {
            self::addError('Access hash is missing from request');
        } elseif (!$api->verifyLogin($request['hash'])) {
            self::addError('Login credentials provided are not valid');
        } else {
            switch ($request['cmd']) {
                case 'listswitches':
                    self::$output['switches'] = $api->listSwitches();
                    break;

                case 'getgraph':
                    self::sendHeaders('png');
                    $api->getGraphImage($request['switch'], $request['port'],array('from'=>isset($request['from']) ? $request['from'] : false,'to'=> isset($request['to']) ? $request['to'] : false));
                    exit;
                    break;

                case 'getgraphdata':
                   self::$output['data'] = $api->getGraphData($request['switch'], $request['port'], $request['from'],$request['to']);
                    break;

                case 'testconnection':
                    self::$output['success'] = true;
                    break;



                default:
                    self::addError('API function is missing/not supported');
                    break;
            }
        }

        self::sendHeaders();
        self::sendOutput();
    }

}

/**
 * Process request.
 * Sample usage:
 * GET http://cactiurl.com/hb_api.php?hash=ACCESSHASH&cmd=listswitches
 *
 * GET http://cactiurl.com/hb_api.php?hash=ACCESSHASH&cmd=deleteuser&username=USER
 */
HB_CactiAPI_Response::processRequest($_REQUEST);