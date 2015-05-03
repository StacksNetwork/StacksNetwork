<div id="">
    <ul class="breadcrumb-nav" style="margin-top:10px;">
        <li><a href="#" class="active disabled" onclick="load_onapp_section('provisioning')">供应</a></li>
        <li><a href="#" class="disabled" onclick="load_onapp_section('resources')">资源</a></li>
        <li><a href="#" class="disabled" onclick="load_onapp_section('ostemplates')">OS模板</a></li>
        <li><a href="#" class="disabled" onclick="load_onapp_section('storage')">存储/快照</a></li>
        <li><a href="#" class="disabled" onclick="load_onapp_section('network')">网络</a></li>
        <li><a href="#" class="disabled" onclick="load_onapp_section('misc')">其它</a></li>
        <li><a href="#" class="disabled" onclick="load_onapp_section('finish')">完成</a></li>
    </ul>
    <div style="margin-top:-1px;border: solid 1px #DDDDDD;padding:10px;margin-bottom:10px;background:#fff" id="onapptabcontainer">
        <div class="onapptab" id="provisioning_tab">
            {include file="../../../includes/modules/Hosting/cloudstack2/productconf/config_provisioning.tpl"}
        </div>
        <div class="onapptab form" id="resources_tab">
            {include file="../../../includes/modules/Hosting/cloudstack2/productconf/config_resources.tpl"}
        </div>
        <div class="onapptab form" id="ostemplates_tab">
            {include file="../../../includes/modules/Hosting/cloudstack/productconf/config_ostemplates.tpl"}
        </div>
        <div class="onapptab form" id="storage_tab">
            {include file="../../../includes/modules/Hosting/cloudstack/productconf/config_storage.tpl"}
            {include file="../../../includes/modules/Hosting/cloudstack2/productconf/config_storage.tpl"}
        </div>
        <div class="onapptab form" id="network_tab">
            {include file="../../../includes/modules/Hosting/cloudstack/productconf/config_network.tpl"}
        </div>
        <div class="onapptab form" id="misc_tab">
            {include file="../../../includes/modules/Hosting/cloudstack2/productconf/config_misc.tpl"}
        </div>
        <div class="onapptab form" id="finish_tab">
            <table border="0" cellspacing="0" width="100%" cellpadding="6">
                <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> 从CloudStack项目获取数据, 请稍候...</td></tr>
                <tr>
                    <td valign="top" width="160" style="border-right:1px solid #E9E9E9">
                        <h4 class="finish">完成</h4>
                        <span class="fs11" style="color:#C2C2C2">保存 &amp; 开始销售</span>
                    </td>
                    <td valign="top">
                        准备购买您的CloudStack项目套餐. <br/>
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
    $('.odesc_').hide();
    $('.odesc_cloud_vm').show();
</script> 
