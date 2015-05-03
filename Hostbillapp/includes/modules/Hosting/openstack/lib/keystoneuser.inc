<?php

/**
 *
 * @author Kris Pajak @hostbill
 */

namespace OpenCloud\Keystone;

require_once('persistentobject.inc');

class KeystoneUser extends \OpenCloud\PersistentObject {
    const
    JSON_ELEMENT = 'user',
    URL_RESOURCE = 'users';

    public

    $id, // the server's ID
    $username,
    $email,
    $password,
    $enabled,
            $tenantId; //not tested, experimental, you may want to try OS-KSADM:tenantId

    // flavor reference (for create)

    /**
     * Creates a new KeystoneUser object and associates it with a KeystoneService service
     *
     * @param mixed $info
     * * If NULL, an empty Server object is created
     * * If an object, then a Server object is created from the data in the
     *      object
     * * If a string, then it's treated as a Server ID and retrieved from the
     *      service
     * The normal use case for SDK clients is to treat it as either NULL or an
     *      ID. The object value parameter is a special case used to construct
     *      a Server object from a ServerList element to avoid a secondary
     *      call to the Service.
     * @throws ServerNotFound if a 404 is returned
     * @throws UnknownError if another error status is reported
     */
    public function __construct(\OpenCloud\KeystoneService $service, $info=NULL) {
        // make the service persistent
        parent::__construct($service, $info);
    }

    /**
     * Assign user to tenant. EXPERIMENTAL
     * This is not documented via openstack API
     * @see https://github.com/openstack/python-keystoneclient/blob/master/keystoneclient/v2_0/users.py
     * @param <type> $tenant_id
     */
    public function AdminAssignTenant($tenant_id) {

        $url = $this->Service()->Url('users/' . $this->id . '/OS-KSADM/tenant');
        $obj = new \stdClass();
        $obj->user = new \stdClass();
        $obj->user->id = $this->id;
        $ob->user->tenantId = $tenant_id;
        $json = json_encode($obj);
        if ($this->CheckJsonError())
            return;
        $response = $this->Service()->Request($url, 'POST', array(), $json);
        // check response
        if ($response->HttpStatus() > 204)
            throw new \OpenCloud\HttpError(sprintf(
                            _('Error allocating tenant, request [%s] ' .
                                    'status [%d] response [%s]'),
                            $json, $response->HttpStatus(), $response->HttpBody()));

        // return response
        return $response;
    }

    /**
     * Do not rely on this - it requires OS-KSADM enabled
     * @return <type>
     */
    public function AdminEnable() {
        $url = $this->Service()->Url('users/' . $this->id . '/OS-KSADM/enabled');
        $obj = new \stdClass();
        $obj->user = new \stdClass();
        $obj->user->id = $this->id;
        $ob->user->enabled = true;
        $json = json_encode($obj);
        if ($this->CheckJsonError())
            return;
        $response = $this->Service()->Request($url, 'POST', array(), $json);
        // check response
        if ($response->HttpStatus() > 204)
            throw new \OpenCloud\HttpError(sprintf(
                            _('Error enabling user, request [%s] ' .
                                    'status [%d] response [%s]'),
                            $json, $response->HttpStatus(), $response->HttpBody()));

        // return response
        return $response;
    }
        /**
     * Do not rely on this - it requires OS-KSADM enabled
     * @return <type>
     */
    public function AdminDisable() {
        $url = $this->Service()->Url('users/' . $this->id . '/OS-KSADM/enabled');
        $obj = new \stdClass();
        $obj->user = new \stdClass();
        $obj->user->id = $this->id;
        $obj->user->enabled = false;
        die($url);
        $json = json_encode($obj);
        if ($this->CheckJsonError())
            return;
        $response = $this->Service()->Request($url, 'POST', array(), $json);
        // check response
        if ($response->HttpStatus() > 204)
            throw new \OpenCloud\HttpError(sprintf(
                            _('Error disabling user, request [%s] ' .
                                    'status [%d] response [%s]'),
                            $json, $response->HttpStatus(), $response->HttpBody()));

        // return response
    }

    public function Update($params=array()) {
		// set parameters



                 $obj = new \stdClass();
                $obj->user = new \stdClass();
                $obj->user->id = $this->id;

                foreach($params as $key => $value)
			$obj->user->$key = $value;

		$json = json_encode($obj);
		if ($this->CheckJsonError())
			return FALSE;
		$this->debug('%s::Update JSON [%s]', get_class($this), $json);


               $url = $this->Service()->Url('users/' . $this->id );

		// send the request
		$response = $this->Service()->Request(
			$url,
			'PUT',
			array(),
			$json
		);

		// check the return code
		if ($response->HttpStatus() > 204)
			throw new UpdateError(sprintf(
				_('Error updating [%s] with [%s], status [%d] response [%s]'),
				get_class($this),
				$json,
				$response->HttpStatus(),
				$response->HttpBody()));

		// set values from response

		return $response;
	}

    /**
     * Create new user.
     */
    public function Create($params=array()) {

        $url = $this->Service()->Url('users');
        foreach ($params as $key => $value)
            $this->$key = $value;

        $obj = new \stdClass();
        $obj->user = new \stdClass();
        $obj->user->name = $this->username;
        $obj->user->email = $this->email;
        $obj->user->enabled = true;
        $obj->user->password = $this->password;
        $obj->user->tenantId = $this->tenantId;
         $json = json_encode($obj);
        if ($this->CheckJsonError())
            return;

        $response = $this->Service()->Request($url, 'POST', array(), $json);
        if (!is_object($response))
            throw new \OpenCloud\HttpError(sprintf(
                            _('Invalid response for KeystoneUser::%s() request'),
                            'Create'));
        $json = $response->HttpBody();
        if ($response->HttpStatus() >= 300)
            throw new \OpenCloud\CreateError(
                    sprintf(_('Problem creating user with , ' .
                                    'status [%d] response [%s]'),
                            $response->HttpStatus(),
                            $response->HttpBody()));
        else if (!$json)
            throw new UnknownError(_('Unexpected error in KeystoneUser::Create()'));
        else {
            $info = json_decode($json);
            if ($this->CheckJsonError())
                return FALSE;
            foreach ($info->user as $item => $value)
                $this->$item = $value;
        }
        return $response;
    }

    /*     * ********* PROTECTED METHODS ********** */

    /**
     * the top-level JSON identifier
     */
    protected function JsonName() {
        return self::JSON_ELEMENT;
    }

    /**
     * the URL resource
     */
    protected function ResourceName() {
        return self::URL_RESOURCE;
    }

}
