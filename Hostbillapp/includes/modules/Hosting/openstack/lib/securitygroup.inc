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
class SecurityGroup extends \OpenCloud\PersistentObject {

    public
    $id,
    $name,
    $description,
    $rules;


    const
    JSON_ELEMENT = 'security_group',
    URL_RESOURCE = 'os-security-groups';

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

    public function CreateRule($params) {
        $url = $this->Service()->Url('os-security-group-rules');

        $obj = new \stdClass();
        $obj->security_group_rule = new \stdClass();
        foreach ($params as $key => $value)
            $obj->security_group_rule->$key = $value;

        $obj->security_group_rule->parent_group_id = $this->id;
        $obj->security_group_rule->group_id =  $this->id;
        $json = json_encode($obj);
        if ($this->CheckJsonError())
            return;
        $response = $this->Service()->Request($url, 'POST', array(), $json);
        // check response
        if ($response->HttpStatus() > 204)
            throw new VolumeError(sprintf(
                            _('Error creating security group rule request [%s] ' .
                                    'status [%d] response [%s]'),
                            $json, $response->HttpStatus(), $response->HttpBody()));

        // return response
        return $response;
    }

    public function DeleteRule($rule_id) {
        $response = $this->Service()->Request($this->Service()->Url('os-security-group-rules/' . $rule_id), 'DELETE');
        if ($response->HttpStatus() > 204)
            throw new DeleteError(sprintf(
                            _('Error deleting security rule [%s], status [%d] response [%s]'),
                            $rule_id,
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

    protected function CreateJson($element='security_group') {
        // create a blank object
        $obj = new \stdClass();
        // set a bunch of properties
        $obj->$element = new \stdClass();
        $obj->$element->name = $this->name;
        $obj->$element->description = $this->description;
        return $obj;
    }


}