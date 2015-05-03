{if $generate_invoices}
<div>
    {if !empty($generated_invoices)}
        {foreach from=$generated_invoices item=inv}
        <strong>Invoice <a href="?cmd=invoices&amp;action=edit&amp;id={$inv.invoice_id}">#{$inv.invoice_id}</a></strong> created for user <strong>{$inv.clientname}</strong>. Total: <strong>{$inv.total|price:$currency}</strong>
        {/foreach}
    {else} No invoices has been created.
    {/if}
</div>
{/if}