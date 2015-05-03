
{if !$mode}{literal}
        <script type="text/javascript">
            var actv_form = 0;
            $(function() {
                $('.form_container').hide().eq(0).show();
                $('.content .fleft > div').eq(0).addClass('actv');
                $('.content .fleft > div').each(function(x) {
                    $(this).click(function() {
                        actv_form = x;
                        $('.form_container').hide().eq(x).show();
                        $('.content .fleft > div').removeClass('actv').eq(x).addClass('actv');
                    });
                });
                $("a.vtip_description").vTip();
            });
            function test(l) {
                form = $(l).parents('form');
                ajax_update("?cmd=module&module={/literal}{$moduleid}{literal}&mode=testcon&" + form.serialize(), {}, $(l).next('.test'), false)
            }
            function submitList(form) {
                ajax_update("?cmd=module&module={/literal}{$moduleid}{literal}&mode=addlist&" + form.serialize(), false, function(data) {
                    ajax_update("?cmd=module&module={/literal}{$moduleid}{literal}&refresh=1&", {}, "#treecont");
                    $(document).trigger('close.facebox');
                });
            }
            function shpool(el) {
                if ($(el).is(':checked')) {
                    $('#pool_settings').show();
                } else {
                    $('#pool_settings').hide();
                }
                return false;
            }
            function vtype(ip) {
                $('.cidrts').hide();
                $('#cidr_' + ip).show();
            }
            function inichosen() {
                if (typeof jQuery.fn.chosen != 'function') {
                    $('<style type="text/css">@import url("templates/default/js/chosen/chosen.css")</style>').appendTo("head");
                    $.getScript('templates/default/js/chosen/chosen.min.js', function() {
                        inichosen();
                        return false;
                    });
                    return false;
                }

                $('#client_id', '#facebox').each(function(n) {
                    var that = $(this);
                    var selected = that.attr('default');
                    $.get('?cmd=clients&action=json', function(data) {
                        if (data.list != undefined) {
                            for (var i = 0; i < data.list.length; i++) {
                                var name = data.list[i][3].length ? data.list[i][3] : data.list[i][1] + ' ' + data.list[i][2];
                                var select = selected == data.list[i][0] ? 'selected="selected"' : '';
                                that.append('<option value="' + data.list[i][0] + '" ' + select + '>#' + data.list[i][0] + ' ' + name + '</option>');
                            }
                        }
                        that.chosen();

                    });
                });
                $('#vlan_id').each(function(n) {
                    var that = $(this),
                        set = that.attr('default');
                    $.get('?cmd=ipam&action=vlan_lists', function(data) {
                        $.each(data.vlangroups, function(){
                            var optg = this,
                                optgh = $('<optgroup label="'+optg.name+'"></optgroup>').appendTo(that);
                            $.each(optg.list, function(){
                                $('<option value="' + this.id + '" >#' + this.vlan + ' ' + this.name + '</option>').prop('selected',set == this.id).appendTo(optgh);
                            })
                        });
                        that.chosen();
                    }); 
                });
            }
            inichosen();
        </script>
    {/literal}
    <table width="100%"><tr>
            <td class="fleft">
                <div>添加新列表</div>
                {if $suported}
                    {foreach from=$suported item=api}
                        <div>{$api.modname}</div>
                    {/foreach}
                {/if}
            </td>
            <td class="fright">
                <h3 style="margin-bottom:0px;">
                    添加 {if $suported}或导入 {/if}新IP {if $sublist}子网到 {$sublist.name}{else}列表{/if}
                </h3>
                <div class="form_container">
                    <form action="?cmd=module&module={$moduleid}" method="post" onsubmit="return false">
                        <input type="hidden" name="action" value="addlist" />
                    {if $sublist}<input type="hidden" name="sub" value="{$sublist.id}" />{/if}
                    <br/>
                    <label>列表名称</label><input type="text" name="listname" value="" />
                    <div class="clear"></div>



                    <label class="nodescr">所有人</label>
                    <select  class="w250" name="client_id" load="clients"  id="client_id" ><option value="0">无</option></select>
                    <div class="clear"></div>

                    <label>IP类型</label><select name="type" class="w250" onchange="vtype($(this).val())">
                        <option value="ipv4">IPv4</option>
                        <option value="ipv6">IPv6</option>
                    </select>
                    <div class="clear"></div>

                    <label class="nodescr">VLAN</label>
                    <select  class="w250" name="vlan_id" default="{$group.vlan_id}" id="vlan_id" load="?cmd=ipam&action=vlan" >
                        <option value="0" {if !$group.vlan_id || $group.vlan_id=='0'}selected="selected"{/if}>无</option>
                    {if $vlan}<option value="{$vlan.id}" selected="selected">#{$vlan.vlan} {$vlan.name}</option>{/if}
                </select>
                <div class="clear"></div>

                <label>自动分配 <a class="vtip_description" title="启用该选项, 如果您想使用IP地址池自动配置服务器"></a></label>
                <input type="checkbox" name="autoprovision" value="1" />
                <div class="clear"></div>

                <label>私有? <a class="vtip_description" title="仅供信息显示的作用与自动化IP配置"></a></label>
                <input type="checkbox" name="private" value="1" />
                <div class="clear"></div>

                <label>填写IP地址池?</label><input type="checkbox" name="is_pool" value="1" onclick="shpool(this)" />

                <div class="clear"></div>
                <div id="pool_settings" style="display:none">
                    <label>网络(CIDR)</label><input type="text" name="firstip" value=""  class="w250 left" style="width:200px;margin-right:10px;"/>
                    <select name="cidr_ipv4" id="cidr_ipv4" class="w250 left cidrts" style="width:80px">
                        {foreach from=$v4blocks item=i key=k}
                            <option value="{$k}">{$k} ({$i})</option>
                        {/foreach}
                    </select>
                    <select name="cidr_ipv6" id="cidr_ipv6" class="w250 left cidrts" style="width:80px;display:none">
                        {foreach from=$v6blocks item=i key=k}
                            <option value="{$k}">{$k} ({$i})</option>
                        {/foreach}
                    </select>
                    <div class="clear"></div>
                    <label>网关</label><input type="text" name="gateway" value=""  class="w250"/>
                    <div class="clear"></div>
                </div>


                <label>说明</label><textarea name="description" class="w250"></textarea>
                <div class="clear"></div>

            </form>
        </div>
        {if $suported}
            {foreach from=$suported item=api}
                <div class="form_container">
                    <form action="?cmd=module&module={$moduleid}" method="post" onsubmit="return false" >
                        <input type="hidden" name="action" value="addlist" />
                    {if $sublist}<input type="hidden" name="sub" value="{$sublist.id}" />{/if}
                    <input type="hidden" name="import" value="{$api.id}" />
                    <br>
                    <label>列表名称</label><input type="text" name="listname" value="" />
                    {if $forms[$api.id] && is_array($forms[$api.id])}
                        {foreach from=$forms[$api.id] item=field}
                            <label>{$field.name}{if $field.descr}<br /><small>{$field.descr}</small>{/if}</label><{$field.type} {if $field.attr}{foreach from=$field.attr item=attr key=atn}{$atn}="{$attr}"{/foreach}{/if}>
                                {/foreach}
                            {else}
                        <label>标识</label><input type="text" name="host" value="" />
                        <label>IP地址</label><input type="text" name="ip" value="" />
                        <label>用户名</label><input type="text" name="username" value="" />
                        <label>密码</label><input type="password" name="password" value="" />
                        <label>保护</label><input type="checkbox" name="secure" value="1" />
                    {/if}
                    <br />
                    <a href="#" class="testcon" onclick="test(this)">测试连接</a>
                    <div class="cleat test"></div>
                </form>
            </div>
        {/foreach}
    {/if}
</td>
</tr></table>
<div style=" background: #272727; box-shadow: 0 -1px 2px rgba(0, 0, 0, 0.3); color: #FFFFFF; height: 20px; padding: 11px 11px 10px; clear:both">
    <div class="left spinner" style="display: none;">
        <img src="ajax-loading2.gif">
    </div>
    <div class="right">
        <span class="bcontainer ">
            <a class="new_control greenbtn" onclick="$('.spinner').show();
                submitList($('.form_container form').eq(actv_form));
                return false;" href="#">
                <span>添加列表</span>
            </a>
        </span>
        <span class="bcontainer">
            <a class="submiter menuitm" href="#" onclick="$(document).trigger('close.facebox');
                return false;">
                <span>关闭</span>
            </a>
        </span>
    </div>
    <div class="clear"></div>
</div>
{elseif $mode == 'testcon'}
{if $conection == 1}<span class="Successfull"><strong>成功!</strong></span>{else}<span class="error">错误: {$conection}</span>{/if}
{/if}