{include file="`$onappdir`header.cloud.tpl"}
<div class="header-bar">
    <h3 class="cpuusage hasicon">{$lang.Usage}</h3>
    <form action="" method="post" id="uform">
    <div class="sub-ul">
        <select name="cf" onchange="{literal}$('#uform').submit();{/literal}">
            <option value="hour:AVERAGE" {if $cf=='hour:AVERAGE'}selected="selected"{/if}>Hour (average)</option>
            <option value="hour:MAX" {if $cf=='hour:MAX'}selected="selected"{/if}>Hour (max)</option>
            <option value="day:AVERAGE"  {if $cf=='day:AVERAGE'}selected="selected"{/if}>Day (average)</option>
            <option value="day:MAX"  {if $cf=='day:MAX'}selected="selected"{/if}>Day (max)</option>
            <option value="week:AVERAGE"  {if $cf=='week:AVERAGE'}selected="selected"{/if}>Week (average)</option>
            <option value="week:MAX"  {if $cf=='week:MAX'}selected="selected"{/if}>Week (max)</option>
            <option value="day:AVERAGE"  {if $cf=='day:AVERAGE'}selected="selected"{/if}>Month (average)</option>
            <option value="month:MAX"  {if $cf=='month:MAX'}selected="selected"{/if}>Month (max)</option>
            <option value="day:AVERAGE" {if $cf=='day:AVERAGE'}selected="selected"{/if}>Year (average)</option>
            <option value="year:MAX"  {if $cf=='year:MAX'}selected="selected"{/if}>Year (max)</option>
        </select>
    </div></form>
    <div class="clear"></div>
</div>
<div class="content-bar" style="background:#f3f3f3">
    <div style="margin:0px auto;">
        <div style="width:800px">
            <h4>CPU usage %</h4>
            <img src="?cmd=module&module={$proxmoxid}&action=usage&cf={$cf}&vpsid={$vpsid}&type=cpu&id={$service.id}" alt="" />
            <h4>Memory usage</h4>
            <img src="?cmd=module&module={$proxmoxid}&action=usage&cf={$cf}&vpsid={$vpsid}&type=mem,maxmem&id={$service.id}" alt="" />
            <h4>Network traffic</h4>
            <img src="?cmd=module&module={$proxmoxid}&action=usage&cf={$cf}&vpsid={$vpsid}&type=netin,netout&id={$service.id}" alt="" />
            <h4>Disk IO</h4>
            <img src="?cmd=module&module={$proxmoxid}&action=usage&cf={$cf}&vpsid={$vpsid}&type=diskread,diskwrite&id={$service.id}" alt="" />
        </div></div>

</div>
{include file="`$onappdir`footer.cloud.tpl"}