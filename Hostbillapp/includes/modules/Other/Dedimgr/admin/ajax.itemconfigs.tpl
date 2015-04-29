<table style="width: 100%" cellpadding="6" cellspacing="0" class="configs hover">
    <thead>
        <tr>
            <th>运行设置</th>
            <th>档案文件</th>
        </tr>
    </thead>
    {foreach from=$configs item=conf key=main}
        <tbody>

            <tr>
                <td> 
                    {if $conf.active}
                        {$conf.active.description|escape|truncate} 
                        <a href="?cmd=module&module={$moduleid}&action=itemconfigedit&item_id={$item.id}&id={$conf.active.id}" class="editbtn" target="_blank" >编辑</a> 
                        <a href="?cmd=module&module={$moduleid}&action=itemconfigs&item_id={$item.id}&remove={$conf.active.id}" class="editbtn rem" >删除</a> 
                        <i style="font-size: 10px; display: block; color: rgb(125, 125, 125);">({$conf.active.date|dateformat:$date_format}, {$conf.active.author})</i> 
                    {else}
                        -
                    {/if}
                </td>
                <td>
                    {if $conf.archived}
                        {$conf.archived[0].description|escape|truncate} 

                        <a href="?cmd=module&module={$moduleid}&action=itemconfigs&item_id={$item.id}&remove={$conf.archived[0].id}" class="editbtn right rem" >删除</a> 
                        <a href="?cmd=module&module={$moduleid}&action=itemconfigedit&item_id={$item.id}&id={$conf.archived[0].id}" class="editbtn right" target="_blank" style="padding: 0 4px;">显示</a>
                        <i style="font-size: 10px; color: rgb(125, 125, 125);">({$conf.archived[0].date|dateformat:$date_format}, {$conf.archived[0].author})</i> 
                    {else}
                        -
                    {/if}
                </td>
            </tr>
            {foreach from=$conf.archived item=entry name=cfgl}
                {if !$smarty.foreach.cfgl.first}
                    <tr {if $smarty.foreach.cfgl.index > 2}class="fold"{/if}>
                        <td></td>
                        <td>
                            {$entry.description|escape|truncate} 
                            <a href="?cmd=module&module={$moduleid}&action=itemconfigs&item_id={$item.id}&remove={$entry.id}" class="editbtn right rem" >删除</a> 
                            <a href="?cmd=module&module={$moduleid}&action=itemconfigedit&item_id={$item.id}&id={$entry.id}" class="editbtn right" target="_blank" style="padding: 0 4px;">显示</a>
                            <i style="font-size: 10px; color: rgb(125, 125, 125);">({$entry.date|dateformat:$date_format}, {$entry.author})</i> 
                        </td>
                    </tr>
                {/if}
            {/foreach}
            {if $smarty.foreach.cfgl.index > 2}
                <tr>
                    <td></td>
                    <td><a href="#" onclick="$(this).children().toggle().end().parents('tr').eq(0).prevAll('.fold').toggle();
                            return false;" class="editbtn"><span>显示更多 ..</span><span style="display: none">隐藏旧的内容 ..</span></a></td>
                </tr>
            {/if}
        </tbody>
    {foreachelse}
        <tr>
            <td colspan="2">
                {if $item.id > 0}
                    尚未添加任何配置.
                {else}
                    首先保存该物品.
                {/if}
            </td>
        </tr>
    {/foreach}
    <tfoot>
        <tr>
            <td colspan="2">
                {if $item.id > 0}
                    <a href="?cmd=module&module={$moduleid}&action=itemconfigedit&item_id={$item.id}&id=new" target="_blank" class="new_control greenbtn"><span>新的配置</span></a>
                    <a href="?cmd=module&module={$moduleid}&action=itemconfigdiff&item_id={$item.id}" target="_blank" class="new_control "><span>配置比较</span></a>
                {/if}
            </td>
        </tr>
    </tfoot>
</table>