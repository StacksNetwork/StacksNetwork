<div class="form port-form clearfix">
    <h3>
        {if $port.type=='NIC'}
            <img src="{$moduledir}icons/network-ethernet.png" alt="" style="margin-right:5px" class="left"  />
        {else}
            <img src="{$moduledir}icons/plug.png" alt="" style="margin-right:5px" class="left"  />
        {/if} <span class="left">{$port.item_label} - 
            {if $port.type=='PDU'}
                Socket
            {else}
                端口
            {/if}
            #{$port.number}
        </span>
    </h3>

    <a onclick="closePortEditor();
            return false;" class=" menuitm right" href="#"><span><b>关闭</b></span></a>
    <div class="clear"></div>

    {if $port.type=='NIC'}
        <div class="form-group">
            <label class="nodescr">MAC</label>
            <input type="text" class="w250" name="port[mac]" value="{$port.mac}" placeholder="eg. 01:23:45:67:89:AB" />
        </div>
        <div class="form-group">
            <label class="nodescr">IPv4 / IPv6</label>
            <input type="text" style="width:100px"  name="port[ipv4]" value="{$port.ipv4}" placeholder="eg. 192.168.1.1" />
            <input type="text" style="width:200px"  name="port[ipv6]" value="{$port.ipv6}" placeholder="eg. 2002:c0a8:0a64::c0a8:0a64" />
        </div>
    {/if}

    <div class="form-group">
        <label class="nodescr">硬件端口ID/标签</label>
        <input type="text"  style="width:100px" name="port[port_id]" value="{$port.port_id}" />
        <input type="text"  style="width:200px" name="port[port_name]" value="{$port.port_name}" />
    </div>
    <div class="form-group">
        <label class="nodescr">连接设备/机柜</label>
        <select  class="w250" name="port[rack_id]" default="{$port.rack_id}" id="port_rack_id" onchange="changePortRack($(this).val());"><option value="0">未连接</option>
            {foreach from=$racks item=floor}

                <optgroup label="Floor {$floor[0].floor_id} {if $floor[0].floorname}- {$floor[0].floorname}{/if}">
                    {foreach from=$floor item=rack}
                        <option value="{$rack.id}" {if $port.rack_id==$rack.id}selected="selected"{/if}>{$rack.name} ({$rack.units} U)</option>
                    {/foreach}
                </optgroup>
            {/foreach}
        </select>
    </div>


    <div class="form-group" id="port_item_id_container" {if !$port.rack_id}style="display:none"{/if}>
        {include file='ajax.rackitems.tpl'}
    </div>

    <div class="form-group" id="port_port_id_container" {if !$port.connected_id}style="display:none"{/if}>
        {include file='ajax.itemports.tpl'}
    </div>

    {if $ipam &&  $port.type=='NIC'}
        <div class="form-group">
            <span>更新IPAM的IP分配</span>
            <input type="checkbox" value="1" name="port[ipam]" checked="checked" /> 
        </div>
    {/if}

    <input type="hidden"  name="port[old_connected_to]" value="{$port.connected_to}" id="port_old_connected_to"/>
    <input type="hidden"  name="port[type]" value="{$port.type}" id="port_type" />
    <input type="hidden"  name="port[id]" value="{$port.id}" id="port_id"/>
    <input type="hidden" name="port[item_id]" value="{$port.item_id}"/>
    <input type="hidden" name="port[direction]" value="{$port.direction}" />
    <input type="hidden" name="port[old_ipv4]" value="{$port.ipv4}" />
    <input type="hidden" name="port[old_ipv6]" value="{$port.ipv6}" />
</div>

<div class="dark_shelf dbottom">
    <div class="left spinner"><img src="ajax-loading2.gif"></div>
    <div class="right">
        <span class="bcontainer ">
            <a onclick="savePortForm('{$port.id}');
            return false" href="#" class="new_control greenbtn"><span>更新端口详情</span>
            </a>
        </span>
        <span>或</span>
        <span class="bcontainer">
            <a onclick="closePortEditor();
            return false;" class="submiter menuitm" href="#"><span>关闭</span></a>
        </span>
    </div>
    <div class="clear"></div>
</div>
{literal}
    <script>
        function closePortEditor() {
            if ($('#facebox #porteditor').length) {
                $('#porteditor').hide();
            } else {
                $(document).trigger('close.facebox');
            }
        }

        function savePortForm(id) {
            var s = $('input,select', '.port-form').serialize();
            $('.spinner:last').show();
            $.post('?cmd=module&module=dedimgr&do=saveport&' + s, {}, function(data) {
                $('.spinner:last').hide();
                refreshports();
                closePortEditor();
            })
        }

        function changePortRack(v) {
            //load items
            if (v == '0') {
                $('#port_item_id_container').hide().html('');
                $('#port_port_id_container').hide().html('');
                return;
            }
            $('#port_item_id_container').html('').show();
            $('#port_port_id_container').html('').show();
            ajax_update('?cmd=module&module=dedimgr&do=rackitms&rack_id=' + v, {}, '#port_item_id_container');
        }
        function changePortItem(e) {
            //load ports
            var v = $(e).val();
            $('#port_port_id_container').html('');
            if (v == '0') {
                $('#port_port_id_container').hide();
                return;
            }
            $('#port_port_id_container').show();
            ajax_update('?cmd=module&module=dedimgr&do=itemports&item_id=' + v, {
                old: $('#port_old_connected_to').val(),
                type: $('#port_type').val(),
                id: $('#port_id').val()
            }, '#port_port_id_container');
        }
    </script>
{/literal}