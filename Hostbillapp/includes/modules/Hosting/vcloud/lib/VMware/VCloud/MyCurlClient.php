<?php


/**
 * @see VMware_VCloud_SDK_Http_Client_Interface
 */
require_once 'VMware/VCloud/Http/IClient.php';

/**
 * Constants
 */
require_once 'VMware/VCloud/Constants.php';
require_once 'curl/curl.php';
require_once 'curl/curl_response.php';

class MyCurlClient implements VMware_VCloud_SDK_Http_Client_Interface {

    /**
     *
     * @var Curl
     */
    var $curl;
    
    /**
     * HTTP_Request2 configuration parameters
     * @see HTTP_Request2 $apiVersion variable
     */
    private $apiVersion = null;
    
    /**
     * Set the API Version
     *
     * @param array  $apiVersion  An API Version
     * @since SDK Version 5.1.1
     */
    public function setAPIVersion($apiVersion)
    {
        $this->apiVersion = $apiVersion;
    }

    public function __construct() {
        $this->curl = new Curl;
    }


    var $username;
    var $password;
    public function setAuth($auth) {

       $this->username=$auth['username'];
       $this->password= $auth['password'];

    }


    var $authToken = null;
    
     private function sendRequest($url, $method, $headers=null, $body=null)
    {
           $this->curl->headers=array();
           $this->curl->options=array();
      
           $this->curl->options['CURLOPT_SSL_VERIFYHOST']=false;
           $this->curl->options['CURLOPT_SSL_VERIFYPEER']=false;
           $this->curl->headers['Accept']=VMware_VCloud_SDK_Constants::VCLOUD_ACCEPT_HEADER .  ';' .   'version=' . $this->apiVersion;
            if ($this->authToken)
            {
                $this->curl->headers[VMware_VCloud_SDK_Constants::VCLOUD_AUTH_TOKEN]=$this->authToken;
            }
            else
            {
                $this->curl->options['CURLOPT_USERPWD']=$this->username . ':' .   $this->password;
              
            }
            if($headers) {
                $h = $this->curl->headers;
                $h = array_merge($h,$headers);
                $this->curl->headers = $h;
            }
               $response=  $this->curl->$method($url,$body);
                //  var_dump($url,$method,$this->curl,$body);
           
               if(!is_object($response) && $this->curl->error()) {
                  // var_dump($url,$method,$headers,$body,$this->curl);
                   throw new Exception ($this->curl->error());
               }

            if (!$this->authToken)
            {
                $this->authToken = $response->headers[VMware_VCloud_SDK_Constants::VCLOUD_AUTH_TOKEN];
            }
            return $response;

    }

    public function setConfig($config) {

        curl_setopt($this->ch, CURLOPT_RETURNTRANSFER, true);
    }

    public function get($url, $headers=null) {
        return $this->sendRequest($url,'get',$headers);
    }

    public function post($url, $headers, $data) {
        if(stripos($url, '/vdcs')!==false) {
            //hack
            $data=str_replace('<vmext:NetworkPoolReference','<NetworkPoolReference',$data);
            $headers['Content-Length']=$headers['Content-Length']-6;
        }
        return $this->sendRequest($url,'post',$headers,$data);
    }

    public function put($url, $headers, $data) {
        return $this->sendRequest($url,'put',$headers,$data);
    }

    public function delete($url) {
        return $this->sendRequest($url,'delete',$headers,$data);
    }

    public function download($url, $headers, $dest) {
        
    }

    public function upload($url, $headers, $file) {
        
    }

}