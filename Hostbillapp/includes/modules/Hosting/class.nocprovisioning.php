<?php
/**
 * NOC-PS Hostbill module, version 0.1
 *
 * Copyright (C) Maxnet 2011
 *
 * May be distributed under the terms of the LGPL license.
 * In plain English: feel free to use and modify this file to fit your needs,
 * however do NOT ioncube encode it.
 * The source code must be available to anyone you distribute this module to.
 */


class Nocprovisioning extends VPSModule /*HostingModule*/
{
	protected $description = "NOC-PS dedicated server management";
	protected $version     = "1.0.5";
	
	protected $lang = array(
		'english' => array(
			'Power'             => "Power control",
			'Provision'         => "Provision server",
			'ProvisionStatus'   => "Provisioning status",
			'Datatraffic'       => "Data traffic",
			'rebootmethod'      => "Reboot method",
			'producttype'       => "Product type",
			'poolfrom'          => "If product type is automatic: take server FROM pool - select available servers pool",
			'poolto'            => "Move server TO pool after assignment",
			'bandwidthunit'     => "Bandwidth billing unit",
			'powerdown_on_suspend' => "Power down server on suspend (warning: can corrupt file system)",
			'powerdown_on_delete'  => "Power down server on service cancellation",
			'ERR_UNKNOWN_SERVER'=> "Server is not listed in NOC-PS database"
		)
	);
	
	protected $serverFields = array(
		'ip'           => true,
		'username'     => true,
		'password'     => true,
		'ssl'          => false, /* We ALWAYS use SSL, so do not ask the user if he wants it */
		'status_url'   => false,
		'hostname'     => false,
		'maxaccounts'  => false,
		'hash'         => false
    );
	
	protected $commands       = array('Create','Terminate','Suspend','Unsuspend');
	protected $clientCommands = array();
	
	protected $details        = array();
	protected $options        = array(
		'rebootmethod' => array(
			'name'  => 'rebootmethod',
			'value' => '',
			'type'  => 'select',
			'default' => array(
				array('ipmi',"IPMI (ask user for password)"),
				array('auto',"Automatic (using stored passwords)"),
				array('manual',"Manual (reboots done outside of panel)")
			)
		),
		'producttype' => array(
			'name' => 'producttype',
			'value' => '',
			'type' => 'select',
			'default' => array(
				array('dedicated-manual', 'Dedicated server - manual assignment'),
				array('dedicated-auto', 'Dedicated server - automatic assignment')
			)
		),
		'poolfrom' => array(
			'name'    => 'poolfrom',
			'value'   => false,
			'type'    => 'loadable',
			'default' => 'getPools'
		),
		'poolto' => array(
			'name'    => 'poolto',
			'value'   => false,
			'type'    => 'loadable',
			'default' => 'getPools'			
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
		)		
	);
	
	/**
	 * Space seperated list of blacklist or whitelisted profiles
	 * Profiles can be specified by numeric ID, or tag (e.g. "windows")
	 */
	protected $whitelist = "";
	protected $blacklist = "";
	
	/**
	 * Set $debug to true to have error messages mailed to support@maxnet.eu
	 * for troubleshooting
	 */
	protected $debug = false;


	function __construct()
	{
		if ($this->debug)
		{
			set_error_handler(array("Nocprovisioning", "_debugErrorHandler"), E_ALL & ~E_NOTICE & ~E_DEPRECATED);
		}
		
		parent::__construct();
	}
	
	/**
	 * Test the connection by retrieving the list of available profiles
	 * Logs exact error on failure
	 *
	 * @return boolean true on success
	 */
	function testConnection()
	{
		$ok = false;
		
		try
		{
			$profiles = $this->_api->getProfileNames(0, 1);
			$ok = true;
		}
		catch (Exception $e)
		{
			$msg = $e->getMessage();
			if ($msg == "Unauthorized")
				$msg = "Username or password incorrect";
			$this->addError("Error communicating with NOC-PS server (on port 443): $msg" );
		}
		
		return $ok;
    }
	
	function Create()
	{
		if ($this->options['producttype']['value'] == "dedicated-auto")
		{
			$poolfrom = intval($this->options['poolfrom']['value']);
			$poolto = intval($this->options['poolto']['value']);
			
			if ($poolfrom == $poolto)
			{
				$this->addError("'From' pool should not be the same as 'to' pool");
				return false;
			}
			
			$mac = $this->_api->popFromPool($poolfrom, $poolto);
			if (!$mac)
			{
				$this->addError("Automatic provisioning failed: No available servers in pool");
				return false;
			}
			
			$hostinfo = $this->_api->getHost($mac);
			$ip = $hostinfo['ip'];
			$this->mainIP = $ip;
			$this->account_details['vpsip'] = $ip;
			$this->vpstype = 'Other';			
		}
		
		return true;
	}
	
	/**
	 * All power control functionality
	 */
	function getPower()
	{
		$this->_setNonce();
		$ip     = $this->account_details['vpsip'];
		$mac    = $this->mac();
		$rebootmethod = $this->options['rebootmethod']['value'];
		$password = isset($_POST['ipmipassword']) ? $_POST['ipmipassword'] : '';
		$result = "";

		if ($rebootmethod == "manual")
			return array('errormsg' => "Power management not enabled (reboot method set to manual)");

		if ( !empty($_POST['poweraction']) && $this->_verifyNonce() )
		{
			try
			{
				if ($rebootmethod == 'ipmi' && !$password)
					return array('errormsg' => "Enter your server's IPMI password");
				
				$result = $this->_api->powercontrol($mac, $_POST['poweraction'], $password, $rebootmethod);
				$this->log("Power management action '".$_POST['poweraction']."' - $result - MAC $mac");
			}
			catch (Exception $e)
			{
				$result = "ERROR: ".$e->getMessage();
			}
		}

		$actionsString = '';
		if ($mac)
		{
			try
			{
				if ($rebootmethod == 'ipmi' && !$password)
				{
					$status        = 'unknown';
					$actionsString = 'on off reset cycle';
				}
				else
				{
					$status           = $this->_api->powercontrol($mac, 'status', $password, $rebootmethod);
					$actionsString    = $this->_api->powercontrol($mac, 'supportedactions', $password, $rebootmethod);
					if (!$actionsString)
						return array('errormsg' => "This server does not support automatic reboots (no IPMI, AMT or reboot device associated with this server)");
				}
				
			}
			catch (Exception $e)
			{
				$status = "ERROR: ".$e->getMessage();
			}
		}
		else
		{
			$status           = $this->lang["english"]["ERR_UNKNOWN_SERVER"];
		}
		$supportedActions = explode(' ', $actionsString);
		
		return array(
			'serviceid'		=> $this->account_details['id'],
			'ip'    		=> $ip,
			'nonce' 		=> $this->_nonce(),
			'result'		=> $result,
			'status'		=> $status,
			'supportsOn'    => in_array('on', $supportedActions),
			'supportsOff'   => in_array('off', $supportedActions),
			'supportsReset' => in_array('reset', $supportedActions),
			'supportsCycle' => in_array('cycle', $supportedActions),
			'supportsCtrlAltDel' => in_array('ctrlaltdel', $supportedActions),
			'ask_ipmi_password' => ($rebootmethod == 'ipmi')
		);
	}
	
	/**
	 * All data traffic functionality
	 */
	function getDatatraffic()
	{
		$mac = $this->mac();
		/* get the number of network connections associated with the server,
		   and the time the data was first and last updated */
		$info = $this->_api->getAvailableBandwidthData($mac);
		
		/* check when the customer purchased the server, to hide traffic from previous customers */
		$regdate = strtotime($this->account_details['date_created']);
		
		/* show graphs by calendar month */
		$day     = 0;

		/* this month's graph */
		$startgraph1 = mktime(0,0,0,date('n'), $day, date('Y'));
		$endgraph1   = mktime(0,0,0,date('n')+1, $day, date('Y'));
		$startgraph1 = max($startgraph1, $info['start'], $regdate);
		$endgraph1	 = $info['last'];

		/* last month's graph */
		$startgraph2 = mktime(0,0,0,date('n')-1, $day, date('Y'));
		$endgraph2   = mktime(0,0,0,date('n'), $day, date('Y'));
		
		if ($endgraph2 < $info['start'] || $endgraph2 < $regdate)
		{
			/* we don't have data from last month */
			$startgraph2 = $endgraph2 = 0;
		}
		else
		{
			$startgraph2 = max($startgraph2, $info['start'], $regdate);
		}
		
		$currentGraphs   = array();
		$lastMonthGraphs = array();
		
		if ($endgraph1 > $startgraph1)
		{		
			for ($port = 0; $port < $info['ports']; $port++)
			{
				$currentGraphs[] = "data:image/png;base64,".$this->_api->generateBandwidthGraph(array('host' => $mac, 'port' => $port, 'start' => $startgraph1, 'end' => $endgraph1));
				
				if ($startgraph2)
					$lastMonthGraphs[] = "data:image/png;base64,".$this->_api->generateBandwidthGraph(array('host' => $mac, 'port' => $port, 'start' => $startgraph2, 'end' => $endgraph2));
			}
		}
		
		return array(
			"ports"	          => $info['ports'],
			"currentGraphs"   => $currentGraphs,
			"lastMonthGraphs" => $lastMonthGraphs
		);
	}
	
	/**
	 * AJAX status poll
	 */
	function ajaxStatusPoll($lastevent)
	{
		require_once('Zend/Json.php');
		
		// prevent session file lock
		session_write_close();
		
		// wait up to 28 seconds for new event
		$eventnr = $this->_api->longPoll($lastevent, 28);
		$status  = $this->_api->getProvisioningStatusByServer($this->mac() );
		if ($status)
			$status = '<img src="templates/default/img/ajax-loading2.gif" width=16 height=16 alt="ajax"> '.$status['statusmsg'];
		
		//echo json_encode(array('eventnr' => $eventnr, 'statusmsg' => $status));
		// Not everyone has JSON extension installed, so use Zend instead
		echo Zend_Json::encode(array('eventnr' => $eventnr, 'statusmsg' => $status));
		exit(0);
	}
	
	/**
	 * All provisioning functionality
	 */
	function getProvision()
	{
		try
		{
			$this->_setNonce();
			
			$ip    = $this->account_details['vpsip'];
			$mac   = $this->mac();
			if (!$mac)
				throw new Exception($this->lang["english"]["ERR_UNKNOWN_SERVER"]);
			$error = "";
			$rebootmethod = $this->options['rebootmethod']['value'];
			if ($rebootmethod == 'manual')
				$rebootmethod = '';
			$ipmipassword = isset($_POST['ipmipassword']) ? $_POST['ipmipassword'] : '';			
			
			if ( !empty($_POST['profile']) && $this->_verifyNonce() )
			{
				/* Never trust user input. Double check if profile is not blacklisted */
				$whitelist = array_filter(explode(' ', $this->whitelist));
				$blacklist = array_filter(explode(' ', $this->blacklist));
				$profileid = intval($_POST['profile']);
				$profile   = $this->_api->getProfile($profileid);
				$tags      = explode(' ', $profile['data']['tags']);
				
				if ( count($whitelist) && !in_array($profileid, $whitelist) && count(array_intersect($tags, $whitelist)) == 0 )
				{
					throw new Exception("Profile is not on whitelist");
				}
				else if ( count($blacklist) && ( in_array($profileid, $blacklist) || count(array_intersect($tags, $blacklist)) ))
				{
					throw new Exception("Profile is on blacklist");
				}			
				/* --- */
				if ($rebootmethod == 'ipmi' && !$ipmipassword)
					throw new Exception("Enter your server's IPMI password");					
				
		
				/* Provision server */
				$result = $this->_api->provisionHost(array(
					"mac"           => $mac,
					"hostname"		=> $_POST["hostname"],
					"profile"       => $profileid,
					"rootpassword"  => $_POST["rootpassword"],
					"rootpassword2" => $_POST["rootpassword2"],
					"adminuser"	    => $_POST["adminuser"],
					"userpassword"  => $_POST["userpassword"],
					"userpassword2" => $_POST["userpassword2"],
					"disk_addon"	=> $_POST["disklayout"],
					"packages_addon"=> $_POST["packageselection"],
					"extra_addon1"	=> $_POST["extra1"],
					"extra_addon2"  => $_POST["extra2"],
					"rebootmethod"  => $rebootmethod,
					"ipmipassword"  => $ipmipassword
				));
				
				if ($result['success'])
				{
					$n = $profile['data']['name'];
					if ($_POST['disklayout'])
						$n .= '+'.$_POST['disklayout'];
					if ($_POST['packages_addon'])	
						$n .= '+'.$_POST['packages_addon'];
					if ($_POST['extra1'])
						$n .= '+'.$_POST['extra1'];
					if ($_POST['extra2'])
						$n .= '+'.$_POST['extra2'];
					
					$this->log("Provisioning server - Profile '$n' - MAC $mac");
				}
				else
				{
					/* input validation error */
					
					foreach ($result['errors'] as $field => $msg)
					{
						$error .= $field.': '.htmlentities($msg).'<br>';
					}
					
					$this->logError("Error trying to provision - ".str_replace("<br>", " - ", $error));
				}
			}
			else if ( !empty($_POST['cancelprovisioning']) )
			{
				/* Cancel provisioning */
				$this->_api->cancelProvisioning($mac);
				$this->log("Cancelled provisioning - MAC $mac");
			}
		
			$status = $this->_api->getProvisioningStatusByServer($mac);
			
			if ($status)
			{
				/* Host is already being provisioned */
		
				return array(
					'ip'		=> $ip,
					'mac'		=> $mac,
					'nonce'     => $this->_nonce(),
					'status'    => $status
				);
			}
			else
			{
				$profiles = $this->_api->getProfileNames(0, 1000);
				$addons   = $this->_api->getProfileAddonNames(0, 1000);
				
				/* Check profile against white- and blacklist */
				$whitelist = array_filter(explode(' ', $this->whitelist) );
				$blacklist = array_filter(explode(' ', $this->blacklist) );
				
				foreach ($profiles['data'] as $k => $profile)
				{
					$tags = explode(' ', $profile['tags']);
					
					/* Check wheter the profile ID or any of its tags are on the whitelist */
					if ( count($whitelist) && !in_array($profile['id'], $whitelist) && count(array_intersect($tags, $whitelist)) == 0 )
					{
						/* not on whitelist, remove */
						unset($profiles['data'][$k]);
					}
					else if ( count($blacklist) && ( in_array($profile['id'], $blacklist) || count(array_intersect($tags, $blacklist)) ))
					{
						/* on blacklist, remove */
						unset($profiles['data'][$k]);
					}
				} 
				/* --- */
		
				require_once('Zend/Json.php');
			
				return array(
					'ip'        => $ip,
					'mac'       => $mac,
					'nonce'     => $this->_nonce(),
					'profiles'  => $profiles['data'],
					'addons_json'   => Zend_Json::encode($addons['data']),
					'profiles_json' => Zend_Json::encode( array_values($profiles['data']) ),
					'errormsg'      => $error,
					'ask_ipmi_password' => ($rebootmethod == 'ipmi')
				);
			}
		}
		catch (Exception $e)
		{
			return array(
				"errormsg" => $e->getMessage()
			);
		}		
	}
	
	protected $_api = false;
	
	/**
	 * Connect to NOC-PS server
	 *
	 * @param $p associative array with the following information:
	 * - ip OR host
	 * - username
	 * - password
	 */
	function connect($p)
	{
		try
		{
			//require_once(MAINDIR.'includes'.DS.'libs'.DS.'nocprovisioning'.DS.'nocps_api.php');
			require_once(dirname(__FILE__).'/nocprovisioning/nocps_api.php');
			$this->_api = new nocps_api( !empty($p['ip']) ? $p['ip'] : $p['host'], $p['username'], $p['password'], $this->_getUsername() );
		}
		catch (Exception $e)
		{
			$this->addError( $e->getMessage() );
		}
	}
	
	/**
	 * Returns the MAC-address of the customer's server
	 *
	 * @return string MAC-address (or empty if the order has not been associated with a server IP yet)
	 */
	protected function mac()
	{
		$ip = $this->account_details['vpsip'];
		if (!$ip)
			return "";
		
		return $this->_api->getServerByIP($ip);
	}
	
	function getPools()
	{
		$r     = array();
		$pools = $this->_api->getPools();

		foreach ($pools['data'] as $poolinfo)
		{
			$r[] = array($poolinfo['id'], $poolinfo['id'].') '.$poolinfo['name']);
		}
		
		return $r;
	}
	
	public function Suspend()
	{
		if ($this->options['powerdown_on_suspend']['value'])
		{
			try
			{
				$mac = $this->mac();
				
				if ($mac)
				{
					$result = $this->_api->powercontrol($mac, 'off', '', 'auto');
					$this->log("Powered down server $mac on suspend");
				}
			}
			catch (Exception $e) {
				$this->log('Error powering down server $mac on suspend: '.$e->getException() );
				return false;
			}
		}		
		
		return true;
	}

	public function Unsuspend()
	{
		if ($this->options['powerdown_on_suspend']['value'])
		{
			try
			{
				$mac = $this->mac();
				
				if ($mac)
				{
					$result = $this->_api->powercontrol($mac, 'on', '', 'auto');
					$this->log("Powered up server $mac on unsuspend");
				}
			}
			catch (Exception $e) {
				$this->log('Error powering up server $mac on unsuspend: '.$e->getException() );
			}
		}		
		
		return true;
	}
	
	function Terminate()
	{
		if ($this->options['powerdown_on_delete']['value'])
		{
			try
			{
				$mac = $this->mac();
				
				if ($mac)
				{
					$result = $this->_api->powercontrol($mac, 'off', '', 'auto');
					$this->log("Powered down server $mac on cancellation");
				}
			}
			catch (Exception $e) {
				$this->log('Error powering down server $mac on cancellation: '.$e->getException() );
			}
		}
		
		return true;
	}

	/*
	 * All console functionality
	 */
	function getConsole()
	{
		$this->_setNonce();
		$mac = $this->mac();
		$rebootmethod = $this->options['rebootmethod']['value'];
		$password = isset($_POST['ipmipassword']) ? $_POST['ipmipassword'] : '';
		$isVPS = isset($this->options['vcpu']);

		$info = $this->_api->getHost($mac);
		if (!$isVPS && (empty($info['ipmi_ip']) || $info['ipmi_type'] == 'v2nokvm' || $info['ipmi_type'] == 'v1'))
			return array('errormsg' => "This server does not have KVM-over-IP console functionality, or it uses technology that is not supported.");
		
		if ($rebootmethod == 'auto' || $isVPS)
		{
			$powerstate = $this->_api->powercontrol($mac, 'status', '', 'auto');
		}
		else
		{
			$powerstate = 'unknown';
		}
		
		if (count($_POST) && $this->_verifyNonce())
		{
			try
			{
				$password = !empty($_POST['ipmipassword']) ? $_POST['ipmipassword'] : '';
				
				if (!empty($_POST['powerup']))
				{
					$powerstate = $this->_api->powercontrol($mac, 'on', $password, $rebootmethod);
				}
				if (!empty($_POST['resetbmc']))
				{
					$response = $this->_api->submitIPMI(array(
						'ip' => $info['ipmi_ip'],
						'username' => $info['ipmi_user'],
						'password' => $password,
						'ipmi_type' => 'v2',
						'cmd' => 'bmc reset cold'
					));	
					
					return array('errormsg' => "Performed BMC reset. It can take a few minutes before it is available again.");
				}
				else
				{
					$url = $this->_api->getConsoleURL($mac, $password, $_SERVER['REMOTE_ADDR']);
		
					$this->log("Activated console for server $mac");
					
					header("Location: $url");
					exit();
				}
			} catch (Exception $e) {
				return array( 'errormsg' => $e->getMessage() );
			}
		}
		else
		{
			return array(
				'nonce' => $this->_nonce(),
				'mac' => $mac,
				'consoletype' => ($isVPS || $info['ipmi_type'] == 'AMT' ? 'html5' : 'jnlp'),
				'powered_off' => ($powerstate == "Halted" || $powerstate == "stopped" || strpos($powerstate, "off") !== false ),
				'ask_ipmi_password' => ($rebootmethod == 'ipmi')
			);
		}
	}
	
	/**
	 * Log message
	 *
	 * @param $msg message
	 * @param $success true if message is informational, false if it concerns an error
	 */
	protected function log($msg, $success = true)
	{
		//
		// FIXME: find the right internal hostbill method instead of accessing db directly!
		//
		$account_id = $this->account_details['id'];
		$module     = get_class($this);
		$login      = $this->_getUsername();
		$action     = 'Clientarea action';
		$manual     = 1;
		$result     = ($success ? 1 : 0);
		
		$stmt = $this->db->prepare("INSERT INTO hb_account_logs(date,account_id,admin_login,module,manual,action,`change`,result,error) VALUES (NOW(),?,?,?,?,?,'',?,?)");
		if (!$stmt->execute( array($account_id, $login, $module, $manual, $action, $result, $msg) ) )
			die( print_r($stmt->errorInfo(), true)  );
	}
	
	protected function logError($msg)
	{
		$this->log($msg, false);
	}
	
	/**
	 * Get the name of the logged in user
	 */
	protected function _getUsername()
	{
		$u = '';
		
		//
		// FIXME: find the right internal hostbill method
		//
		if ( isset($_SESSION['AppSettings']) )
		{
			if ( isset($_SESSION['AppSettings']['admin_login']) && isset($_SESSION['AppSettings']['admin_login']['username']))
				$u = $_SESSION['AppSettings']['admin_login']['username'];
			else if (isset($_SESSION['AppSettings']['login']) && isset($_SESSION['AppSettings']['login']['email']))
				$u = $_SESSION['AppSettings']['login']['email'];
		}		
		
		return $u;
	}

	/**
	 * Set Nonce against Cross-site request forgery attacks
	 */
	protected function _setNonce()
	{
		if ( empty($_SESSION['nps_nonce'] ))
			$_SESSION['nps_nonce'] = uniqid().mt_rand();		
	}

	/**
	 * @return string Nonce value set earlier
	 */
	protected function _nonce()
	{
		return $_SESSION['nps_nonce'];
	}
	
	/**
	 * @return bool true if nonce value is correct
	 */
	protected function _verifyNonce()
	{
		return (!empty($_SESSION['nps_nonce']) && !empty($_POST['nps_nonce']) && $_SESSION['nps_nonce'] == $_POST['nps_nonce']);
	}
	
	/**
	 * E-mail errors to support@maxnet.eu for troubleshooting
	 * Only gets executed when the $debug variable is set to true
	 */
	static function _debugErrorHandler($errno, $errstr, $errfile, $errline, $errcontext)
	{
		$msg = "$errno $errstr ($errfile [$errline])\n\n".print_r($errcontext, true).print_r(debug_backtrace(), true)."\n\n".print_r($GLOBALS, true);
		mail('support@maxnet.eu', 'NOC-PS Hostbill module error', $msg);
	}
}