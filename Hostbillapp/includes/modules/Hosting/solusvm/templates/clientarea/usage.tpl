{include file="`$onappdir`header.cloud.tpl"}
<div class="header-bar">
    <h3 class="cpuusage hasicon">{$lang.Usage}</h3>
    <form action="" method="post" id="uform">
        <ul class="sub-ul">
            {counter print=false name=show start=0 assign=showg}
            {if $VMDetails.trafficgraph }<li><a href="#" {if $showg == 0}{counter name=show}class="active"{/if} onclick="$('#s_graph div').hide();$('#trafic_graph').show();return false;">{$lang.networkusage}</a></li>{/if}
            {if $VMDetails.loadgraph }<li><a href="#" {if $showg == 0}{counter name=show}class="active"{/if} onclick="$('#s_graph div').hide();$('#load_graph').show();return false;">{$lang.cpuusage}</a></li>{/if}
            {if $VMDetails.memorygraph }<li><a href="#" {if $showg == 0}{counter name=show}class="active"{/if} onclick="$('#s_graph div').hide();$('#memory_graph').show();return false">{$lang.memory} {$lang.Usage}</a></li>{/if}
            {if $showg == 0}<li><a hrref="#">No usage data available</a></li>{/if}
        </ul>
        <div class="clear"></div>
</div>
<div class="content-bar" style="background:#f3f3f3">
    <div style="margin:0px auto;">
        <div id="s_graph">
            {counter print=false name=show start=0 assign=showg}
            {if $VMDetails.trafficgraph }
                <div id="trafic_graph" {if $showg != 0}style="display:none"{/if}{counter name=show}>
                    <h4>{$lang.networkusage}</h4>
                    <center><img src="?cmd=module&module={$moduleid}&action=usage&vpsid={$vpsid}&type=trafficgraph&id={$service.id}" alt="" /></center>
                </div>
            {/if}
            {if $VMDetails.loadgraph }
                <div id="load_graph" {if $showg != 0}style="display:none"{/if}{counter name=show}>
                    <h4>{$lang.cpuusage}</h4>
                    <center><img src="?cmd=module&module={$moduleid}&action=usage&vpsid={$vpsid}&type=loadgraph&id={$service.id}" alt="" /></center>
                </div>
            {/if}
            {if $VMDetails.memorygraph }
                <div id="memory_graph" {if $showg != 0}style="display:none"{/if}{counter name=show}>
                    <h4>{$lang.memory} {$lang.Usage}</h4>
                    <center><img src="?cmd=module&module={$moduleid}&action=usage&vpsid={$vpsid}&type=memorygraph&id={$service.id}" alt="" /></center>
                </div>
            {/if}
            {if $showg == 0}<div><h4>No usage data available</h4></div>{/if}
            <br />
        </div>
    </div>

</div>
{include file="`$onappdir`footer.cloud.tpl"}