{if !$switches}
错误: 无法从Cacti应用中读取交换机
{else}
<select id="cacti_switch_id" class="inp" onchange="change_cacti_sw(this);">
    {foreach from=$switches item=sw}
    <option value="{$sw.id}">{$sw.description} - {$sw.hostname}</option>
    {/foreach}
</select>

Port:
{foreach from=$switches item=sw name=f}
<select id="cacti_port_id_{$sw.id}" class="inp sw_cacti_port" {if !$smarty.foreach.f.first}style="display:none"{/if}>
        {foreach from=$sw.ports item=i key=k}
        <option value="{$k}">{$i.ifName} - {$i.ifDescr}</option>
    {/foreach}
</select>
{/foreach}

<input type="checkbox" value="1" checked="checked" name="billforit" id="billforit" /> 该端口的流量账单
<a href="#" onclick="return assignCactiPort();" class="new_control greenbtn" onclick="return false;"><span class="addsth"><strong>分配</strong></span></a>
{/if}
