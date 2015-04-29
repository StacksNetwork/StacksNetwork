{if !$ajax}
    <form action="" method="post" id="testform" >
        <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
        <div class="blu">
            <div class="right">
                <div class="pagination"></div>
            </div>
            <div class="clear"></div>
        </div>
        <a href="?cmd=module&module={$moduleid}&do=viewlogs" id="currentlist" style="display:none" updater="#updater"></a>
        <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike hover" style="">
            <thead>
                <tr>
                    <th width="20%"><a href="?cmd=module&module={$moduleid}&do=viewlogs&orderby=when|ASC" class="sortorder">日期</a></th>
                    <th width="60%"><a href="?cmd=module&module={$moduleid}&do=viewlogs&orderby=what|ASC" class="sortorder">描述</a></th>
                    <th width="20%"><a href="?cmd=module&module={$moduleid}&do=viewlogs&orderby=who|ASC" class="sortorder">用户名</a></th>
                </tr>
            </thead>
            <tbody id="updater">
            {/if}
            {if $logs}
                {foreach from=$logs item=log}
                    <tr>
                        <td>{$log.when|dateformat:$date_format}</td>
                        <td>
                            {if $log.rel && $log.rel_id}
                                <a href="?cmd=module&module={$moduleid}
                                   {if $log.rel == 1}&do=floors&colo_id={$log.rel_id}
                                   {elseif $log.rel == 2}&do=floors&floor_id={$log.rel_id}
                                   {elseif $log.rel == 3}&do=rack&rack_id={$log.rel_id}
                                   {elseif $log.rel == 4}&do=itemeditor&item_id={$log.rel_id}
                                   {elseif $log.rel == 5}&do=vendors#v{$log.rel_id}
                                   {elseif $log.rel == 6}&do=inventory&subdo=category&category_id={$log.rel_id}
                                   {elseif $log.rel == 7}&do=inventory&subdo=item&item_id={$log.rel_id}
                                {elseif $log.rel == 8}&do=inventory&subdo=fieldtypes#f{$log.rel_id}{/if}" target="_blank">{$log.what|escape}</a>
                        {else}
                            {$log.what|escape}
                        {/if}
                    </td>
                    <td>{$log.who|capitalize}</td>
                </tr>
            {/foreach}
        {else}
            <tr>
                <td colspan="3">尚无任何日志.</td>
            </tr>
        {/if}
        {if !$ajax}
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
{/if}