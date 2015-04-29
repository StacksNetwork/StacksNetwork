<label class="nodescr">连接设备</label>

<select  class="w250" name="port[item_id]"   id="port_item_id" onchange="changePortItem(this)">
    <option value="0">未连接</option>
        {foreach from=$rackitems item=item}
        <option value="{$item.id}" {if $port.connected_id==$item.id}selected="selected"{/if}>pos: {$item.position+1} {$item.categoryname} - {$item.name} - {$item.label}</option>
        {/foreach}

</select><div class="clear"></div>
