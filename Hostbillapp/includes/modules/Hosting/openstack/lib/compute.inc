<?php

/**
 * The OpenStack Compute (Nova) service
 *
 * @copyright 2012 Rackspace Hosting, Inc.
 * See COPYING for licensing information
 *
 * @package phpOpenCloud
 * @version 1.0
 * @author Glen Campbell <glen.campbell@rackspace.com>
 */

namespace OpenCloud;

require_once('nova.inc');
require_once('server.inc');
require_once('image.inc');
require_once('flavor.inc');
require_once('network.inc');
require_once('securitygroup.inc');
require_once('floatingips.inc');
require_once('floatingippool.inc');
require_once('servermetadata.inc');

/**
 * The Compute class represents the OpenStack Nova service.
 *
 * It is constructed from a OpenStack object and requires a service name,
 * region, and URL type to select the proper endpoint from the service
 * catalog. However, constants can be used to define default values for
 * these to make it easier to use:
 *
 * Creating a compute object:
 *
 * <code>
 * $rackspace = new OpenCloud\Rackspace(...);
 * $dallas = new Compute(
 *    $rackspace,              // connection
 *   'cloudServersOpenStack',  // the service's name
 *   'DFW',                    // region identifier
 *   'publicURL'               // URL type
 *  );
 * </code>
 *
 * The easy way (with defaults); this assumes that the constants (RAXSDK_...)
 * are defined elsewhere *before* the inclusion of the first SDK library file:
 *
 * <code>
 * $rackspace = new OpenCloud\Rackspace(...);
 * $dallas = new OpenCloud\Compute($rackspace); // uses defaults
 * </code>
 *
 */
class Compute extends Nova {

    /**
     * Called when creating a new Compute service object
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
    public function __construct(OpenStack $conn, $serviceName, $serviceRegion, $urltype) {
        $this->debug(_('initializing Compute...'));
        parent::__construct(
                        $conn,
                        'compute',
                        $serviceName,
                        $serviceRegion,
                        $urltype
        );

        // load extension namespaces
        $this->load_namespaces();
    }

// function __construct()

    /**
     * Returns the selected endpoint URL of this compute Service
     *
     * @param string $resource - an optional child resource. For example,
     *      passing 'details' would return .../servers/details. Should *not* be
     *    prefixed with a slash (/).
     * @param array $args (optional) an array of key-value pairs for query
     *      strings to append to the URL
     * @returns string - the requested URL
     */
    public function Url($resource='servers', $args=array()) {
        return parent::Url($resource, $args);
    }

    /**
     * Returns a Server object associated with this Compute service
     *
     * This is a factory method and should generally be used to create server
     * objects (thus ensuring that they are correctly associated with the
     * server) instead of calling the Server class explicitly.
     *
     * @api
     * @param string $id - if specified, the server with the ID is retrieved
     * @returns Compute\Server object
     */
    public function Server($id=NULL) {
        return new Compute\Server($this, $id);
    }

    /**
     * Return security group object
     * @param <type> $id
     * @return Compute\FloatingIPs
     */
    public function FloatingIPs($id=NULL) {

        if (!in_array('os-floating-ips', $this->namespaces()))
            throw new VolumeError(_('os-floating-ips extension is not available'));

        return new Compute\FloatingIPs($this, $id);
    }

    /**
     * Returns collection of security groups
     * @param <type> $filter
     * @return <type>
     */
    public function FloatingIPsList() {
        if (!in_array('os-floating-ips', $this->namespaces()))
            throw new VolumeError(_('os-floating-ips extension is not available'));

        $url = $this->Url(Compute\FloatingIPs::URL_RESOURCE, array());


        return $this->Collection($url, 'FloatingIPs', 'floating_ips');
    }

    /**
     * Returns collection of floating ip pools
     * @param <type> $filter
     * @return <type>
     */
    public function FloatingIPsListPools() {
        if (!in_array('os-floating-ip-pools', $this->namespaces()))
            throw new VolumeError(_('os-floating-ip-pools extension is not available'));

        $url = $this->Url(Compute\FloatingIPPool::URL_RESOURCE, array());


        return $this->Collection($url, 'FloatingIPPool', 'floating_ip_pools');
    }

    /**
     * Returns floating ip pool object
     * @param <type> $filter
     * @return <type>
     */
    public function FloatingIPPool($id=NULL) {
        if (!in_array('os-floating-ip-pools', $this->namespaces()))
            throw new VolumeError(_('os-floating-ip-pools extension is not available'));

        return new Compute\FloatingIPPool($this, $id);
    }

    /**
     * Return security group object
     * @param <type> $id
     * @return Compute\SecurityGroup
     */
    public function SecurityGroup($id=NULL) {

        if (!in_array('os-security-groups', $this->namespaces()))
            throw new VolumeError(_('security_groups extension is not available'));

        return new Compute\SecurityGroup($this, $id);
    }

    /**
     * Returns collection of security groups
     * @param <type> $filter
     * @return <type>
     */
    public function SecurityGroupList($server_id=false) {
        if (!in_array('os-security-groups', $this->namespaces()))
            throw new VolumeError(_('security_groups extension is not available'));

        if ($server_id) {
            $url = $this->Url("servers/{$server_id}/os-security-groups", array());
        } else {
            $url = $this->Url(Compute\SecurityGroup::URL_RESOURCE, array());
        }

        return $this->Collection($url, 'SecurityGroup', 'security_groups');
    }

    /**
     * Returns a Collection of server objects, filtered by the specified
     * parameters
     *
     * This is a factory method and should normally be called instead of
     * creating a ServerList object directly.
     *
     * @api
     * @param boolean $details - if TRUE, full server details are returned; if
     *      FALSE, just the minimal set of info is listed. Defaults to TRUE;
     *      you might set this to FALSE to improve performance at the risk of
     *      not having all the information you need.
     * @param array $filter - a set of key/value pairs that is passed to the
     *    servers list for filtering
     * @returns Collection
     */
    public function ServerList($details=TRUE, $filter=array()) {

        if (!is_bool($details))
            throw new InvalidArgumentException(
                    _('First argument for Compute::ServerList() must be boolean'));
        if (!is_array($filter))
            throw new InvalidArgumentException(
                    _('Second argument for Compute::ServerList() must be array'));
        if ($details)
            $url = $this->Url(Compute\Server::URL_RESOURCE . '/detail', $filter);
        else
            $url = $this->Url(Compute\Server::URL_RESOURCE, $filter);

        return $this->Collection($url, 'Server', 'servers');
    }

    /**
     * Returns a Network object
     *
     * @api
     * @param string $id the network ID
     * @return Compute\Network
     */
    public function Network($id=NULL) {
        return new Compute\Network($this, $id);
    }

    /**
     * Returns a Collection of Network objects
     *
     * @api
     * @param array $filters array of filter key/value pairs
     * @return Collection
     */
    public function NetworkList($filter=array()) {
        return $this->Collection(
                $this->Url(Compute\Network::URL_RESOURCE),
                'Network',
                Compute\Network::JSON_ELEMENT . 's');
    }

    /**
     * Returns an image from the service
     *
     * This is a factory method and should normally be called instead of
     * creating an Image object directly.
     *
     * @api
     * @param string $id - if supplied, returns the image with the specified ID.
     * @return Compute\Image object
     */
    public function Image($id=NULL) {
        return new Compute\Image($this, $id);
    }

    /**
     * Returns a Collection of images (class Image)
     *
     * This is a factory method and should normally be used instead of creating
     * an ImageList object directly.
     *
     * @api
     * @param boolean $details - if TRUE (the default), returns complete image
     * 		details. Set to FALSE to improve performance, but only return a
     *      minimal set of data
     * @param array $filter - key/value pairs to pass to the images resource.
     * 		The actual values available here are determined by the OpenStack
     * 		code and any extensions installed by your cloud provider;
     * 		see http://docs.rackspace.com/servers/api/v2/cs-devguide/content/List_Images-d1e4435.html
     * 		for current filters available.
     * @return Collection
     */
    public function ImageList($details=TRUE, $filter=array()) {
        // validate arguments
        if (gettype($details) != 'boolean')
            throw new Compute\InvalidParameterError(
                    _('Invalid argument for Compute::ImageList(); ' .
                            'boolean required'));
        if ($details)
            $url = $this->Url('images/detail', $filter);
        else
            $url = $this->Url('images', $filter);
        return $this->Collection($url, 'Image', 'images');
    }

    /**
     * Access extension API
     * available in stackops:
     * Disk Management Extension -> OS-DCF
     * Admin-only host administration -> os-hosts
     * Pass arbitrary key/value pairs to the scheduler -> os-scheduler-hints
     * Quotas management support - > os-quota-sets
     * Floating IP DNS support -> os-floating-ip-dns
     * Provide additional data for flavors -> OS-FLV-EXT-DATA
     * Instance type (flavor) extra specs -> os-flavor-extra-specs
     * Security group support -> security_groups
     * Admin-only access to accounts -> os-accounts
     * Volumes support -> os-volumes
     * Extended Status support -> OS-EXT-STS
     * Interactive Console support. -> os-consoles
     * Virtual interface support -> virtual_interfaces
     * Admin-only aggregate administration -> os-aggregates
     * Instance deferred delete -> os-deferred-delete
     * Allow Admins to view server diagnostics through server action -> os-server-diagnostics
     * Admin-only Network Management Extension -> os-networks
     * Extended Server Attributes support. -> OS-EXT-SRV-ATTR
     * Enable admin-only server actions -> os-admin-actions
     * Floating IPs support -> os-floating-ip-pools
     * Start/Stop instance compute API support -> os-server-start-stop
     * Certificates support -> os-certificates
     * Instance rescue mode -> os-rescue
     * Flavor create/delete API support -> os-flavor-manage
     * Multiple network support -> NMN
     * Allow admins to acces user information -> os-users
     * SimpleTenantUsage -> os-simple-tenant-usage
     * Allow Admins to view pending server actions -> os-server-action-list
     * Console log output support, with tailing ability. -> os-console-output
     *
     * @param string $extension Extension to access
     */
    public function ExtensionApi($extension) {

        if (!in_array($extension, $this->namespaces()))
            throw new \OpenCloud\UnsupportedFeatureExtension(_($extension . ' extension is not available'));

        switch ($extension) {
            case 'os-flavor-manage':
                return $this->Url('flavors');
                break;
            default:
                return $this->Url();
                break;
        }
    }

    /**
     * Create new flavor trough flavor management API
     * @param <type> $data
     * @return <type>
     */
    public function CreateFlavor($data) {

        $url = $this->ExtensionApi('os-flavor-manage');
        $obj = new \stdClass();
        $obj->flavor = new \stdClass();
        foreach ($data as $k => $v) {
            $obj->flavor->$k = $v;
        }
        $json = json_encode($obj);
        if ($this->CheckJsonError())
            return;
        $response = $this->Service()->Request($url, 'POST', array(), $json);
        // check response
        if ($response->HttpStatus() > 204)
            throw new VolumeError(sprintf(
                            _('Error creating flavor request [%s] ' .
                                    'status [%d] response [%s]'),
                            $json, $response->HttpStatus(), $response->HttpBody()));

        // return response
        return $response;
    }

    /**
     * GET v2/{tenant_id}/os-simple-tenant-usage/{tenant_id}
     * @param <type> $tenant_id
     * @param <type> $start
     * @param <type> $end
     * @todo start param triggers compute error
     */
    public function GetTenantUsage($tenant_id, $start=false, $end=false) {
        if (!in_array('os-simple-tenant-usage', $this->namespaces()))
            throw new UnknownError(_('os-simple-tenant-usage extension is not available'));

        $url = $this->Url('os-simple-tenant-usage' . '/' . $tenant_id);

        if (!$start) {
            $start = date('Y-m-d H:i:s', strtotime(date('Y-m-d H:i:s') . ' - 1 day'));
        }
       // $url.='?start=' . $start;
        $response = $this->Request($url);
        if ($response->HttpStatus() > 204)
            throw new UnknownError(sprintf(
                            _('Error getting tenant usage details ' .
                                    'status [%d] response [%s]'),
                            $response->HttpStatus(), $response->HttpBody()));

        if ($response) {
            $tenants_json = $response->HttpBody();
            $tenants_json = json_decode($tenants_json);
            if ($tenants_json->tenant_usage) {
                return $tenants_json->tenant_usage;
            }
            return array();
        }
    }

    /**
     * Get tenant limits set
     * @param <type> $tenant_id
     */
    public function GetTenantLimits($tenant_id) {
         if (!in_array('os-quota-sets', $this->namespaces()))
            throw new UnknownError(_('os-quota-sets extension is not available'));

        $url = $this->Url('os-quota-sets' . '/' . $tenant_id);
          $response = $this->Request($url);
        if ($response->HttpStatus() > 204)
            throw new UnknownError(sprintf(
                            _('Error getting tenant usage details ' .
                                    'status [%d] response [%s]'),
                            $response->HttpStatus(), $response->HttpBody()));

        if ($response) {
            $tenants_json = $response->HttpBody();
            $tenants_json = json_decode($tenants_json);
            if ($tenants_json->quota_set) {
                return $tenants_json->quota_set;
            }
            return array();
        }
    }

    /**
     * Set tenant limits
     * Requires os-quota-sets extension to be available
     * @param <type> $params
     * @return <type>
     */
    public function SetTenantLimits($tenant_id, $params=array()) {

        if (!in_array('os-quota-sets', $this->namespaces()))
            throw new UnknownError(_('os-quota-sets extension is not available'));

        $url = $this->Url('os-quota-sets' . '/' . $tenant_id);
        $obj = new \stdClass();
        $obj->quota_set = new \stdClass();
        foreach ($params as $k => $v) {
            $obj->quota_set->$k = $v;
        }
        $json = json_encode($obj);
        if ($this->CheckJsonError())
            return;
        $response = $this->Request($url, 'PUT', array(), $json);
        // check response
        if ($response->HttpStatus() > 204)
            throw new UnknownError(sprintf(
                            _('Error creating setting tenant limits request [%s] ' .
                                    'status [%d] response [%s]'),
                            $json, $response->HttpStatus(), $response->HttpBody()));

        // return response
        return $response;
    }

    /**
     * Returns a Collection of flavors
     *
     * This is a factory method and should normally be called instead of
     * creating a ServerList object directly.
     *
     * @api
     * @param boolean $details
     * @param array $filter
     * @returns Collection
     */
    public function FlavorList($details=TRUE, $filter=array()) {
        if (!is_bool($details))
            throw new InvalidArgumentException(
                    _('First argument for Compute::FlavorList() must be boolean'));
        if (!is_array($filter))
            throw new InvalidArgumentException(
                    _('Second argument for Compute::FlavorList() must be array'));
        if ($details)
            $url = $this->Url(Compute\Flavor::URL_RESOURCE . '/detail', $filter);
        else
            $url = $this->Url(Compute\Flavor::URL_RESOURCE, $filter);

        return $this->Collection($url, 'Flavor', 'flavors');
    }

}

// class Compute
