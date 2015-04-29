{literal}
<style>
  .menuzord-tabs {
  width: 100%;
  float: left;
  }
#appstab {
width: 20%;
}
.rich_row .integration_box p {
text-align: center;
margin-top: 0px;
width: 95%;
}
.rich_row .integration_box a{
color: #197ea8;
}
.menuzord-tabs-nav li.active a, .menuzord-tabs-nav li:hover a {
background: #f0f0f0;
}
.menuzord-tabs-content {
  width: 78%;
  float:right;
}
.menuzord-tabs-nav {
width: 20%;
margin: 0;
padding: 0;
float: left;
list-style: none;
}
#appstab li a {
width: 225px;
}
.menuzord-tabs-nav > li > a {
border: none;
}
.rich_row .integration_box {
width: 120px;
background: #fff;
border: 1px solid #eeeeee;
border-radius: 3px;
float: left;
font-size: 12px;
margin: 10px 0 0 10px;
line-height: normal;
vertical-align: middle;
text-align: center;
height: 80px;
}
.rich_row .integration_box .img_box:before {
        content: ' ';
        display: inline-block;
        vertical-align: middle;
        height: 100%;
}

.megamenu .rich_row .integration_box {
margin: 10px 0 0 5px;
}
.menuzord-tabs-nav > li > a {
width: 100%;
padding: 7px 16px;
float: left;
font-size: 13px;
text-decoration: none;
color: #666;
outline: 0;
}
.menuzord-tabs-nav li a {
cursor: pointer;
}
.rich_row .integration_box img {
border: none;
max-width: 100px;
max-height: 40px;
margin-left: 0px;
}
.rich_row .integration_box .img_box {
height: 40px;
margin-top: 6px;
}
.menuzord-tabs-nav {
padding-right: 20px;
border-right: 1px dotted #999;
}
</style>

<script>
  function showhideitem(clss,el) {

    $('.'+clss).hide().eq(el).show();
    return false;
  }

</script>
{/literal}
        <link href="{$template_dir}css/font-awesome.min.css?v={$hb_version}" rel="stylesheet" media="all" />
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
  <tr>
      <td colspan="2" ><br/></td>
  </tr>
  <tr>
    <td class="leftNav">
        <h3>Paid Apps</h3>
         </td>
    <td  valign="top"  class="bordered"><div id="bodycont">
	 <div class="newhorizontalnav" id="newshelfnav">
<div class="list-1">
<ul>
  <li class="list-1elem active picked"><a href="#" onclick="return showhideitem('howhideitems',0);">Available Addons</a></li>
  </ul>
</div>
</div>


            <div id="ticketbody" style="padding:15px;background:#F5F9FF">
            
            <div class="howhideitems">




                <!--- BOF: PAID APPS -->
                <div class="megamenu none" style="right: 0px; display: block;">
                    <div class="megamenu-row">
                        <div class="menuzord-tabs">
                            <ul class="menuzord-tabs-nav" id="appstab">
                                <li class="active" data-submenu-id="0"><a>New Apps</a></li>
                                <li  data-submenu-id="1"><a>Apps</a></li>
                                <li data-submenu-id="2"><a>Hosting Integrations</a></li>
                                <li data-submenu-id="3"><a>Client Portals</a></li>
                                <li data-submenu-id="4"><a>Order Pages</a></li>
                            </ul>

                            <div class="menuzord-tabs-content" style="display: block;">
                                <h4>Updated: January 2015</h4>
                                <div class="rich_row">
                                    <div class="integration_box"><a href="http://hostbillapp.com/products/xero-com-accounting/">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/xero.png">
                                            </div><p><span class="int_gray">Xero.com</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/products/quickbooks-online-accounting/">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/quickbooks.png">
                                            </div><p><span class="int_gray">Quickbooks Online</span></p></a>
                                    </div>
                                </div>
                                <div style="clear:both"></div>
                                <h4>Updated: December 2014</h4>
                                <div class="rich_row">
                                    <div class="integration_box"><a href="http://hostbillapp.com/products/provisioning-apps/kerio-connect/">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/kerio.png">
                                            </div><p><span class="int_gray">Kerio Connect</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/products/provisioning-apps/zimbra/">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/zimbra.png">
                                            </div><p><span class="int_gray">Zimbra</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/proxmox.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/proxmox.png">
                                            </div><p><span class="int_gray">Proxmox VE</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/viesvateu/index.html">
                                            <div class="img_box"><i class="icon-money icon-3x"></i>
                                            </div><p><span class="int_gray">VIES VAT EU Plugin </span></p></a>
                                    </div>

                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/supportfields/index.html">
                                            <div class="img_box"><i class="icon-support icon-3x"></i>
                                            </div><p><span class="int_gray">Support Fields</span></p></a>
                                    </div>
                                </div>
                                <div style="clear:both"></div>
                                <h4>Updated: Novemver 2014</h4>
                                <div class="rich_row">
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/cpanel.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/cpanel.png">
                                            </div><p><span class="int_gray">Cpanel</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/directadmin.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/directadmin.png">
                                            </div><p><span class="int_gray">DirectAdmin</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/plesk.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/plesk.png">
                                            </div><p><span class="int_gray">Plesk</span></p></a>
                                    </div>

                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/ovhdedicated/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/ovh.png">
                                            </div><p><span class="int_gray">OVH Dedicated <br>Servers</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/boxcom/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/box.png">
                                            </div><p><span class="int_gray">Box.com</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/pleskautomation.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/plesk_automation.png">
                                            </div><p><span class="int_gray">Plesk Automation</span></p></a>
                                    </div>
                                </div>

                            </div>
                            <div class="menuzord-tabs-content" style="display: none;">
                                <div class="rich_row">
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/colocationv5/">
                                            <div class="img_box"><i class="icon-database icon-3x"></i>
                                            </div><p><span class="int_gray">Dedicated Server /Collocation Manager</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/ipam/">
                                            <div class="img_box"><i class="icon-sitemap icon-3x"></i>
                                            </div><p><span class="int_gray">IPAM – IP Address Management Plugin </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/inventory/">
                                            <div class="img_box"><i class="icon-edit icon-3x"></i>
                                            </div><p><span class="int_gray">Inventory/Asset Manager </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/cloudmonitoring/">
                                            <div class="img_box"><i class="icon-cloud icon-3x"></i>
                                            </div><p><span class="int_gray">CloudMonitoring Plugin </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/statusupdates/index.html">
                                            <div class="img_box"><i class="icon-bell icon-3x"></i>
                                            </div><p><span class="int_gray">Srv/Service/Network Status Updates </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/livechat/">
                                            <div class="img_box"><i class="icon-wechat icon-3x"></i>
                                            </div><p><span class="int_gray">HBChat – HostBill LiveChat </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/smsverification/index.html">
                                            <div class="img_box"><i class="icon-mobile-phone icon-3x"></i>
                                            </div><p><span class="int_gray">SMS Verification </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/password_manager/index.html">
                                            <div class="img_box"><i class="icon-lock icon-3x"></i>
                                            </div><p><span class="int_gray">Password Manager </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/migrationmanager/index.html">
                                            <div class="img_box"><i class="icon-arrows-h icon-3x"></i>
                                            </div><p><span class="int_gray">Migration Manager </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/duosecurity/index.html">
                                            <div class="img_box"><i class="icon-unlock icon-3x"></i>
                                            </div><p><span class="int_gray">DuoSecurity.com – two factor auth</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/cartsuggestions/index.html">
                                            <div class="img_box"><i class="icon-shopping-cart icon-3x"></i>
                                            </div><p><span class="int_gray">Cart Suggestions</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/quote/index.html">
                                            <div class="img_box"><i class="icon-bars icon-3x"></i>
                                            </div><p><span class="int_gray">Auotmated Quote Generator </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/endofshift/index.html">
                                            <div class="img_box"><i class="icon-calendar-o icon-3x"></i>
                                            </div><p><span class="int_gray">End Of Shift Report </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/prioritysupport/index.html">
                                            <div class="img_box"><i class="icon-bar-chart icon-3x"></i>
                                            </div><p><span class="int_gray">Priority Support </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/supportfields/index.html">
                                            <div class="img_box"><i class="icon-support icon-3x"></i>
                                            </div><p><span class="int_gray">Support Fields</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/autologinshare/index.html">
                                            <div class="img_box"><i class="icon-share-alt icon-3x"></i>
                                            </div><p><span class="int_gray">AutoLogin Share  </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/bugtracker/index.html">
                                            <div class="img_box"><i class="icon-bug icon-3x"></i>
                                            </div><p><span class="int_gray">Simple Bugtracker Module </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/viesvateu/index.html">
                                            <div class="img_box"><i class="icon-money icon-3x"></i>
                                            </div><p><span class="int_gray">VIES VAT EU Plugin </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/products/xero-com-accounting/">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/xero.png">
                                            </div><p><span class="int_gray">Xero.com</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/products/quickbooks-online-accounting/">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/quickbooks.png">
                                            </div><p><span class="int_gray">Quickbooks Online</span></p></a>
                                    </div>
                                </div>
                            </div>
                            <div class="menuzord-tabs-content" style="display: none;">
                                <div class="rich_row">
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/onapp.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/onapp.png">
                                            </div><p><span class="int_gray">OnApp</span></p></a>
                                    </div>

                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/cloudstack.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/cloudstack.png">
                                            </div><p><span class="int_gray">Cloudstack</span></p></a>
                                    </div>

                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/openstack/">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/openstack.png">
                                            </div><p><span class="int_gray">OpenStack</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/freeradius.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/freeradius.png">
                                            </div><p><span class="int_gray">freeRADIUS</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/powerdns.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/powerdns.png">
                                            </div><p><span class="int_gray">PowerDNS</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/observium.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/observium.png">
                                            </div><p><span class="int_gray">Observium</span></p></a>
                                    </div>

                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/cacti.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/cacti.png">
                                            </div><p><span class="int_gray">Cacti</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/cpanel.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/cpanel.png">
                                            </div><p><span class="int_gray">Cpanel</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/products/provisioning-apps/interworx/">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/interworx.png">
                                            </div><p><span class="int_gray">InterWorx</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/products/provisioning-apps/h-sphere/">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/hsphere.png">
                                            </div><p><span class="int_gray">H-Sphere</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/directadmin.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/directadmin.png">
                                            </div><p><span class="int_gray">DirectAdmin</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/solusvm.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/solusvm.png">
                                            </div><p><span class="int_gray">SolusVM</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/products/provisioning-apps/websitepanel/">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/websitepanel.png">
                                            </div><p><span class="int_gray">Websitepanel</span><br></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/plesk.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/plesk.png">
                                            </div><p><span class="int_gray">Plesk</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/vpsnet.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/vpsnet.png">
                                            </div><p><span class="int_gray">VPS.net</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/products/provisioning-apps/ahsay-backup/">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/ahsay.png">
                                            </div><p><span class="int_gray">Ahsay Backup</span><br></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/products/provisioning-apps/hypervm/">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/hypervm.gif">
                                            </div><p><span class="int_gray">HyperVM</span><br></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/virtuozzo_pva.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/virtuozzo.png">
                                            </div><p><span class="int_gray">Virtuozzo PVA</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/vmware5.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/vmware.png">
                                            </div><p><span class="int_gray">VMWare vSphere 5</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/products/provisioning-apps/ispmanager/">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/ispmanager.png">
                                            </div><p><span class="int_gray">ISPManager</span><br></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/cakemail.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/cakemail.png">
                                            </div><p><span class="int_gray">CakeMail</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/onappcdn.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/onapp.png">
                                            </div><p><span class="int_gray">OnApp CDN</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/products/provisioning-apps/virtuozzo/">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/virtuozzo.png">
                                            </div><p><span class="int_gray">Virtuozzo</span><br></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/onappbalancers.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/onapp.png">
                                            </div><p><span class="int_gray">OnApp Load Balancers</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/products/provisioning-apps/virtualmin/">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/virtualmin.png">
                                            </div><p><span class="int_gray">Virtualmin</span><br></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/onappreseller.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/onapp.png">
                                            </div><p><span class="int_gray">OnApp Reseller</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/opensrstrust.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/opensrs.png">
                                            </div><p><span class="int_gray">OpenSRS SSL</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/cpaneldns.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/cpanel.png">
                                            </div><p><span class="int_gray">cPanel DNS</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/enomssl.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/enom.png">
                                            </div><p><span class="int_gray">Enom SLL</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/thesslstore.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/sslstore.png">
                                            </div><p><span class="int_gray">The SSL Store</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/onappdns.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/onapp.png">
                                            </div><p><span class="int_gray">OnApp DNS</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/cpanel_manage2.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/cpanel.png">
                                            </div><p><span class="int_gray">Cpanel Manage2</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/xenserver.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/xen.png">
                                            </div><p><span class="int_gray">Citrix XenServer</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/rackspacecloud.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/rackspace.png">
                                            </div><p><span class="int_gray">Rackspace Cloud</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/globalsignvoucher.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/globalsign.png">
                                            </div><p><span class="int_gray">GlobalSign OneClick SSL</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/vcloud.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/vcloud.png">
                                            </div><p><span class="int_gray">vCloud Director</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/proxmox.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/proxmox.png">
                                            </div><p><span class="int_gray">Proxmox VE</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/servertasticssl.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/servertastic.png">
                                            </div><p><span class="int_gray">ServerTastic SSL</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/manualssl.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/manualssl.png">
                                            </div><p><span class="int_gray">Manual SSL</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/products/provisioning-apps/noc-ps/">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/nocps.png">
                                            </div><p><span class="int_gray">Noc PS</span><br></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/buycpanel.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/buycpanel.png">
                                            </div><p><span class="int_gray">Buycpanel.com</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/pingdom/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/pingdom.png">
                                            </div><p><span class="int_gray">Pingdom</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://bytecp.com/">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/bytecp.png">
                                            </div><p><span class="int_gray">ByteCP</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/cloudflare/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/cloudflare.png">
                                            </div><p><span class="int_gray">Cloudflare</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/gogetssl.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/gogetssl.png">
                                            </div><p><span class="int_gray">GoGetSSL.com</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/cloudmonitoring/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/manualssl.png">
                                            </div><p><span class="int_gray">CloudMonitoring</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/virtualizor/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/virtualizor.gif">
                                            </div><p><span class="int_gray">Virtualizor</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/owncloud/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/owncloud.png">
                                            </div><p><span class="int_gray">OwnCloud</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/digitalocean/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/digitalocean.png">
                                            </div><p><span class="int_gray">DigitalOcean</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/idera/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/idera.png">
                                            </div><p><span class="int_gray">Idera Server Backup</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/splv1/features/amazon_ec2/">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/amazon.png">
                                            </div><p><span class="int_gray">Amazon EC2</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/onapp-smartservers/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/onapp.png">
                                            </div><p><span class="int_gray">OnApp Smart Servers</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/ovhdedicated/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/ovh.png">
                                            </div><p><span class="int_gray">OVH Dedicated <br>Servers</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/boxcom/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/box.png">
                                            </div><p><span class="int_gray">Box.com</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/apps/pleskautomation.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/plesk_automation.png">
                                            </div><p><span class="int_gray">Plesk Automation</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/products/provisioning-apps/kerio-connect/">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/kerio.png">
                                            </div><p><span class="int_gray">Kerio Connect</span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/products/provisioning-apps/zimbra/">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/integration_icons/zimbra.png">
                                            </div><p><span class="int_gray">Zimbra</span></p></a>
                                    </div>
                                </div>

                            </div>

                            <div class="menuzord-tabs-content" style="display: none;">
                                <div class="rich_row">
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/clientarea/yservers">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/clientareas_thumbs/thumb_08.png">
                                            </div><p><span class="int_gray">Y-Server Theme </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/gallery/clientarea_cloudy/index.html" class="swf_gallery">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/clientareas_thumbs/thumb_03.png">
                                            </div><p><span class="int_gray">Cloudy Theme </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/gallery/clientarea_flatui/index.html" class="swf_gallery">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/clientareas_thumbs/thumb_01.png">
                                            </div><p><span class="int_gray">FlatUI Theme </span></p></a>
                                    </div>


                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/nextgenclean/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/clientareas_thumbs/thumb_06.png">
                                            </div><p><span class="int_gray">NextGen Clean </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/gallery/clientarea_fullpanel/index.html" class="swf_gallery">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/clientareas_thumbs/thumb_04.png">
                                            </div><p><span class="int_gray">FullPanel Theme </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/gallery/clientarea_metrobill/index.html" class="swf_gallery">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/clientareas_thumbs/thumb_02.png">
                                            </div><p><span class="int_gray">MetroBill Theme </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/gallery/clientarea_modernpanel/index.html" class="swf_gallery">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/clientareas_thumbs/thumb_05.png">
                                            </div><p><span class="int_gray">Modern Panel </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/gallery/clientarea_sidepad/index.html" class="swf_gallery">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/clientareas_thumbs/thumb_07.png">
                                            </div><p><span class="int_gray">SidePad Theme </span></p></a>
                                    </div>
                                </div>


                            </div>
                            <div class="menuzord-tabs-content" style="display: none;">
                                <div class="rich_row">
                                    <div class="integration_box"><a href="http://hostbillapp.com/gallery/orderpage_cloudorder/index.html" class="swf_gallery">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_41.png">
                                            </div><p><span class="int_gray">Cloud Order, One Step </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/gallery/orderpage_cloudslider/index.html" class="swf_gallery">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_03.png">
                                            </div><p><span class="int_gray">Cloud Slider, One-Step orderpage </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/triplebox/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_15.png">
                                            </div><p><span class="int_gray">Triple Box, One Step </span></p></a>
                                    </div>

                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/enomssl/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_09.png">
                                            </div><p><span class="int_gray">Enom SSL Order </span></p></a>
                                    </div>

                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/simpleboxes/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_10.png">
                                            </div><p><span class="int_gray">Simple Boxes </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/gallery/orderpage_listingandmore/index.html" class="swf_gallery">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_21.png">
                                            </div><p><span class="int_gray">Listing and More Info </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/proorder/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_01.png">
                                            </div><p><span class="int_gray">Dedicated Servers Pro-Order Form </span></p></a>
                                    </div>

                                    <div class="integration_box"><a href="http://hostbillapp.com/gallery/orderpage_packagesliders/index.html" class="swf_gallery">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_16.png">
                                            </div><p><span class="int_gray">Package sliders, One Step </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/gallery/orderpage_coverflow/index.html" class="swf_gallery">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_42.png">
                                            </div><p><span class="int_gray">Coverflow, One Step </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/gallery/orderpage_stepslider/index.html" class="swf_gallery">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_20.png">
                                            </div><p><span class="int_gray">Step wizard slider </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/gallery/orderpage_tableboxes/index.html" class="swf_gallery">
                                            <div class="img_box"><img src="https://hostbillapp.com/features/tour/onestep_table_boxes/pictures/v1.png">
                                            </div><p><span class="int_gray">Table Boxes, Wizard Theme </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/gallery/orderpage_premadesliders/index.html" class="swf_gallery">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_53.png">
                                            </div><p><span class="int_gray">Premade Sliders, One Step </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/gallery/orderpage_circularsliders/index.html" class="swf_gallery">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_07.png">
                                            </div><p><span class="int_gray">Circular Slider, One Step </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/gallery/orderpage_fancy/index.html" class="swf_gallery">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_05.png">
                                            </div><p><span class="int_gray">Fancy Order-Page, One Step </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/gallery/orderpage_handdrawn/index.html" class="swf_gallery">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_46.png">
                                            </div><p><span class="int_gray">Hand-Drawn Checkout, One Step </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/gallery/orderpage_flexibleboxes/index.html" class="swf_gallery">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_40.png">
                                            </div><p><span class="int_gray">Flexible Height Boxes </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/gallery/orderpage_accordion/index.html" class="swf_gallery">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_49.png">
                                            </div><p><span class="int_gray">Accordion, Wizard Theme </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/gallery/orderpage_charttable/index.html" class="swf_gallery">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_38.png">
                                            </div><p><span class="int_gray">Chart Table, One Step </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/gallery/orderpage_bootstrapsliders/index.html" class="swf_gallery">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_14.png">
                                            </div><p><span class="int_gray">Bootstrap Sliders, One Step </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/vpshardware/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_54.png">
                                            </div><p><span class="int_gray">VPS Hardware, One-step orderpage </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/gallery/orderpage_fourcomparison/index.html" class="swf_gallery">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_47.png">
                                            </div><p><span class="int_gray">Four Comparison Boxes, One Step </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/post/1410496452/hostbill_one_step_order_page.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/box-icon2.png">
                                            </div><p><span class="int_gray">OneStep 5-Box Compare Orderpage </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/gallery/orderpage_dedicated/index.html" class="swf_gallery">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_08.png">
                                            </div><p><span class="int_gray">Dedicated Servers Full-screen (2) </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/gallery/orderpage_comparisonflat/index.html" class="swf_gallery">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_43.png">
                                            </div><p><span class="int_gray">Flat comparison boxes, One-step </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/gallery/orderpage_lightweight/index.html" class="swf_gallery">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_13.png">
                                            </div><p><span class="int_gray">Lightweight &amp; Fast </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/onestep_sketchhardware/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_02.png">
                                            </div><p><span class="int_gray">Sketch Hardware, One Step </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/gallery/orderpage_metroboxes/index.html" class="swf_gallery">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_55.png">
                                            </div><p><span class="int_gray">Metro Boxes, One Step </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/squareboxes/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com///hostbillapp.com/features/tour/squareboxes/pictures/v1.png">
                                            </div><p><span class="int_gray">Square Boxes, One Step </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/cart_circlechart/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_06.png">
                                            </div><p><span class="int_gray">Circle Chart, Wizard Theme </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/fancyfour/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_22.png">
                                            </div><p><span class="int_gray">Fancy Four Comparison Boxes, Wizard Theme </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/gaugesliders/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_39.png">
                                            </div><p><span class="int_gray">Gauge Sliders, One-step </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/cart_rotatebox/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_12.png">
                                            </div><p><span class="int_gray">Rotate Boxes, Wizard Theme </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/bookshelf/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_19.png">
                                            </div><p><span class="int_gray">Bookshelf, Wizard Theme </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/cart_scrolledlist/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_27.png">
                                            </div><p><span class="int_gray">Scrolled List, Wizard Theme </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/simpleslider/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_17.png">
                                            </div><p><span class="int_gray">Simple Slider, Wizard Theme </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/ssloverd/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_52.png">
                                            </div><p><span class="int_gray">SSL Certificates Overd (Version 2) </span></p></a>
                                    </div>

                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/onestep_rainboxes/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_11.png">
                                            </div><p><span class="int_gray">Rain Boxes, One Step </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/listwizard/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_23.png">
                                            </div><p><span class="int_gray">List Wizard Theme </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/onestep_checkoutboxes/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_48.png">
                                            </div><p><span class="int_gray">Checkout Boxes Slider, One Step </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/comparisontable/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_18.png">
                                            </div><p><span class="int_gray">Comparison Table (Three Plans) </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/cart_flipcover/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_25.png">
                                            </div><p><span class="int_gray">Flip Cover, Wizard Theme </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/volumeslider/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_37.png">
                                            </div><p><span class="int_gray">Volume slider, One Step </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/doubleslider/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_26.png">
                                            </div><p><span class="int_gray">Double Slider, Wizard Theme </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/fancysliderboxes/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_04.png">
                                            </div><p><span class="int_gray">Fancy Slider, Wizard Theme with Boxes </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/onestep_checkout/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_50.png">
                                            </div><p><span class="int_gray">Simple Checkout, Full Screen </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/smallboxes/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_44.png">
                                            </div><p><span class="int_gray">Small comparison boxes </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/listboxes/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_33.png">
                                            </div><p><span class="int_gray">List Boxes, Wizard Theme </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/comparisonboxesfull/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_28.png">
                                            </div><p><span class="int_gray">Comparison Boxes, Full Screen </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/box-icon2.png">
                                            </div><p><span class="int_gray">OneStep Comparison </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/onestep_pulse/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_51.png">
                                            </div><p><span class="int_gray">Pulse Hardware, One step </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/sliders/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_45.png">
                                            </div><p><span class="int_gray">Premade Sliders, Wizard Theme </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/modernsliders/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_32.png">
                                            </div><p><span class="int_gray">Modern Sliders, One Step </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/onestep_darkbootstrap/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_35.png">
                                            </div><p><span class="int_gray">Dark Bootstrap Full-screen, One-step </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/metered/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_30.png">
                                            </div><p><span class="int_gray">Metered Plan </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/onestep_livecloud/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_24.png">
                                            </div><p><span class="int_gray">Live Cloud, One Step </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/cart_foldingbox/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_31.png">
                                            </div><p><span class="int_gray">Folding Box, Wizard Theme </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/smartwizard/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_36.png">
                                            </div><p><span class="int_gray">Smart Wizard, Wizard Theme </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/fancyslider/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_34.png">
                                            </div><p><span class="int_gray">Fancy Slider, Wizard Theme </span></p></a>
                                    </div>
                                    <div class="integration_box"><a href="http://hostbillapp.com/features/tour/onestep_lato/index.html">
                                            <div class="img_box"><img src="https://hostbillapp.com/image/orderpages_thumbs/thumb_29.png">
                                            </div><p><span class="int_gray">Lato FullScreen </span></p></a>
                                    </div>
                                </div>

                            </div>
                        </div>

                    </div>
                </div>

                <!--- EOF: PAID APPS -->
                        <div style="clear:both"></div>
            </div>

            <div class="howhideitems" style="display:none">

<script type="text/javascript">
                        {literal}
                            

   jQuery(document).ready(function(){  
        var $menu2 =jQuery("#appstab");
        $menu2.menuAim({
            activate: activateSubmenu,
            deactivate: deactivateSubmenu
     });
        function activateSubmenu(row) {
            var $row = jQuery(row),
                $parent = $row.parents('.menuzord-tabs').eq(0),
                submenuId = $row.data("submenuId"),
                $submenu = jQuery('.menuzord-tabs-content',$parent).hide().eq(submenuId);
                $submenu.show();

                jQuery('.menuzord-tabs-nav > li',$parent).removeClass('active');
                $row.addClass("active");
        }

        function deactivateSubmenu(row) {
            var $row = jQuery(row),
                $parent = $row.parents('.menuzord-tabs').eq(0),
                submenuId = $row.data("submenuId"),
                $submenu = jQuery('.menuzord-tabs-content',$parent).eq(submenuId);
                $submenu.hide();
                $row.removeClass("active");
        }
   });

                            function LatestModules() {
                                $.get("?cmd=managemodules&action=getlatest", {}, function(data) {
                                    var r = parse_response(data);
                                    if (r) {
                                        $('#loadme').fadeOut('fast', function() {
                                            $(this).html(r).fadeIn('fast');
                                        });
                                    } else {
                                        $('#latest_additions').fadeOut();
                                    }
                                });
                            }
                            appendLoader('LatestModules');
                        {/literal}
                    </script>



                  </div>
{literal}
<style>
            
.stepsh3 h3 {
   display:block;
   clear:both;
   font-size:18px !important;
}    


</style>
{/literal}