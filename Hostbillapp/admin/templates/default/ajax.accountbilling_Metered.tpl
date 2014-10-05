<table class="whitetable" width="100%" cellspacing="0" cellpadding="3">
    <thead><tr>
            <th  >Date updated</th> 
            {foreach from=$metered_usage_log.variables item=variab}
            <th>{$variab.name}</th>
            {/foreach}
            <th >Total due</th>
        </tr></thead>
    <tbody>
        {if $metered_usage_interval=='1h'}
             {foreach from=$metered_usage_log.usage key=da item=val name=usageloop}
            {if $val.type=='Report'}
            <tr class="{if $smarty.foreach.usageloop.iteration%2==0}even{else}odd{/if}">
                <td >{$da}</td>
                {foreach from=$metered_usage_log.variables item=variab key=v}
                <td>{if $val.$v}{$val.$v}{else}0{/if} {$variab.unit_name}</td>
                {/foreach}
                <td >{$val.charge|price:$val.currency_id:true:false:true:4}</td>
            </tr>
            {else}
            <tr class="{if $smarty.foreach.usageloop.iteration%2==0}even{else}odd{/if}">
                <td  style="background:#ecf5ff">{$da}</td>
                {foreach from=$metered_usage_log.variables item=variab key=v}
                <td style="background:#ecf5ff">-</td>
                {/foreach}
                <td style="background:#ecf5ff">
                    {if $val.type=='Invoice'}
                    <em>Invoice generated</em>
                    {else}
                    <em>{$val.type} report sent</em>
                    {/if}
                </td>
            </tr>
            {/if}
            {/foreach}
        {else}

             {foreach from=$metered_usage_log.usage key=da item=val name=usageloop}
            <tr class="{if $smarty.foreach.usageloop.iteration%2==0}even{else}odd{/if}">
                <td >{$da}</td>
                {foreach from=$metered_usage_log.variables item=variab key=v}
                <td>Avg: {$val[$v].use} {$variab.unit_name}<br><small>Price: {$val[$v].price|price:$metered_usage_log.currency:true:false:true:4}</small></td>
                {/foreach}
                <td >{$val.dailycharge|price:$metered_usage_log.currency:true:false:true:4}</td>
            </tr>
          {/foreach}


        {/if}
       
    </tbody>

</table>