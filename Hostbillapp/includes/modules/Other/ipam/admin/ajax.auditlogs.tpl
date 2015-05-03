{if !$hideth}
<div class="ipam-right" id="logsright">
    <div class="right">
        <div class="pagination right" ></div>
        <a class="left fs11 menuitm menu" style="padding: 1px 4px; margin-right: 5px;" onclick="return refreshipamlogs(); return false;" href="#">刷新</a>
    </div>
    <div class="clear"></div>
    <input type="hidden" value="{$totalpages}" name="totalpages2" id="logstotalpages"/>	
    <table width="100%" cellspacing="0" cellpadding="0" class="clear" style="margin-top:10px">
        <tbody>
            <tr>
                <th width="140">日期</th>
                    {*}<th width="200">内容</th>{*}
                <th>更改</th>
                <th width="120">By</th>
            </tr>
        </tbody>
        
        
        <tbody id="logsupdater">
            {/if}
            <a href="?cmd=module&module={$moduleid}&action=logs&refresh=1" id="logscurrentlist"></a>
            {foreach from=$logs item=log}
                <tr>
                    <td>{$log.date}</td>
                    {*}<td>{if $log.item_name}{$log.item_name}{else}{$log.item_id}{/if}</td>{*}
                    <td>{$log.log}</td>
                    <td>{$log.changedby}</td>
                </tr>
            {/foreach}
            {if !$hideth}
        </tbody>
    </table>
    <span style="margin-left: 5px">
    {$lang.showing} <span id="logssorterlow">{$sorterlow}</span> - <span id="logssorterhigh">{$sorterhigh}</span> {$lang.of} <span id="logssorterrecords">{$sorterrecords}</span>
    </span>
</div>
{/if}