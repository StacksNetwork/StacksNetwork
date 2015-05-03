<tr><td id="getvaluesloader">{if $test_connection_result}
        <span style="margin-left: 10px; font-weight: bold;text-transform: capitalize; color: {if $test_connection_result.result == 'Success'}#009900{else}#990000{/if}">
            {$lang.test_configuration}:
            {if $lang[$test_connection_result.result]}{$lang[$test_connection_result.result]}{else}{$test_connection_result.result}{/if}
            {if $test_connection_result.error}: {$test_connection_result.error}{/if}
        </span>
        {/if}</td>
    <td id="onappconfig_"><div id="">
            <ul class="breadcrumb-nav" style="margin-top:10px;">
                <li><a href="#" class="active disabled" onclick="load_onapp_section('provisioning')">预先配置</a></li>
                <li><a href="#" class="disabled" onclick="load_onapp_section('resources')">用户&用户组</a></li>
            </ul>
            <div style="margin-top:-1px;border: solid 1px #DDDDDD;padding:10px;margin-bottom:10px;background:#fff" id="onapptabcontainer">
                <div class="onapptab" id="provisioning_tab">
                    <div id="preconfigure_off">
                        您需要收集用户名和密码的用户请添加变量名的元素形式: rd_username & rd_password
                         <div style="padding:15px" >
                                    <a onclick="return preconfigure();"  class="new_control" href="#"><span class="gear_small">自动添加所需的表单域</span></a>
                                </div>
                    </div>
                    <div id="preconfigure_on" style="display:none;">您的套餐现在预先配置了用户和密码表单域, 您可以继续进行用户和组的设置. <br/>
                    请检查下部件 -> 表现形式是否有添加正确相关的字段  <br /> <br/>

                    {literal}
                    <em>自动发送的电子邮件客户端创建后使用 <b>{$service.forms.rd_username.value}</b> 显示用户名和 <b>{$service.forms.rd_password.value}</b> 显示密码.</em>
                    {/literal}
                    </div>

                  

                </div>
                <div class="onapptab form" id="resources_tab">
                    <table border="0" cellspacing="0" cellpadding="6" width="100%" >
                        <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> 从文件读取数据, 请稍候...</td></tr>

                      
                       
                        <tr>
                            <td width="160"><label >用户组<a class="vtip_description" title="HostBill将创建新用户和分配到该组"></a></label></td>
                            <td id="option1container" class="tofetch"><input type="text" size="3" name="options[option1]" value="{$default.option1}" id="option1"/>
                            </td>
                        </tr>
                        <tr>
                            <td width="160"><label >密码类型 <a class="vtip_description" title="选择用户密码的存储类型"></a></label></td>
                            <td  ><select name="options[option0]"  >
                                    <option value="MD5-Password" {if $default.option0=='MD5-Password'}selected="selected"{/if}>MD5-密码</option>
                                    <option value="SHA-Password" {if $default.option0=='SHA-Password'}selected="selected"{/if}>SHA-密码</option>
                                    <option value="NT-Password" {if $default.option0=='NT-Password'}selected="selected"{/if}>NT-密码</option>
                                    <option value="User-Password" {if $default.option0=='User-Password'}selected="selected"{/if}>明文密码</option>

                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td width="160"><label >用户属性<a class="vtip_description" title="用户创建后属性将被分配"></a></label></td>
                            <td>
                                <table border="0" cellspacing="0" cellpadding="3" id="trtable">
                                    <tr>
                                        <td width="120">属性:</td>
                                        <td width="70">OP:</td>
                                        <td width="120">值:</td>
                                        <td width="14"></td>
                                    </tr>
                                     {foreach from=$default.option2 item=attribute key=k}
                                    <tr id="tr{$k}">
                                        <td ><input type="text" name="options[option2][{$k}][attribute]" value="{$attribute.attribute}" /></td>
                                        <td ><select name="options[option2][{$k}][op]">
                                                {foreach from=$ops item=op}
                                                <option value="{$op}" {if $op==$attribute.op}selected="selected"{/if}>{$op|htmlspecialchars}</option>
                                                {/foreach}
                                            </select></td>
                                        <td ><input type="text" name="options[option2][{$k}][value]" value="{$attribute.value}" /></td>
                                        <td><a onclick="tr_remove_row(this); return false" class="rembtn" href="#">删除</a></td>
                                    </tr>
                                    {/foreach}
                                     <tr id="tr{if $default.option2}{$k+1}{else}0{/if}">
                                        <td ><input type="text" name="options[option2][{if $default.option2}{$k+1}{else}0{/if}][attribute]" value="" /></td>
                                        <td ><select name="options[option2][{if $default.option2}{$k+1}{else}0{/if}][op]">
                                                {foreach from=$ops item=op}
                                                <option value="{$op}">{$op|htmlspecialchars}</option>
                                                {/foreach}
                                            </select></td>
                                        <td ><input type="text" name="options[option2][{if $default.option2}{$k+1}{else}0{/if}][value]" value="" /></td>
                                        <td><a onclick="tr_remove_row(this); return false" class="rembtn" href="#">删除</a></td>
                                    </tr>
                                </table>
                                <a href="#" class="editbtn" onclick="tr_add_row(); return false;">添加新的属性</a>
                            </td>
                        </tr>

                    </table>
                 
                </div>

            </div>
            {literal}
          

            <script type="text/javascript">
                function tr_remove_row(el) {
                    if ($('#trtable tr').length>2) {
                        $(el).parents('tr').eq(0).remove();
                    } else {
                       $(el).parents('tr').eq(0).find('input').val('');
                    }

                }
                function tr_add_row() {
                    var t = $('#trtable tr:last');
                    if(!t.attr('id')) {
                        return false;
                    }
                    var prev = t.attr('id').replace(/[^0-9]/g,'');
                    next = parseInt(prev)+1;
                    var nw = t.clone();
                    nw.attr('id','tr'+next);
                    nw.find('input, select').each(function(){
                        var n =$(this).attr('name');
                        n=n.replace("["+prev+"]","["+next+"]");
                        $(this).attr('name',n).val('');
                    });
                    
                    $('#trtable').append(nw);
                    return false;
                }
                function preconfigure() {
                    $('#preconfigure_off').hide();
                    $('#preconfigure_on').show();
                    $.post('?cmd=freeradius&action=preconfigure',
                        {
                            id:$('#product_id').val(),
                            cat_id:$('#category_id').val(),
                            server_id:$('#serv_picker input[type=checkbox][name]:checked:eq(0)').val()
                        },function(data){
                            var r=parse_response(data);
                                 ajax_update('?cmd=configfields',{product_id:$('#product_id').val(),action:'loadproduct'},'#configeditor_content');
                        });
                    return false;
                }
               function load_onapp_section(section)  {
                    if(!$('#serv_picker input[type=checkbox][name]:checked:eq(0)').val()) {
                        alert('请先设置&选择服务器');
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
                            make:'loadoptions',
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
             function append_onapp() {
                     if($('#product_id').val()=='new') {
                        $('#onappconfig_ ').html('<b>Please save your product first</b>');

                        return;
                     }
                     if($('#configvar_rd_username').length && $('#configvar_rd_password').length) {
                    $('#preconfigure_off').hide();
                    $('#preconfigure_on').show();

                     }
                    $('#onappconfig_').TabbedMenu({elem:'.onapptab',picker:'.breadcrumb-nav a',aclass:'active',picker_id:'nan1'});
                    
                    $(document).ajaxStop(function() {
                        $('.onapp-preloader').hide();
                    });

                    if($('#serv_picker input[type=checkbox][name]:checked:eq(0)').val())
                        $('#onappconfig_ .breadcrumb-nav a').removeClass('disabled');
                }
                {/literal}{if $_isajax}setTimeout('append_onapp()',50);{else}appendLoader('append_onapp');{/if}{literal}
            </script>

            {/literal}

        </div>

        <link href="{$module_templates}productconfig.css?v={$hb_version}" rel="stylesheet" media="all" />
    </td>
</tr>