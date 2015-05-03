{if $step.status=='Completed'}
    {if !$details.invoice_id}
    <span class="info-success">该订单没有生成账单</span>
    {else}
    <span class="info-success"><a href="?cmd=invoices&action=edit&id={$details.invoice_id}">账单 #{$details.invoice_id}</a> 已经发送到用户界面</span>
    {/if}
{elseif $step.status=='Pending'}
     <a class="menuitm greenbtn" href="?cmd=orders&action=executestep&step=sendInvoice&order_id={$details.id}&security_token={$security_token}"><span>为用户启用账单</span></a>
{/if}