<table class="glike hover" border="0" cellpadding="3" cellspacing="0" width="100%">
    <tbody>
        <tr>
            <th>子网 </th>
            <th> 客户使用IPs统计</th>
            <th class="lastelb">说明 </th>
        </tr>
    </tbody>
    <tbody>
        {foreach from=$lists item=list}
        <tr>
            <td><a href="?cmd=ipam&action=details&group={$list.id}" target="_blank">{$list.name}</a></td>
            <td>{$list.owned}</td>
            <td>{$list.description}</td>
        </tr>
        {foreachelse}
            <tr><td colspan="3" style="text-align: center">尚未分配IPs</td></tr>
        {/foreach}
    </tbody>
</table>