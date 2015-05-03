<div id="newshelfnav" class="newhorizontalnav">
    <div class="list-1">
        <ul>
            <li class="{if $action == 'default'}active{/if}">
                <a {if $action != 'default'} href="?cmd=status"{/if}><span>网络维护</span></a>
            </li>
            <li class="{if $action == 'add'}active{/if} last">
                <a {if $action != 'add'}href="?cmd=status&action=add"{/if}><span>新的维护工作</span></a>
            </li>
        </ul>
    </div>
    <div class="list-2">
        <div class="subm1 haveitems" style="display: block; height: 20px;">
        </div>
    </div>
</div>
{if $statuses}

    <a id="currentlist" updater="#updater" style="display:none" href="?cmd=status"></a>
    <table width="100%" cellspacing=0 cellpadding="6px" class="glike hover">
        <tr>
            <th><a href="?cmd=status&orderby=date|ASC" class="sortorder">日期</a></th>
            <th><a href="?cmd=status&orderby=name|ASC" class="sortorder">主题</a></th>
            <th><a href="?cmd=status&orderby=status|ASC" class="sortorder">目前状况</a></th>
            <th>相关服务</th>
            <th><a href="?cmd=status&orderby=author|ASC" class="sortorder">添加人</a></th>
            <th style="width: 5%"></th>
        </tr>
        <tbody id="updater">
            {include file="ajax.default.tpl"}
        </tbody>
        <tr>
            <th colspan="6"><small>{$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span></small></th>
        </tr>
    </table>
    <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
    <div class="blu">
        <div class="right">
            <div class="pagination"></div>
        </div>
        <div class="clear"></div>
    </div>
    <div class="clear"></div>
{else}
    <div class="blank_state blank_kb">
        <div class="blank_info">
            <h1>维护内容更新</h1>
            您可以在这里添加新的维护内容与维护状况更新.
            <div class="clear"></div>
            <a style="margin-top:10px" href="?cmd=status&action=add" class="new_add new_menu">
                <span>添加新的维护情况</span></a>
            <div class="clear"></div>
        </div>
    </div>
{/if}