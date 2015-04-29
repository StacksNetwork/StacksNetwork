<h3>客户资料更改来自 {$details.date|dateformat:$date_format} by {$details.who}</h3>

<table width="100%" cellspacing="0" cellpadding="3" border="0" class="whitetable" style="border:solid 1px #ddd;">
    <tbody>
        <tr>
            <th>字段</th>
            <th>原值e</th>
            <th>新值</th>
        </tr>
        {foreach from=$details.change item=change key=field name=fl}
        <tr {if $smarty.foreach.fl.index%2==0}class="odd"{else}class="even"{/if}>
            <td><b>{if $lang.$field}{$lang.$field}{else}{$field}{/if}</b></th>
            <td class="lastitm">{$change.from}</td>
            <td class="lastitm">{$change.to}</td>
        </tr>

        {/foreach}
    </tbody>
</table>
