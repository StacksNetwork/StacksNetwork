<tr>
    <td id="getvaluesloader">
        {if $test_connection_result}
            <span style="margin-left: 10px; font-weight: bold;text-transform: capitalize; color: {if $test_connection_result.result == 'Success'}#009900{else}#990000{/if}">
                {$lang.test_configuration}:
                {if $lang[$test_connection_result.result]}{$lang[$test_connection_result.result]}
                {else}{$test_connection_result.result}
                {/if}
                {if $test_connection_result.error}: {$test_connection_result.error}
                {/if}
            </span>
        {/if}
    </td>
    <td id="onappconfig_">
        <input type="hidden" id="saved_module" value="{if $default}1{else}0{/if}"/>
        <div id="">
            <ul class="breadcrumb-nav" style="margin-top:10px;">
                <li><a href="#" class="active disabled" onclick="solusvm.load_section('provisioning')">Provisioning</a></li>
                <li><a href="#" class="disabled" onclick="solusvm.load_section('resources')">Resources</a></li>                
                <li><a href="#" class="disabled" onclick="solusvm.load_section('ostemplates')">OS Templates</a></li>
                <li><a href="#" class="disabled" onclick="solusvm.load_section('memory')">Memory</a></li>
                <li><a href="#" class="disabled" onclick="solusvm.load_section('network')">Network</a></li>
                <li><a href="#" class="disabled" onclick="solusvm.load_section('finish');">Finish</a></li>
            </ul>
            <script type="text/javascript" src="{$system_url}includes/modules/Hosting/solusvm/templates/adminarea/config_script.js"></script>
            <div style="margin-top:-1px;border: solid 1px #DDDDDD;padding:10px;margin-bottom:10px;background:#fff" id="onapptabcontainer">
                {include file="`$module_templates`config_provisioning.tpl"}
                {include file="`$module_templates`config_resources.tpl"}
                {include file="`$module_templates`config_ostemplates.tpl"}
                {include file="`$module_templates`config_memory.tpl"}
                {include file="`$module_templates`config_network.tpl"}
                <div class="onapptab form" id="finish_tab">
                    <table border="0" cellspacing="0" width="100%" cellpadding="6">
                        <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from SolusVM, please wait...</td></tr>
                        <tr>
                            <td valign="top" width="160" style="border-right:1px solid #E9E9E9">
                                <h4 class="finish">Finish</h4>
                                <span class="fs11" style="color:#C2C2C2">Save &amp; start selling</span>
                            </td>
                            <td valign="top">
                                Your package is ready to be purchased. <br/>
                                To make sure everything works properly you should perform configuration test, to proceed click on button below.
                                <div style="padding:15px" id="testconfigcontainer">
                                    <a onclick="return HBTestingSuite.initTest();"  class="new_control" href="#"><span class="gear_small">Test your configuration</span></a>
                                </div>
                                
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            {literal}
                <style type="text/css">
                    .nav-er {
                        margin:20px 0px 7px;
                        text-align:center;
                    }
                    .nav-er a {
                        display: inline-block;
                        padding:10px;
                        background-color:  #F1F1F1;
                        background-image: -moz-linear-gradient(center top , #F5F5F5, #F1F1F1);
                        border: 1px solid #DDDDDD;
                        color: #444444;
                        border-radius:4px;
                        text-decoration: underline;
                        margin:0px 7px;
                    }
                    .nav-er a:hover {
                        color:#222;
                        text-decoration:none;
                        background: #F5F5F5;
                    }
                    h4.finish {
                        margin:0px;
                        color:#262626;
                        font-weight: normal;
                        font-size:20px;
                    }
                    .onapp-preloader {display:none; color:#7F7F7F;padding-left:178px;font-size:11px;background:#EBEBEB;font-weight:bold;}
                    .pdx {
                        margin-bottom:10px;
                    }
                    select.multi {
                        min-width:120px;
                    }

                    .form select {
                        margin:0px;
                    }
                    .paddedin {
                        margin: 2px 10px 20px 10px;
                    }
                    .odescr {
                        padding-left:7px;
                    }
                    .onapp_opt:hover {
                        border: solid 1px  #CCCCCC;
                        background:#f6fafd;
                    }
                    .opicker {
                        width: 25px;
                        
                        -moz-border-radius-topleft: 3px;
                        -moz-border-radius-topright: 0px;
                        -moz-border-radius-bottomright: 0px;
                        -moz-border-radius-bottomleft: 3px;
                        -webkit-border-radius: 3px 0px 0px 3px;
                        border-radius: 3px 0px 0px 3px;
                    }
                    .onapp_opt {
                        border: solid 1px #DDDDDD;
                        padding:4px;
                        margin:15px;
                        -webkit-border-radius: 4px;
                        -moz-border-radius: 4px;
                        border-radius: 4px;
                    }
                    .onapp_active {
                        border:solid 1px #96c2db;
                        background:#f5f9fa;
                    }
                    .graylabel {
                        font-size:11px;
                        padding:2px 3px;
                        float:left;
                        clear:both;
                        background:#ebebeb;
                        color:#7f7f7f;
                        -webkit-border-radius: 3px;
                        -moz-border-radius: 3px;
                        border-radius: 3px;
                    }
                    #testconfigcontainer .dark_shelf {
                        display:none;
                    }
                    .disable_ select{
                        margin-right: 3px;
                    }
                    /*
                    .resource{
                        position: relative;
                        width: 300px;
                        height: 10px;
                        border: 1px solid #ddd;
                        background: #eee;
                    }
                    .used_resource{
                        position: relative;
                        width: 0%;
                        height: 10px;
                        border: none;
                        background: #59e;
                    }*/
                </style>
            {/literal}
            
            <script type="text/javascript">
                {if $_isajax}setTimeout('solusvm.append()',50);
                {else}appendLoader('solusvm.append');
                {/if}
            </script>
        </div>
    </td>
</tr>