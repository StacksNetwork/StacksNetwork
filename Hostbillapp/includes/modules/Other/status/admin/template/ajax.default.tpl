
{foreach from=$statuses item=entry}
    <tr class="havecontrols">
        <td>{$entry.date}</td>
        <td><a href="?cmd=status&action=edit&id={$entry.id}">{$entry.name}</a></td>
        <td>{if $lang[$entry.status]}{$lang[$entry.status]}{else}{$entry.status}{/if}</td>
        <td>{$entry.relatedinfo|escape|truncate}</td>
        <td>
            {foreach from=$staff item=admin}
                {if $admin.id == $entry.author}
                    {$admin.lastname} {$admin.firstname}
                    {break}
                {/if}
            {/foreach}
        </td>
        <td>
            <div>
                <a title="维护数据" class="menuitm menuf" href="?cmd=status&action=update&id={$entry.id}">
                    <span class="addsth" style="padding: 0 7px"></span>
                </a>
                <a title="编辑" class="menuitm menuc" href="?cmd=status&action=edit&id={$entry.id}">
                    <span class="editsth"></span>
                </a>
                <a title="删除" class="menuitm menul" href="?cmd=status&action=delete&id={$entry.id}&security_token={$security_token}" onclick="return confirm('您确定要删除该维护数据?')">
                    <span class="delsth"></span>
                </a>
            </div>
        </td>
    </tr>
{/foreach}
