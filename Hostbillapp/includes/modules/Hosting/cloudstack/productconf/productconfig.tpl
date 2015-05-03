<div id="">
    <ul class="breadcrumb-nav" style="margin-top:10px;">
        <li><a href="#" class="active disabled" onclick="load_onapp_section('provisioning')">Provisioning</a></li>
        <li><a href="#" class="disabled" onclick="load_onapp_section('resources')">Resources</a></li>
        <li><a href="#" class="disabled" onclick="load_onapp_section('ostemplates')">OS Templates</a></li>
        <li><a href="#" class="disabled" onclick="load_onapp_section('storage')">Storage / Snapshot</a></li>
        <li><a href="#" class="disabled" onclick="load_onapp_section('network')">Network</a></li>
        <li><a href="#" class="disabled" onclick="load_onapp_section('misc')">Misc</a></li>
        <li><a href="#" class="disabled" onclick="load_onapp_section('finish')">Finish</a></li>
    </ul>
    <div style="margin-top:-1px;border: solid 1px #DDDDDD;padding:10px;margin-bottom:10px;background:#fff" id="onapptabcontainer">
        <div class="onapptab" id="provisioning_tab">
            {include file="../../../includes/modules/Hosting/cloudstack/productconf/config_provisioning.tpl"}
        </div>
        <div class="onapptab form" id="resources_tab">
            {include file="../../../includes/modules/Hosting/cloudstack/productconf/config_resources.tpl"}
        </div>
        <div class="onapptab form" id="ostemplates_tab">
            {include file="../../../includes/modules/Hosting/cloudstack/productconf/config_ostemplates.tpl"}
        </div>
        <div class="onapptab form" id="storage_tab">
            {include file="../../../includes/modules/Hosting/cloudstack/productconf/config_storage.tpl"}
        </div>
        <div class="onapptab form" id="network_tab">
            {include file="../../../includes/modules/Hosting/cloudstack/productconf/config_network.tpl"}
        </div>
        <div class="onapptab form" id="misc_tab">
            {include file="../../../includes/modules/Hosting/cloudstack/productconf/config_misc.tpl"}
        </div>
        <div class="onapptab form" id="finish_tab">
            <table border="0" cellspacing="0" width="100%" cellpadding="6">
                <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from CloudStack, please wait...</td></tr>
                <tr>
                    <td valign="top" width="160" style="border-right:1px solid #E9E9E9">
                        <h4 class="finish">Finish</h4>
                        <span class="fs11" style="color:#C2C2C2">Save &amp; start selling</span>
                    </td>
                    <td valign="top">
                        Your CloudStack package is ready to be purchased. <br/>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>
<link href="../includes/modules/Hosting/cloudstack/productconf/config_style.css" rel="stylesheet" media="all" />
<script type="text/javascript" src="../includes/modules/Hosting/cloudstack/productconf/config_script.js"></script>

<script type="text/javascript">
    {if $_isajax}
    setTimeout('append_onapp()', 50);
    {else}
    appendLoader('append_onapp');
    {/if}
</script> 
