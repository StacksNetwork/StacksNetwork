{if $orderlogs}
<table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
    <tbody>
        <tr>
            <th width="120">{$lang.Date}</th>
            <th width="100">{$lang.Username}</th>
            <th>{$lang.Description}</th>
        </tr>
    </tbody>
    <tbody>

        {foreach from=$orderlogs item=order}
        <tr>
            <td>{$order.date|dateformat:$date_format}</td>
            <td>{$order.who}</td>
            <td>{$order.entry}</td>
        </tr>
        {/foreach}
    </tbody>

</table>
{else}
<p style="text-align: center">{$lang.nothingtodisplay}</p>
{/if}