<?php
/**
 *
 * @author Kris Pajak @hostbill
 */

namespace OpenCloud\Keystone;

require_once('persistentobject.inc');


class Roles extends \OpenCloud\PersistentObject {

	const
		JSON_ELEMENT = 'role',
		URL_RESOURCE = 'OS-KSADM/roles';

	public

		$id,			// the server's ID
		$name,			// the server's name
		$description;

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



        /*********** PROTECTED METHODS ***********/

	/**
	 * Creates the JSON for creating a new server
	 *
	 * @param string $element creates {server ...} by default, but can also
	 *      create {rebuild ...} by changing this parameter
	 * @return json
	 */
	protected function CreateJson($element='role') {
       
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
