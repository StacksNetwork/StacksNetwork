<?php
/**
 *
 * @author Kris Pajak @hostbill
 */

namespace OpenCloud\Keystone;

require_once('persistentobject.inc');


class Tenant extends \OpenCloud\PersistentObject {

	const
		JSON_ELEMENT = 'tenant',
		URL_RESOURCE = 'tenants';

	public

		$id,			// the server's ID
		$name,			// the server's name
		$description,		// date and time the server was created
		$enabled;

			// flavor reference (for create)

	/**
	 * Creates a new Tenant object and associates it with a KeystoneService service
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
         * Create new tenant.
         * @param <type> $params
         * @return <type>
         */
        public function Create($params=array()) {
	    // reset values
	    $this->id = $this->name =  $this->enabled = NULL;
		foreach($params as $key => $value)
			$this->$key = $value;

		$this->debug(_('Tenant::Create() [%s]'), $this->name);
		$create = $this->CreateJson( 'tenant' );
		$response = $this->Service()->Request(
			$this->Service()->Url('tenants'),
			'POST',
			array(),
			$create
		);
		if (!is_object($response))
			throw new \OpenCloud\HttpError(sprintf(
			    _('Invalid response for Tenant::%s() request'),
			   'Create'));
		$json = $response->HttpBody();
		if ($response->HttpStatus() >= 300)
			throw new \OpenCloud\CreateError(
			    sprintf(_('Problem creating tenant with [%s], '.
			              'status [%d] response [%s]'),
			        $create,
			        $response->HttpStatus(),
			        $response->HttpBody()));
		else if (!$json)
			throw new UnknownError(_('Unexpected error in Tenant::Create()'));
		else {
			$info = json_decode($json);
			if ($this->CheckJsonError())
				return FALSE;
			foreach($info->tenant as $item => $value)
				$this->$item = $value;
		}
		return $response;
	}

  

        /*********** PROTECTED METHODS ***********/

	/**
	 * Creates the JSON for creating a new server
	 *
	 * @param string $element creates {server ...} by default, but can also
	 *      create {rebuild ...} by changing this parameter
	 * @return json
	 */
	protected function CreateJson($element='tenant') {
        // create a blank object
        $obj = new \stdClass();
        // set a bunch of properties
        $obj->$element = new \stdClass();
        $obj->$element->name = $this->name;
        $obj->$element->description = $this->description;
        $obj->$element->enabled = $this->enabled;


        $json = json_encode($obj);
        return $json;
	}

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
