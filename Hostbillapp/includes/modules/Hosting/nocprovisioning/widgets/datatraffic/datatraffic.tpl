<div class="wbox"><div class="wbox_header">数据流量图</div><div class="wbox_content">


{if $ports == 0}
没有数据流量信息可用于这台服务器.
{else}

<h2>本月</h2>

{foreach from=$currentGraphs item=graph}
<p>
<img width="497" height="249" alt="本月" src="{$graph}" />
</p>
{/foreach}

{if $lastMonthGraphs|@count}
<h2>上月</h2>

{foreach from=$lastMonthGraphs item=graph}
<p>
<img width="497" height="249" alt="上月" src="{$graph}" />
</p>
{/foreach}
{/if}

{/if}

</div></div>