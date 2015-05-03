{if $valx=='sizes'} 
    <select id="sizes" name="options[sizes]">
        {foreach from=$modvalues item=size}
            <option value="{$size.id}" {if $defval == $size.id}selected="selected"{/if}>{$size.name}</option>
        {/foreach}
    </select>
{elseif $valx=='regions'} 
    <select id="regions" name="options[regions]">
        {foreach from=$modvalues item=region key=title}
            <option value="{$region.id}"  {if $defval == $region.id}selected="selected"{/if}>{$region.name}</option>
        {/foreach}
    </select>
{elseif $valx=='images'} 
    <select id="images" name="options[images]">
        {foreach from=$modvalues item=image key=title}
            <option value="{$image.id}"  {if $defval == $image.id}selected="selected"{/if}>{$image.name}</option>
        {/foreach}
    </select>
{/if}
