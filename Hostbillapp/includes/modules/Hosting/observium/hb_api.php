<?php

/* * **************************************************************************
 *
 * HostBill-Observium API file.
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
 * This file is part of Observium module for HostBill it should be placed in main
 * Observium html directory (accessible from web).
 *
 * ***************************************************************************
 */

//error_reporting(E_ALL);
//ini_set('display_errors', 1);

/**
 * General Observium functions and declarations:
 * Tested on: Observium CE 0.14.8.5766
 */
include_once("../includes/defaults.inc.php");
include_once("../config.php");
include_once("../includes/definitions.inc.php");
include_once("../includes/common.inc.php");
include_once("../includes/dbFacile.php");

//include("includes/graphs/graph.inc.php");


function hb_get_image($port_id, $from=false, $to=false, $width=1075, $height=300) {
    //declare vars, required are from, to, id
    global $config, $rrd_cmd, $rrd_options;
    $vars = array(
        'from' => $from,
        'to' => $to,
        'id' => $port_id,
        'height' => $height ? $height : 300,
        'width' => $width ? $width : 1075,
        'type' => 'port_bits'
    );
    foreach ($vars as $k => $v) {
        $_GET[$k] = $v;
    }

    $ds_in = "INOCTETS";
    $ds_out = "OUTOCTETS";
    $from = (isset($vars['from']) && $vars['from'] ? $vars['from'] : time() - 60 * 60 * 24);
    $to = (isset($vars['to']) && $vars['to'] ? $vars['to'] : time());

    if ($from < 0) {
        $from = $to + $from;
    }

    $period = $to - $from;

    $prev_from = $from - $period;
    $rrd_options = "";
    $auth = "1";
    unset($config['allow_unauth_graphs_cidr']);
    
    include($config['install_dir'] . "/includes/rewrites.inc.php");
    include($config['install_dir'] . "/includes/rrdtool.inc.php");
    include($config['install_dir'] . "/includes/entities.inc.php");
    include($config['html_dir'] . "/includes/functions.inc.php");
    
    include($config['install_dir'] . "/html/includes/graphs/graph.inc.php");
    include($config['install_dir'] . "/html/includes/graphs/port/auth.inc.php");
    include($config['install_dir'] . "/html/includes/graphs/generic_data.inc.php");

    //get_device_id_by_port_id($port_id) in /includes/common.php
}

function hb_get_data($port_id, $from=false, $to=false) {
     global $config, $rrd_cmd, $rrd_options, $debug;
     $debug = TRUE;
     ob_start();
    $vars = array(
        'from' => $from,
        'to' => $to,
        'id' => $port_id,
        'height' => 300,
        'width' =>  1075,
        'type' => 'port_bits'
    );
    foreach ($vars as $k => $v) {
        $_GET[$k] = $v;
    }

    $ds_in = "INOCTETS";
    $ds_out = "OUTOCTETS";
    $from = (isset($vars['from']) && $vars['from'] ? $vars['from'] : time() - 60 * 60 * 24);
    $to = (isset($vars['to']) && $vars['to'] ? $vars['to'] : time());

    if ($from < 0) {
        $from = $to + $from;
    }
    $period = $to - $from;
    $prev_from = $from - $period;
    $rrd_options = "";
    $auth = "1";
    $graphfile = $config['temp_dir'] . "/"  . strgen() . ".png";
    
    include($config['install_dir'] . "/includes/rewrites.inc.php");
    include($config['install_dir'] . "/includes/rrdtool.inc.php");
    include($config['install_dir'] . "/includes/entities.inc.php");
    include($config['html_dir'] . "/includes/functions.inc.php");
    
    include($config['install_dir'] . "/html/includes/graphs/port/auth.inc.php");
    include($config['install_dir'] . "/html/includes/graphs/port/bits.inc.php");
    include($config['install_dir'] . "/html/includes/graphs/generic_data.inc.php");
    ob_get_clean();

   ob_start();
   $rrd_options= str_ireplace('--alt-autoscale','',$rrd_options);

   $tmp_arr = explode(" ",trim($rrd_options));
   $tmp = array_pop($tmp_arr);
   if(substr_count($rrd_options,$tmp)>1) {
     //possible repetition.
    $rrd_options = substr($rrd_options, 0, strpos($rrd_options,$tmp)+strlen($tmp));
   }

   $xml=rrdtool_graph_xport($rrd_options);
   $ret = ob_get_clean();

   if(stripos($ret, '</xport>')==false)
           return false;
   $ret = substr($ret, stripos($ret,'<xport>'));
   $ret = substr($ret, 0,stripos($ret,'</xport>')).'</xport>';

   $xml = json_decode(json_encode((array) simplexml_load_string($ret)), 1);
   return $xml;
}

function rrdtool_graph_xport($options) {
    global $config;
    $debug=1;
    header('Content-type: text/html');

    if(substr_count($options,'--alt-autoscale-max')>1) {
        $options = substr($options,  strripos($options, '--alt-autoscale-max'));
    }

    $options = str_replace(array(
        '--alt-autoscale-max ',
        '--rigid ',
        '-E'
    ), '', $options);

    $options = preg_replace(array(
        '/--(width|height)\s[\d]+/',
        '/-c\s[^\s]+/',
        '/--font\s[^\s]+/',
        '/--font-render-mode\s[^\s]+/',
        '/-R\s[^\s]+/'
    ), '', $options);
    $xport ="";
    if(preg_match_all("/(?<=\s)DEF:[\s]?([a-zA-Z]+)(?==)/", $options, $matches)) {
        $def = $matches[1];
        foreach($def as $d) {
            $xport.= "XPORT:" . $d . ":" . "\"" . str_replace(":", "", $d) . "\" ";
        }
    }
    rrdtool_pipe_open($rrd_process, $rrd_pipes);

    if (is_resource($rrd_process)) {
        // $pipes now looks like this:
        // 0 => writeable handle connected to child stdin
        // 1 => readable handle connected to child stdout
        // Any error output will be appended to /tmp/error-output.txt


        fwrite($rrd_pipes[0], "xport $graph_file $options $xport");


        fclose($rrd_pipes[0]);

        while (strlen($line) < 1) {
            // wait for 10 milliseconds to loosen loop
            usleep(10000);
            $line = fgets($rrd_pipes[1], 1024);
            $data .= $line;
        }

        $return_value = rrdtool_pipe_close($rrd_process, $rrd_pipes);

        
        return $data;
    } else {
        return 0;
    }
}

class HB_ObserviumAPI {


    /**
     * Check if given hash credentials are ok
     * @param string $hash
     * @return boolean
     */
    public function verifyLogin($hash) {
        $hash = preg_replace("/[^a-zA-Z0-9_]/", "", $hash);
        $hash = explode('_',$hash,2);
        $id = dbFetchRow("SELECT password,user_id FROM users WHERE MD5(MD5(`username`)) = '" . $hash[0] . "' LIMIT 1");
        if (!$id)
            return false;
         if ($id['password'] == crypt(base64_decode($hash[1]),$id['password']))
            {
              return true;
            }
        return true;
    }

    /**
     * List switches/devices defined with 'Interface - Traffic' data source.
     * If possible fetch corresponding ports for each switch
     * @return array
     */
    public function listSwitches() {

        $query = "SELECT device_id, hostname FROM devices";

        $switches = dbFetchRows($query);
        if (!$switches)
            return false;

        foreach ($switches as &$switch) {
            $switch['ports'] = $this->listPorts($switch['device_id']);
        }
        return $switches;
    }

    /**
     * List ports available for given device
     * @param integer $host_id Device ID in Observium
     * @return array ie.:
     * array('11'=>array('ifDescr'=>'Ethernet ...','ifName'=>'1/0/1'))
     */
    private function listPorts($host_id) {


        $poout = dbFetchRows("SELECT port_id, ifDescr, ifName FROM ports WHERE device_id='{$host_id}' ");

        if (!$poout)
            return array();

        $ports = array();
        //transpose rows to cols
        foreach ($poout as $v) {
            $ports[$v['port_id']] = $v['ifDescr'];
        }
        return $ports;
    }

    /**
     * Output interface utilisation graph for given switch & ports
     * @see function rrdtool_function_graph in lib/rrd.php
     * @param integer $switch
     * @param integer $port
     * @param array $data graph data, allowed keys:
     * from - plot graph from
     * to - plot graph to
     * width - graph width
     * heigth - graph heigth
     * @return png image
     */
    public function getGraphImage($switch, $port, $data=array()) {
        hb_get_image($port, $data['from'], $data['to'], $data['width'], $data['height']);
    }

    /**
     * Fetch RRDtool graph data for given switch/port
     * @param integer $switch Switch to look graph of. ID in host table
     * @param integer $port Port to look graph of. snmp_index in host_snmp_cache
     * @param string $from Date to collect data from (unix timestamp)
     * @param string $to  Date to collect data to (unix timestamp)
     * @return array Output from rrdtool_function_xport
     *
     */
    public function getGraphData($switch, $port, $from, $to) {
        //small sanitization
        $from = intval($from);
        $to = intval($to);


        //2nd use rrdtool_function_xport on this graph
        return hb_get_data($port, $from, $to);
    }

}

class HB_ObserviumAPI_Response {

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

        $api = new HB_ObserviumAPI();

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
                    $api->getGraphImage($request['switch'], $request['port'], array('from' => $request['from'], 'to' => $request['to'], 'width' => $request['width'], 'height' => $request['height']));
                    exit;
                    break;

                case 'getgraphdata':
                    self::$output['data'] = $api->getGraphData($request['switch'], $request['port'], $request['from'], $request['to']);
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

HB_ObserviumAPI_Response::processRequest($_REQUEST);