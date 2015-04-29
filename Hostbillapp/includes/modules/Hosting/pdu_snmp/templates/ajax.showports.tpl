{if $ports}
<select name="pdu_port_id" id="pdu_port_id" class="inp">
    {foreach from=$ports item=port key=k}
    <option value="{$port.id}">{$port.port_name} {if $port.account_id}( 分配给 #{$port.account_id}){/if}</option>
    {/foreach}
</select>
<input type="hidden" value="{$server_id}" id="pdu_server_id" name="pdu_server_id" />
<a href="#" onclick="return assignPort();" class="new_control greenbtn" onclick="return false;"><span class="addsth"><strong>分配</strong></span></a>
{else}
    <p style="margin:5px">无法列出端口, 检查您的物品是否有正确的进行端口配置. 您可能需要使用"读取端口"按钮来更新状态.</p>
{/if}