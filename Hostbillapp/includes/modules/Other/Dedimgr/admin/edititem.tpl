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

<script type="text/javascript" src="{$moduledir}freetile/jquery.freetile.js"></script>
<h1>
    数据中心: <strong>
        <a href="?cmd=module&module={$moduleid}&do=floors&colo_id={$rack.colo_id}">{$rack.coloname}</a></strong>
    &raquo; 楼层: <strong><a href="?cmd=module&module={$moduleid}&do=floor&floor_id={$rack.floor_id}">{$rack.floorname}</a> <em>{if $rack.room} 机房: {$rack.room}{/if}</em></strong>
    &raquo; 机柜: <strong><a href="?cmd=module&module={$moduleid}&do=rack&rack_id={$rack.id}">{$rack.name}</a> ({$rack.units} U)</strong> 
    &raquo; {$item.category_name} - {$item.name} {if $item.label}&raquo; {$item.label}{/if}  #{$item.id}
</h1>
<div id="page_view">
    {include file='ajax.edititem.tpl'}
</div>

