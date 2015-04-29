
<h1>数据中心: <strong><a href="?cmd=module&module={$moduleid}&do=floors&colo_id={$floor.colo_id}">{$floor.coloname}</a></strong> &raquo; 
    楼层:  <a href="?cmd=module&module={$moduleid}&do=floor&floor_id={$floor.id}">{$floor.name}</a> &raquo; 机架: </h1>
<p id="floorview_switch">
    <a class="menuitm menuf {if !$floorview}activated{/if}" href="?cmd=module&module={$moduleid}&do=listview&rel=floor&id={$floor.id}">详情</a>{*}
    {*}<a class="menuitm menul {if $floorview}activated{/if}" style="width:30px; text-align: center" title="列表" href="?cmd=module&module={$moduleid}&do=listview&rel=floor&id={$floor.id}&type=list">列表</a>
</p>
<div class="wall">
    <table border=0 cellpadding="0" cellspacing="0">
        <tr>
            {foreach from=$racks item=rack}
                <td valign="top">
                    <div class="rack_container">

                        <center><a class="rack3d"></a></center>
                        <div>
                            <p>机架: <strong>{$rack.name}</strong> ({$rack.units}U)</p>
                        <p>{if $rack.room}包房: {$rack.room}{/if} &nbsp;</p>
                        <div class="usage {if $rack.usage > 75}red{elseif $rack.usage>50}yelow{elseif $rack.usage>25}green{/if}">
                            <div style="width: {$rack.usage}%"><span class="inverted">{$rack.usage}%</span></div>
                            <span>{$rack.usage}%</span>
                        </div>
                        <div style="padding:10px 0px;">
                            <a href="?cmd=module&module={$moduleid}&do=rack&rack_id={$rack.id}" class="sorter-ha menuitm menuf"><span>物品</span></a><!--
                            --><a onclick="return editRack('{$rack.id}')" href="#" class="menuitm menuc" title="编辑" style="width:14px;"><span class="editsth"></span></a><!--
                            --><a class="menuitm menul" title="delete" onclick="return confirm('您确定需要删除该机架以及内部所有设备?');" href="?cmd=module&module={$moduleid}&do=removerack&rack_id={$rack.id}&floor_id={$rack.floor_id}"><span class="delsth"></span></a>
                        </div>
                    </div>

                </div>
            </td>
        {/foreach}
        <td valign="top">
            <div class="new_rack_container" onclick="return addRack('{$floor.id}')">

                <center><a class="new_rack3d"></a></center>
                <div>
                    &nbsp;
                    <div style="padding:10px 0px;">
                        <a id="addnew_conf_btn" onclick="return false;" class="new_control" href="#"><span class="addsth"><strong>添加新机架</strong></span></a>
                    </div>
                </div>

            </div>

            </div>
        </td>
    </tr>
</table>
</div>
