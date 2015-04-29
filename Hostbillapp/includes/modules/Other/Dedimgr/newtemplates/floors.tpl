
<h1>数据中心: <strong><a href="?cmd=module&module={$moduleid}&do=floors&colo_id={$colocation.id}">{$colocation.name}</a></strong> &raquo; 楼层:  </h1>

{if $floors}
<ul style="border:solid 1px #ddd;border-bottom:none;" id="grab-sorter">

    {foreach from=$floors item=floor}

    <li style="background:#ffffff"><div style="border-bottom:solid 1px #ddd;">
            <table width="100%" cellspacing="0" cellpadding="5" border="0">
                <tbody><tr>
                        <td width="120" valign="top"><div style="padding:10px 0px;">
                                <a  class="sorter-ha menuitm menuf" href="?cmd=module&module={$moduleid}&do=floor&floor_id={$floor.id}"><span >机架</span></a><!--
                                --><a style="width:14px;" title="Edit" class="menuitm menuc" href="#" onclick="return editFloor('{$floor.id}')"><span class="editsth"></span></a><!--
                                --><a   href="?cmd=module&module={$moduleid}&do=removefloor&floor_id={$floor.id}&colo_id={$floor.colo_id}" onclick="return confirm('您确定需要删除该层并包含所有内容吗?');" title="删除" class="menuitm menul" ><span class="delsth"></span></a>
                            </div></td>
                        <td style="line-height:20px">
                            <h3><a href="?cmd=module&module={$moduleid}&do=floor&floor_id={$floor.id}">楼层 #{$floor.floor}- {$floor.name}</a></h3>
                            机架: <a href="?cmd=module&module={$moduleid}&do=floor&floor_id={$floor.id}"><strong>{$floor.racks}</strong></a><br/>
                            
                            {foreach from=$floor.rack_list item=rack}<em class="fs11" style="padding-left:20px"><a href="?cmd=module&module={$moduleid}&do=rack&rack_id={$rack.id}">{$rack.name} ({$rack.units} U)</a></em>{/foreach} <em class="fs11" style="padding-left:20px"><a href="?cmd=module&module={$moduleid}&do=floor&floor_id={$floor.id}">...</a></em>

                        </td>

                    </tr>
                </tbody></table></div></li>


    {/foreach}
</ul>
<div style="padding:10px 4px">
    <a id="addnew_conf_btn" onclick="return addFloor('{$colocation.id}');" class="new_control" href="#"><span class="addsth"><strong>添加新楼层</strong></span></a>
</div>
{else}

<div class="blank_state_smaller blank_forms" id="blank_pdu">
    <div class="blank_info">
        <h1>您尚未添加任何楼层</h1>
        服务器托管模块组织您的库存 数据中心->楼层->机架->设备配置. 开始添加楼层 <br/><br/>


        <div class="clear"></div>
            <a onclick="return addFloor('{$colocation.id}');" class="new_control" href="#"><span class="addsth"><strong>添加楼层</strong></span></a>
        <div class="clear"></div>
    </div>
</div>

{/if}





