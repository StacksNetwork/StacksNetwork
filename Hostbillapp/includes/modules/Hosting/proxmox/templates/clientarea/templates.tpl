
<table class="data-table backups-list"  width="100%" cellspacing=0>
    <thead>
        <tr>
            <td>{$lang.date}</td>
            <td>{$lang.name}</td>
            <td>{$lang.parent_template}</td>
            <td>{$lang.size}</td>
            <td>&nbsp;</td>
        </tr>
    </thead>
    {foreach item=temp from=$templates}
    <tr>
        <td>{$temp.created}</td>
        <td>{$temp.label}</td>
        <td>{$temp.parent_label}</td>
        <td>{$temp.size} MB</td>
        <td width="60" style="text-align: right">
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsid={$vpsid}&vpsdo=templates&do=delete&templateid={$temp.id}&security_token={$security_token}" onclick="return confirm('{$lang.suretodeletetemplate}')" class="small_control small_delete fs11">{$lang.delete}</a>
        </td>
    </tr>
    {foreachelse}
    <tr>
        <td colspan="7">{$lang.nothing}</td>
    </tr>
    {/foreach}
</table>