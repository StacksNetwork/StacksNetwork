{if $action=='accountslistip'}
    {if $list}
        <select name="imap_ip_id" id="imap_ip_id" class="inp">
            <option value="-{$groupid}">分配整个列表</option>
            {foreach from=$list item=port key=k}
                <option value="{$port.ipaddress}">{$port.ipaddress}</option>
            {/foreach}
        </select>

        <a href="#" onclick="return assignIP();" class="new_control greenbtn" onclick="return false;"><span class="addsth"><strong>分配</strong></span></a>
    {else}
        无法列出端口
    {/if}
{elseif $action=='accountseditor'}
    <link rel="stylesheet" href="templates/default/js/gui.elements.css" type="text/css">
    <link rel="stylesheet" href="../includes/modules/Other/ipam/admin/stylesheet.css" type="text/css">
    <script src="templates/default/js/gui.elements.js" type="text/javascript"></script>
    {literal}
        <script type="text/javascript">
            function assignIP() {
                var v = $('#imap_item_id').val();
                if (v == -2) {
                    //manual
                    var opt = {
                        account_id: $('#account_id').val(),
                        ip: $('#ipam_manual_ip').val(),
                        manual: 1
                    };
                } else if (v > 0) {
                    var opt = {
                        account_id: $('#account_id').val(),
                        ip: $('#imap_ip_id').val(),
                        manual: 0
                    };
                } else {
                    return false;
                }
                $.post('?cmd=module&module=ipam&action=addaccip', opt, function(d) {
                    parse_response(d);
                    loadIpamMGR();
                });
                return false;

            }
            function unassignAllIPs() {
                if (!confirm('您确定吗?')) {
                    return false;
                }

                $.post('?cmd=module&module=ipam&action=removeaccip', {account_id: $('#account_id').val(), current: [], toremove: 'all'}, function() {
                    loadIpamMGR();
                });
                return false;
            }
            function unassignIP(ip) {
                if (!confirm('您确定吗?')) {
                    return false;
                }

                $.post('?cmd=module&module=ipam&action=removeaccip', {account_id: $('#account_id').val(), toremove: ip}, function() {
                    loadIpamMGR();
                });
                return false;
            }
            function getCurrentIps() {
                var ip = [];
                $('.ipam_ips').each(function(n) {
                    ip[n] = $(this).val();
                });
                return ip;
            }
            function setMainIp(ip){
                var params = $('.ipam_ips').clone().attr('name','current').serializeObject(),
                    ipr = params.current.splice(params.current.indexOf(ip),1)[0];
                params.current.unshift(ipr);
                params.account_id =  $('#account_id').val();
                $.post('?cmd=module&module=ipam&action=addaccip', params, function() {
                    loadIpamMGR();
                });
            }
            function load_ipam_options(select) {
                var v = parseInt($(select).val());


                $('#ipam_ips_loader').hide();
                $('#ipam_manual_loader').hide();
                if (v == -2) {
                    $('#ipam_manual_loader').show();
                    return;

                }
                if (v > 0) {
                    $('#ipam_ips_loader').show();
                    ajax_update("?cmd=module&module=ipam&action=accountslistip", {group: v}, '#ipam_ips_loader', true);
                }

                return false;
            }

            function advEdit(id) {
                $.facebox({
                    ajax: "?cmd=module&module=ipam&action=editip&id=" + id,
                    width: 900,
                    nofooter: true,
                    opacity: 0.8
                });
                return false;
            }

        </script>
    {/literal}
    <div id="add_ipam" style="display:none; margin-bottom: 10px;" class="p6">
        <div class="left" style="margin-right:10px;padding:4px"><b>分配新IP:</b></div>
        <select name="imap_item_id" id="imap_item_id" class="inp left" onchange="load_ipam_options(this)" style="margin-right:10px;">
            <option value="0">选择分配方法:</option>
            <option value="-2">手动输入IP/子网</option>
            <option value="-1" disabled style="color:gray;">从IPAM列表中分配IP:</option>
            {foreach from=$lists item=list}
                <option value="{$list.id}" {if $list.indent!='0'}style="padding-left:10px"{/if}>{$list.name}</option>
            {/foreach}
        </select>

        <div id="ipam_ips_loader" class="left" style="display:none"></div>
        <div id="ipam_manual_loader" class="left" style="display:none">IP: <a class="vtip_description vt" title="您可以输入: <br/>- 单个IP<br/>- CIDR子网 (x.x.x.x/y)<br/>- IP范围 x.x.x.x - y.y.y.y"></a><input class="inp" name="manual_ip" id="ipam_manual_ip" style="width:250px"/>
            <a href="#" onclick="return assignIP();" class="new_control greenbtn" onclick="return false;"><span class="addsth"><strong>分配</strong></span></a></div>
        <div class="clear"></div>
    </div>
    <div id="add_main" style="display:none; margin-bottom: 10px;" class="p6">
        <b>选择主IP:</b>
        <select name="imap_main_ip" id="imap_main_ip" class="inp" style="margin-right:10px;" >
            {foreach from=$ipam_ips item=ip}
                <option value="{$ip.ip}" >{$ip.ip}</option>
            {/foreach}
        </select>
        <a href="#" onclick="return setMainIp($('#imap_main_ip').val());" class="new_control" onclick="return false;"><strong>更改</strong></a>
    </div>

    {if $ipam_ips}
        <h3>分配IPs:</h3>
        {if count($ipam_ips)>1}
        <div style="padding:10px 0px">
            <a href="#" class="menuitm " title="更换主IP" onclick="$(this).hide(); $('#add_main').show(); return false"><span class="gear_small">更换主IP</span></a>
            {if count($ipam_ips)>4}
                    <a onclick="$(this).hide();
                    $('#add_ipam').show();
                    $('.vt').vTip();
                    return false;" class="new_control" href="#"><span class="addsth"><strong>分配新IP</strong></span></a>
                    <a href="#" class="menuitm " title="删除" onclick="return unassignAllIPs()"><span class="rmsth">取消分配所有IPs</span></a>

            {/if}
        </div>
        {/if}
        <ul style="border:solid 1px #ddd;border-bottom:none;margin-bottom:15px" id="grab-sorter">
            {foreach from=$ipam_ips item=ip key=i name=iploop}
                <li style="background:#ffffff" class="power_row" data_1="{$itm.item_id}" data_2="{$itm.port_id}" >
                    <div style="border-bottom:solid 1px #ddd;">
                        {if $smarty.foreach.iploop.first}
                            <input type="hidden" name="ip" value="{$i}" class="ipam_ips"  />
                        {else}<input type="hidden" name="additional_ip[]" value="{$i}" class="ipam_ips" />
                        {/if}
                        <table width="100%" cellspacing="0" cellpadding="5" border="0" {if $ip.status == 'reserved'}style="background: #efefef"{/if}>
                            <tbody>
                                <tr>
                                    <td width="120" valign="top">
                                        <div style="padding:10px 0px;">
                                            <a onclick="return unassignIP('{$i}')" title="delete" class="menuitm menuf" href="#"><span class="rmsth">取消分配</span></a>{*}
                                            {*}<a onclick="return advEdit('{$ip.id}')" title="编辑详细内容" class="menuitm menul" href="#"><span class="editsth"></span></a>
                                        </div>
                                    </td>
                                    <td >
                                        <b>
                                            {$i} 
                                            {if $ip.main }<span style="font-weight: normal">(主IP)</span>{/if}
                                            {if $ip.status == 'reserved'}<span style="font-weight: normal">({$ip.client_description})</span>{/if}
                                        </b>
                                    </td>
                                    <td width="160" > 
                                        {if $ip.rdns} rDNS: {$ip.rdns} {/if}
                                        {if $ip.vlan}{if $ip.rdns}<br />{/if} VLAN: {$ip.vlan} {/if}
                                    </td>

                                    <td width="160" > {if $ip.inipam} IPAM列表: <a class="external" target="_blank" href="?cmd=module&module=ipam&group={$ip.listid}">{$ip.listname}</a> {/if}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </li>
            {/foreach}
        </ul>

        <a onclick="$(this).hide();
                $('#add_ipam').show();
                $('.vt').vTip();
                return false;" class="new_control" href="#"><span class="addsth"><strong>分配新IP</strong></span></a>
        <a href="#" class="menuitm " title="delete" onclick="return unassignAllIPs()"><span class="rmsth">取消分配所有IPs</span></a>
    {else}

        <div class="blank_state_smaller blank_forms" id="blank_ipam">
            <div class="blank_info">
                <h3>没有IP已分配给该账户</h3>
                您可以很轻松地使用IPAM模块从IP地址池中分配现有的IP地址, 或手动输入IP地址
                <div class="clear"></div>
                <br /><a onclick="$('#blank_ipam').hide();
                $('.vt').vTip();
                $('#add_ipam').show();
                return false;" class="new_control" href="#"><span class="addsth"><strong>分配IP</strong></span></a>

                <div class="clear"></div>
            </div>
        </div>
    {/if}
{/if}