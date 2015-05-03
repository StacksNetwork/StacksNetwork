{if is_array($extra)}
    {foreach from=$extra item=ex key=key}
        {include file="`$moduletpldir`extra.tpl" inputname="`$inputname`[`$key`]" extra=$ex}
    {/foreach}
{else}
    <input type="hidden" name="{$inputname}" value="{$extra}" />
{/if}