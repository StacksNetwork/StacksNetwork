<tr><td id="getvaluesloader">{if $test_connection_result}
                <span style="margin-left: 10px; font-weight: bold;text-transform: capitalize; color: {if $test_connection_result.result == 'Success'}#009900{else}#990000{/if}">
                    {$lang.test_configuration}:
                    {if $lang[$test_connection_result.result]}{$lang[$test_connection_result.result]}{else}{$test_connection_result.result}{/if}
                    {if $test_connection_result.error}: {$test_connection_result.error}{/if}
                </span>
        {/if}</td>
    <td id="onappconfig_"><div id="">
        <ul class="breadcrumb-nav" style="margin-top:10px;">
    <li><a href="#" class="active disabled" onclick="load_onapp_section('provisioning')">开始</a></li>
    <li><a href="#" class="disabled" onclick="load_onapp_section('resources')">常规</a></li>
    <li><a href="#" class="disabled" onclick="load_onapp_section('vdc')">vDC</a></li>
    <li><a href="#" class="disabled" onclick="load_onapp_section('network')">网络</a></li>
    <li><a href="#" class="disabled" onclick="load_onapp_section('finish')">完成</a></li>
</ul>
<div style="margin-top:-1px;border: solid 1px #DDDDDD;padding:10px;margin-bottom:10px;background:#fff" id="onapptabcontainer">
    <div class="onapptab" id="provisioning_tab">
        开始请配置和选择上述服务器.<br/>
    </div>
    <div class="onapptab form" id="resources_tab">
        <table border="0" cellspacing="0" cellpadding="6" width="100%" >
             <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> 从vCloud Director读取数据, 请稍候...</td></tr>

             <tr>
                <td width="160"><label >用户角色<a class="vtip_description" title="系统将添加默认用户与角色的新组织机构."></a></label></td>
                <td id="rolecontainer" class="tofetch"><input type="text" size="3" name="options[role]" value="{$default.role}" id="role"/>
                </td>
            </tr>
  <tr>
                <td width="160"><label >配置模式</label></td>
                <td id="allocationcontainer" >
                    <select name="options[allocation]">
                        <option value="AllocationPool" {if $default.allocation=='AllocationPool'}selected="selected"{/if}>配置池</option>
                        <option value="AllocationVApp" {if $default.allocation=='AllocationVApp'}selected="selected"{/if}>即刻交付</option>
                        <option value="ReservationPool" {if $default.allocation=='ReservationPool'}selected="selected"{/if}>保留池</option>
                    </select>
                </td>
            </tr>

              <tr>
                <td width="160"><label >组织机构</label></td>
                <td id="organizationcontainer"><input type="hidden" size="3" name="options[organization]" value="{$default.organization}" id="organization"/>
                    <span class="fs11"><input type="checkbox" class="formchecker"  rel="organization" /> 允许客户进入订单处理过程 (或使用客户公司名称)</span>
                </td>
            </tr>
        </table>
    <div class="nav-er"  id="step-2">
            <a href="#" class="prev-step">上一步</a>
            <a href="#" class="next-step">下一步</a>
        </div>

    </div>
    
    <div class="onapptab form" id="vdc_tab">
        <table border="0" cellspacing="0" cellpadding="6" width="100%" >
             <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif">  从vCloud Director读取数据, 请稍候...</td></tr>

            
            <tr>
                <td width="160"><label >vDC供应商</label></td>
                <td id="vdccontainer" class="tofetch"><input type="text" size="3" name="options[vdc]" value="{$default.vdc}" id="vdc"/>
                </td>
            </tr>
            <tr>
                <td width="160"><label >最大VMs<a class="vtip_description" title="限制客户端可以创建VMS的数量"></a></label></td>
                <td id="maxvms"><input type="text" size="3" name="options[maxvms]" value="{$default.maxvms}" id="maxvms"/>
                    
                </td>
            </tr>

            <tr>
                <td width="160"><label >CPU配置[MHz]</label></td>
                <td id="cpucontainer"><input type="text" size="3" name="options[cpu]" value="{$default.cpu}" id="cpu"/>
                    <span class="fs11"><input type="checkbox" class="formchecker"  rel="cpu" /> 允许客户在订单调整时使用滑块</span>
                </td>
            </tr>

            <tr>
                <td width="160"><label >内存配置[MB]</label></td>
                <td id="memorycontainer"><input type="text" size="3" name="options[memory]" value="{$default.memory}" id="memory"/>
                    <span class="fs11"><input type="checkbox" class="formchecker"  rel="memory" /> 允许客户在订单调整时使用滑块</span>
                </td>
            </tr>
            <tr>
                <td width="160"><label >磁盘配置[GB]</label></td>
                <td id="disk_sizecontainer"><input type="text" size="3" name="options[disk_size]" value="{$default.disk_size}" id="disk_size"/>
                    <span class="fs11"><input type="checkbox" class="formchecker"  rel="disk_size" /> 允许客户在订单调整时使用滑块</span>
                </td>
            </tr>


        </table>
         <div class="nav-er"  id="step-4">
            <a href="#" class="prev-step">上一步</a>
            <a href="#" class="next-step">下一步</a>
        </div>

    </div>
    <div class="onapptab form" id="network_tab">
        <table border="0" cellspacing="0" cellpadding="6" width="100%" >
          <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif">  从vCloud Director读取数据, 请稍候...</td></tr>
       
             <tr>
                <td width="160"><label >网络池</label></td>
                <td id="poolcontainer" class="tofetch"><input type="text" size="3" name="options[pool]" value="{$default.pool}" id="pool"/>
                </td>
            </tr>
             <tr>
                <td width="160"><label >网络配额</label></td>
                <td id="networkscontainer"><input type="text" size="3" name="options[networks]" value="{$default.networks}" id="networks"/>
                </td>
            </tr>

        </table>
         <div class="nav-er"  id="step-5">
            <a href="#" class="prev-step">上一步</a>
            <a href="#" class="next-step">下一步</a>
        </div>
    </div>
    <div class="onapptab form" id="finish_tab">
        <table border="0" cellspacing="0" width="100%" cellpadding="6">
             <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif">  从vCloud Director读取数据, 请稍候...</td></tr>
            <tr>
                <td valign="top" width="160" style="border-right:1px solid #E9E9E9">
                    <h4 class="finish">结束</h4>
                    <span class="fs11" style="color:#C2C2C2">保存 &amp; 开始出售</span>
                </td>
                <td valign="top">
                     您的VMWare vCloud Director套餐已经准备完成可以购买. <br/>
                    

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
                        if(!confirm('您确信要删除相关表单元素? ')) {
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
                        $.post('?cmd=vcloud&action=productdetails',{
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
                    $(this).parents('span').eq(0).append(' <a href="#" onclick="return editCustomFieldForm('+fid+','+pid+')" class="editbtn orspace">编辑相关表单元素</a>');
                });
            }
            
            function load_onapp_section(section)  {
                if(!$('#serv_picker input[type=checkbox][name]:checked:eq(0)').val()) {
                    alert('请先选择服务器配置');
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
                    $.post('?cmd=vcloud&action=productdetails&'+vl,
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