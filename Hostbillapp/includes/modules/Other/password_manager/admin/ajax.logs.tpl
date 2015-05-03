{foreach from=$logs item=log}
    <tr>
        <td>{$log.date|dateformat:$date_format}</td>
        <td>{$log.log}</td>
        <td>{$log.admin}</td>
    </tr>
{foreachelse}
    <tr>
        <td colspan="3">{$lang.nothingtodisplay}</td>
    </tr>
{/foreach}