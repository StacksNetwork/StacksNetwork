{if $ports}
<select name="pdu_port_id" id="pdu_port_id" class="inp">
    {foreach from=$ports item=port key=k}
    <option value="{$port.id}">{$port.port_name} {if $port.account_id}( Assigned to #{$port.account_id}){/if}</option>
    {/foreach}
</select>
<input type="hidden" value="{$server_id}" id="pdu_server_id" name="pdu_server_id" />
<a href="#" onclick="return assignPort();" class="new_control greenbtn" onclick="return false;"><span class="addsth"><strong>Assign</strong></span></a>
{else}
    <p style="margin:5px">Unable to list ports, check if your item has correct port configuration, you may need to use "Load Ports" button to update it</p>
{/if}