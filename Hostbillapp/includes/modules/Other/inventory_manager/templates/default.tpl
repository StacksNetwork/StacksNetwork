<script>
var currencySettings={literal}{{/literal}
decimalSeparator:".", thousandsSeparator: "", decimalPlaces: {$currency.decimal}, prefix: "{$currency.sign}", suffix:" {$currency.code}", defaultValue: '0.00'
{literal}}{/literal};

</script>
<link rel="stylesheet" type="text/css" media="screen" href="{$moduleliburl}jqueryui/custom-theme/jquery-ui-1.10.0.custom.css" />
<link rel="stylesheet" type="text/css" media="screen" href="{$moduleliburl}jqgrid/css/ui.jqgrid.css" />
<link rel="stylesheet" href="{$template_dir}js/facebox/facebox.css" type="text/css" />
<link rel="stylesheet" type="text/css"  href="{$moduleliburl}font-awesome/css/font-awesome.min.css" />
<script type="text/javascript" src="{$template_dir}js/facebox/facebox.js"></script>

<script src="{$moduleliburl}common.js" type="text/javascript"></script>
<script src="{$moduleliburl}jqueryui/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<script src="{$moduleliburl}jqgrid/js/grid.locale-en.js" type="text/javascript"></script>
<script src="{$moduleliburl}jqgrid/js/jquery.jqGrid.src.js" type="text/javascript"></script>
<script src="{$moduleliburl}jquery.highlight.js" type="text/javascript"></script>


<div class="newhorizontalnav" id="newshelfnav">
    <div class="list-1">
        <ul>
            <li class="{if $action=='default' || !$action}active{/if}">
                <a href="?cmd=inventory_manager"><span>库存控制台</span></a>
            </li>
            
            <li class="{if $action=='inventory' || $action=='inventorylist'}active{/if}">
                <a href="?cmd=inventory_manager&action=inventory"><span>库存信息(已用/闲置)</span></a>
            </li>

            <li class="{if $action=='builds'}active{/if}">
                <a href="?cmd=inventory_manager&action=builds"><span>设备调试(Build!)</span>{if $pending_builds>0}<span class="badge">{$pending_builds}</span>{/if}</a>
            </li>

            <li class="{if $action=='deliveries'}active{/if}">
                <a href="?cmd=inventory_manager&action=deliveries"><span>已采购的设备</span></a>
            </li>


            <li class="{if $action=='deployments'}active{/if}">
                <a href="?cmd=inventory_manager&action=deployments"><span>可调试的设备配置</span></a>
            </li>

            <li  class="{if $action=='categories'}active{/if}">
                <a href="?cmd=inventory_manager&action=categories"><span>配件分类/类型</span></a>
            </li>
            <li class="{if $action=='vendors'}active{/if}">
                <a href="?cmd=inventory_manager&action=vendors"><span>供应商信息</span></a>
            </li>
            <li class="{if $action=='producers'}active{/if}">
                <a href="?cmd=inventory_manager&action=producers"><span>厂商信息</span></a>
            </li>

            <li class="{if $action=='settings'}active{/if} last">
                <a href="?cmd=inventory_manager&action=settings"><span>系统设置</span></a>
            </li>

        </ul>
    </div>
</div>
<div style="padding:10px">
    {if !$action || $action=='default'}
        {include file='dashboard.tpl'}
    {elseif $action=='inventory'}
        {include file='inventory.tpl'}
    {elseif $action=='inventorylist'}
        {include file='inventorylist.tpl'}
    {elseif $action=='builds'}
        {include file='builds.tpl'}
    {elseif $action=='deliveries'}
        {include file='deliveries.tpl'}
    {elseif $action=='deployments'}
        {include file='deployments.tpl'}
    {elseif $action=='producers'}
        {include file='producers.tpl'}
    {elseif $action=='vendors'}
        {include file='vendors.tpl'}
    {elseif $action=='categories'}
        {include file='categories.tpl'}
    {elseif $action=='settings'}
        {include file='settings.tpl'}
    {/if}    

</div>
{literal}
    <style>
        td.bordered {
            border-left: 0 none;
            border-right: 0 none;
            display: block;
            left: 0;
            margin-top: -20px;
            position: absolute;
            width: 100%;
        }
        #bodycont2{
            margin-right: 92px;
            border-top: 3px solid #6694E3;
            display: block;
            left: 0;
            margin-top: -20px;
            position: absolute;
            width: 100%;
        }
        #helpcontainer {
            padding-bottom:10px;     
        }
        .modernfacebox .conv_content .tabb {
            position:relative;
        }
        .subgrid-data , .subgrid-cell{
            background:#eee;
        }
        #porteditor {
            background: #F8F8F8;
            bottom: 52px;
            box-shadow: -1px 0 2px rgba(0, 0, 0, 0.2);
            display: none;
            left: 300px;
            position: absolute;
            right: 10px;
            top: 10px;
            padding:20px;
            z-index: 999;
            overflow:auto;
        }

        #facebox .ui-jqgrid .jqgrow td input, #facebox .ui-pg-input, #facebox .ui-pg-selbox {
            margin:0px;
            width:auto;
            border-radius:0px;
            padding:1px;
            box-shadow:none;
        }
        .badge {
            background-color: rgb(185, 74, 72);
            border-bottom-left-radius: 9px;
            border-bottom-right-radius: 9px;
            border-collapse: separate;
            border-top-left-radius: 9px;
            border-top-right-radius: 9px;
            color: rgb(255, 255, 255);
            display: inline-block;
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            font-size: 12px;
            font-weight: bold;
            height: 14px;
            line-height: 14px;
            padding-bottom: 2px;
            padding-left: 9px;
            padding-right: 9px;
            padding-top: 2px;
            text-align: left;
            text-shadow: rgba(0, 0, 0, 0.247059) 0px -1px 0px;
            vertical-align: baseline;
            white-space: nowrap;    
            margin-left:10px;
        }
    </style>
{/literal}