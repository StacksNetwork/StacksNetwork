
<script type="text/javascript" src="{$moduledir}jquery-ui-1.9.2.custom/js/jquery-ui-1.9.2.custom.min.js"></script>
<link rel="stylesheet" href="{$moduledir}jquery-ui-1.9.2.custom/css/ui-lightness/jquery-ui-1.9.2.custom.min.css" type="text/css" />

<link rel="stylesheet" href="{$moduledir}popover/popover.css" type="text/css" />
<script type="text/javascript" src="{$moduledir}rack.js"></script>
<script type="text/javascript" src="{$template_dir}hbchat/media/mustache.js?v={$hb_version}"></script>

{if $inventory_manager}
    <link rel="stylesheet" type="text/css" media="screen" href="{$moduleliburl}jqgrid/css/ui.jqgrid.css" />
    <script src="{$moduleliburl}jqgrid/js/grid.locale-en.js" type="text/javascript"></script>
    <script src="{$moduleliburl}jqgrid/js/jquery.jqGrid.min.js" type="text/javascript"></script>
{/if}
{if $monitoring_data}
    <script type="text/javascript">
        $.extend(MonitoringData, {$monitoring_data} || {literal}{}{/literal}) ;;
        {literal}
        $(function(){
            loadMonitoring(MonitoringData);
        });
        {/literal}
    </script>
{/if}
<input type="hidden" name="rack_id" value="{$rack.id}" id="rack_id" />

<h1>数据中心: <strong>
        <a href="?cmd=module&module={$moduleid}&do=floors&colo_id={$rack.colo_id}">{$rack.coloname}</a></strong>
    &raquo; 楼层: <strong><a href="?cmd=module&module={$moduleid}&do=floor&floor_id={$rack.floor_id}">{$rack.floorname}</a> <em>{if $rack.room} 机房: {$rack.room}{/if}</em></strong>
    &raquo; 机柜: <strong><a href="?cmd=module&module={$moduleid}&do=rack&rack_id={$rack.id}">{$rack.name}</a> ({$rack.units} U)</strong> </h1>

<p id="rackview_switch">
    <a class="menuitm menuf {if !$rackview}activated{/if}" href="?cmd=module&module={$moduleid}&do=listview&rel=rack&id={$rack.id}" data-rel="rack_view">详情</a>{*}
    {*}<a class="menuitm menuc {if $rackview=='list'}activated{/if}" href="?cmd=module&module={$moduleid}&do=listview&rel=rack&id={$rack.id}&type=list" data-rel="rack_list">列表</a>{*}
    {*}<a class="menuitm menul {if $rackview=='ipam'}activated{/if}" href="?cmd=module&module={$moduleid}&do=listview&rel=rack&id={$rack.id}&type=ipam" data-rel="rack_ipam">IPAM</a>
</p>

<table border="0" cellpadding="0" cellspacing="0" width="100%" class="rack-list" id="rack_ipam">
    <tr>
        <th>位置</th>
        <th>设备</th>
        <th>端口</th>
        <th>IPAM</th>
        <th>子网/VLAN</th>
        <th></th>
    </tr>
    {foreach from=$rackips item=i}
        <tr class="rack-list-item">
            <td class="rack-list-u">
                <div>
                    {math equation="x + 1" x=$i.position}
                </div>
            </td>
            <td>
                {$i.item.category_name}: {$i.item.name} - {$i.item.label}
            </td>
            <td>
                <div onclick="getportdetails({$i.id})" class="port "><div>{$i.number}</div></div>
            </td>
            <td>{$i.ipaddress}</td>
            <td class="rack-list-ca">
                {if !$i.ipam}
                    <em>未安装IPAM模块</em>
                {else}
                    <em>子网: {if $i.subnet_id}<a href="?cmd=module&module=ipam&action=details&group={$i.subnet_id}" target="_blank">{$i.subnet_name}</a>{else}无{/if}</em>
                    <em>VLAN: {if $i.vlan_id}<a href="?cmd=module&module=ipam&action=vlan_details&group={$i.vlan_id}" target="_blank">{$i.vlan_name}</a>{else}无{/if}</em>
                {/if}
            </td>
            <td class="rack-list-act">
                <div>
                    <a onclick="return editRackItem('{$i.item_id}')" href="#" class="menuitm menu" title="编辑" style="width:14px;"><span class="editsth"></span></a></a>
                </div>
            </td>
        </tr>
    {/foreach}
    <tr>
        <td colspan="10">
            <span style="padding-right:20px">总功率: {$rack.power} W </span>
            <span style="padding-right:20px">总电流: {$rack.current} A </span>
            <span style="padding-right:20px">总重量: {$rack.weight} KG </span>
            <span style="padding-right:20px">月资费: {$rack.monthly_cost} {$currency.code} </span>
        </td>
    </tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" width="100%" class="rack-list" id="rack_list">
    <tr>
        <th>位置</th>
        <th>设备</th>
        <th>标签</th>
        <th>单位</th>
        <th>分配</th>
        <th></th>
    </tr>
    {foreach from=$rack.positions item=positions key=location}
        <tbody>
        {if $location!='Front'}
            <tr><th colspan="6">{if $lang[$location]}{$lang[$location]}{else}{$location}{/if}</th></tr>
        {/if}
        {foreach from=$positions item=i}
            {if $i}
                <tr class="rack-list-item">
                    <td class="rack-list-u">
                        <div>
                            {math equation="x + 1" x=$i.position}
                        </div>
                    </td>
                    <td>{$i.category_name}: {$i.name}</td>
                    <td>{$i.label}</td>
                    <td>{$i.units}U</td>
                    <td class="rack-list-ca">
                        <em>客户: {if $i.client_id}<a href="?cmd=clients&action=show&id={$i.client_id}" >#{$i.client_id} {$i.lastname} {$i.firstname}</a>{else}无{/if}</em>
                        <em>账号: {if $i.account_id}<a href="?cmd=accounts&action=edit&id={$i.account_id}" >#{$i.account_id} {$i.domain}</a>{else}无{/if}</em>
                    </td>
                    <td class="rack-list-act">
                        <div>
                            <a onclick="return editRackItem('{$i.id}')" href="#" class="menuitm menuf" title="编辑" style="width:14px;"><span class="editsth"></span></a><!--
                            --><a class="menuitm menul" title="删除" onclick="return confirm('您确定需要删除该物品吗?');" 
                                  href="?cmd=module&module={$moduleid}&do=rack&make=delitem&id={$i.id}&rack_id={$rack.id}"><span class="delsth"></span></a>
                        </div>
                    </td>
                </tr>
                {foreach from=$i.bladeitems item=i name=blade}
                    <tr class="rack-list-item blade">
                        <td class="rack-list-u">
                            <div>{if $smarty.foreach.blade.last}&#x2514;{else}&#x251c;{/if}</div>
                        </td>
                        <td>{$i.category_name}: {$i.name}</td>
                        <td>{$i.label}</td>
                        <td>-</td>
                        <td class="rack-list-ca">
                            <em>客户: {if $i.client_id}<a href="?cmd=clients&action=show&id={$i.client_id}" >#{$i.client_id} {$i.lastname} {$i.firstname}</a>{else}无{/if}</em>
                            <em>账号: {if $i.account_id}<a href="?cmd=accounts&action=edit&id={$i.account_id}" >#{$i.account_id} {$i.domain}</a>{else}无{/if}</em>
                        </td>
                        <td class="rack-list-act">
                            <div>
                                <a onclick="return editRackItem('{$i.id}')" href="#" class="menuitm menuf" title="编辑" style="width:14px;"><span class="editsth"></span></a><!--
                                --><a class="menuitm menul" title="删除" onclick="return confirm('您确定需要删除该物品吗?');" 
                                      href="?cmd=module&module={$moduleid}&do=rack&make=delitem&id={$i.id}&rack_id={$rack.id}"><span class="delsth"></span></a>
                            </div>
                        </td>
                    </tr>
                {/foreach}
            {/if}
        {/foreach}
        </tbody>
    {/foreach}
    <tr>
        <td colspan="10">
            <span style="padding-right:20px">总功率: {$rack.power} W </span>
            <span style="padding-right:20px">总电流: {$rack.current} A </span>
            <span style="padding-right:20px">总重量: {$rack.weight} KG </span>
            <span style="padding-right:20px">月资费: {$rack.monthly_cost} {$currency.code} </span>
        </td>
    </tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" width="100%" id="rack_view">
    <tr>
        <td colspan="2"></td>
        <td colspan="3" class="rack-header">
            <a href="#<<" title="扩展左侧" onclick="return expandRack('l')"><i class="fa fa-caret-square-o-left"></i></a>
            <a href="#>>" title="扩展右侧" onclick="return expandRack('r')" class="right"><i class="fa fa-caret-square-o-right"></i></a>
            <a href="#edit" title="编辑机架详情" onclick="return editRack('{$rack.id}')"><i class="fa fa-pencil-square"></i></a>
            <a href="#monitoring" title="加载监控" id="monitoringbtn" onclick="loadMonitoring();return false" ><i class="fa fa-refresh"></i></a>
        </td>
        <td></td>
    </tr>
    <tr>
        <td valign="top" width="30">
            <table class="rack-table" id="statuscol" cellpadding="0" cellspacing="0" width="20">
                <tbody>
                    {foreach from=$rack.positions.Front item=i key=k} 
                        <tr>
                            <td pos="{$k}"></td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </td>
        <td valign="top" width="30">
            <table class="rack-table rack-u-legend" id="rowcols" cellpadding="0" cellspacing="0" width="28">
                <tbody>
                    {foreach from=$rack.positions.Front item=i key=k} 
                        <tr><td>{math equation="x + 1" x=$k}U</td></tr>
                    {/foreach}
                </tbody>
            </table>
        </td>
        <td valign="top" width="1" >
            <div class="rack-mount">
                <div class="rack-side rack-side-l">
                    {foreach from=$rack.positions.Lside item=i key=k name=cols}
                        {if $smarty.foreach.cols.index % $rack.units ==0}{if !$smarty.foreach.cols.first}</div>{/if}<div class="col-group">{/if}
                        {if $i}
                            {include file="rack_item.tpl"}
                            {else}
                            <div class="newitem"></div>
                        {/if}
                    {/foreach}
                    </div><!-- col-group -->
                </div>
            </div>
        </td>
        <td valign="top" width="200">
            <table class="rack-front" cellpadding="0" cellspacing="0">
                <tbody id="sortable">
                    {foreach from=$rack.positions.Front item=i key=k}
                        {if $i}
                            <tr class="have_items dragdrop" data-position="{$k}" data-units="{$i.units}" data-id="{$i.id}" label="{$i.hash}">
                                <td class="rack_{$i.units}u contains rack-row" id="item_{$i.id}" >
                                    {include file="rack_item.tpl"}
                                </td>
                            </tr>
                        {else}
                            <tr data-position="{$k}" class="dragdrop" data-units="1">
                                <td class="rack_1u canadd">
                                    <a class="newitem" href="#" onclick="return addRItem('{$k}')">上架新设备</a>
                                </td>
                            </tr>
                        {/if}
                    {/foreach}
                </tbody>
            </table>
        </td>
        <td valign="top" width="1" >
            
            <div class="rack-mount">
                <div class="rack-side rack-side-r">
                    {foreach from=$rack.positions.Rside item=i key=k name=cols}
                        {if $smarty.foreach.cols.index % $rack.units ==0}{if !$smarty.foreach.cols.first}</div>{/if}<div class="col-group">{/if}
                        {if $i}
                            {include file="rack_item.tpl"}
                            {else}
                            <div class="newitem"></div>
                        {/if}
                    {/foreach}
                    </div><!-- col-group -->
                </div>
            </div>
        </td>
        <td valign="top" id="former" style="padding-left:10px">
            
            <b>{$rack.name} 综述:</b>
            <div  class="p6" style="width:180px;margin-bottom:10px">
                <span style="padding-right:20px">总功率: {$rack.power} W </span> <br/>
                <span style="padding-right:20px">总电流: {$rack.current} A </span><br/>
                <span style="padding-right:20px">总重量: {$rack.weight} KG </span><br/>
                <span style="padding-right:20px">月资费: {$rack.monthly_cost} {$currency.code} </span>
                
            </div>
                
            <b>已安装上架的0U设备:</b>
            <div   style="width:200px;margin-bottom:10px">
               <table class="rack-front" cellpadding="0" cellspacing="0">
    <tbody >{foreach from=$rack.positions.Zero item=i key=k}
                        {if $i}
                            <tr class="have_items dragdrop" data-position="{$k}" data-units="1" data-id="{$i.id}" label="{$i.hash}">
                                <td class="rack_{$i.units}u contains rack-row" id="item_{$i.id}" >
                                    {include file="rack_item.tpl"}
                                </td>
                            </tr>
                        {else}
                            <tr data-position="{$k}" class="dragdrop" data-units="1">
                                <td class="rack_1u canadd">
                                    <a class="newitem" href="#" onclick="return addRItem('1','Zero')">安装上架新设备</a>
                                </td>
                            </tr>
                        {/if}
                    {/foreach}
    </tbody>
</table>
                
            </div>
        </td>
    </tr>

    <tr>
        <td colspan="2"></td>
        <td class="rack-floor" colspan="3" align="center">
            <h3>机柜: {$rack.name}</h3>
        </td>
        <td style="padding-left:20px" valign="top">
            
        </td>
    </tr>
</table>

<script type="text/javascript">
    initRack();
    {if $expand}
        {literal}
    $(document).ready(function() {
        editRackItem('{/literal}{$expand}{literal}');
    });
        {/literal}
    {/if}
</script>
