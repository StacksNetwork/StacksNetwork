<link type="text/css" rel="stylesheet" href="{$moduleurl}pm_styles.css" />
<div id="newshelfnav" class="newhorizontalnav">
    <div class="list-1">
        <ul>
            <li class="{if $action == 'default'}active{/if}">
                <a {if $action != 'default'} href="?cmd={$modulename}"{/if}><span>列表</span></a>
            </li>
            <li class="{if $action == 'log'}active{/if}">
                <a {if $action != 'log'}href="?cmd={$modulename}&action=log"{/if}><span>审核日志</span></a>
            </li>
            {if $action == 'edit'}
                <li class="active last">
                    <a href="#"><span>{$entry.label|truncate}</span></a>
                </li>
            {else}
                <li class="{if $action == 'add'}active last{/if}">
                    <a {if $action != 'add'}href="?cmd={$modulename}&action=add"{/if}><span>新的条目</span></a>
                </li>
            {/if}
        </ul>
    </div>
</div>
<form action="" method="post" id="testform" >
    <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
    <div style="padding: 5px;">
        <div class="right">
            <div class="pagination"></div>
        </div>
        <div class="clear"></div>
    </div>
    <a href="?cmd={$modulename}&action=log" id="currentlist" style="display:none" updater="#updater"></a>
    <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
        <tbody>
            <tr>
                <th width="15%"><a href="?cmd={$modulename}&action=log&orderby=date|ASC"  class="sortorder">{$lang.Date}</a></th>
                <th >{$lang.Description}</th>
                <th width="10%"><a href="?cmd={$modulename}&action=log&orderby=admin|ASC"  class="sortorder">{$lang.Username}</a></th>
            </tr>
        </tbody>
        <tbody id="updater">
            {include file='ajax.logs.tpl'}
        </tbody>
        <tbody id="psummary">
            <tr>
                <th colspan="3">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                </th>
            </tr>
        </tbody>
    </table>
    <div class="blu">
        <div class="right">
            <div class="pagination"></div>
        </div>
        <div class="clear"></div>
    </div>
    {securitytoken}
</form>
