<h1>数据流量图</h1> 

{if $ports == 0}
没有关于该服务器的可用数据流量图信息.
{else}

<h2>本月</h2>

{foreach from=$currentGraphs item=graph}
<p>
<img width="497" height="249" alt="本月" src="{$graph}" />
</p>
{/foreach}

{if $lastMonthGraphs|@count}
<h2>上个月</h2>

{foreach from=$lastMonthGraphs item=graph}
<p>
<img width="497" height="249" alt="上个月" src="{$graph}" />
</p>
{/foreach}
{/if}

{/if}