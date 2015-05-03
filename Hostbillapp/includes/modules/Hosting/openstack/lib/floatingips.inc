<?php

/**
 *
 * @author Kris Pajak @hostbill
 */

namespace OpenCloud\Compute;

require_once('persistentobject.inc');

/**
 *
 */
class FloatingIPs extends \OpenCloud\PersistentObject {

    public
    $id,
    $ip,
    $instance_id,
    $fixed_ip,
    $pool;


    const
    JSON_ELEMENT = 'floating_ip',
    URL_RESOURCE = 'os-floating-ips';

    /**
     * Creates a new flavor object; if ID is specified, then the
     * flavor with the specified ID is retrieved
     *
     * @param $id - the ID of the flavor to retrieve; otherwise, an empty
     *    SecurityGroup object is created.
     * @throws SecurityGroupError, JsonError, UnknownError
     */
    public function __construct($compute, $id=NULL) {
        parent::__construct($compute, $id);
    }

    /**
     * Allocate new IP from pool
     * @param <type> $pool
     * @return <type>
     */
    public function Allocate($pool='nova') {
        $url = $this->Service()->Url('os-floating-ips');
        $obj = new \stdClass();
        $obj->pool = $pool;
        $json = json_encode($obj);
        if ($this->CheckJsonError())
            return;
        $response = $this->Service()->Request($url, 'POST', array(), $json);
        // check response
        if ($response->HttpStatus() > 204)
            throw new \OpenCloud\CreateError(sprintf(
                            _('Error allocating pool, request [%s] ' .
                                    'status [%d] response [%s]'),
                            $json, $response->HttpStatus(), $response->HttpBody()));

        // return response

        if (!is_object($response))
            throw new \OpenCloud\HttpError(sprintf(
                            _('Invalid response for allocating pool request')));
        $json = $response->HttpBody();
        if (!$json)
            throw new \OpenCloud\UnknownError(_('Unexpected error'));
        else {
            $info = json_decode($json);
            if ($this->CheckJsonError())
                return FALSE;
            foreach ($info->floating_ip as $item => $value)
                $this->$item = $value;
        }
        return $response;
    }

    /**
     * Deallocate floating IP
     * @param <type> $id
     */
    public function Deallocate($id) {
$response = $this->Service()->Request($this->Service()->Url('os-floating-ips/' . $id), 'DELETE');
        if ($response->HttpStatus() > 204)
            throw new \OpenCloud\DeleteError(sprintf(
                            _('Error deallocating floating IP [%s], status [%d] response [%s]'),
                            $id,
                            $response->HttpStatus(),
                            $response->HttpBody()));
        return $response;
    }

    /**
     * returns the URL resource component
     */
    protected function ResourceName() {
        return self::URL_RESOURCE;
    }

    /**
     * returns the JSON top-level element
     */
    protected function JsonName() {
        return self::JSON_ELEMENT;
    }

    protected function CreateJson($element='floating_ip') {

        return $json;
    }

   

}