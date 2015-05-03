<tr>
    <td id="getvaluesloader">
        {if $test_connection_result}
            <span style="margin-left: 10px; font-weight: bold;text-transform: capitalize; color: {if $test_connection_result.result == 'Success'}#009900{else}#990000{/if}">
                {$lang.test_configuration}:
                {if $lang[$test_connection_result.result]}
                    {$lang[$test_connection_result.result]}
                {else}{$test_connection_result.result}
                {/if}
                {if $test_connection_result.error}: 
                    {$test_connection_result.error}
                {/if}
            </span>
        {/if}
    </td>
    <td id="onappconfig_">
        
        <div id="">
    <ul class="breadcrumb-nav" style="margin-top:10px;">
        <li><a href="#" class="active disabled" onclick="load_onapp_section('resources')">Resources</a></li>
        <li><a href="#" class="disabled" onclick="load_onapp_section('ostemplates')">OS Templates</a></li>
    </ul>
    <div style="margin-top:-1px;border: solid 1px #DDDDDD;padding:10px;margin-bottom:10px;background:#fff" id="onapptabcontainer">
        
        <div class="onapptab form" id="resources_tab">
            
            
<div class="odesc_ pdx">Your client will be able to use resource with limits configured here</div>
<table border="0" cellspacing="0" cellpadding="6" width="100%" >
    <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from Amazon, please wait...</td></tr>

    <tr class="">
        <td width="160"><label >Max Virtual Machines</label></td>
        <td><input type="text" size="3" name="options[option14]" value="{$default.option14}" id="option14"/></td>
    </tr>

</table>

            
            
        </div>
        <div class="onapptab form" id="ostemplates_tab">
           <div class=" pdx">Limit access to OS templates available in your Amazon EC2, you can also add charge to selected OS templates</div>
<table border="0" cellspacing="0" cellpadding="6" width="100%" >
    <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from Amazon, please wait...</td></tr>


    <tr class="">
        <td  width="160"></td>
        <td><span class="fs11" ><input type="checkbox" rel="os2" class="formchecker osloader" />Set template pricing</span></td>
    </tr>
    
</table>

        </div>
        
    </div>
</div>
<link href="../includes/modules/Hosting/amazon_ec2/productconf/config_style.css" rel="stylesheet" media="all" />
<script type="text/javascript" src="../includes/modules/Hosting/amazon_ec2/productconf/config_script.js"></script>

<script type="text/javascript">
    {if $_isajax}
    setTimeout('append_onapp()', 50);
    {else}
    appendLoader('append_onapp');
    {/if}
    $('.odesc_').hide();
    $('.odesc_cloud_vm').show();
</script> 

    </td>
</tr>