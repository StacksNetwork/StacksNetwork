{if $make=='getonappval' && $valx}
    {if $valx=='option31'}   {* Flavors  *}

        <select id="option31" multiple class="multi" name="options[option31][]">
            {foreach from=$modvalues item=value}
            <option value="{$value[0]}" {if in_array($value[0],$defval)}selected="selected"{/if}>{$value[1]}</option>
            {/foreach}
        </select>

    {elseif $valx=='option11'}    {* Flavor  *}

        <select id="option11" name="options[option11]">
               {foreach from=$modvalues item=value}
                 <option value="{$value[0]}" {if $value[0]==$defval}selected="selected"{/if}>{$value[1]}</option>
            {/foreach}
        </select>

    {elseif $valx=='option15'}    {* Tenant *}

        <select id="option15" name="options[option15]">
               {foreach from=$modvalues item=value}
                 <option value="{$value[0]}" {if $value[0]==$defval}selected="selected"{/if}>{$value[1]}</option>
            {/foreach}
        </select>
    {elseif $valx=='option12'}    {*  ostemplate  *}

        <select id="option12" name="options[option12]">
               {foreach from=$modvalues item=value}
                 <option value="{$value[0]}" {if $value[0]==$defval}selected="selected"{/if}>{$value[1]}</option>
            {/foreach}
        </select>
    {elseif $valx=='option22'}  {*   floating IP pool *}

        <select id="option22"  name="options[option22]">
            {foreach from=$modvalues item=value}
            <option value="{$value}" {if $value==$defval}selected="selected"{/if}>{$value}</option>
            {/foreach}
        </select>

    {/if}
{elseif $make=='importformel' && $fid}
<a href="#" onclick="return editCustomFieldForm('{$fid}','{$pid}')" class="editbtn orspace">Edit related form element</a>
{if $vartype=='os'}<a href="#" onclick="return updateOSList('{$fid}')" class="editbtn orspace">Update images list from OpenStack</a>{/if}
<script type="text/javascript">editCustomFieldForm('{$fid}','{$pid}');</script>
{/if}