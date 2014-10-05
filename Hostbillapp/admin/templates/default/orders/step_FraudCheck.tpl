{if $fraud_out}
    {if is_array($fraud_out)}
    <table width="100%" cellpadding="2" cellspacing="0">
        {foreach from=$fraud_out item=f key=k name=checker}
            {if $smarty.foreach.checker.index%3=='0'}<tr>{/if}
            {if $k!='explanation'} <td width="16%" align="right"><strong>{$k}</strong></td><td width="16%" align="left">{$f}</td>{/if}
            {if $smarty.foreach.checker.index%3=='5'}</tr>{/if}
        {/foreach}
    </table>
        {if $fraud_out.explanation}
            <b>{$lang.Explanation}: </b>
            {$fraud_out.explanation}
        {/if}
    {else $fraud_out}
        <b>{$lang.Explanation}: </b>
        {$fraud_out}
    {/if}
{else}
    {if $step.status=='Failed'}
        <span class="info-failed">Step was marked as Failed, which means order is probably fraudulent.</span> <br/>
        If automated fraud verification was wrong you can change it as complete using button below.<br/><br/>
        <a class="menuitm " href="?cmd=orders&action=executestep&step=FraudCheck&order_id={$details.id}&security_token={$security_token}&skip=true" onclick="return confirm('Are you sure?');"><span>Mark Fraud Prevention as Complete (not fraud)</span></a>
        <br/><br/>


    {/if}
    {if $details.fraud}
        {foreach from=$details.fraud item=fro name=loop}
            {if !$smarty.foreach.loop.first}</br>
            {/if}
            {if $fro.module}
                {if $details.status=='Fraud'}
                    <div class="bigger" style="margin-bottom:10px;">
                        <strong>{$fro.name}</strong>
                         - <strong>
                        {if $details.fraudout[$fro.module].riskScore}
                            {$lang.fraudscore}: <span style="color:#{if $smarty.foreach.loop.last}FF00{else}00CC{/if}00">{$details.fraudout[$fro.module].riskScore}%</span>
                        {else}
                            {if $smarty.foreach.loop.last}<span style="color:#FF0000">Failed</span>
                            {else}<span style="color:#00CC00">Pass</span>
                            {/if}
                        {/if}
                        </strong>
                    </div>

                    <div style="padding:5px;font-size:11px;" >
                        {if $details.fraudout[$fro.module]}
                            {include file="orders/step_FraudCheck.tpl" fraud_out=$details.fraudout[$fro.module]}
                        {else}
                            {include file="orders/step_FraudCheck.tpl" fraud_out=$fro.output}
                        {/if}
                    </div>
                {else}
                    <div class="bigger" style="margin-bottom:10px;">
                        <strong>{$fro.name}</strong>
                         - <strong>
                        {if $details.fraudout[$fro.module].riskScore}
                            {$lang.fraudscore}: <span style="color:#00CC00">{$details.fraudout[$fro.module].riskScore}%</span>
                        {else}
                            <span style="color:#00CC00">Pass</span>
                        {/if}
                        </strong>
                        <a href="#" onclick="$('#frauddetails{$fro.module}').show();
                         ajax_update('?cmd=orders&action=frauddetails&fraudmodule={$fro.module}&id={$details.id}',{literal} {}{/literal}, '#frauddetails{$fro.module}', true);
                         $(this).hide();
                         return false;">{$lang.getdetailedinfo} </a>
                    </div>
                    <div style="padding:5px;display:none;font-size:11px;" id="frauddetails{$fro.module}" ></div>
                {/if}
            {else}
                {if $step.output}
                    <span class="info-success">{$step.output}</span>
                {else}
                    <div class="bigger" style="margin-bottom:10px;"><strong>No fraud prevention module is active</strong></div>
                {/if}
            {/if}
        {/foreach}
    {/if}
{/if}