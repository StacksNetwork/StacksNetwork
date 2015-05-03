{if $monitoring_data}<script type="text/javascript">MonitoringData['{$item.hash}'] = {$monitoring_data};;</script>{/if}
<script type="text/javascript" src="{$moduledir}edititem.js"></script>
<form id="saveform" class="clearfix" method="post" action="?cmd=module&module=dedimgr">
    <input type="hidden" name="do" value="rack" />
        <input type="hidden" name="backview" value="{$backview}" />
    <input type="hidden" name="rack_id" value="{if $rack_id}{$rack_id}{else}{$rack.id}{/if}" />
    {if $item.id!='new'}
        <input type="hidden" name="id" value="{$item.id}" id="item_id"/>
        <input type="hidden" name="make" value="edititem" />
    {else}
        <input type="hidden" name="id" value="new" id="item_id"/>
        <input type="hidden" name="make" value="additem" />
        <input type="hidden" name="item_id" value="{$item.type_id}" />
        <input type="hidden" name="category_id" value="{$item.category_id}" />
        <input type="hidden" name="position" value="{$position}" />
        <input type="hidden" name="location" value="{$location}" />
    {/if}
    {if $itsblade}
        <input type="hidden" name="parent_id" value="{$itsblade}" />
        <input type="hidden" name="location" value="Blade" />
    {/if}
    <input type="hidden" value="{if $item.category_name}{$item.category_name|escape} - {/if}{$item.name|escape} {if $item.label}&raquo; {$item.label|escape}{/if}  #{$item.id}" id="item_name">
    <div id="lefthandmenu">
        <a class="tchoice" href="#0">基本设置</a>
        {if $item.isblade=='1'}
            <a class="tchoice" href="#1">刀片/模块化系统</a>   
        {/if}
        {if $inventory_manager}
            <a class="tchoice" href="#2">库存管理</a>
        {/if}
        <a class="tchoice" href="#3">硬件</a>
        <a class="tchoice" href="#4">物理连接</a> 
        <a class="tchoice" href="#5">监控</a>
        <a class="tchoice" href="#6">配置</a>
        <a class="tchoice" href="#7">备注</a>
    </div>
    <div class="conv_content">

        {if $item.isblade=='1'}
            <!-- BLADE -->
            {include file="blade_servers.tpl"}<!-- BLADE END -->
        {/if}

        <!-- CONNECTIONS -->
        <div class="tabb tabb-big" data-tab="4">
            <h3><i class="fa fa-sitemap"></i> 连接</h3>
            {if $item.id=='new'}
                <strong>首先保存您的设备, 并接通电源连接网络</strong>
            {else}
                <div id="connection_mgr">
                    {include file='ajax.connections.tpl'}
                </div>
            {/if}
        </div><!-- CONNECTIONS END -->

        <!-- CONFIGURATIONS -->
        <div class="tabb tabb-big" id="configurations" data-tab="6">
            <h3><i class="fa fa-archive"></i> 配置</h3>
            <div>
                {include file="ajax.itemconfigs.tpl"}
            </div>
        </div><!-- CONFIGURATIONS END -->
        
        <!-- MONITORING  -->
        <div class="tabb tabb-big" data-tab="5">
            <h3><i class="fa fa-eye"></i> 监控</h3>
            <p>
                如果Nagios模块被激活并已启用, 则您可以监控该设备. <br/>
                在相关的机架内, 监控系统搜索和匹配设备相应的主机名/标签.
            </p>
            <p style="padding: 5px 0;">
                <a class="new_control" href="#" onclick="loadItemMonitoring(1); return false" ><span>刷新</span></a>
            </p>
            <div id="itemmonitoring">没有发现监测数据/取出该物品</div>
        </div><!-- MONITORING END -->
        
        <!-- NOTES -->
        <div class="tabb tabb-big" data-tab="7" >
            <h3><i class="fa fa-info-circle"></i> 备注</h3>
            <div class="form-group"> 
                <span>管理员备注</span>
                <textarea name="notes" style="width: 99%; height: 100px">{$item.notes}</textarea>
            </div>
        </div><!-- NOTES END -->
        
        <!-- SETTINGS -->
        <div class="tabb tabb-small tabb-complex tabb-overflow" data-tab="0">
            <h3><i class="fa fa-edit"></i> 基础设置</h3>

            <div class="form-group">
                <label>主机名 / 标签</label>
                <input type="text" size="" class="w250" name="label" value="{$item.label}" id="item_label"/>
                <input type="hidden" value="{$item.hash}" id="item_hash"/>
            </div>
            {if !$itsblade}
                <div class="form-group">
                    <label>上一层设备</label>
                    <select class="w250" name="parent_id" default="{$item.parent_id}" >
                        <option value="0" {if $item.parent_id=='0'}selected="selected"{/if}>#0: 无</option>
                    </select>
                </div>

            {/if}
            <div class="form-group">
                <label class="nodescr">所有人</label>
                <select class="w250" name="client_id" default="{$item.client_id}" onchange="reloadServices()">
                    <option value="0">无</option>
                </select>
            </div>
            <div id="related_service" class="form-group">
                {if $item.account_id}
                    <label class="nodescr">相关服务</label>
                    <input type="text"   size="" value="{$item.account_id}" class="w250" name="account_id" id="account_id" />

                {/if}
            </div>
            <div class="form-group">
                <label >刀片机? <small>在激活后请重新加载</small></label>
                <input type="checkbox" value="1" {if $item.isblade=='1'}checked="checked"{/if} name="isblade" />
            </div>
        </div><!-- SETTINGS END -->
            
        <!-- SUMMARY -->
        <div class="tabb tabb-small tabb-complex" data-tab="0">
            <h3><i class="fa fa-bar-chart-o"></i> 概要</h3>
            <div>
                <table cellspacing="0" cellpadding="0" width="100%" class="whitetable" style="border: 1px solid #DDDDDD;">
                    <tbody>
                        <tr><td>尺寸:</td><td> {$item.units} U</td></tr>
                        <tr><td>电流:</td><td>{$item.current} Amps</td></tr>
                        <tr><td>功率:</td><td>{$item.power} W</td></tr>
                        <tr><td>重量: </td><td>{$item.weight} KG</td></tr>
                        <tr><td>月资费:</td><td>{$item.monthly_price} {$currency.code}</td></tr>
                        <tr><td>供应商:</td><td>{$item.vendor_name}</td></tr>
                        <tr><td colspan="2"><a href="?cmd=module&module=dedimgr&do=inventory&subdo=category&category_id={$item.category_id}&item_id={$item.item_id}" target="_blank" class="editbtn fs11 orspace">编辑该物品类型</a></td></tr>
                    </tbody>
                </table>
            </div>
        </div><!-- SUMMARY END -->

        {if $accounts}
            <!-- ACCOUNTS -->
            <div class="tabb tabb-small tabb-complex" data-tab="0">
                <h3><i class="fa fa-users"></i> 账号</h3>
                <div>
                    <table cellspacing="3" cellpadding="0" width="100%" class="whitetable" style="border: 1px solid #DDDDDD;">
                        <tbody>
                            <tr>
                                <td><b>该物品被分配到以下帐户:</b></td>
                            </tr>
                            {foreach from=$accounts item=a}
                                <tr>
                                    <td>
                                        <a href="?cmd=clients&action=show&id={$a.client_id}" target="_blank">客户 #{$a.client_id} {$a.lastname} {$a.firstname}</a> - <a href="?cmd=accounts&action=edit&id={$a.id}" target="_blank">账号 #{$a.id}</a>
                                    </td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
            </div><!-- ACCOUNTS END -->
        {/if}

        {if $inventory_manager}
            <!-- INVENTORY MGR -->
            <div class="tabb tabb-small tabb-overflow" data-tab="2">
                <h3><i class="fa fa-tasks"></i> 库存管理</h3>
                <div class="form-group">
                    <label class="nodescr">调试完成ID</label>
                    <select  class="w250" name="build_id" default="{$item.build_id}" onchange="reloadInventory($(this).val())">
                        <option value="0" {if $item.build_id=='0'}selected="selected"{/if}>#0: 无</option>
                    </select>
                </div>
                <div id="inventorygrid">
                </div>
            </div><!-- INVENTORY MGR END -->
        {/if}
        <!-- HARDWARE -->
        <div class="tabb tabb-small" data-tab="3">
            <h3><i class="fa fa-hdd-o"></i> 硬件</h3>
            {foreach from=$item.fields item=f}
                {if $f.field_type=='clients'}{continue}
                {/if}
                <div class="form-group">
                    <label class="nodescr">{$f.name} </label>
                    {if $f.field_type=='input'}
                        <input name="field[{$f.id}]" value="{$f.value}" class="w250"  type="text" />
                    {elseif $f.field_type=='text'}
                        <input name="field[{$f.id}]" value="{$f.value}" type="hidden" />
                        {$f.default_value}
                    {elseif $f.field_type=='select'}
                        <select name="field[{$f.id}]" class="w250">
                            {foreach from=$f.default_value item=d}
                                <option {if $f.value==$d}selected="selected"{/if}>{$d}</option>
                            {/foreach}
                        </select>

                    {elseif $f.field_type=='pdu_app'}
                        <select name="field[{$f.id}]" class="w250" onchange="changeHardwareApp(this, 'pdu')">
                            <option value="0" {if $f.value=='0'}selected="selected"{/if}>---</option>
                            {foreach from=$pdu_apps item=d}
                                <option value="{$d.id}" {if $f.value==$d.id}selected="selected"{/if}>#{$d.id} {$d.groupname} - {$d.name}</option>
                            {/foreach}
                            <option value="new" >添加新连接</option>
                        </select> <a class="new_control" href="#" onclick="loadports('{$f.id}', 'PDU', this); return false;"><span class="gear_small"> 加载端口</span></a>
                    {elseif $f.field_type=='switch_app'}
                        <select name="field[{$f.id}]" class="w250" onchange="changeHardwareApp(this, 'switch')">
                            <option value="0" {if $f.value=='0'}selected="selected"{/if}>---</option>
                            {foreach from=$switch_apps item=d}
                                <option value="{$d.id}" {if $f.value==$d.id}selected="selected"{/if}>#{$d.id} {$d.groupname} - {$d.name}</option>
                            {/foreach}
                            <option value="new" >连接新端口</option>
                        </select> <a class="new_control" href="#" onclick="loadports('{$f.id}', 'NIC', this); return false;"><span class="gear_small"> 加载端口</span></a>
                    {/if}
                </div>
            {foreachelse}
                <div>无附加字段</div>
            {/foreach}
        </div><!-- HARDWARE END -->
        <div id="porteditor" style="display:none"></div>
    </div>
    {securitytoken}
</form>
<div class="dark_shelf dbottom">
        <div class="left spinner page-hidden"><img src="ajax-loading2.gif"></div>
    <div class="right">
            <span class="bcontainer" >
            <a class="new_control greenbtn" href="#" onclick="$('#saveform').submit();
            return false"><span>{$lang.savechanges}</span>
            </a>
        </span>
            <span class="page-hidden">{$lang.Or}</span>
            <span class="bcontainer page-hidden">
            <a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');
            return false;"><span>{$lang.Close}</span></a>
        </span>


    </div>
</div>