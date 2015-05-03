{if $step.status=='Completed'}
   <span class="info-success">付款订单已被捕获</span>
    {if $step.output}
    <br/><br/><b>捕获返回:</b> {$step.output}
    {/if}<br/><br/>


    <a class="menuitm" href="?cmd=orders&action=edit&id={$details.id}&markcancelledrefund=true&security_token={$security_token}" onclick="return confirm('您确定吗? 它将调用模块终止命令')"><span style="color:red">取消 &amp; 退款单</span></a>

    <span class="orspace fs11">注意: 您将能够在发布之前审查退款.</span>
{else}
    {if $step.status=='Pending'}
       付款方式是等待被捕获. {if $step.auto=='1'}捕获应自动发生与Cron运行, 如果失败尝试下面的按钮{/if}<br/><br/>
    {else}
        <span class="info-failed">支付捕获失败</span><br/>
    {/if}
    <br/><br/>
    {if $details.modusubtype=='1'}
        
         <a class="menuitm greenbtn" href="?cmd=orders&action=executestep&step=Capture&order_id={$details.id}&security_token={$security_token}"><span>{$details.module}: 捕获</span></a>

         
    {else}
      目前的支付模块是不是信用卡处理, 捕获过程将被标记为完成同时相关账单将支付.
    {/if}
    
    {if $step.output}
    <br/><br/><b>获取返回:</b> {$step.output}
    {/if}
{/if}



