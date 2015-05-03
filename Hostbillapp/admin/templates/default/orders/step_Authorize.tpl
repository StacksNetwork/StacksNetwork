{if $step.status=='Completed'}
    <span class="info-success">授权成功.</span>
    {if $step.output}
    <br/><br/><b>授权返回:</b> {$step.output}
    {/if}

{else}

    {if $step.status=='Pending'}
        授权申请, 请审核订单
    {else}

        <span class="info-failed">付款授权失败.</span>
        {if $step.output}
        <br/><br/><b>授权返回:</b> {$step.output}
        {/if}
    {/if}

    {if $details.invoice_id!='0' && $details.module}<br/><br/>
    <a class="menuitm greenbtn" href="?cmd=orders&action=executestep&step=Authorize&order_id={$details.id}&security_token={$security_token}" ><span>{$details.module}: 授权</span></a>
    {/if}
    <a class="menuitm " href="?cmd=orders&action=executestep&step=Authorize&order_id={$details.id}&security_token={$security_token}&skip=true" ><span>标记为已完成</span></a>

{/if}