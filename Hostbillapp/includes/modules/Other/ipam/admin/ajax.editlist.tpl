<table width="100%">
    <tr>
        <td class="fright">
            <h3 style="margin-bottom:0px;">编辑列表详情 {$group.name}</h3>
            <div class="form_container">
                <form action="?cmd=module&module={$moduleid}" method="post" onsubmit="return false">
                    <input type="hidden" name="action" value="editlist" />
                    <input type="hidden" name="group" value="{$group.id}" />

                    <br/>

                    <label>列表名称</label><input type="text" name="name" value="{$group.name}" />
                    <div class="clear"></div>

                    <label class="nodescr">所有人</label>
                    <select  class="w250" name="client_id" load="clients" default="{$group.client_id}" id="client_id" ><option value="0">无</option></select>
                    <div class="clear"></div>


                    <label class="nodescr">上层列表</label>
                    <select  class="w250" name="parent_id" default="{$group.client_id}" id="parent_id" >
                        <option value="0" {if !$group.parent_id || $group.parent_id=='0'}selected="selected"{/if}>无</option>

                        {foreach from=$servers item=server}
                            <option value="{$server.id}" {if $group.parent_id==$server.id}selected="selected"{/if}>{$server.name}</option>
                        {/foreach}
                    </select>
                    <div class="clear"></div>
                    
                    <label class="nodescr">VLAN</label>
                    <select  class="w250" name="vlan_id" default="{$group.vlan_id}" id="vlan_id" load="?cmd=ipam&action=vlan" >
                        <option value="0" {if !$group.vlan_id || $group.vlan_id=='0'}selected="selected"{/if}>无</option>
                        {if $vlan}<option value="{$vlan.id}" selected="selected">#{$vlan.vlan} {$vlan.name}</option>{/if}
                    </select>
                    <div class="clear"></div>

                    <label>说明</label><textarea name="description" class="w250">{$group.description}</textarea>
                    <div class="clear"></div>

                    <label>自动分配 <a class="vtip_description" title="启用该选项, 如果您需要将地址池自动配置完成服务器"></a></label>
                    <input type="checkbox" name="autoprovision" value="1" {if $group.autoprovision=='1'}checked="checked"{/if} />
                    <div class="clear"></div>

                    <label>私人? <a class="vtip_description" title="仅对信息和自动IP配置"></a></label>
                    <input type="checkbox" name="private" value="1" {if $group.private=='1'}checked="checked"{/if} />
                    <div class="clear"></div>
                </form>
            </div>
        </td>
    </tr>
</table>
<div style=" background: #272727; box-shadow: 0 -1px 2px rgba(0, 0, 0, 0.3); color: #FFFFFF; height: 20px; padding: 11px 11px 10px; clear:both">
    <div class="left spinner" style="display: none;">
        <img src="ajax-loading2.gif" />
    </div>
    <div class="right">
        <span class="bcontainer ">
            <a class="new_control greenbtn" onclick="$('.spinner').show();
                        submitIPRange($('#facebox .form_container form').eq(0));
                        return false;" href="#">
                <span>更新列表详情</span>
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
{literal}
    <script type="text/javascript">
        $(function() {
            $("a.vtip_description").vTip();
            inichosen();
        });
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
    </script>
{/literal}