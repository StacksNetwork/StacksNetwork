{if $colocations}
<ul style="border:solid 1px #ddd;border-bottom:none;" id="grab-sorter">

    {foreach from=$colocations item=colo}

    <li style="background:#ffffff"><div style="border-bottom:solid 1px #ddd;">
            <table width="100%" cellspacing="0" cellpadding="5" border="0">
                <tbody><tr>
                        <td width="120" valign="top"><div style="padding:10px 0px;">
                                <a  class="sorter-ha menuitm menuf" href="?cmd=module&module={$moduleid}&do=floors&colo_id={$colo.id}"><span >楼层</span></a><!--
                                --><a style="width:14px;" title="编辑" class="menuitm menuc" href="?cmd=module&module={$moduleid}&do=floors&colo_id={$colo.id}" onclick="return editColocation('{$colo.id}')"><span class="editsth"></span></a><!--
                                --><a  onclick="return confirm('您确定需要删除该数据中心吗?');" title="删除" class="menuitm menul" href="?cmd=module&module={$moduleid}&do=removecolo&colo_id={$colo.id}"><span class="delsth"></span></a>
                            </div></td>
                        <td  style="line-height:20px">
                            <h3><a href="?cmd=module&module={$moduleid}&do=floors&colo_id={$colo.id}">{$colo.name}</a></h3>
                            楼层: <a href="?cmd=module&module={$moduleid}&do=floors&colo_id={$colo.id}"><strong>{$colo.floors}</strong></a><br />
                            机架: <strong>{$colo.racks}</strong> {foreach from=$colo.rack_list item=rack}<em class="fs11" style="padding-left:20px"><a href="?cmd=module&module={$moduleid}&do=rack&rack_id={$rack.id}">{$rack.name} ({$rack.units} U)</a></em>{/foreach} <em class="fs11" style="padding-left:20px"><a href="?cmd=module&module={$moduleid}&do=floors&colo_id={$colo.id}">...</a></em><br />
                            {if $colo.address}<strong>地址:</strong> {$colo.address}<br />{/if}
                            {if $colo.phone}<strong>电话:</strong> {$colo.phone}<br />{/if}
                            {if $colo.emergency_contact}<strong>紧急联系人:</strong> {$colo.emergency_contact}<br />{/if}
                        </td>
                        <td width="150" valign="top" style="background:#F0F0F3;color:#767679;font-size:11px">
                            <strong>单价 / 1GB:</strong> {$colo.price_per_gb|price:$currency}<br />
                            <strong>单价 / IP:</strong> {$colo.price_per_ip|price:$currency}<br />
                            <strong>单价 / Rank:</strong> {$colo.price_reboot|price:$currency}
                        </td>
                    </tr>
                </tbody></table></div></li>


    {/foreach}
</ul>

<div style="padding:10px 4px">
    <a id="addnew_conf_btn" onclick="return addColocation();" class="new_control" href="#"><span class="addsth"><strong>添加新的数据中心</strong></span></a>
</div>
{else}
<div class="blank_state_smaller blank_forms" id="blank_pdu">
    <div class="blank_info">
        <h1>您尚未选定任何数据中心</h1>
        服务器托管模块组织您的库存 数据中心->楼层->机架->设备配置. 开始添加数据中心 <br/><br/>


        <div class="clear"></div>
            <a onclick="return addColocation();" class="new_control" href="#"><span class="addsth"><strong>添加数据中心</strong></span></a>
        <div class="clear"></div>
    </div>
</div>

{/if}