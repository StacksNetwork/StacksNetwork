{if $do=='get_support_summary'}
{if $precheck=='1'}
    您尚未定义任何服务支持部门, 进入 服务与支持->工单部门 添加相关部门

 {elseif $precheck=='2'}

    还没有开启的服务工单
{else}

工单关闭 ({$summary.totals.closed}) 
{foreach from=$summary.closed item=su}
{$system_url}admin/?cmd=tickets&action=view&list=all&num={$su}
{/foreach}



工单响应 ({$summary.totals.replied})
{foreach from=$summary.replied item=su}
{$system_url}admin/?cmd=tickets&action=view&list=all&num={$su}
{/foreach}



未读工单 ({$summary.totals.unread})
{foreach from=$summary.unread item=su}
{$system_url}admin/?cmd=tickets&action=view&list=all&num={$su}
{/foreach}

{if $summary.totals.replied==0 && $summary.totals.closed==0 && $summary.totals.unread==0}
(没有应答/工单 从最后一次报告开始)
{/if}

{/if}

{elseif $do=='get_server_list'}

{foreach from=$servers item=server}
{$server.gname} - {$server.name} ({if $server.host}{$server.host}{else}{$server.ip}{/if})
{foreachelse}
没有定义应用程序, 需要新建请立请进入 设置->应用
{/foreach}
{/if}