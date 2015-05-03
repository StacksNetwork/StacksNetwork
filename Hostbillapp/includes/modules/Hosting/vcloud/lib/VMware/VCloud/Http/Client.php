<?php
/**
 * VMware vCloud SDK for PHP
 *
 * PHP version 5
 * *******************************************************
 * Copyright VMware, Inc. 2010-2013. All Rights Reserved.
 * *******************************************************
 *
 * @category    VMware
 * @package     VMware_VCloud_SDK
 * @subpackage  Samples
 * @author      Ecosystem Engineering
 * @disclaimer  this program is provided to you "as is" without
 *              warranties or conditions # of any kind, whether oral or written,
 *              express or implied. the author specifically # disclaims any implied
 *              warranties or conditions of merchantability, satisfactory # quality,
 *              non-infringement and fitness for a particular purpose.
 * @SDK version 5.5.0
 */

/**
 * For connecting to VMware vCloud REST interfaces
 */
require_once 'HTTP/Request2.php';

/**
 * @see VMware_VCloud_SDK_Http_Client_Interface
 */
require_once 'VMware/VCloud/Http/IClient.php';

/**
 * Constants
 */
require_once 'VMware/VCloud/Constants.php';

/**
 * The default implementation of VMware_VCloud_SDK_Http_Client_Interface.
 *
 * @package VMware_VCloud_SDK_Http
 */
class VMware_VCloud_SDK_Http_Client implements
      VMware_VCloud_SDK_Http_Client_Interface
{
    /**
     * Represents an HTTP_Request2 object
     */
    private $request = null;
    /**
     * User name to log into VMware vCloud
     */
    private $username = null;
    /**
     * Password to log into VMware vCloud
     */
    private $password = null;
    /**
     * HTTP_Request2 configuration parameters
     * @see HTTP_Request2 $config variable
     */
    private $config = null;
    /**
     * HTTP_Request2 configuration parameters
     * @see HTTP_Request2 $apiVersion variable
     */
    private $apiVersion = null;
    /**
     * Authentication token used for login to the session
     */
    private $authToken = null;

    /**
     * Constructor, creates a new HTTP_Request2 instance.
     */
    public function __construct()
    {
        $this->request = new HTTP_Request2();
    }

    /**
     * Set the login user name and password.
     *
     * @param array $auth   In array('username'=><username>,
     *                               'password'=><password>) format
     * @return null
     * @throws VMware_VCloud_SDK_Http_Exception
     * @since Version 1.0.0
     */
    public function setAuth($auth)
    {
        if (array_key_exists('username', $auth) &&
            array_key_exists('password', $auth))
        {
            $this->username = $auth['username'];
            $this->password = $auth['password'];
        }
        else
        {
            require_once 'VMware/VCloud/Http/Exception.php';
            throw new VMware_VCloud_SDK_Http_Exception(
                 "'username' and 'password' are valid keys of array \$auth\n");
        }
    }

    /**
     * Set the HTTP configurations
     *
     * @param array  $config  An HTTP configuration array
     * @since Version 1.0.0
     */
    public function setConfig($config)
    {
        $this->config = $config;
    }

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

    /**
     * Gets the vcloud token
     *
     * @return String
     * @since API 5.1.0
     * @since SDK 5.1.0
     */
    public function getVcloudToken()
    {
        if ($this->authToken != null)
        return $this->authToken;
        throw new VMware_VCloud_SDK_Exception("Failed the Vcloud Token \n");
    }

    /**
     * Sets the vcloud token
     *
     * @param string $vcloudToken
     * @since API 5.1.0
     * @since SDK 5.1.0
     */
    public function setVcloudToken($vcloudToken)
    {
        $this->authToken = $vcloudToken;
    }

    /**
     * Send request to vCloud server.
     *
     * @param string $url      URL to send an HTTP request
     * @param string $method   HTTP method
     * @param string $headers  HTTP headers
     * @param string $body     HTTP request body
     * @return VMware_VCloud_SDK_Http_Response_Interface   An Response object
     * @access private
     */
    private function sendRequest($url, $method, $headers=null, $body=null)
    {
        # 'Accept' header is used to identify VMware vCloud Director version
        $headers['Accept'] = VMware_VCloud_SDK_Constants::VCLOUD_ACCEPT_HEADER .
                             ';' .
                             'version=' . $this->apiVersion;
        try
        {
            $request = clone $this->request;
            if ($this->config)
            {
                $request->setConfig($this->config);
            }
            $request->setUrl($url);
            $request->setMethod($method);
            $request->setHeader($headers);
            if ($this->authToken)
            {
                $request->setHeader(VMware_VCloud_SDK_Constants::
                                        VCLOUD_AUTH_TOKEN,
                                    $this->authToken);
            }
            else
            {
                $request->setAuth($this->username, $this->password);
            }
            if ($body)
            {
                $request->setBody($body);
            }
            $response = $request->send();
            if (!$this->authToken)
            {
                $this->authToken = $response->getHeader(
                                VMware_VCloud_SDK_Constants::VCLOUD_AUTH_TOKEN);
            }
            return $response;
        }
        catch (HTTP_Request2_Exception $e)
        {
            require_once 'VMware/VCloud/Http/Exception.php';
            throw new VMware_VCloud_SDK_Http_Exception($e->getMessage(),
                                                       $e->getCode());
        }
    }

    /**
     * Send an HTTP GET request.
     *
     * @param string $url      URL to send an HTTP request
     * @param array $headers   HTTP request headers
     * @return VMware_VCloud_SDK_Http_Response_Interface
     * @since Version 1.0.0
     */
    public function get($url, $headers=null)
    {
        return $this->sendRequest($url,
                                  HTTP_Request2::METHOD_GET,
                                  $headers);
    }

    /**
     * Send an HTTP POST request.
     *
     * @param string $url      URL to send an HTTP request
     * @param array $headers   HTTP request headers
     * @param mixed  $data     HTTP request body
     * @return VMware_VCloud_SDK_Http_Response_Interface
     * @since Version 1.0.0
     */
    public function post($url, $headers=null, $data=null)
    {
        return $this->sendRequest($url,
                                  HTTP_Request2::METHOD_POST,
                                  $headers,
                                  $data);
    }

    /**
     * Send an HTTP PUT request.
     *
     * @param string $url      URL to send an HTTP request
     * @param array $headers   HTTP request headers
     * @param mixed  $data     HTTP request body
     * @return VMware_VCloud_SDK_Http_Response_Interface
     * @since Version 1.0.0
     */
    public function put($url, $headers=null, $data=null)
    {
        return $this->sendRequest($url,
                                  HTTP_Request2::METHOD_PUT,
                                  $headers,
                                  $data);
    }

    /**
     * Send an HTTP DELETE request.
     *
     * @param string $url      URL to send an HTTP request
     * @return VMware_VCloud_SDK_Http_Response_Interface|null
     * @since Version 1.0.0
     */
    public function delete($url)
    {
        return $this->sendRequest($url,
                                  HTTP_Request2::METHOD_DELETE);
    }

    /**
     * Download a file and dump to specified location.
     *
     * @param string $url      Download source
     * @param array $headers   HTTP request headers
     * @param string $dest     Destination of the file to write to
     * @return null
     * @since Version 1.0.0
     */
    public function download($url, $headers, $dest)
    {
        $fd = fopen($dest, 'wb');
        fwrite($fd, $this->get($url, $headers)->getBody());
        fclose($fd);
    }

    /**
     * Upload a file.
     *
     * @param string $url      Target where to upload the file
     * @param array $headers   HTTP request headers
     * @param string $file     Full path of the file to be uploaded
     * @return null
     * @since Version 1.0.0
     */
    public function upload($url, $headers, $file)
    {
        session_write_close();
        if ($fh = fopen($file, 'rb'))
        {
            $data = fread($fh, filesize($file));
            $this->put($url, $headers, $data);
            flush();
        }
        fclose($fh);
    }
}
// end of class VMware_VCloud_SDK_Http_Client
?>
