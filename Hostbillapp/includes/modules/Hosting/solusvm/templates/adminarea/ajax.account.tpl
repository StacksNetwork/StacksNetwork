{if $vpsdo == 'list_nodes'}
    <select name="extra_details[option10]" >
        {foreach from=$nodes item=type key=typename}
            <optgroup label="{$typename}">
                {foreach from=$type item=node}
                    <option {if $current == $node}selected="selected"{/if} value="{$node}">{$node}</option>
                {/foreach}
            </optgroup>
        {/foreach}
    </select>
{elseif $vpsdo == 'getstatus'}
{if $status}<span class="yes">Yes</span>{else}<span class="no">No</span>{/if}
{elseif $vpsdo == 'clientsvms'}
    {if $provisioning_type == 'cloud'}
        <table width="100%" cellspacing="0" class="data-table backups-list">
            <thead>
                <tr>
                    <td></td>
                    <td>ID</td>
                    <td>Node</td>
                    <td>Hostname</td>
                    <td>IP Address</td>
                    <td>Memory</td>
                    <td>Disk Space</td>
                    <td>CPU</td>
                    <td>Bandwidth</td>
                </tr> 
            </thead>
            <tbody>
                {counter name=vmcount start=0 print=false assign=vmcount}
                {if !$vms}
                    <tr><td colspan="28"><b>No virtual machines found</b></td></tr>
                {else}
                    {foreach from=$vms item=vm}
                        {counter name=vmcount}
                        <tr>
                            <td class="power-status" rel="{$vm.veid}"><span class="no">No</span></td>
                            <td><a href="{$solusurl}/admincp/manage.php?id={$vm.veid}" target="_blank" class="external"><strong>{$vm.veid}</strong></a></td>
                            <td>
                                <a href="{$solusurl}/admincp/managenode.php?id={$vm.node.id}" target="_blank"  class="external" title="Manage node">
                                    {$vm.node.name}
                                </a>
                            </td>
                            <td>{$vm.name}</td>
                            <td>{$vm.ip}</td>
                            <td>{$vm.guaranteed_ram} MB</td>
                            <td>{$vm.disk_limit} GB</td>
                            <td>{$vm.extra.cpu} </td>
                            <td>{$vm.bw_limit} GB</td>
                        </tr>
                    {/foreach}
                {/if}
            </tbody>
        </table>
        {literal}
            <script type="text/javascript">
            $('#vm_count').text('{/literal}{$vmcount}{literal}');
            $('.power-status').each(function(){
                var rel = $(this);
                $.post('{/literal}?cmd=accounts&action=edit&id={$details.id}&service={$details.id}{literal}', {vpsdo: 'getstatus', vpsid: rel.attr('rel')}, function(data){
                    var r = parse_response(data);
                    rel.html(r); 
                });
            });
        
            </script>
        {/literal}
    {elseif $provisioning_type == 'single'}
        <div class="data-table backups-list">
            {if $vm_import}
                {if $vm_import_list}
                    <p>Select VM that should be associated with this account</p>
                    <select id="vm_bind" class="inp" name="vm_bind">
                    {foreach from=$vm_import_list item=item}
                        <option value="{$item.vserverid}"> #{$item.vserverid} {$item.hostname} ({$item.ipaddress}) - {if $item.client.company}{$item.client.company}{else}{$item.client.firstname} {$item.client.lastname}{/if} ({$item.client.email})</option> 
                    {/foreach}
                    </select> <br />
                    <button onclick="load_clientvm(true,$('#vm_bind').val()); return false;" title="This operation may take a while">Synchronize</button> 
                {else}
                    <p>Missing or invalid VPS ID</p>
                    <button onclick="load_clientvm(true,'sync'); return false;" title="This operation may take a while">Synchronize</button> 
                    <script type="text/javascript">sync_alert();</script>
                {/if}
            {/if}
             
            {if $vm}
                {if $save_veid}
                    <script type="text/javascript">window.location = "?cmd=accounts&action=edit&id={$details.id}"</script>
                    <input type="hidden" value="{$vm.id}" name="extra_details[option6]" >
                {/if}
            {if $vm.trafficgraph!=false || $vm.loadgraph!=false || $vm.memorygraph!=false || $vm.type =='openvz' }
                
                <table width="50%" cellspacing="0" class="data-table backups-list right" style="text-align: center">
                    <thead>
                        <tr>
                            <td colspan="5">Usage graphs</td>
                        </tr>
                    </thead>
                    <tbody>

                    {if $vm.trafficgraph != ''}
                        <tr><td style="height:180px">
                        <img src="?cmd=module&module={$moduleid}&action=usage&vpsid={$vm.id}&type=trafficgraph&id={$details.id}" alt="Traffic graph" width="497" height="153"/>
                        </tr></td>
                    {elseif $vm.type =='openvz'}
                        <tr><td>
                        <p>Bandwidth Usage graph is not available yet. <a href="#" onclick="$('#vmrefresh').click();">Click</a> to reload.</p>
                        </td></tr>
                    {/if}

                    {if $vm.loadgraph != ''}
                        <tr><td style="height:180px">
                        <img src="?cmd=module&module={$moduleid}&action=usage&vpsid={$vm.id}&type=loadgraph&id={$details.id}" alt="Load graph" width="497" height="153" />
                        </td></tr>
                    {elseif $vm.type =='openvz'}
                        <tr><td>
                        <p>CPU Load Usage graph is not available yet. <a href="#" onclick="$('#vmrefresh').click();">Click</a> to reload.</p>
                        </td></tr>
                    {/if}

                    {if $vm.memorygraph != ''}
                        <tr><td style="height:180px">
                        <img src="?cmd=module&module={$moduleid}&action=usage&vpsid={$vm.id}&type=memorygraph&id={$details.id}" alt="Memory graph" width="497" height="153" />
                        </td></tr>
                    {elseif $vm.type =='openvz'}
                        <tr><td>
                        <p>Memory Usage graph is not available yet. <a href="#" onclick="$('#vmrefresh').click();">Click</a> to reload.</p>
                        </td></tr>
                    {/if}

                    </tbody>
                </table>
            {/if}
            <table width="50%" cellspacing="0" class="data-table backups-list left">
                <thead>
                    <tr>
                        <td colspan="5">VPS Info</td>
                    </tr>
                </thead>
                <tbody>
                    <tr style="background-color: #eee;">
                        <td class="right-aligned" width="33%">
                            <b>State</b>
                        </td> 
                        <td class="power-status" >{if $vm.status == 'online'}<span class="yes left">Yes</span>{else}<span class="no left">No</span>{/if} 
                            <div class="left">
                                {$vm.status|capitalize}
                                <button onclick="load_clientvm();$('#lmach').addLoader(); return false;">Refresh</button>
                                {if $vm.status == 'online'}
                                    <button onclick="reboot_clientvm(); return false;">Reboot</button>
                                    <button onclick="shutdown_clientvm(); return false;">Shutdown</button>
                                {elseif $vm.status != 'disabled'}
                                    <button onclick="startup_clientvm(); return false;">Power On</button>
                                {/if}
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="right-aligned"><b>Type</b></td>
                        <td class="courier-font">{$vm.type}</td>
                    </tr>
                    <tr style="background-color: #eee;">
                        <td class="right-aligned"><b>IP&nbsp;Addresses</b></td>
                        <td class="courier-font">{foreach from=$vm.ipaddresses item=ip}<a style="display: block; width: 100px;" href="http://{$ip}">{$ip}</a> {/foreach}</td>
                    </tr>
                </tbody>
            </table>
            <table width="50%" cellspacing="0" class="data-table backups-list left">
                <thead>
                    <tr>
                        <td colspan="5">VPS Usage</td>
                    </tr>
                </thead>
                <tbody>
                    <tr style="background-color: #eee;">
                        <td class="right-aligned"><b>Traffic</b></td>
                        <td class="courier-font">
                            <b>limit:</b> {if $vm.bandwidth_info.total}{$vm.bandwidth_info.total}{elseif $vm.bandwidth}{$vm.bandwidth} MB{else} <span class="infospan">value not accessible</span>{/if}<br />
                            <b>used:</b> {if $vm.bandwidth_info.used}{$vm.bandwidth_info.used} ( {$vm.bandwidth_info.percent} ){else}<span class="infospan">value not accessible</span>{/if} <br />
                            <b>free:</b> {if $vm.bandwidth_info.free} {$vm.bandwidth_info.free} {else} <span class="infospan">value not accessible</span> {/if}      
                        </td>
                    </tr>
                    <tr>
                        <td class="right-aligned"><b>Memory</b></td>
                        <td class="courier-font">
                            <b>limit:</b> {if $vm.memory_info.total}{$vm.memory_info.total}{elseif $vm.memory}{$vm.memory} MB{else} <span class="infospan">value not accessible</span>{/if}<br />
                            <b>used:</b> {if $vm.memory_info.used}{$vm.memory_info.used} ( {$vm.memory_info.percent} ){else}<span class="infospan">value not accessible</span>{/if}<br />
                            <b>free:</b> {if $vm.memory_info.free} {$vm.memory_info.free}  {else} <span class="infospan">value not accessible</span> {/if}
                        </td>
                    </tr>
                    <tr style="background-color: #eee;">
                        <td class="right-aligned"><b>Disk</b></td>
                        <td class="courier-font">
                            <b>limit:</b> {if $vm.disk_info.total}{$vm.disk_info.total}{elseif $vm.disk}{$vm.disk} MB{else} <span class="infospan">value not accessible</span>{/if}<br />
                            <b>used:</b> {if $vm.disk_info.used}{$vm.disk_info.used}  ( {$vm.disk_info.percent} ){else} <span class="infospan">value not accessible</span>{/if}<br />
                            <b>free:</b> {if $vm.disk_info.free} {$vm.disk_info.free} {else} <span class="infospan">value not accessible</span>{/if}                         
                        </td>
                    </tr>
                </tbody>
            </table>
            {elseif !$vm_import}
                <center>{$lang.nothingtodisplay}</center>
            {/if}
                        <div class="clear"></div>
        </div>
        {literal}
            <style>
                table.data-table tbody tr td{
                    height:60px
                }
                span.infospan{
                    border-bottom: 1px dashed #777777;
                    cursor: help;    
                }
            </style>
            <script type="text/javascript">
                $('.infospan').each(function(){
                    $(this).attr('title','This value is not accessible, and cannot be obtained from SolusVM at this time');
                }).vTip();
            </script>
        {/literal}
    {else}
        <ul class="accor">
            <li>
                <a href="#" class="darker">VM</a>
                <div class="sor"><a id="vmrefresh" href="#" style="position: relative; top: -25px; left: 50px;" class="menuitm" onclick="ajax_update('?cmd=accounts&action=edit&id={$details.id}&service={$details.id}&vpsdo=clientsvms','','#lmach',true);">refresh</a>
                    <div id="lmach">
                        <br />
                    </div>
                    <script type="text/javascript">
                        load_clientvm();
                    </script>
                </div>
            </li>
        </ul>
    {/if}
{/if}