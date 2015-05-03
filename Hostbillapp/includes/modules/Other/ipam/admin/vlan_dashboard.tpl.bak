{if !$servers}
    <div class="blank_state_smaller blank_forms" id="blank_pdu">
        <div class="blank_info">
            <h1>Welcome to IPAM VLAN</h1>
            Thank you for purchasing our IP Management plugin for HostBill. To start, add your <a href="#" onclick="addVlanList();
                    return false;">first VLAN Group</a>

        </div>
    </div>
{else}
    <table class="clear" width="100%" cellspacing="0" cellpadding="0" >

        <tbody>
            <tr>
                <th width="220">List Name</th>
                <th width="200">Range</th>
                <th width="80">Auto-assign</th>
                <th width="80">Private</th>
                <th width="80">VLAN count</th>
                <th width="100">Unassigned</th>
                <th >Description</th>
            </tr>
            {foreach from=$servers item=server}

                <tr>
                    <td><a href="#" onclick="groupDetails({$server.id});return false;">{$server.name}</a></td>
                    <td >{$server.range_from} - {$server.range_to}</td>
                    <td >{if $server.autoprovision=='1'}Yes{else}No{/if}</td>
                    <td >{if $server.private=='1'}Yes{else}No{/if}</td>
                    <td>{$server.count}</td>
                    <td>{$server.count_unasigned}</td>
                    <td>{$server.description}</td>
                </tr>
            {/foreach}
        </tbody>
    </table>
{/if}