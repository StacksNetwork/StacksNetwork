<tr><td id="getvaluesloader">{if $test_connection_result}
        <span style="margin-left: 10px; font-weight: bold;text-transform: capitalize; color: {if $test_connection_result.result == 'Success'}#009900{else}#990000{/if}">
            {$lang.test_configuration}:
            {if $lang[$test_connection_result.result]}{$lang[$test_connection_result.result]}{else}{$test_connection_result.result}{/if}
            {if $test_connection_result.error}: {$test_connection_result.error}{/if}
        </span>
        {/if}</td>
    <td id="onappconfig_"><div id="">
            <ul class="breadcrumb-nav" style="margin-top:10px;">
                <li><a href="#" class="active disabled" onclick="load_onapp_section('provisioning')">Start</a></li>
                <li><a href="#" class="disabled" onclick="load_onapp_section('resources')">Resources</a></li>
                <li><a href="#" class="disabled" onclick="load_onapp_section('finish')">Finish</a></li>
            </ul>
            <div style="margin-top:-1px;border: solid 1px #DDDDDD;padding:10px;margin-bottom:10px;background:#fff" id="onapptabcontainer">
                <div class="onapptab" id="provisioning_tab">
                    To start please configure and select server above and continue to set CDN resource limits.<br/>
                    Use test connection, to ensure that HostBill can connect with your OnApp installation.

                    <div class="nav-er" style="{if !$default.option10}display:none{/if}" id="step-1">
                        <a href="#" class="next-step">Next step</a>
                    </div>

                </div>
                <div class="onapptab form" id="resources_tab">
                    <div >Your client Virtual Machine will be provisioned with limits configured here</div>
                    <table border="0" cellspacing="0" cellpadding="6" width="100%" >
                        <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from OnApp, please wait...</td></tr>

                       <!-- <tr>
                            <td width="160"><label >Bandwidth [GB/h]</label></td>
                            <td id="option3container"><input type="text" size="3" name="options[option16]" value="{$default.option16}" id="option16"/>
                                <span class="fs11"/><input type="checkbox" class="formchecker"  rel="bandwidth"> Allow client to adjust with slider during order</span>
                            </td>
                        </tr>
                        -->
                        <tr>
                            <td width="160"><label >CDN Edge group <a class="vtip_description" style="display:inline-block" style="display:inline-block" title="CDN edge groups are groups of edge servers – your own, and those you subscribe to from the CDN marketplace. They are usually grouped by location, so they represent a pool of servers for a given geographical area. Once you have created an edge group in OnApp containing edge servers in specific locations, your clients will be able to assign their CDN resources to groups selected here"></a></label></td>
                            <td ><div id="option21container" class="tofetch"><select name="options[option21][]" id="option21" multiple="multiple" class="multi">
                                        <option value="All" {if in_array('All',$default.option21)}selected="selected"{/if}>All</option>
                                        {foreach from=$default.option21 item=vx}{if $vx=='All'}{continue}{/if}
                                        <option value="{$vx}" selected="selected">{$vx}</option>
                                        {/foreach}
                                    </select></div><div class="clear"></div>
                                <span class="fs11"> <input type="checkbox" class="formchecker"  rel="edgegroup" />Set separate group metered traffic pricing</span>
                            </td>
                        </tr>
                        <tr>
                            <td width="160"><label >OR</label></td>
                            <td id="option23container" >
                                <input type="checkbox"   name="options[option23]" value="1" id="option23" {if $default.option23}checked="checked"{/if}/> Create custom edge group using location:
                            </td>
                        </tr>
                        <tr>
                            <td width="160"></td>
                            <td ><div id="option22container" class="tofetch"><select name="options[option22][]" id="option22" multiple="multiple" class="multi">
                                        {foreach from=$default.option22 item=vx}
                                        <option value="{$vx}" selected="selected">{$vx}</option>
                                        {/foreach}
                                    </select></div><div class="clear"></div>
                                <span class="fs11"> <input type="checkbox" class="formchecker"  rel="locations"/>Allow client to choose locations during signup <a class="vtip_description" style="display:inline-block" title="This will create two form elements. One - for admin only to keep prices[metered billing] per location. Second visible in cart with locations to choose from."></a></span>
                            </td>
                            </tr>
                        <tr>
                            <td width="160"><label >User Role<a class="vtip_description" style="display:inline-block" title="HostBill will create new user for client in onapp using this role."></a></label></td>
                            <td id="option1container" class="tofetch"><input type="text" size="3" name="options[option1]" value="{$default.option1}" id="option1"/>
                            </td>
                        </tr>
                    </table>
                    <div class="nav-er"  id="step-2">
                        <a href="#" class="prev-step">Previous step</a>
                        <a href="#" class="next-step">Next step</a>
                    </div>

                </div>

                <div class="onapptab form" id="finish_tab">
                    <table border="0" cellspacing="0" width="100%" cellpadding="6">
                        <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from OnApp, please wait...</td></tr>
                        <tr>
                            <td valign="top" width="160" style="border-right:1px solid #E9E9E9">
                                <h4 class="finish">Finish</h4>
                                <span class="fs11" style="color:#C2C2C2">Save &amp; start selling</span>
                            </td>
                            <td valign="top">
                                Your OnApp CDN package is ready to be purchased. <br/>
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

        </div>{literal}<script type="text/javascript">

           
            if (typeof(HBTestingSuite)=='undefined')
                var HBTestingSuite={};

            HBTestingSuite.product_id=$('#product_id').val();
            HBTestingSuite.initTest=function(){
                var name = $('form#productedit input[name=name]').val();
                onapp_showloader();
                ajax_update('?cmd=testingsuite&action=beginsimpletest',{product_id:this.product_id,pname:name},'#testconfigcontainer');
                //$.facebox({ ajax: "?cmd=testingsuite&action=beginsimpletest&product_id="+this.product_id+"&pname="+name,width:700,nofooter:true,opacity:0.8,addclass:'modernfacebox' });
                return false;
            };

        </script> {/literal}
    </td>
</tr>