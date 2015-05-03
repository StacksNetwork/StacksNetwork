{literal}
    <script type="text/javascript">
        function load_pdu_ports(select) {
            var v = $(select).val();
            if (!v)
                return;
            ajax_update('?cmd=pdu_snmp&action=loadports', {item_id: v, account_id: $('#account_id').val()}, '#pdu_port_loader', true);
        }
        function assignPort() {
            if (!$('#pdu_item_id').val())
                return false;

            $.post('?cmd=module&module=dedimgr&do=addassignment', {
                account_id: $('#account_id').val(),
                port_id: $('#pdu_port_id').val(),
                item_id: $('#pdu_item_id').val(),
                server_id: $('#pdu_server_id').val(),
                port_name: $('#pdu_port_id option:selected').text()
            }, function(data) {
                parse_response(data);
                loadPDUMgr();
            });
            return false;
        }
        function cyclePower(item_id, port_id, id) {
            var p = port_id.replace(/\./g, '');
            var state = 'state_' + item_id + '' + p;
            if (!$('#' + state).length) {
                return false;
            }
            var confirmation = false;
            var s = $('#' + state).text();
            if (s == 'ON') {
                if (confirm('Are you sure you wish to power this port OFF?')) {
                    confirmation = 'off';
                }
            } else if (s == 'OFF') {
                if (confirm('Are you sure you wish to power this port ON?')) {
                    confirmation = 'on';
                }
            }
            if (confirmation) {

                $('#' + state).removeClass('power_off').removeClass('power_on').html('<span class="fs11">Loading status...</span>').addClass('unknown');
                $.post('?cmd=pdu_snmp&action=cyclepower', {
                    account_id: $('#account_id').val(),
                    port_id: port_id,
                    item_id: item_id,
                    id: id,
                    power: confirmation
                }, function(data) {
                    parse_response(data);
                    loadPDUMgr();
                });
            }
            return false;
        }
        function loadStatuses() {
            $('.power_row').each(function() {
                var row = $(this);
                if ($('td.unknown', $(this)).length) {
                    var td = $('td.unknown', $(this));
                    $.getJSON('?cmd=pdu_snmp&action=loadstatus', {
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
        function unassignPort(item_id, port_id, id) {
            if (!confirm('Are you sure you want to unassign this port?'))
                return false;
            $.post('?cmd=module&module=dedimgr&do=rmassignment', {
                account_id: $('#account_id').val(),
                port_id: port_id,
                item_id: item_id,
                id: id
            }, function() {
                loadPDUMgr();
            });
            return false;
        }
    </script>
    <style>
        .unknown  { background:#F0F0F3;color:#767679;}
        .power_on {font-weight:bold;background:#BBDD00;}
        .power_off {font-weight:bold;background:#AAAAAA;}
    </style>
{/literal}
<div id="add_pdu" style="display:none" class="p6">
    <div class="left" style="margin-right:10px;padding:4px"><b>Assign new PDU port:</b></div>
    <select name="item_id" id="pdu_item_id" class="inp left" onchange="load_pdu_ports(this)" style="margin-right:10px;">
        <option value="0">Select PDU to assign</option>
        {foreach from=$pdus item=pdu}
            <option value="{$pdu.id}">{$pdu.rackname} - {$pdu.name}{if $pdu.label} ({$pdu.label}){/if}</option>
        {/foreach}
    </select>

    <div id="pdu_port_loader" class="left"></div>
    <div class="clear"></div>
</div>
{if $items}

    <ul style="border:solid 1px #ddd;border-bottom:none;margin-bottom:15px" id="grab-sorter">
        {foreach from=$items item=itm}
            <li style="background:#ffffff" class="power_row"  data-item-id="{$itm.item_id}" data-port-id="{$itm.port_id}" data-id="{$itm.id}" >
                <div style="border-bottom:solid 1px #ddd;">
                    <table width="100%" cellspacing="0" cellpadding="5" border="0">
                        <tbody>
                            <tr>
                                <td width="80" valign="middle" align="center" id="state_{$itm.item_id}{$itm.port_id|replace:'.':''}" 
                                    class="{if $itm.port_status==='0'}power_off{elseif $itm.port_status==='1'}power_on{else}unknown{/if}">{*}
                                    {*}{if $itm.port_status==='0'}OFF{elseif $itm.port_status=='1'}ON{else}<span class="fs11">Loading status...</span>{/if}{*}
                                {*}</td>
                                <td width="120" valign="top">
                                    <div style="padding:10px 0px;">
                                        <a onclick="return cyclePower('{$itm.item_id}', '{$itm.port_id}', '{$itm.id}')" class="sorter-ha menuitm menuf" href="#"><span title="move" class="gear_small">On / Off</span></a><!--
                                        --><a onclick="return unassignPort('{$itm.item_id}', '{$itm.port_id}', '{$itm.id}')" title="delete" class="menuitm menul" href="#"><span class="rmsth">Unassign</span></a>
                                    </div>
                                </td>
                                <td>
                                    <strong>PDU Port:</strong><br />
                                    Rack: <a href="?cmd=module&module=dedimgr&do=rack&rack_id={$itm.rack_id}" class="external" target="_blank">{$itm.rack_name}</a>
                                    , PDU:  <a href="?cmd=module&module=dedimgr&do=itemeditor&item_id={$itm.item_id}" class="external" 
                                               title="{$itm.item_name}"
                                               target="_blank">
                                        {if $itm.item_label}{$itm.item_label}{else}{$itm.item_name}{/if}
                                    </a>
                                    , Port: <b>{if $itm.port_name}{$itm.port_name}{elseif $itm.port_id}{$itm.port_id}{else}{$itm.number}{/if}</b>
                                </td>
                                <td style="width: 40%"> 
                                    <strong>Connected to:</strong><br />
                                    {if $itm.connected_port_number}
                                        Rack: <a href="?cmd=module&module=dedimgr&do=rack&rack_id={$itm.connected_rack_id}" class="external" target="_blank">{$itm.connected_rack_name}</a>
                                        , PDU:  <a href="?cmd=module&module=dedimgr&do=itemeditor&item_id={$itm.connected_item_id}" class="external" 
                                                   title="{$itm.connected_item_name}"
                                                   target="_blank">
                                            {if $itm.connected_item_label}{$itm.connected_item_label}{else}{$itm.connected_item_name}{/if}
                                        </a>
                                        , Port: <b>{if $itm.connected_port_name}{$itm.connected_port_name}{elseif $itm.connected_port_id}{$itm.connected_port_id}{else}{$itm.connected_port_number}{/if}</b>
                                    {else}
                                        Not connected
                                    {/if}
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </li>
        {/foreach}
    </ul>

    <a onclick="$(this).hide();
            $('#add_pdu').show();
            return false;" class="new_control" href="#"><span class="addsth"><strong>Connect PDU port to this server</strong></span></a>

{else}
    {if $pdus}
        <div class="blank_state_smaller blank_forms" id="blank_pdu">
            <div class="blank_info">
                <h3>Connect PDU ports with this server.</h3>
                <span class="fs11">You can enable PDU control for this server owner, allowing for powering off/on/remote reboots trough PDU</span>
                <div class="clear"></div>
                <br>
                <a onclick="$('#blank_pdu').hide();
            $('#add_pdu').show();
            return false;" class="new_control" href="#"><span class="addsth"><strong>Connect PDU port to this server</strong></span></a>
                <div class="clear"></div>
            </div>
        </div>

    {else}
        <div class="blank_state blank_news">
            <div class="blank_info">
                <h1>No PDU connection set</h1>
                No PDU is defined in dedicated servers manager yet. To add PDU: <br/>
                - go To Settings->Modules, locate PDU_snmp module and activate it <br/>
                - under Settings->Apps create new App with PDU_snmp module, select most matching unit to one you're using <br/>
                - you can repeat step above for each PDU you have <br/>
                - go to Extras->Dedicated Servers Manager <br/>
                - define PDU modles under Inventory, make sure to add PDU App field to inventory item <br/>
                - add Your new Inventory item to rack, while adding, select one of Apps defined in previous steps, corresponding to actual PDU <br/>
                - Your newly defined PDU and its ports will be available here <br/>
                <div class="clear"></div>
                <div class="clear"></div>
            </div>
        </div>
    {/if}
{/if}

<script>loadStatuses();</script>