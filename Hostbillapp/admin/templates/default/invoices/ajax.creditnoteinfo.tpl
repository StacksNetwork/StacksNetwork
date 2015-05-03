{if $invoice.status!='Creditnote'}
    {if $invoice.credit_note_id}
        <div  style="padding:5px;" class="lighterblue fs11">一条信用记录已经关联该账单: <a href="?cmd=invoices&action=edit&id={$invoice.credit_note_id}&list=creditnote">{$invoice.credit_note_paid_id}</a></div>
    {/if}
{else}
    {if $invoice.related_invoice_id}<div  style="padding:5px;" class="lighterblue fs11">该信用记录已经关联账单: <a href="?cmd=invoices&action=edit&id={$invoice.related_invoice_id}&list=all">{*
        *}{if $invoice.related_invoice_paid_id}{$invoice.related_invoice_paid_id}{else}#{$invoice.related_invoice_id}{/if}</a></div>{/if}
{/if}