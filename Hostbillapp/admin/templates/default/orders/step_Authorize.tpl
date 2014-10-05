{if $step.status=='Completed'}
    <span class="info-success">Authorization succeeded.</span>
    {if $step.output}
    <br/><br/><b>Authorization return:</b> {$step.output}
    {/if}

{else}

    {if $step.status=='Pending'}
        Authorization is pending, please review order
    {else}

        <span class="info-failed">Payment authorization failed.</span>
        {if $step.output}
        <br/><br/><b>Authorization return:</b> {$step.output}
        {/if}
    {/if}

    {if $details.invoice_id!='0' && $details.module}<br/><br/>
    <a class="menuitm greenbtn" href="?cmd=orders&action=executestep&step=Authorize&order_id={$details.id}&security_token={$security_token}" ><span>{$details.module}: Authorize</span></a>
    {/if}
    <a class="menuitm " href="?cmd=orders&action=executestep&step=Authorize&order_id={$details.id}&security_token={$security_token}&skip=true" ><span>Mark as completed</span></a>

{/if}