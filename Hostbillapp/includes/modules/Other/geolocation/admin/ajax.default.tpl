{if !$action || $action == 'add' ||  $action == 'del' ||  $action == 'edit' || $action == 'default'}
    {foreach from=$rules item=rule name=loop}
    <li {if $smarty.foreach.loop.first}class="first"{/if}>
        <div class="actions">
        <a class="menuitm menuf" href="?cmd=geolocation&action=edit&id={$rule.id}" title="edit" onclick="geolocation.copyform(this); return false;" ><span class="editsth"></span></a>
        <a class="menuitm menul" title="delete" href="?cmd=geolocation&action=dell&id={$rule.id}" onclick="return confirm('Are you sure you wish to remove this from your list?');"><span class="delsth"></span></a>
        </div>
        <div class="name">
            {$countries[$rule.country]}
            {if $rule.region}&raquo; {$rule.region}{/if}
            {if $rule.city}&raquo; {$rule.city}{/if}
        </div>
        <div class="description">
            <input type="hidden" name="country" value="{$rule.country}" />
            <input type="hidden" name="region" value="{$rule.region}" />
            <input type="hidden" name="city" value="{$rule.city}" />
            <input type="hidden" name="language" value="{$rule.language.name}" />
            <input type="hidden" name="currency" value="{$rule.currency.id}" />
            {if $rule.gates_count || $rule.gates_count===0 }
                {foreach from=$rule.gates item=gate}
                    <input type="hidden" name="gates[]" value="{$gate}" />
                {/foreach}  
            {else}
                <input type="hidden" name="gates[]" value="all" />
            {/if}
            {if $rule.language}<span>Language: <b>{$rule.language.name|capitalize}</b></span>{/if}
            {if $rule.currency}<span>Currency: <b>{$rule.currency.code}</b></span>{/if}
            {if $rule.gates_count || $rule.gates_count===0}<span>Enabled gateways: <b>{$rule.gates_count}</b></span>{/if}
        </div>
        <div class="clear"></div>
        <div class="edit"></div>
    </li>
    {foreachelse}
        <li>Your list is currently empty</li>
    {/foreach}
    <script type="text/javascript">
        geolocation.descr();
    </script>
{/if}