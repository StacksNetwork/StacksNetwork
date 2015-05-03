{if $bandwidth}
     
<table class="table table-striped fullscreen" width="100%" cellspacing="0" cellpadding="6">
   <tr>
         <td colspan="2"><h3>带宽限制: {$bandwidth.formatted.limit}, 已用: {$bandwidth.formatted.used}{if $bandwidth.over},
                 <b style="color:red">超额: {$bandwidth.formatted.overage}</b>{/if} </h3>
</td>
     </tr>
     <tr>
         <td align="right" width="160">超出率:</td>
        <td >{$bandwidth.cost|price:$currency} / 1 {$bandwidth.overage_unit}</td>
     </tr>

     <tr>
        <td align="right">当前超额计费:</td>
        <td >{$bandwidth.charge|price:$currency}</td>
     </tr>
     <tr>
        <td align="right">预计使用:</td>
        <td >{$bandwidth.projected_usage}</td>
     </tr>
     {if $bandwidth.projected_overage}
      <tr>
        <td align="right">预计超额:</td>
        <td  style="color:red">{$bandwidth.projected_overage}</td>
     </tr>
      <tr>
        <td align="right">预计超额计费:</td>
        <td><b style="color:red">{$bandwidth.projected_charge|price:$currency}</b></td>
     </tr>
     {/if}
</table>
{/if}