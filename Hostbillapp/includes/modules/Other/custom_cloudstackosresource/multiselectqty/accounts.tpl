<select style="width:160px" id="custom_field_select_{$kk}">
    <option value="0" {if $c.value=='0'}selected="selected"{/if}>-</option>
    {foreach from=$c.items item=itm}
        <option value="{$itm.id}" {if $c.values[$itm.id]}selected="selected"{/if}>{$itm.name} {if $itm.price}({$itm.price|price:$currency:true:$forcerecalc}){/if}</option>
    {/foreach}
</select>
{if $c.values[$itm.id]}
    {foreach from=$c.items item=itm}
        {if $c.values[$itm.id]}
            <input name="custom[{$kk}][{$itm.id}]" value="{$c.qty}" size="4" id="custom_field_{$kk}" />
        {/if}
    {/foreach}
{else}
    {foreach from=$c.items item=itm}
        <input name="custom[{$kk}][{$itm.id}]" value="{$c.qty}" size="4" id="custom_field_{$kk}"/>{break}
    {/foreach}
{/if}
<script type="text/javascript">
    (function(){literal}{{/literal}
        var cf = $('#custom_field_{$kk}'),
            cfs = $('#custom_field_select_{$kk}'),
            name =  cf.attr('name').replace(/\[\d+\]$/,'');

        cfs.change(function(){literal}{{/literal}
            var name =  cf.attr('name').replace(/\[\d+\]$/,'')
            cf.attr('name', name + '[' + cfs.val() + ']');
        {literal}});
        cf.attr('name', name + '[' + cfs.val() + ']');
    })();
    {/literal}
</script>

