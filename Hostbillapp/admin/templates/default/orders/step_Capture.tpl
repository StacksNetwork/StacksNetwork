{if $step.status=='Completed'}
   <span class="info-success">Payment for order has been captured</span>
    {if $step.output}
    <br/><br/><b>Capture return:</b> {$step.output}
    {/if}<br/><br/>


    <a class="menuitm" href="?cmd=orders&action=edit&id={$details.id}&markcancelledrefund=true&security_token={$security_token}" onclick="return confirm('Are you sure? It will call module terminate command')"><span style="color:red">Cancel &amp; refund order</span></a>

    <span class="orspace fs11">Note: You will be able to review refund before issuing it.</span>
{else}
    {if $step.status=='Pending'}
       Payment is awaiting to be captured. {if $step.auto=='1'}Capture should happen automatically with cron run, if it fails try button below{/if}<br/><br/>
    {else}
        <span class="info-failed">Payment capture failed</span><br/>
    {/if}
    <br/><br/>
    {if $details.modusubtype=='1'}
        
         <a class="menuitm greenbtn" href="?cmd=orders&action=executestep&step=Capture&order_id={$details.id}&security_token={$security_token}"><span>{$details.module}: Capture</span></a>

         
    {else}
      Current payment module is not credit card processor, capture process will be marked as completed once related invoice will be paid.
    {/if}
    
    {if $step.output}
    <br/><br/><b>Capture return:</b> {$step.output}
    {/if}
{/if}



