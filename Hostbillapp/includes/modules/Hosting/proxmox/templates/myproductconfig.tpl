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
    <li><a href="#" class="disabled" onclick="load_onapp_section('storage')">Storage</a></li>
    <li><a href="#" class="disabled" onclick="load_onapp_section('network')">Network</a></li>
   {if $ipam} <li><a href="#" class="disabled" onclick="load_onapp_section('ipam')">IPAM</a></li> {/if}
    <li><a href="#" class="disabled" onclick="load_onapp_section('finish')">Finish</a></li>
</ul>
<div style="margin-top:-1px;border: solid 1px #DDDDDD;padding:10px;margin-bottom:10px;background:#fff" id="onapptabcontainer">
    <div class="onapptab" id="provisioning_tab">
        To start please configure and select server above.<br/>
        You can configure your HostBill to provision Proxmox VE resources in multi">Networple ways:

        <div class="onapp_opt {if $default.option10=='Single Machine, autocreation'}onapp_active{/if}">
            <table border="0" width="500">
                <tr>
                    <td class="opicker"><input type="radio" name="options[option10]" id="single_vm" value="Single Machine, autocreation" {if $default.option10=='Single Machine, autocreation'}checked='checked'{/if}/></td>
                    <td class="odescr">
                        <h3>Single VPS</h3>
                        <div class="graylabel">One account in HostBill = 1 virtual machine in Proxmox VE</div>
                    </td>
                </tr>
            </table>
        </div>
        <div class="onapp_opt {if $default.option10=='Multiple Machines, full management'}onapp_active{/if}">
            <table border="0" width="500">
                <tr>
                    <td  class="opicker"><input type="radio" name="options[option10]"  id="cloud_vm" value="Multiple Machines, full management" {if $default.option10=='Multiple Machines, full management'}checked='checked'{/if} /></td>
                    <td class="odescr">
                        <h3>Cloud Hosting</h3>
                        <div class="graylabel">Your client will be able to create machines by himself in HostBill interface </div>
                    </td>
                </tr>
            </table>
        </div>

        <div class="nav-er" style="{if !$default.option10}display:none{/if}" id="step-1">
            <a href="#" class="next-step">Next step</a>
        </div>

    </div>
    <div class="onapptab form" id="resources_tab">
        <div class="odesc_ odesc_single_vm pdx">Your client's Virtual Machine will be provisioned with limits configured here</div>
        <div class="odesc_ odesc_cloud_vm pdx">Your client will be able to use resource with limits configured here</div>
        <table border="0" cellspacing="0" cellpadding="6" width="100%" >
             <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from Proxmox, please wait...</td></tr>


              <tr>
                <td width="160"><label >Virtualization<a class="vtip_description" title="Select virtualization method for this package. This will affect other options, like templates loaded."></a></label></td>
                <td ><select name="options[option30]"  id="option30">
                        <option value="qemu" {if $default.option30!='openvz'}selected="selected"{/if}>KVM</option>
                        <option value="openvz" {if $default.option30=='openvz'}selected="selected"{/if}>OpenVZ</option>
                    </select>
                </td>
            </tr>
             <tr>
                <td width="160"><label >User Role<a class="vtip_description" title="HostBill will add user to pool with this role."></a></label></td>
                <td id="option1container" class="tofetch"><input type="text" size="3" name="options[option1]" value="{$default.option1}" id="option1"/>
                </td>
            </tr>
 <tr>
                <td width="160"><label >User Group<a class="vtip_description" title="Assign new user to this group."></a></label></td>
                <td id="option2container" class="tofetch"><input type="text" size="3" name="options[option2]" value="{$default.option2}" id="option2"/>
                </td>
            </tr>


            <tr>
                <td width="160"><label >Memory [MB]</label></td>
                <td id="option3container"><input type="text" size="3" name="options[option3]" value="{$default.option3}" id="option3"/>
                    <span class="fs11"><input type="checkbox" class="formchecker"  rel="memory"> Allow client to adjust with slider during order</span>
                </td>
            </tr>
            <tr>
                <td width="160"><label >CPU Cores <a class="vtip_description" title="Number of cores per socket. For cloud packages client will be able to adjust it"></a></label></td>
                <td id="option5container"><input type="text" size="3" name="options[option5]" value="{$default.option5}" id="option5"/>
                    <span class="fs11"><input type="checkbox" class="formchecker"  rel="cpu_cores" /> Allow client to adjust with slider during order</span>
                </td>
            </tr>
           {* <tr>
                <td width="160"><label >CPU Sockets  <a class="vtip_description" title="Each client VM will be created with this qty of sockets. Default=1"></a></label></td>
                <td id="option4container"><input type="text" size="3" name="options[option4]" value="{$default.option4}" id="option4"/>
                    <span class="fs11"><input type="checkbox" class="formchecker" rel="cpu_sockets" /> Allow client to adjust with slider during order</span>
                </td>
            </tr>
*}
            <tr>
                <td width="160"><label >CPU Type </label></td>
                <td id="option24container" class="tofetch"><input type="text" size="3" name="options[option24]" value="{$default.option24}" id="option24"/>
                </td>
            </tr>

            <tr>
                <td width="160"><label >Available nodes <a class="vtip_description" title="If more than one selected, HostBill will provision VM on least used Node"></a></label></td>
                <td ><div id="option23container" class="tofetch"><select name="options[option23][]" id="option23" multiple="multiple" class="multi">
                        <option value="Auto-Assign" {if in_array('Auto-Assign',$default.option23)}selected="selected"{/if}>Auto-Assign</option>
                        {foreach from=$default.option23 item=vx}{if $vx=='Auto-Assign'}{continue}{/if}
                         <option value="{$vx}" selected="selected">{$vx}</option>
                        {/foreach}
                    </select></div><div class="clear"></div>
                    <span class="fs11"> <input type="checkbox" class="formchecker"  rel="node" />Allow to select by client during checkout</span>
                </td>
            </tr>
            
        </table>
    <div class="nav-er"  id="step-2">
            <a href="#" class="prev-step">Previous step</a>
            <a href="#" class="next-step">Next step</a>
        </div>

    </div>
    <div class="onapptab form" id="ostemplates_tab">
        <div class=" pdx">Limit access to ISO Images available in your Proxmox, you can also add charge to selected images</div>
        <table border="0" cellspacing="0" cellpadding="6" width="100%" >
             <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from Proxmox, please wait...</td></tr>

            <tr>
                <td width="160"><label >ISO Storage<a class="vtip_description" title="Select storage your clients will be able to choose ISO from. Note: iso stores should share name/id across nodes, HostBill will assume that selected ISO is available on all nodes configured with this product"></a></label></td>
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
            <tr class="odesc_ odesc_single_vm">
                <td><label >OS Template <a class="vtip_description" title="Your client VM will be automatically provisioned with this template"></a></label></td>
                <td id="option12container" ><div  class="tofetch"><input type="text" size="3" name="options[option12]" value="{$default.option12}" id="option12"/></div>
                    <span class="fs11" ><input type="checkbox" class="formchecker osloader" rel="os1" />Allow client to select during checkout</span></td>
            </tr>

        </table>
         <div class="nav-er"  id="step-3">
            <a href="#" class="prev-step">Previous step</a>
            <a href="#" class="next-step">Next step</a>
        </div>
    </div>
    <div class="onapptab form" id="storage_tab">
        <table border="0" cellspacing="0" cellpadding="6" width="100%" >
             <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from Proxmox, please wait...</td></tr>

            <tr>
                <td width="160"><label >Disk size [GB]</label></td>
                <td id="option6container"><input type="text" size="3" name="options[option6]" value="{$default.option6}" id="option6"/>
                    <span class="fs11"  ><input type="checkbox" class="formchecker" rel="disk_size" />Allow client to adjust with slider during order</span>
                </td>
            </tr>
            <tr>
                <td width="160"><label >Storage <a class="vtip_description" title="VM's disk will be created on selected storage. Auto-assign option will use random storage"></a></label></td>
                <td id="option21container" ><div  class="tofetch"><select name="options[option21][]" id="option21" multiple="multiple" class="multi">
                       <option value="Auto-Assign" {if in_array('Auto-Assign',$default.option21)}selected="selected"{/if}>Auto-Assign</option>
                        {foreach from=$default.option21 item=vx}{if $vx=='Auto-Assign'}{continue}{/if}
                         <option value="{$vx}" selected="selected">{$vx}</option>
                        {/foreach}
                    </select></div>
                    <span class="fs11"><input type="checkbox" class="formchecker" rel="datastorezone" />Allow client to select during order</span>
                </td>
            </tr>

             <tr>
                <td width="160"><label >Bus/Device <a class="vtip_description" title="Select bus/device available for client. Selecting more than one for cloud will allow client to choose from"></a></label></td>
                <td id="option18container" ><div  ><select name="options[option18][]" id="option18" multiple="multiple" class="multi">
                       <option value="IDE" {if in_array('IDE',$default.option18)}selected="selected"{/if}>IDE</option>
                       <option value="VIRTIO" {if in_array('VIRTIO',$default.option18)}selected="selected"{/if}>VIRTIO</option>
                    </select></div>
                </td>
            </tr>
             <tr>
                <td width="160"><label >Disk Format <a class="vtip_description" title="For KVM provisioning"></a></label></td>
                <td id="option43container" ><div  ><select name="options[option43]" id="option43" >
                       <option value="raw" {if $default.option43=='raw'}selected="selected"{/if}>Raw disk image (raw)</option>
                       <option value="qcow2" {if $default.option43=='qcow2'}selected="selected"{/if}>QUEMU image format (qcow2)</option>
                       <option value="vmdk" {if $default.option43=='vmdk'}selected="selected"{/if}>VMWare image format (vmdk)</option>
                    </select></div>
                </td>
            </tr>
        </table>
         <div class="nav-er"  id="step-4">
            <a href="#" class="prev-step">Previous step</a>
            <a href="#" class="next-step">Next step</a>
        </div>

    </div>
    <div class="onapptab form" id="network_tab">
        <table border="0" cellspacing="0" cellpadding="6" width="100%" >
          <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from Proxmox, please wait...</td></tr>
       
            <tr>
                <td width="160"><label >Port Speed [Mbps] <a class="vtip_description" title="Leave blank to unlimited. For cloud hosting this value will be used for each Virtual Machine created by client"></a></label></td>
                <td id="option9container"><input type="text" size="3" name="options[option9]" value="{$default.option9}" id="option9"/>
                    <span class="fs11"><input type="checkbox" class="formchecker" rel="rate"  />Allow client to select during order</span>
                </td>
            </tr>
            <tr>
                <td width="160"><label >Network mode <a class="vtip_description" title="For OpenVZ virtualization only"></a></label></td>
                <td ><select name="options[option31]" id="option31" >
                         <option value="bridged" {if $default.option31!='routed'}selected="selected"{/if}>Bridged</option>
                         <option value="routed" {if $default.option31=='routed'}selected="selected"{/if}>Routed (venet) - requires IPAM plugin</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td width="160"><label >Network bridge <a class="vtip_description" title="Client VM's will be connected trough this bridge. <br>Note1: For OpenVZ used in bridged mode<br>Note2: when using multiple nodes make sure your bridge names are the same across all nodes"></a></label></td>
                <td id="option22container" class="tofetch"><select name="options[option22]" id="option22" >
                         <option value="{$default.option22}" selected="selected">{$default.option22}</option>
                    </select>
                </td>
            </tr>


             <tr>
                <td width="160"><label >Model <a class="vtip_description" title="Select network device models available. Selecting more than one for cloud will allow client to choose from"></a></label></td>
                <td id="option27container" ><div  ><select name="options[option27][]" id="option27" multiple="multiple" class="multi">
                       <option value="rtl8139" {if in_array('rtl8139',$default.option27)}selected="selected"{/if}>Realtec RTl8139</option>
                       <option value="e1000" {if in_array('e1000',$default.option27)}selected="selected"{/if}>Intel E1000</option>
                       <option value="virtio" {if in_array('virtio',$default.option27)}selected="selected"{/if}>VirtIO (paravirtualized)</option>
                    </select></div>
                </td>
            </tr>
        </table>
         <div class="nav-er"  id="step-5">
            <a href="#" class="prev-step">Previous step</a>
            <a href="#" class="next-step">Next step</a>
        </div>
    </div>
    {if $ipam}<div class="onapptab form" id="network_tab">
        <table border="0" cellspacing="0" cellpadding="6" width="100%" >
          <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from Proxmox, please wait...</td></tr>
            <tr>
                <td colspan="2">
                    You have enabled ipam plugin - thats great, now you can enable feature to automatically assign IP addresses to client's virtual machines.<br/>
                    <b>How it works?</b><br/>
                    <ul>
                        <li>Enable IPAM integration below</li>
                        <li>Select IP pool from IPAM to use with this product</li>
                        <li>Each time client creates virtual machine HostBill will get free IP from IPAM, and mark it as assigned to this virtual machine</li>
                        <li>IP will be displayed in clientarea interface, and set as admin comment to client VM</li>
                        <li>Use those IPs as reference when configuring networking for client VM's</li>
                    </ul>
                </td>
            </tr>
        <tr>
                <td width="160"><label >Enable IPAM</label></td>
                <td ><input type="checkbox" name="options[option33]" value="1" {if $default.option33=='1'}checked="checked"{/if}> </td>
            </tr>
        <tr>
                <td width="160"><label >IPAM Pool <a class="vtip_description" title="Select pool from which HostBill should assign IPs for this package."></a></label></td>
                <td ><select name="options[option32]" >
                        {foreach from=$ipam_lists item=list}
                        <option value="{$list.id}" {if $list.indent!='0'}style="padding-left:10px"{/if} {if $default.option32==$list.id}selected="selected"{/if}>{$list.name}</option>
                        {/foreach}

                    </select></td>
            </tr>
        </table>
         <div class="nav-er"  id="step-5">
            <a href="#" class="prev-step">Previous step</a>
            <a href="#" class="next-step">Next step</a>
        </div>
    </div>{/if}
    <div class="onapptab form" id="finish_tab">
        <table border="0" cellspacing="0" width="100%" cellpadding="6">
             <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from Proxmox, please wait...</td></tr>
            <tr>
                <td valign="top" width="160" style="border-right:1px solid #E9E9E9">
                    <h4 class="finish">Finish</h4>
                    <span class="fs11" style="color:#C2C2C2">Save &amp; start selling</span>
                </td>
                <td valign="top">
                     Your Proxmox VE package is ready to be purchased. <br/>
                    

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
                        $.post('?cmd=proxmox&action=productdetails',{
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
                $.post('?cmd=proxmox&action=productdetails&make=updateostemplates',{
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
                    $.post('?cmd=proxmox&action=productdetails&'+vl,
                    {
                        make:'getonappval',
                        id:$('#product_id').val(),
                        cat_id:$('#category_id').val(),
                        other:$('input, select','#onapptabcontainer').serialize(),
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