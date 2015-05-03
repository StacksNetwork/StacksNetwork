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
class FloatingIPPool extends \OpenCloud\PersistentObject {

    public
    $name;
    private
    $service;


    const
    JSON_ELEMENT = 'floating_ip',
    URL_RESOURCE = 'os-floating-ip-pools';

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

    /**
     * Returns the service associated with this SecurityGroup
     */
    public function Service() {
        return $this->service;
    }

}