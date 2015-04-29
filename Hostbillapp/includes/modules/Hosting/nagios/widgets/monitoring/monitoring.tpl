<h1>服务监控</h1> 

{foreach from=$monitors item=host key=hostk}
<h3>{$hostk}</h3>

<table border="0" cellspacing="0" cellpadding="0" width="730" class="statustable">
    <tr>
        <th>服务</th>
        <th>状态</th>
        <th>最近一次检查</th>
        <th>持续时间</th>
        <th>尝试</th>
        <th>信息</th>
    </tr>

    {foreach from=$host.services item=s}
    <tr class="rowstatus-{$s.status}">
        <td>{$s.service}</td>
        <td>{$s.status}</td>
        <td>{$s.lastcheck}</td>
        <td>{$s.duration}</td>
        <td>{$s.attempt}</td>
        <td>{$s.info}</td>
    </tr>
    {/foreach}
</table>
{/foreach}
{literal}
<style>
    .statustable td{
        border:solid 1px #fff;
        font-size:11px;
    }
    .statustable th{
        background-color: #E9E9E9;
    }
    .statustable .rowstatus-OK td {background-color: #F4F4F4;}
    .statustable .rowstatus-UNKNOWN td {background-color:#FFDA9F}
    .statustable .rowstatus-CRITICAL td {background-color:#FFBBBB;}
    .statustable .rowstatus-WARNING td {background-color: #FEFFC1;}

</style>
{/literal}