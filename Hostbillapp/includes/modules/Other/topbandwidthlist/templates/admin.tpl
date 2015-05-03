<table border="0" cellpadding="0" cellspacing="0" style="margin-bottom:10px;" width="100%">
<tbody><tr>
<td class="logoLeftNav"></td>
<td valign="top" >
    
    {if !$data}
        <h3>尚无任何 Cacti/Observium 缓存内容</h3>
        {else}
            
            显示 <a href="?cmd=topbandwidthlist&limit=10">10</a> <a href="?cmd=topbandwidthlist&limit=50">50</a>   <a href="?cmd=topbandwidthlist&limit=100">100</a>
            <br/><br/>
            <table width="100%" cellspacing="0" cellpadding="3" border="0" class="whitetable" style="border:solid 1px #ddd;">
<tbody>
<tr>
    
    <th  align="left">账户</th>
    <th  align="left">客户</th>
    <th  align="left">设备</th>
    <th  align="left">周期</th>
    <th  align="left">总流量</th>
    <th  align="left">平均带宽</th>
    <th  align="left">95th峰值</th>
</tr>
{foreach from=$data item=i name=fl}
<tr class="havecontrols {if $smarty.foreach.fl.index%2==0}even{/if}">
    
    <td><a href="?cmd=accounts&action=edit&id={$i.account_id}" target="_blank">#{$i.account_id} {$i.domain}</a></td>
    <td><a href="?cmd=clients&action=show&id={$i.client_id}" target="_blank">#{$i.client_id} {$i.lastname} {$i.firstname}</a></td>
    <td>{$i.name}</td>
    <td>{$i.cache.from} - {$i.cache.to}</td>
    <td>{$i.formatted.total}</td>
    <td>{$i.formatted.average}</td>
    <td>{$i.formatted.95th}</td>
</tr>
{/foreach}
  </tbody>          
            {/if}
</td>
</tr>
</tbody></table>