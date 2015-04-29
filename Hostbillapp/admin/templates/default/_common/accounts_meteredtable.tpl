<table class="whitetable" width="100%" cellspacing="0" cellpadding="3">
    <thead><tr>
            <th width="150">更新日期</th>
            {foreach from=$metered_usage_log.variables item=variab}
            <th>{$variab.name}</th>
            {/foreach}
            <th width="100">总额</th>
        </tr></thead>
    <tbody>
        {if !$metered_usage_log.usage}
        <tr class="odd">
            <td colspan="{$metered_usage_log.colspan}" align="center">没有任何使用记录</td>
        </tr>
        {else}
        {foreach from=$metered_usage_log.usage key=da item=val name=usageloop}
        {if $val.type=='Report'}
        <tr class="{if $smarty.foreach.usageloop.iteration%2==0}even{else}odd{/if}">
            <td width="150">{$val.date}</td>
            {foreach from=$metered_usage_log.variables item=variab key=v}
            <td>{if $val.$v}{$val.$v}{else}0{/if} {$variab.unit_name}</td>
            {/foreach}
            <td width="100">{$val.charge|price:$val.currency_id:true:false:true:4}</td>
        </tr>
        {else}
        <tr class="{if $smarty.foreach.usageloop.iteration%2==0}even{else}odd{/if}">
            <td colspan="{$metered_usage_log.colspan}" style="background:#ecf5ff"><em>{$val.date} - {$val.type} 报告发送</em></td>
        </tr>
        {/if}
        {/foreach}
        {/if}
    </tbody>

</table>