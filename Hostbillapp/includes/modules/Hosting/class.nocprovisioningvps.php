<?php
/**
 * NOC-PS VPS Hostbill module, version 1.0.5
 *
 * Copyright (C) Maxnet 2011-2014
 *
 * May be distributed under the terms of the LGPL license.
 * In plain English: feel free to use and modify this file to fit your needs,
 * however do NOT ioncube encode it.
 * The source code must be available to anyone you distribute this module to.
 */

require_once('class.nocprovisioning.php');

class Nocprovisioningvps extends Nocprovisioning
{
	protected $description = "NOC-PS VPS (Xenserver/Vsphere) provisioning";
	protected $version     = "1.0.5";

	/*
	 * Ping the IP we intend to give to the VPS to double check if it is not already in use
	 */
	protected $pingCheck = true;

	/**
	 * Space seperated list of blacklisted or whitelisted profiles
	 * Profiles can be specified by numeric ID, or tag (e.g. "windows")
	 */
	protected $whitelist = "";
	protected $blacklist = "xenserver esxi proxmox ovirt";	

	protected $options = array(
		'subnet' => array(
			'name'    => 'subnet',
			'value'   => false,
			'type'    => 'loadable',
			'default' => 'getSubnets'
		),
		'node' => array(
			'name'    => 'node',
			'value'   => false,
			'type'    => 'loadable',
			'default' => 'getNodes'
		),
		'datastore' => array(
			'name'    => 'datastore',
			'value'   => false,
			'type'    => 'loadable',
			'default' => 'getDatastores'
		),
		'network' => array(
			'name'    => 'network',
			'value'   => false,
			'type'    => 'loadable',
			'default' => 'getNetworks'
		),		
		'vcpu' => array(
			'name'    => 'vcpu',
			'value'   => '1',
			'type'    => 'select',
			'default' => array('1','2','4')
		),
		'memory' => array(
			'name'    => 'memory',
			'value'   => '768',
			'type'    => 'input',
			'default' => '768'
		),
		'disk' => array(
			'name'    => 'disk',
			'value'   => '10000',
			'type'    => 'input',
			'default' => '10000'
		),
		'powerdown_on_suspend' =>array (
			'name'=> 'powerdown_on_suspend',
			'value' => '0',
			'type' => 'check',
			'default' =>false
		),
		'powerdown_on_delete' =>array (
			'name' => 'powerdown_on_delete',
			'value' => '0',
			'type' => 'check',
			'default' =>false
		),
		'deletevps_on_delete' =>array (
			'name' => 'deletevps_on_delete',
			'value' => '0',
			'type' => 'check',
			'default' => false
		)
	);
	
	protected $lang = array(
		'english' => array(
			'Power' 			=> "Power control",
			'Provision' 		        => "Provision server",
			'ProvisionStatus'               => "Provisioning status",
			'Datatraffic' 		        => "Data traffic",
			'subnet'			=> "Subnet to assign IPs from",
			'node'				=> "Hypervisor node",
			'vcpu'				=> "vCPUs",
			'network'			=> "Network",
			'memory'			=> "Memory in MB<br><sub>(most profiles need min. 512 MB)</sub>",
			'datastore'			=> "Datastore",
			'disk'  			=> "Disk space in MB",
			'powerdown_on_suspend'          => "Power down server on suspend (warning: can corrupt file system)",
			'powerdown_on_delete'		=> "Power down server on service cancellation",
			'deletevps_on_delete'           => "Delete VPS and all files on service cancellation",
			'ERR_UNKNOWN_SERVER'            => "Server is not listed in NOC-PS database"
		)
	);
	
	protected $_vpstypes = array('xenserver','vmware','proxmox','ovirt');
	
	function __construct()
	{
		parent::__construct();
	}
	
	function Create()
	{
		try
		{
			$subnet    = $this->options['subnet']['value'];
			$node      = $this->options['node']['value'];
			$datastore = $this->options['datastore']['value'];
			$network   = $this->options['network']['value'];
			$memory    = intval($this->options['memory']['value']);
			$disk      = intval($this->options['disk']['value']);
			$vcpu      = intval($this->options['vcpu']['value']);
			$hostname  = $this->account_details['domain'];
			
			if (!$node)
				throw new Exception("No hypervisor node configured in product settings");
			if (!$subnet)
				throw new Exception("No subnet configured in product settings");
			if (!$memory)
				throw new Exception("Amount of memory not set in product settings");
			if (!$disk)
				throw new Exception("Amount of disk space not set in product settings");
			if (!$datastore)
				throw new Exception("Datastore not set in product settings");
			if (!$network)
				throw new Exception("Network not set in product settings");
			if (!$vcpu)
				throw new Exception("vCpus not set in product settings");

			
			$ip = $this->_api->getFirstAvailableIP($subnet);
			if (!$ip)
				throw new Exception("No IPs available in subnet $subnet");
			
			if ($this->pingCheck)
			{
				if ( $this->ping($ip) )
					throw new Exception("IP $ip is free according to the database, but responds to ping");
			}
			
			$result = $this->_api->addVM( array(
				'subnet'      => $subnet,
				'ip'          => $ip,
				'hostname'    => $hostname,
				'description' => 'Created by Hostbill',
				'module'      => $node,
				'numips'      => 1,
				'datastore'   => $datastore,
				'network'     => $network,
				'memory'      => $memory,
				'disk'        => $disk,
				'vcpu'        => $vcpu
			));
			
			if ($result['success'])
			{
				$this->mainIP = $ip;
				$this->account_details['vpsip'] = $ip;
				$this->vpstype = 'Other';
				return true;
			}
			else
			{
				/* input validation error */
				
				foreach ($result['errors'] as $field => $msg)
				{
					$error .= $field.': '.htmlentities($msg).'<br>';
				}
				
				throw new Exception($error);
			}
		}
		catch (Exception $e)
		{
			$this->addError( $e->getMessage() );
			return false;
		}
		
		return true;
	}
	
	function getSubnets()
	{
		$r       = array();
		$subnets = $this->_api->getSubnets(0,99999);

		foreach ($subnets['data'] as $subnetinfo)
		{
			$r[] = $subnetinfo['subnet'];
		}
		
		return $r;
	}
	
	function getNodes()
	{
		$r       = array();
		$modules = $this->_api->getDevices(0,99999);
		
		foreach ($modules['data'] as $moduleinfo)
		{
			if (in_array($moduleinfo['type'], $this->_vpstypes))
			{
				$r[] = array($moduleinfo['id'], $moduleinfo['name']);
			}
		}

		return $r;
	}
	
	/**
	 * Get a list of all datastores from all available hypervisors (might take a while to retrieve)
	 */
	function getDatastores()
	{
		$r = array();
		$modules = $this->_api->getDevices(0,99999);
		
		foreach ($modules['data'] as $moduleinfo)
		{
			try
			{
				if (in_array($moduleinfo['type'], $this->_vpstypes))
				{
					$stores = $this->_api->getDatastores($moduleinfo['id']);
					if ( isset($stores['data']))
					{
						foreach ($stores['data'] as $store)
						{
							$r[] = array($store['id'], $moduleinfo['name'].': '.$store['name']);
						}
					}
				}
			}
			catch (Exception $e) { }
		}
		
		return $r;
	}
	
	/**
	 * Get a list of all networks from all available hypervisors (might take a while to retrieve)
	 */
	function getNetworks()
	{
		$r = array();
		$modules = $this->_api->getDevices(0,99999);
		
		foreach ($modules['data'] as $moduleinfo)
		{
			try
			{
				if (in_array($moduleinfo['type'], $this->_vpstypes))
				{
					$networks = $this->_api->getNetworks($moduleinfo['id']);
					if ( isset($networks['data']))
					{
						foreach ($networks['data'] as $net)
						{
							$r[] = array($net['id'], $moduleinfo['name'].': '.$net['name']);
						}
					}
				}
			}
			catch (Exception $e) { }
		}
		
		return $r;
	}	
	
	function getProvision()
	{
		$this->options['rebootmethod'] = array('value' => 'auto');		
		return parent::getProvision();
	}
	
	function getPower()
	{
		$this->options['rebootmethod'] = array('value' => 'auto');
		return parent::getPower();
	}

	protected function ping($ip)
	{
		exec("ping -c 1 -w 1 ".escapeshellarg($ip), $output);
		if (!count($output))
			throw new Exception("Error executing ping");
			
		$this->log("Double checked that IP is really free: ".implode('',$output));
		return (strpos(implode('', $output), "100%") === false); /* expecting 100% packet loss */
	}
	
	function Terminate()
	{
		parent::Terminate();
		
		if ($this->options['deletevps_on_delete']['value'])
		{
			try
			{
				$mac = $this->mac();
				
				if ($mac)
				{
					$result = $this->_api->deleteVM($mac);
					$this->log("Deleted VPS $mac on cancellation");
				}
			}
			catch (Exception $e) {
				$this->log('Error deleteing VPS $mac on cancellation: '.$e->getException() );
				return false;
			}
		}

		return true;
	}
	
	public function Suspend()
	{
		return parent::Suspend();
	}
	
	public function Unsuspend()
	{
		return parent::Unsuspend();
	}
}
