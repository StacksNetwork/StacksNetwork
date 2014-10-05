{if $step.status=='Completed'}
    {if !$details.invoice_id}
    <span class="info-success">No invoice was generated for this order</span>
    {else}
    <span class="info-success"><a href="?cmd=invoices&action=edit&id={$details.invoice_id}">Invoice #{$details.invoice_id}</a> is available for client in client area</span>
    {/if}
{elseif $step.status=='Pending'}
     <a class="menuitm greenbtn" href="?cmd=orders&action=executestep&step=sendInvoice&order_id={$details.id}&security_token={$security_token}"><span>Enable invoice for customer</span></a>
{/if}