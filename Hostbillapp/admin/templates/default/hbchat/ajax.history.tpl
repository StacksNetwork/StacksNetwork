{if $action == 'clienthistory'}
    <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
        <tbody>
            <tr>
                <th width="60">聊天ID</th>
                <th  width="160">{$lang.Date}</th>
                <th width="160">用户名</th>
                <th>Subject</th>
            </tr>
        </tbody>
        <tbody >
            {foreach from=$transcripts item=trans}
                <tr>
                    <td><a href="?cmd=hbchat&action=viewtranscript&id={$trans.id}" ># {$trans.id}</a></td>
                    <td>{$trans.date_start|dateformat:$date_format}</td>
                    <td>{if $trans.visitor_name}{$trans.visitor_name}{else}<em>无名称</em>{/if}</td>
                    <td><a href="?cmd=hbchat&action=viewtranscript&id={$trans.id}">{if $trans.subject}{$trans.subject}{else}<em>无主题</em>{/if}</a></td>
                </tr>
            {foreachelse}
                <tr>
                    <td colspan="4">{$lang.nothingtodisplay}</td>
                </tr>
            {/foreach}
        </tbody>
    </table> 
    {if $totalpages}
        <center class="blu"><strong>{$lang.Page} </strong>
            {section name=foo loop=$totalpages}
                {if $smarty.section.foo.iteration-1==$currentpage}<strong>{$smarty.section.foo.iteration}</strong>
                {else}
                    <a href='?cmd=invoices&action=clientinvoices&id={$client_id}&page={$smarty.section.foo.iteration-1}&currentlist={$currentlist}' class="npaginer">{$smarty.section.foo.iteration}</a>
                {/if}
            {/section}
        </center>
        <script type="text/javascript">
            {literal}
                $('a.npaginer').click(function() {
                    ajax_update($(this).attr('href'), {}, 'div.slide:visible');
                    return false;
                });
            {/literal}
        </script>
    {/if}
{else}
    {if $transcripts}
        {foreach from=$transcripts item=trans}
            <tr>
                <td><a href="?cmd=hbchat&action=viewtranscript&id={$trans.id}" ># {$trans.id}</a></td>
                <td>{$trans.date_start|dateformat:$date_format}</td>
                <td>{if $trans.visitor_name}{$trans.visitor_name}{else}<em>无名称</em>{/if}</td>
                <td><a href="?cmd=hbchat&action=viewtranscript&id={$trans.id}">{if $trans.subject}{$trans.subject}{else}<em>无主题</em>{/if}</a></td>
                <td></td>
                <td><a href="?cmd=hbchat&make=delete&action=history&id={$trans.id}&security_token={$security_token}" onclick="return confirm('Are you sure you wish to remove this transcript?');" class="delbtn">删除</a></td>
            </tr>
        {/foreach}
    {else}
        <tr>
            <td colspan="6"><p align="center" >未发现转账信息</p></td>
        </tr>
    {/if}
{/if}