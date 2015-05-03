{if !$switches}
错误: 无法从相关Observium应用中读取接口
{else}
<select id="observium_switch_id" class="inp" onchange="change_observium_sw(this);">
    {foreach from=$switches item=sw}
    <option value="{$sw.device_id}">{$sw.hostname}</option>
    {/foreach}
</select>

端口:
{foreach from=$switches item=sw name=f}
<select id="observium_port_id_{$sw.device_id}" class="inp sw_observium_port" {if !$smarty.foreach.f.first}style="display:none"{/if}>
        {foreach from=$sw.ports item=i key=k}
        <option value="{$k}">{$i}</option>
    {/foreach}
</select>
{/foreach}

<input type="checkbox" value="1" checked="checked" name="billforit" id="billforit" /> 该端口的流量账单
<a href="#" onclick="return assignobserviumPort();" class="new_control greenbtn" onclick="return false;"><span class="addsth"><strong>分配</strong></span></a>
{/if}
