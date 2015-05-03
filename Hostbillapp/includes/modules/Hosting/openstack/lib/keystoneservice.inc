<?php
/**
 *
 * @author Kris pajak @hostbill
 */

namespace OpenCloud;

require_once('tenant.inc');
require_once('roles.inc');
require_once('service.inc');
require_once('collection.inc');
require_once('keystoneuser.inc');

class KeystoneService extends Service {
	private $_url, $_namespaces;

        /**
	 * Returns a list of supported namespaces
	 *
	 * @return array
	 */
	public function namespaces() {
	    return $this->_namespaces;
	}

	/********** PRIVATE METHODS **********/

	/**
	 * Loads the available namespaces from the /extensions resource
	 */
	protected function load_namespaces() {
	    $ext = $this->Extensions();

	    foreach($ext as $obj)
	        $this->_namespaces[] = $obj->alias;
	}

	/**
	 * Called when creating a new Keystone service object
	 *
	 * _NOTE_ that the order of parameters for this is *different* from the
	 * parent Service class. This is because the earlier parameters are the
	 * ones that most typically change, whereas the later ones are not
	 * modified as often.
	 *
	 * @param \OpenCloud\Identity $conn - a connection object
	 * @param string $serviceRegion - identifies the region of this Compute
	 *      service
	 * @param string $urltype - identifies the URL type ("publicURL",
	 *      "privateURL")
	 * @param string $serviceName - identifies the name of the service in the
	 *      catalog
	 */
	public function __construct(OpenStack $conn,
	        $serviceName, $serviceRegion, $urltype) {
		$this->debug(_('initializing Keystone...'));
		parent::__construct(
			$conn,
			'identity',
			$serviceName,
			$serviceRegion,
			$urltype
		);
		$this->_url = noslash(parent::Url());
		$this->load_namespaces();
	} // function __construct()

	/**
	 * Returns the selected endpoint URL of this Service
	 *
	 * @param string $resource - a child resource. For example,
	 *      passing 'servers' would return .../servers. Should *not* be
	 *    prefixed with a slash (/).
	 * @param array $args (optional) an array of key-value pairs for query
	 *      strings to append to the URL
	 * @returns string - the requested URL
	 */
	public function Url($resource='tenants', $args=array()) {
	      $baseurl = $this->_url;
	    if ($resource != '')
	        $baseurl = noslash($baseurl).'/'.$resource;
	    if (!empty($args))
	        $baseurl .= '?'.$this->MakeQueryString($args);
		return $baseurl;
	}


	public function Request($url, $method='GET', $headers=array(), $body=NULL) {
		$headers['Content-Type'] = 'application/json';
		return parent::Request($url, $method, $headers, $body);
	}

        public function Tenant($id=NULL) {
		return new Keystone\Tenant($this, $id);
        }

         public function User($id=NULL) {
		return new Keystone\KeystoneUser($this, $id);
        }



         public function Role($id=NULL) {
		return new Keystone\Roles($this, $id);
        }

        public function RolesList() {
        $r = $this->Request($this->url('OS-KSADM/roles'));

        }

        public function RolesForUser($tenant_id, $user_id) {
        $route = sprintf("tenants/%s/users/%s/roles", $tenant_id, $user_id);

        $r = $this->Request($this->url($route));
        if ($r) {
            $tenants_json = $r->HttpBody();
            $tenants_json = json_decode($tenants_json);
            if ($tenants_json->roles) {
                return $tenants_json->roles;
            }
            return array();
        }
    }

        public function TenantList() {
        $r = $this->Request($this->url('tenants'));
        if ($r) {
           $tenants_json= $r->HttpBody();
            $tenants_json = json_decode($tenants_json);
            if ($tenants_json->tenants) {
                return $tenants_json->tenants;
            }
            return array();
        }
    }

    
}
