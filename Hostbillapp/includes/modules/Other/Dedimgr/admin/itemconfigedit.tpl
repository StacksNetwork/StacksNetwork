<h1> 
    <strong><a href="?cmd=module&module={$moduleid}&do=floors&colo_id={$rack.colo_id}">数据中心: {$rack.coloname}</a></strong>
    &raquo; <strong><a href="?cmd=module&module={$moduleid}&do=floor&floor_id={$rack.floor_id}">楼层: {$rack.floorname}</a> <em>{if $rack.room} 机房: {$rack.room}{/if}</em></strong>
    &raquo; <strong><a href="?cmd=module&module={$moduleid}&do=rack&rack_id={$rack.id}">机柜: {$rack.name}</a> </strong> 
    {foreach from=$stack item=sti}
        &raquo; {$sti.category_name} - {$sti.name} {if $sti.label}&raquo; {$sti.label}{/if}  #{$sti.id}
    {/foreach}

</h1>
<form action="?cmd=module&module={$moduleid}&action=itemconfigedit&item_id={$item.id}&id={if $entry.id}{$entry.id}{else}new{/if}" method="POST">
    <table style="width: 95%" cellpadding="6" cellspacing="0">
        <tr>
            <td style="width: 80px">描述</td>
            <td><input type="text" class="inp" size="100" name="description" value="{$entry.description|escape}"/></td>
        </tr>

        <tr>

            <td>状态</td>
            <td>
                {if $entry.id}

                    {if $entry.archived}
                        <span style="background: gray; color: white; font-weight: bold; border-radius: 3px; padding: 1px 4px;">档案文件</span>
                        <input type="checkbox" name="archived" value="1"/> 设置为有效配置
                    {else}
                        <span style="background: #3EA23D; color: white; font-weight: bold; border-radius: 3px; padding: 1px 4px;">有效</span>
                        {if $upmode}<input type="checkbox" checked="checked" name="archived" value="1"/> 复制旧版本为档案文件
                        {/if}
                    {/if}
                {else}
                    <select class="inp" name="archived">
                        <option value="0">有效</option>
                        <option value="1">档案文件</option>
                    </select>
                {/if} 
            </td>
        </tr>
        <tr>
            <td style="vertical-align: top">配置</td>
            <td>
                <textarea style="width: 100%; min-height: 100px;" class="inp" name="config">{$entry.config|escape}</textarea>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="submit" value="{if $upmode}更新配置{else}创建配置{/if}" name="save" \>
            </td>
        </tr>
    </table>
</form>