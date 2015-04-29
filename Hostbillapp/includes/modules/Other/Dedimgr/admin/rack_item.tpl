<div class="rackitem server{$i.units}u default_1u" 
     data-position="{$i.position}" data-units="{$i.units}" data-id="{$i.id}" 
     style="background-image: url({$moduledir}images/hardware/{$i.css})">
    <div class="lbl">{*}
        {*}{if $i.label}{$i.label}
        {else}{$i.category_name}
        {/if}
    </div>
    <div class="rackitem-menu">
        <h4>{if $i.label}{$i.label} - {/if}{$i.name}</h4>
        {if $i.bladeitems}
            <h5>刀片服务器/箱式交换机: </h5>
            <ul>
                {foreach from=$i.bladeitems item=b}
                    <li>{if $b.label}{$b.label} - {/if}{$b.name}</li>
                    {/foreach}
            </ul>
        {/if}
        <small>拖动改变位置.</small>
        <div class="fa-actions">
            <br>
            <a href="?cmd=module&module=dedimgr&do=rack&make=delitem&id={$i.id}&rack_id={$rack.id}" 
               title="删除物品"
               onclick="return confirm('您确定需要删除该物品吗?');">
                <i class="fa fa-trash-o"></i>
            </a>
            <a class="edititem" href="?cmd=module&module=dedimgr&do=itemeditor&item_id={$i.id}"
               title="编辑物品"
               onclick="editRackItem('{$i.id}');
                       return false;">
                <i class="fa fa-pencil"></i>
            </a>
            <a class="edititem" href="?cmd=module&module=dedimgr&do=itemeditor&item_id={$i.id}"
               title="在新窗口中显示详细内容">
                <i class="fa fa-share"></i>
            </a>
        </div>
    </div>
</div>