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

    <div class="data-table backups-list">
        <table width="100%" cellspacing="0" class="data-table backups-list left">
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
                    <td class="power-status" >{if $vm.status == 'active'}<span class="yes left">Yes</span>{else}<span class="no left">No</span>{/if} 
                        <div class="left">
                            {$vm.status|capitalize}
                            <button onclick="load_clientvm();
                                    $('#lmach').addLoader();
                                    return false;">Refresh</button>
                            {if $vm.status == 'active'}
                                <button onclick="reboot_clientvm();
                                    return false;">Reboot</button>
                                <button onclick="shutdown_clientvm();
                                    return false;">Shutdown</button>
                            {elseif $vm.status == 'off'}
                                <button onclick="startup_clientvm();
                                    return false;">Power On</button>
                            {/if}
                        </div>
                    </td>
                </tr>
                <tr style="background-color: #eee;">
                    <td class="right-aligned"><b>IP&nbsp;Addresses</b></td>
                    <td class="courier-font"><a style="display: block; width: 100px;" href="http://{$vm.ip_address}">{$vm.ip_address}</a> </td>
                </tr>
            </tbody>
        </table>
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
                                $('.infospan').each(function() {
                                    $(this).attr('title', 'This value is not accessible, and cannot be obtained from server at this time');
                                }).vTip();
        </script>
    {/literal}

{/if}