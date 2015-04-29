{* singe item ports *}
<label class="nodescr">连接端口</label>
<select  class="w250" name="port[connected_to]"   id="port_port_id"><option value="0">未连接</option>

{foreach from=$ports item=item}
        <option value="{$item.id}" {if $port.connected_to==$item.id}selected="selected"{/if} >
                {if $item.type=='PDU' && $item.direction=='in'}已接插座:
                {elseif $item.type=='NIC' && $item.direction=='out'}上联端口: {/if}
                #{$item.number}</option>
        {/foreach}</select>
<div class="clear"></div>