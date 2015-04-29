{literal}
    <script type="text/javascript">
        if (typeof(loadSwitchMgr) !== 'function') {
            function loadSwitchMgr() {
                ajax_update('?cmd=switch_control&action=getAvailableSwitches', {account_id: $('#account_id').val()}, '#switchmgr');
            }
        }
        function load_switch_ports(select) {
            var v = $(select).val();
            if (!v)
                return;
            ajax_update('?cmd=switch_control&action=loadports', {item_id: v, account_id: $('#account_id').val()}, '#switch_port_loader', true);
        }
        function assignSwitchPort() {
            if (!$('#switch_item_id').val())
                return false;

            $.post('?cmd=module&module=dedimgr&do=addassignment', {
                account_id: $('#account_id').val(),
                port_id: $('#switch_port_id').val(),
                item_id: $('#switch_item_id').val(),
                server_id: $('#switch_server_id').val(),
                port_name: $('#switch_port_id option:selected').text()
            }, function(data) {
                parse_response(data);
                loadSwitchMgr();
            });
            return false;
        }
        function cycleSwitchPower(item_id, port_id, id) {
            var p = port_id.replace(/[\.\/]/g, '');
            var state = 'state_' + item_id + '' + p;
            if (!$('#' + state).length) {
                return false;
            }
            var confirmation = false;
            var s = $('#' + state).text();
            if (s == 'UP') {
                if (confirm('您确定要禁用该端口吗?')) {
                    confirmation = 'down';
                }
            } else if (s == 'DOWN') {
                if (confirm('您确定要启用该端口吗?')) {
                    confirmation = 'up';
                }
            }
            if (confirmation) {
                $('#' + state).removeClass('power_down').removeClass('power_up').html('<span class="fs11">加载状态...</span>').addClass('unknown');
                $.post('?cmd=switch_control&action=cyclestate', {
                    account_id: $('#account_id').val(),
                    port_id: port_id,
                    item_id: item_id,
                    id: id,
                    power: confirmation
                }, function(data) {
                    parse_response(data);
                    loadSwitchMgr();
                });
            }
            return false;
        }
        function loadSwitchStatuses() {
            $('.switch_state_row').each(function() {
                var row = $(this);
                if ($('td.unknown', $(this)).length) {
                    var td = $('td.unknown', $(this));
                    $.getJSON('?cmd=switch_control&action=loadstatus', {
                        item_id: row.attr('data-item-id'),
                        port_id: row.attr('data-port-id'),
                        id: row.attr('data-id')
                    }, function(data) {
                        td.removeClass('unknown').html('unknown');
                        if (data.status) {
                            td.addClass('power_' + data.status);
                            td.html(data.status.toString().toUpperCase());
                        }
                    }
                    );
                }
            });
        }
        function unassignSwitchPort(item_id, port_id, id) {
            if (!confirm('您确定要取消分配该端口?'))
                return false;
            $.post('?cmd=module&module=dedimgr&do=rmassignment', {
                account_id: $('#account_id').val(),
                port_id: port_id,
                item_id: item_id,
                id: id
            }, function() {
                loadSwitchMgr();
            });
            return false;
        }
    </script>
    <style>
        .unknown  { background:#F0F0F3;color:#767679;}
        .power_up {font-weight:bold;background:#BBDD00;}
        .power_down {font-weight:bold;background:#AAAAAA;}
    </style>
{/literal}
<div id="add_switch" style="display:none" class="p6">
    <div class="left" style="margin-right:10px;padding:4px"><b>分配新的交换机端口:</b></div>
    <select name="item_id" id="switch_item_id" class="inp left" onchange="load_switch_ports(this)" style="margin-right:10px;">
        <option value="0">选择交换机进行分配</option>
        {foreach from=$pdus item=pdu}
            <option value="{$pdu.id}">{$pdu.rackname} - {$pdu.name} {if $pdu.label} ({$pdu.label}){/if}</option>
        {/foreach}
    </select>

    <div id="switch_port_loader" class="left"></div>
    <div class="clear"></div>
</div>
{if $items}

    <ul style="border:solid 1px #ddd;border-bottom:none;margin-bottom:15px" id="grab-sorter">

        {foreach from=$items item=itm}
            <li style="background:#ffffff" class="switch_state_row" data-item-id="{$itm.item_id}" data-port-id="{$itm.port_id}" data-id="{$itm.id}" ><div style="border-bottom:solid 1px #ddd;">
                    <table width="100%" cellspacing="0" cellpadding="5" border="0">
                        <tbody>
                            <tr>
                                <td width="80" valign="middle" align="center" id="state_{$itm.item_id}{$itm.port_id|replace:'.':''|replace:'/':''}" 
                                    class="{if $itm.port_status==='0'}power_down{elseif $itm.port_status==='1'}power_up{else}unknown{/if}">
                                    {if $itm.port_status==='0'}DOWN{elseif $itm.port_status=='1'}UP{else}<span class="fs11">加载状态...</span>{/if}
                                </td>
                                <td width="120" valign="top">
                                    <div style="padding:10px 0px;">
                                        <a onclick="return cycleSwitchPower('{$itm.item_id}', '{$itm.port_id}', '{$itm.id}')" class="sorter-ha menuitm menuf" href="#"><span title="move" class="gear_small">启用 / 禁用</span></a><!--
                                        --><a onclick="return unassignSwitchPort('{$itm.item_id}', '{$itm.port_id}', '{$itm.id}')" title="删除" class="menuitm menul" href="#"><span class="rmsth">取消分配</span></a>
                                    </div>
                                </td>
                                <td>
                                    {foreach from=$pdus item=pdu}
                                        {if $pdu.id==$itm.item_id}Rack: {$pdu.rackname}, Switch: {$pdu.name},
                                        {/if} 
                                    {/foreach} 
                                    Port: <b>{$itm.port_name}</b>
                                </td>
                                <td width="150"> {foreach from=$pdus item=pdu}{if $pdu.id==$itm.item_id}<a href="?cmd=module&module=dedimgr&do=rack&rack_id={$pdu.rack_id}" class="external" target="_blank">{$pdu.rackname}</a>{/if} {/foreach}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </li>
        {/foreach}
    </ul>
    <a onclick="$(this).hide();
            $('#add_switch').show();
            return false;" class="new_control" href="#"><span class="addsth"><strong>连接交换机端口到该服务器</strong></span></a> <span class="orspace fs11">备注: 端口分配将在账户挂起时自动禁用</span>

{else}
    {if $pdus}
        <div class="blank_state_smaller blank_forms" id="blank_switch">
            <div class="blank_info">
                <h3>连接交换机和服务器的端口.</h3>
                <span class="fs11">您可以启用此服务器交换机/端口控制如果交换机端口指定, 与挂起/非挂起的指定端口将被禁用/启用</span>
                <div class="clear"></div>
                <br>
                <a onclick="$('#blank_switch').hide();
            $('#add_switch').show();
            return false;" class="new_control" href="#"><span class="addsth"><strong>服务器连接该交换机的端口</strong></span></a>
                <div class="clear"></div>
            </div>
        </div>

    {else}
        <div class="blank_state blank_news">
            <div class="blank_info">
                <h1>没有任何交换机连接</h1>
                No switch was defined in dedicated servers manager yet. To add Switch: <br/>
                - go To Settings->Modules, locate switch_snmp or switch_telnet module and activate it <br/>
                - under Settings->Apps create new App with newly enabled switch module, select most matching unit to one you're using <br/>
                - you can repeat step above for each switch you have <br/>
                - go to Extras->Dedicated Servers Manager <br/>
                - define switch modules under Inventory, make sure to add Switch App field to inventory item <br/>
                - add Your new Inventory item to rack, while adding, select one of Apps defined in previous steps, corresponding to actual Switch <br/>
                - use Load ports button to setup ports in connection manager or setup them manually <br/>
                - Your newly defined Switch and its ports will be available here <br/>
                <div class="clear"></div>
                <div class="clear"></div>
            </div>
        </div>
    {/if}
{/if}

<script>loadSwitchStatuses();</script>