{if $bandwidth}
<h1 style="font-size:20px">限制: {$bandwidth.formatted.limit}, 已用: {$bandwidth.formatted.used}{if $bandwidth.over}, <b style="color:red">超额: {$bandwidth.formatted.overage}</b>{/if} </h1>

<table class="whitetable" width="100%" cellspacing="0" cellpadding="6">
    <tr>
        <td width="200" align="right">计费方法:</td>
        <td width="300"><b>{if $bandwidth.model=='total'}总流量{elseif $bandwidth.model=='average'}平均流量{else}95th计费{/if}</b></td>
   
        <td width="200" align="right">周期:</td>
        <td><b>{$bandwidth.period_from} - {$bandwidth.period_to}</b></td>
     </tr>
     <tr>
        <td align="right">超额比率:</td>
        <td colspan="3">{$bandwidth.cost|price:$account.currency_id:1:1} / 1 {$bandwidth.overage_unit}</td>
     </tr>

     <tr>
        <td align="right">当前超额费用:</td>
        <td colspan="3">{$bandwidth.charge|price:$account.currency_id:1:1}</td>
     </tr>
      <tr>
        <td align="right">预计使用:</td>
        <td colspan="3">{$bandwidth.projected_usage}</td>
     </tr>
      <tr>
        <td align="right">预计超额:</td>
        <td colspan="3">{$bandwidth.projected_overage}</td>
     </tr>
      <tr>
        <td align="right">预计超额费用:</td>
        <td colspan="3">{$bandwidth.projected_charge|price:$account.currency_id:1:1}</td>
     </tr>
</table>
{else}
<em>相关的套餐没有启用带宽计费.</em>
{/if}