{if $make=='getonappval' && $valx}
    {if $valx=='option23'}   {* Node  *}

        <select id="option23" multiple class="multi" name="options[option23][]">
            <option value="Auto-Assign" {if in_array('Auto-Assign',$defval)}selected="selected"{/if}>Auto-Assign</option>
            {foreach from=$modvalues item=value}
            <option value="{$value[0]}" {if in_array($value[0],$defval)}selected="selected"{/if}>{$value[1]}</option>
            {/foreach}
        </select>

    {elseif $valx=='option1' ||  $valx=='option2'}    {*  user role, group  *}

        <select id="{$valx}" name="options[{$valx}]">
            {foreach from=$modvalues item=value}
            <option value="{$value[0]}" {if $value[0]==$defval}selected="selected"{/if}>{$value[1]}</option>
            {/foreach}
        </select>

    {elseif $valx=='option20'} {*  template sets  *}

        <select id="option20" multiple class="multi" name="options[option20][]">
            <option value="All" {if in_array('All',$defval)}selected="selected"{/if}>All</option>
            {foreach from=$modvalues item=value}
            <option value="{$value[0]}" {if in_array($value[0],$defval)}selected="selected"{/if}>{$value[1]}</option>
            {/foreach}
        </select>

    {elseif $valx=='option12'}    {*  ostemplate  *}

        <select id="option12" name="options[option12]">
               {foreach from=$modvalues item=value}
                 <option value="{$value[0]}" {if $value[0]==$defval}selected="selected"{/if}>{$value[1]}</option>
            {/foreach}
        </select>
  {elseif $valx=='option24'}    {*  cputype  *}

        <select id="option24" name="options[option24]">
               {foreach from=$modvalues item=value}
                 <option value="{$value}" {if $value==$defval}selected="selected"{/if}>{$value}</option>
            {/foreach}
        </select>
    {elseif $valx=='option21' }  {*  data store zone  *}

        <select id="{$valx}" multiple class="multi" name="options[{$valx}][]">
            <option value="Auto-Assign" {if in_array('Auto-Assign',$defval)}selected="selected"{/if}>Auto-Assign</option>
            {foreach from=$modvalues item=value}
            <option value="{$value[0]}" {if in_array($value[0],$defval)}selected="selected"{/if}>{$value[1]}</option>
            {/foreach}
        </select>

    {elseif $valx=='option22'}  {*   network zone  *}

        <select id="option22"  name="options[option22]">
            {foreach from=$modvalues item=value}
            <option value="{$value[0]}" {if in_array($value[0],$defval)}selected="selected"{/if}>{$value[1]}</option>
            {/foreach}
        </select>

    {/if}
{elseif $make=='importformel' && $fid}
<a href="#" onclick="return editCustomFieldForm('{$fid}','{$pid}')" class="editbtn orspace">Edit related form element</a>
{if $vartype=='os'}<a href="#" onclick="return updateOSList('{$fid}')" class="editbtn orspace">Update template list from Proxmox</a>{/if}
<script type="text/javascript">editCustomFieldForm('{$fid}','{$pid}');</script>
{/if}