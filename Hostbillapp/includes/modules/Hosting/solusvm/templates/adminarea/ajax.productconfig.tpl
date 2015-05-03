{if $valx=='option2'} 
    <select class="multi" name="options[option2][]" id="option2" multiple="multiple" >
        <option value="Auto-Assign" {if in_array("Auto-Assign", $defval) || !$defval}selected="selected"{/if}>Auto-Assign</option>
        {foreach from=$modvalues item=tygroup key=title}
            <optgroup class="opt_{$title|replace:' ':''}" label="{if $title == 'xen'}Xen PV{elseif $title == 'xen hvm'}Xen HVM{elseif $title == 'openvz'}OpenVZ{elseif $title == 'kvm'}KVM{/if}">
                {foreach from=$tygroup item=value}
                    <option value="{$value}" {if in_array($value, $defval)}selected="selected"{/if}>{$value}</option>
                {/foreach}
            </optgroup>
        {/foreach}
    </select>
{elseif $valx=='nodegroup'}
    <select class="odesc_ odesc_single_vm disable_ disable_single_vm" id="nodegroup" name="options[nodegroup]">
        {if $modvalues}
            {foreach from=$modvalues item=value}
                {if $value[0] != '--none--' && $value[1]}
                    <option value="{if $value[0] != '--none--'}{$value[0]}{/if}" {if ( is_array($defval) && !is_array($types) && $defval[$types] == $value[0] ) ||  $defval == $value[0]}selected="selected"{/if}>{if !$value[0]}--none--{else}{$value[1]}{/if}</option>
                {/if}
            {/foreach}
        {else} <option value="" selected="selected">--none--</option>
        {/if}
    </select>
    <div id="nodegroup2container" class="odesc_ odesc_cloud_vm disable_ disable_cloud_vm" >
        <select name="options[nodegroup][openvz]" >
            <optgroup class="opt_openvz" label="OpenVZ">
                {if $modvalues}
                    {foreach from=$modvalues item=value}
                        {if $value[0] != '--none--' && $value[1]}
                            <option value="{$value[0]}" {if (is_array($defval) && $defval.openvz == $value[0]) || (!is_array($defval) && $defval == $value[0])}selected="selected"{/if}>{if !$value[0]}--none--{else}{$value[1]}{/if}</option>
                        {/if}
                    {/foreach}
                {else} <option value="" selected="selected">--none--</option>
                {/if}
            </optgroup>
        </select> 
        <select name="options[nodegroup][xen]" >
            <optgroup class="opt_xen" label="Xen PV">
                {if $modvalues}
                    {foreach from=$modvalues item=value}
                        {if $value[0] != '--none--' && $value[1]}
                            <option value="{$value[0]}" {if (is_array($defval) && $defval.xen == $value[0]) || (!is_array($defval) && $defval == $value[0])}selected="selected"{/if}>{if !$value[0]}--none--{else}{$value[1]}{/if}</option>
                        {/if}
                    {/foreach}
                {else} <option value="" selected="selected">--none--</option>
                {/if}
            </optgroup>
        </select> 
        <select name="options[nodegroup][xenhvm]" >
            <optgroup class="opt_xenhvm" label="Xen HVM">
                {assign value="xen hvm" var=xenhvm}
                {if $modvalues}
                    {foreach from=$modvalues item=value}
                        {if $value[0] != '--none--' && $value[1]}
                            <option value="{$value[0]}" {if (is_array($defval) && $defval.xenhvm == $value[0]) || (!is_array($defval) && $defval == $value[0])}selected="selected"{/if}>{if !$value[0]}--none--{else}{$value[1]}{/if}</option>
                        {/if}
                    {/foreach}
                {else} <option value="" selected="selected">--none--</option>
                {/if}
            </optgroup>
        </select> 
        <select name="options[nodegroup][kvm]">
            <optgroup class="opt_kvm" label="KVM">
                {if $modvalues}
                    {foreach from=$modvalues item=value}
                        {if $value[0] != '--none--' && $value[1]}
                            <option value="{$value[0]}" {if (is_array($defval) && $defval.kvm == $value[0]) || (!is_array($defval) && $defval == $value[0])}selected="selected"{/if}>{if !$value[0]}--none--{else}{$value[1]}{/if}</option>
                        {/if}
                    {/foreach}
                {else} <option value="" selected="selected">--none--</option>
                {/if}
            </optgroup>
        </select>
    </div>
    <div id="nodegroup3container" class="odesc_ odesc_reseller disable_ disable_reseller" >
        <select name="options[nodegroup][]" id="nodegroup" multiple="multiple" class="multi" >
            {if $modvalues}
                {foreach from=$modvalues item=value}
                    {if $value[0] != '--none--' && $value[1]}
                        <option value="{if $value[0] != '--none--'}{$value[0]}{/if}" {if ( is_array($defval) && in_array($value[0], $defval) ) ||  $defval == $value[0]}selected="selected"{/if}>{if !$value[0]}--none--{else}{$value[1]}{/if}</option>
                    {/if}
                {/foreach} 
            {/if}
        </select>
    </div>
{elseif $valx=='option4'} 
    <select id="option4" name="options[option4]">
        {foreach from=$modvalues item=tygroup key=title}
            {counter name=ostplc print=false start=0 assign=ostplc}
            <optgroup class="opt_{$title|replace:' ':''}" label="{if $title == 'xen'}Xen PV{elseif $title == 'xen hvm'}Xen HVM{elseif $title == 'openvz'}OpenVZ{elseif $title == 'kvm'}KVM{/if}">
                {foreach from=$tygroup item=value}
                    {if $value && $value!='--none--'}
                        {counter name=ostplc}
                        <option value="{$value}" {if $defval == $value}selected="selected"{/if}>{$value}</option>
                    {/if}
                {/foreach}
                {if !$ostplc}
                    <option calue="">-- no templates available --</option>
                {/if}
            </optgroup>
        {/foreach}
    </select>
{elseif $valx=='option5'} 
    <select class="odesc_ odesc_single_vm disable_ disable_single_vm" id="option5" name="options[option5]">
        {if $modvalues}
            {foreach from=$modvalues item=tygroup key=title}
                {assign value=$title|replace:' ':'' var=vtype}
                <optgroup class="opt_{$vtype}" label="{if $title == 'xen'}Xen PV{elseif $title == 'xen hvm'}Xen HVM{elseif $title == 'openvz'}OpenVZ{elseif $title == 'kvm'}KVM{/if}">
                    {foreach from=$tygroup item=value}
                        <option value="{$value}" {if ( is_array($defval) && $defval[$vtype] == $value) ||  $defval == $value}selected="selected"{/if}>{$value}</option>
                    {/foreach}
                </optgroup>
            {/foreach}
{else} <option value="{if is_array($defval) && $defval[$vtype]}{$defval[$vtype]}{elseif $defval}{$defval}{/if}" selected="selected">{if is_array($defval) && $defval[$vtype]}{$defval[$vtype]}{elseif $defval}{$defval}{else}--none--{/if}</option>
{/if}
</select>
<div id="vpstypeplanscontainer" class="odesc_ odesc_cloud_vm disable_ disable_cloud_vm" >
    <select name="options[option5][openvz]">
        <optgroup class="opt_openvz" label="OpenVZ">
            {if $modvalues.openvz}
                {foreach from=$modvalues.openvz item=value}
                    <option value="{$value}" {if (is_array($defval) && $defval.openvz == $value) || (!is_array($defval) && $defval == $value)}selected="selected"{/if}>{$value}</option>
                {/foreach}
{else} <option value="{if is_array($defval) && $defval.openvz}{$defval.openvz}{/if}" selected="selected">{if is_array($defval) && $defval.openvz}{$defval.openvz}{else}--none--{/if}</option>
{/if}
</optgroup>
</select> 
<select name="options[option5][xen]" >
    <optgroup class="opt_xen" label="Xen PV">
        {if $modvalues.xen}
            {foreach from=$modvalues.xen item=value}
                <option value="{$value}" {if (is_array($defval) && $defval.xen == $value) || (!is_array($defval) && $defval == $value)}selected="selected"{/if}>{$value}</option>
            {/foreach}
{else} <option value="{if is_array($defval) && $defval.xen}{$defval.xen}{/if}" selected="selected">{if is_array($defval) && $defval.xen}{$defval.xen}{else}--none--{/if}</option>
{/if}
</optgroup>
</select> 
<select name="options[option5][xenhvm]" >
    <optgroup class="opt_xenhvm" label="Xen HVM">
        {assign value="xen hvm" var=xenhvm}
        {if $modvalues.$xenhvm}
            {foreach from=$modvalues.$xenhvm item=value}
                <option value="{$value}" {if (is_array($defval) && $defval.xenhvm == $value) || (!is_array($defval) && $defval == $value)}selected="selected"{/if}>{$value}</option>
            {/foreach}
{else} <option value="{if is_array($defval) && $defval.xenhvm}{$defval.xenhvm}{/if}" selected="selected">{if is_array($defval) && $defval.xenhvm}{$defval.xenhvm}{else}--none--{/if}</option>
{/if}
</optgroup>
</select> 
<select name="options[option5][kvm]">
    <optgroup class="opt_kvm" label="KVM">
        {if $modvalues.kvm}
            {foreach from=$modvalues.kvm item=value}
                <option value="{$value}" {if (is_array($defval) && $defval.kvm == $value) || (!is_array($defval) && $defval == $value)}selected="selected"{/if}>{$value}</option>
            {/foreach}
{else} <option value="{if is_array($defval) && $defval.kvm}{$defval.kvm}{/if}" selected="selected">{if is_array($defval) && $defval.kvm}{$defval.kvm}{else}--none--{/if}</option>
{/if}
</optgroup>
</select>
</div>
{literal}
    <script type="text/javascript" >
        filter_types();
    </script>
{/literal}
{/if}
