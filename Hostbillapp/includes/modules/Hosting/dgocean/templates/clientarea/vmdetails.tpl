{include file="`$onappdir`header.cloud.tpl"}

{if !$vpsdo || $vpsdo=='vmdetails'}
    {include file="`$onappdir`details.tpl"}
{else}
    {include file="`$onappdir``$vpsdo`.tpl"}
{/if}
{include file="`$onappdir`footer.cloud.tpl"}