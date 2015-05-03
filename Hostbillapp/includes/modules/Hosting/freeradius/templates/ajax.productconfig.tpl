{if $make=='loadoptions' && $valx}
    {if $valx=='option1'}

        <select id="option1"  name="options[option1]">
            {foreach from=$modvalues item=value}
            <option value="{$value[0]}" {if $defval==$value[0]}selected="selected"{/if}>{$value[1]}</option>
            {/foreach}
        </select>

    {/if}
{/if}