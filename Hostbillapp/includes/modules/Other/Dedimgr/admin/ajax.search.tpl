{if $results}


{if $results.Items}
	<li class="choices-header choices-Items">机柜物品</li>
	{foreach from=$results.Items item=r}
		<li class="result"><a href="?cmd=module&module=dedimgr&do=rack&rack_id={$r.rack_id}&expand={$r.id}">{$r.typename} - {$r.label}
                        <span class="second">数据中心: {$r.coloname}, 楼层: {$r.floorname}, 机架: {$r.rackname}</span></a>
		</li>
	{/foreach}
{/if}

{if $results.Racks}
<li class="choices-header choices-Box">机架</li>
	{foreach from=$results.Racks item=r}
		<li class="result"><a href="?cmd=module&module=dedimgr&do=rack&rack_id={$r.id}">{$r.name} ({$r.units})
                        <span class="second">数据中心: {$r.coloname}, 楼层: {$r.floorname}</span></a>
		</li>
	{/foreach}
{/if}

{if $results.Ports}
<li class="choices-header choices-Items">设备端口</li>
	{foreach from=$results.Ports item=r}
		<li class="result"><a href="?cmd=module&module=dedimgr&do=rack&rack_id={$r.rack_id}&expand={$r.id}">{$r.typename} - {$r.label}, 端口: {$r.number}
                        <span class="second">数据中心: {$r.coloname}, 楼层: {$r.floorname}, 机架: {$r.rackname}</span></a>
		</li>
	{/foreach}
{/if}
{else}

<li class="choices-header choices-List2"><em>未找到任何物品</em></li>
{/if}