<tr><td id="getvaluesloader">{if $test_connection_result}
                <span style="margin-left: 10px; font-weight: bold;text-transform: capitalize; color: {if $test_connection_result.result == 'Success'}#009900{else}#990000{/if}">
                    {$lang.test_configuration}:
                    {if $lang[$test_connection_result.result]}{$lang[$test_connection_result.result]}{else}{$test_connection_result.result}{/if}
                    {if $test_connection_result.error}: {$test_connection_result.error}{/if}
                </span>
        {/if}</td>
    <td id="onappconfig_"><div id="">
        <ul class="breadcrumb-nav" style="margin-top:10px;">
    <li><a href="#" class="active disabled" onclick="load_onapp_section('provisioning')">Provisioning</a></li>
    <li><a href="#" class="disabled" onclick="load_onapp_section('resources')">Resources</a></li>
    <li><a href="#" class="disabled" onclick="load_onapp_section('ostemplates')">OS Templates</a></li>
    <li><a href="#" class="disabled" onclick="load_onapp_section('storage')">Storage / Backups</a></li>
    <li><a href="#" class="disabled" onclick="load_onapp_section('network')">Network</a></li>
</ul>
<div style="margin-top:-1px;border: solid 1px #DDDDDD;padding:10px;margin-bottom:10px;background:#fff" id="onapptabcontainer">
    <div class="onapptab" id="provisioning_tab">
        To start please configure and select server above.<br/>
        You can configure your HostBill to provision OnApp resources in multiple ways:
        
        <div class="onapp_opt onapp_active">
            <table border="0" width="100%">
                <tr>
                    <td class="odescr">
                        <h3>Cloud Hosting with pre-set VM sizes</h3>
                        <div class="graylabel">Using this module (OnApp3) create cloud account for customer, and allow to create VMs with ceratain sizes, managed by Cloud Flavor Manager </div>
                    </td>
                </tr>
            </table>
        </div>
        <div class="onapp_opt">
            <table border="0"  width="100%">
                <tr>
                    <td class="odescr">
                        <h3>Single VPS</h3>
                        <div class="graylabel">One account in HostBill = 1 virtual machine in OnApp - use module: OnApp, product Type: OnAppcloud</div>
                    </td>
                </tr>
            </table>
        </div>
        <div class="onapp_opt">
            <table border="0"  width="100%">
                <tr>
                    <td class="odescr">
                        <h3>Cloud Hosting</h3>
                        <div class="graylabel">Your client will be able to create machines by himself in HostBill interface - use module: OnApp, product Type: OnAppcloud </div>
                    </td>
                </tr>
            </table>
        </div>
        

    </div>
    <div class="onapptab form" id="resources_tab">
        <div class="odesc_ odesc_cloud_vm pdx">Your client will be able to use resource with limits configured here</div>
        <table border="0" cellspacing="0" cellpadding="6" width="100%" >
             <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from OnApp, please wait...</td></tr>

            <tr>
                <td width="160"><label >Hypervisor Zone</label></td>
                <td ><div id="option23container" class="tofetch"><select name="options[option23][]" id="option23" class="multi" multiple>
                        <option value="Auto-Assign" {if in_array('Auto-Assign',$default.option23)}selected="selected"{/if}>Auto-Assign</option>
                        {foreach from=$default.option23 item=vx}{if $vx=='Auto-Assign'}{continue}{/if}
                         <option value="{$vx}" selected="selected">{$vx}</option>
                        {/foreach}
                    </select></div><div class="clear"></div>
                    <span class="fs11"> <input type="checkbox" class="formchecker"  rel="hypervisorzone" />Allow to select by client during checkout</span>
                </td>
            </tr>
            <tr class="odesc_ odesc_cloud_vm">
                <td width="160"><label >Max Virtual Machines</label></td>
                <td><input type="text" size="3" name="options[option14]" value="{$default.option14}" id="option14"/></td>
            </tr>
            <tr>
                <td width="160"><label >User Role<a class="vtip_description" title="HostBill will create new user for client in onapp using this role."></a></label></td>
                <td id="option1container" class="tofetch"><input type="text" size="3" name="options[option1]" value="{$default.option1}" id="option1"/>
                </td>
            </tr>
        </table>
   

    </div>
    <div class="onapptab form" id="ostemplates_tab">
        <div class=" pdx">Limit access to OS templates available in your OnApp, you can also add charge to selected OS templates</div>
        <table border="0" cellspacing="0" cellpadding="6" width="100%" >
             <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from OnApp, please wait...</td></tr>

            <tr>
                <td width="160"><label >Template Groups<a class="vtip_description" title="Select template sets you wish to make available for client to use with his virtual machines"></a></label></td>
                <td  class="tofetch" id="option20container"><select name="options[option20][]" id="option20" multiple="multiple" class="multi">
                        <option value="All" {if in_array('All',$default.option20)}selected="selected"{/if}>All</option>
                        {foreach from=$default.option20 item=vx}{if $vx=='All'}{continue}{/if}
                         <option value="{$vx}" selected="selected">{$vx}</option>
                        {/foreach}
                    </select>
                </td>
            </tr>
            <tr class="odesc_ odesc_cloud_vm">
                <td></td>
                <td><span class="fs11" ><input type="checkbox" rel="os2" class="formchecker osloader" />Set template pricing</span></td>
            </tr>
           

        </table>
       
    </div>
    <div class="onapptab form" id="storage_tab">
        <table border="0" cellspacing="0" cellpadding="6" width="100%" >
             <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from OnApp, please wait...</td></tr>

           
            <tr>
                <td width="160"><label >Backup space [GB]</label></td>
                <td id="option17container"><input type="text" size="3" name="options[option17]" value="{$default.option17}" id="option17"/>
                    <span class="fs11"><input type="checkbox" class="formchecker" rel="storage_disk_size" />Allow client to adjust with slider during order</span>
                </td>
            </tr>
            <tr>
                <td width="160"><label >Max backups</label></td>
                <td><input type="text" size="3" name="options[option15]" value="{$default.option15}" id="option15"/></td>
            </tr>
            <tr>
                <td width="160"><label >Data Store Zone <a class="vtip_description" title="Client VMs will be able to use selected zones for storage"></a></label></td>
                <td id="option21container" ><div  class="tofetch"><select name="options[option21][]" id="option21" class="multi" multiple>
                        {foreach from=$default.option21 item=vx}{if $vx=='Auto-Assign'}{continue}{/if}
                         <option value="{$vx}" selected="selected">{$vx}</option>
                        {/foreach}
                    </select></div>
                    <span class="fs11"><input type="checkbox" class="formchecker" rel="datastorezone" />Allow client to select during order</span>
                </td>
            </tr>
            <tr>
                <td width="160"><label >Swap: Data Store Zone <a class="vtip_description" title="Client VMs swap will be created on selected zones"></a></label></td>
                <td id="option24container"  class="tofetch"><select name="options[option24][]" id="option24"  class="multi" multiple>
                        {foreach from=$default.option24 item=vx}{if $vx=='Auto-Assign'}{continue}{/if}
                         <option value="{$vx}" selected="selected">{$vx}</option>
                        {/foreach}
                    </select>
                </td>
            </tr>

            
        </table>
        

    </div>
    <div class="onapptab form" id="network_tab">
        <table border="0" cellspacing="0" cellpadding="6" width="100%" >
          <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from OnApp, please wait...</td></tr>
          
            <tr>
                <td width="160"><label >Port Speed [Mbps] <a class="vtip_description" title="Leave blank to unlimited. For cloud hosting this value will be used for each Virtual Machine created by client"></a></label></td>
                <td id="option9container"><input type="text" size="3" name="options[option9]" value="{$default.option9}" id="option9"/>
                    <span class="fs11"><input type="checkbox" class="formchecker" rel="rate"  />Allow client to select during order</span>
                </td>
            </tr>
            <tr>
                <td width="160"><label >Data sent/period [GB] <a class="vtip_description" title="This is total limit for all client's virtual machines usage"></a></label></td>
                <td id="option16container"><input type="text" size="3" name="options[option16]" value="{$default.option16}" id="option16"/>
                    <span class="fs11"><input type="checkbox" class="formchecker" rel="data_sent" /> Allow client to adjust with slider during order</span></td>
            </tr>
            <tr>
                <td width="160"><label >Data recv/period [GB] <a class="vtip_description" title="This is total limit for all client's virtual machines usage"></a></label></td>
                <td id="option18container"><input type="text" size="3" name="options[option18]" value="{$default.option18}" id="option18"/>
                    <span class="fs11"><input type="checkbox" class="formchecker" rel="data_recv" /> Allow client to adjust with slider during order</span></td>
            </tr>
            <tr>
                <td width="160"><label >Data transfer period </label></td>
                <td><select name="options[option38]" id="option38">
                        <option value="hourly" {if $default.option38=='hourly' || !$default.option38}selected="selected"{/if}>Hourly</option>
                        <option value="monthly" {if $default.option38=='monthly'}selected="selected"{/if}>Monthly</option>
                    </select></td>
            </tr>
            <tr>
                <td width="160"><label >Network Zone <a class="vtip_description" title="Client VMs will be able to use selected zones"></a></label></td>
                <td id="option22container" class="tofetch"><select name="options[option22][]" id="option22" class="multi" multiple>
                        {foreach from=$default.option22 item=vx}{if $vx=='Auto-Assign'}{continue}{/if}
                         <option value="{$vx}" selected="selected">{$vx}</option>
                        {/foreach}
                    </select>
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
background:#f4f4f4;
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

</style>

        <script type="text/javascript">
            function toggle_vcpu(el) {
                if($(el).is(':checked')) {
                    $('#cpu_shares_row').hide();
                    $('#vcpu_row').show();

                } else {
                    $('#cpu_shares_row').show();
                    $('#vcpu_row').hide();
                }
            }
            function onapp_showloader() {
                $('.onapptab:visible').find('.onapp-preloader').slideDown();
            }
            function onapp_hideloader() {
                $('.onapptab:visible').find('.onapp-preloader').slideUp();

            }
            function lookforsliders() {
                var pid = $('#product_id').val();
                $('.formchecker').click(function(){
                    var tr=$(this).parents('tr').eq(0);
                    var rel=$(this).attr('rel').replace(/[^a-z_]/g,'');
                    if(!$(this).is(':checked')) {
                        if(!confirm('Are you sure you want to remove related Form element? ')) {
                            return false;
                        }
                        if($('#configvar_'+rel).length) {
                            ajax_update('?cmd=configfields&make=delete',{
                                id:$('#configvar_'+rel).val(),
                                product_id:pid
                            },'#configeditor_content');
                        }
                        //remove related form element
                        tr.find('.tofetch').removeClass('fetched').removeClass('disabled');
                        tr.find('input[id], select[id]').eq(0).removeAttr('disabled','disabled').show();
                        load_onapp_section($(this).parents('div.onapptab').eq(0).attr('id').replace('_tab',''));
                        $(this).parents('span').eq(0).find('a.editbtn').remove();
                    } else {
                        //add related form element
                        var el=$(this);
                        var rel=$(this).attr('rel');
                        tr.find('input[id], select[id]').eq(0).attr('disabled','disabled').hide();
                        onapp_showloader();
                        $.post('?cmd=services&action=product',{
                             make:'importformel',
                             variableid:rel,
                             cat_id:$('#category_id').val(),
                             other:$('input, select','#onapptabcontainer').serialize(),
                             id:pid,
                             server_id:$('#serv_picker input[type=checkbox][name]:checked:eq(0)').val()
                        },function(data){
                            var r = parse_response(data);
                            if(r) {
                                 el.parents('span').eq(0).append(r);
                                 onapp_hideloader();
                                 ajax_update('?cmd=configfields',{product_id:pid,action:'loadproduct'},'#configeditor_content');
                            }
                        });
                    }
                }).each(function(){
                    var rel=$(this).attr('rel').replace(/[^a-z_]/g,'');
                    if($('#configvar_'+rel).length<1)
                        return 1;
                    var fid = $('#configvar_'+rel).val();
                    var tr=$(this).attr('checked','checked').parents('tr').eq(0);
                    tr.find('input[id], select[id]').eq(0).attr('disabled','disabled').hide();
                    tr.find('.tofetch').addClass('disabled');
                    $(this).parents('span').eq(0).append(' <a href="#" onclick="return editCustomFieldForm('+fid+','+pid+')" class="editbtn orspace">Edit related form element</a>');
                }).filter('.osloader').each(function(){
                    if($('#configvar_os').length<1)
                        return 0;
                    var fid = $('#configvar_os').val();
                    $(this).parents('span').eq(0).append(' <a href="#" onclick="return updateOSList('+fid+')" class="editbtn orspace">Update template list from OnApp</a>');
                });

            }
            function updateOSList(fid) {
                onapp_showloader();
                $.post('?cmd=services&action=product&make=updateostemplates',{
                    id:$('#product_id').val(),
                    cat_id:$('#category_id').val(),
                    other:$('input, select','#onapptabcontainer').serialize(),
                    server_id:$('#serv_picker input[type=checkbox][name]:checked:eq(0)').val(),
                    fid:fid
                },function(data){
                    parse_response(data);
                    editCustomFieldForm(fid,$('#product_id').val());
                });
                return false;
            }
            function load_onapp_section(section)  {
                if(!$('#serv_picker input[type=checkbox][name]:checked:eq(0)').val()) {
                    alert('Please configure & select server first');
                    return;
                }


                var tab = $('#'+section+'_tab');
                    if(!tab.length)
                        return false;
                var elements = tab.find('.tofetch').not('.fetched').not('.disabled');
                if(!elements.length)
                    return false;
                tab.find('.onapp-preloader').show();
                elements.each(function(e){
                    var el = $(this);
                    var inp=el.find('input[id], select[id]').eq(0);
                    if(inp.is(':disabled')) {
                        if((e+1)==elements.length) {
                                  tab.find('.onapp-preloader').slideUp();
                                }
                        return 1; //continue;

                    }
                    var vlx=inp.val();
                    var vl=inp.attr('id')+"="+vlx;
                    if(vlx!=null && vlx.constructor==Array) {
                        vl = inp.serialize();
                    }
                    $.post('?cmd=services&action=product&'+vl,
                    {
                        make:'getonappval',
                        id:$('#product_id').val(),
                        cat_id:$('#category_id').val(),
                        opt:inp.attr('id'),
                        server_id:$('#serv_picker input[type=checkbox][name]:checked:eq(0)').val()
                    },function(data){
                            var r=parse_response(data);
                            if(typeof(r)=='string') {
                             $(el).addClass('fetched');
                              el.html(r);
                            }

                      });

                });
                               $("a.vtip_description","#onappconfig_").not('.vtip_applied').vTip();

                return false;
            }
            function singlemulti() {
                $('#step-1').show();
                if($('#single_vm').is(':checked')) {
                    $('tr.odesc_single_vm').find('.tofetch').removeClass('disabled');
                    $('tr.odesc_cloud_vm td').find('.tofetch').addClass('disabled');
                    $('#option14').val(1);
                    $('#option19').val('No');
                } else {
                    $('tr.odesc_cloud_vm').find('.tofetch').removeClass('disabled');
                    $('tr.odesc_single_vm').find('.tofetch').addClass('disabled');
                }
            }
            function bindsteps() {
                $('a.next-step').click(function(){
                    $('.breadcrumb-nav a.active').removeClass('active').parent().next().find('a').click();
                    return false;
                });
                $('a.prev-step').click(function(){
                    $('.breadcrumb-nav a.active').removeClass('active').parent().prev().find('a').click();
                    return false;
                });
                $('#serv_picker input[type=checkbox]').click(function(){
                    if($('#serv_picker input[type=checkbox][name]:checked:eq(0)').val())
                        $('#onappconfig_ .breadcrumb-nav a').removeClass('disabled');
                    else
                        $('#onappconfig_ .breadcrumb-nav a').addClass('disabled');

                });
            }

            function append_onapp() {
                $('#onappconfig_').TabbedMenu({elem:'.onapptab',picker:'.breadcrumb-nav a',aclass:'active',picker_id:'nan1'});
                $('.onapp_opt input[type=radio]').click(function(e){
                    $('.onapp_opt').removeClass('onapp_active');
                    var id=$(this).attr('id');
                    $('.odesc_').hide();
                    $('.odesc_'+id).show();
                    $(this).parents('div').eq(0).addClass('onapp_active');
                    singlemulti();
                });
                $('.onapp_opt input[type=radio]:checked').click();
                lookforsliders();
                $(document).ajaxStop(function() {
                    $('.onapp-preloader').hide();
                });
                bindsteps();


                if($('#serv_picker input[type=checkbox][name]:checked:eq(0)').val())
                        $('#onappconfig_ .breadcrumb-nav a').removeClass('disabled');
            }
            {/literal}{if $_isajax}setTimeout('append_onapp()',50);{else}appendLoader('append_onapp');{/if}{literal}
        </script>

    {/literal}

</div>
    </td>
</tr>