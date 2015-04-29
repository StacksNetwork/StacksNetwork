{if $portlist}
    {if $portlist}
        {foreach from=$portlist item=p name=ports}
            {if $smarty.foreach.ports.index%4 ==0}{if !$smarty.foreach.ports.first}</div>{/if}<div class="port-group">{/if}
            <div class="connector {if $p.title}hastitle{/if}" {if $p.title}title="{$p.title}"{/if} onclick="getportdetails('{$p.id}')">
                {if $p.connected_to!='0'}
                    <div class="{if $p.type=="NIC"}hasconnection{else}haspower{/if}"></div>
                {/if}
                {if $p.port_status!='-1'}
                    <div class="port-status port-status-{$p.port_status}"></div>
                {/if}
                <div class="nth"><div>{$p.number}</div>
                </div>
            </div>
        {/foreach}
        </div>
    {/if}
{else}
<div class="form-group">
    <img src="{$moduledir}icons/network-ethernet.png" alt="" /> 
    <span>网络端口:</span> 
    <select name="conn[NIC][in]" onchange="setports($(this).val(), 'NIC', 'in')" class="w50">
        <option value="0" {if $ports.NIC.in.count=='0'}selected="selected"{/if}>0</option>
        {section name=foo loop=196}
            <option value="{$smarty.section.foo.iteration}" {if $smarty.section.foo.iteration==$ports.NIC.in.count}selected="selected"{/if}>{$smarty.section.foo.iteration}</option>
        {/section}
    </select>
</div>
    
<div class="crow clearfix">
    {if $ports.NIC.in.ports}
        {include file='ajax.connections.tpl' portlist=$ports.NIC.in.ports}
    {/if}
</div>

<div class="form-group">
    <img src="{$moduledir}icons/network-ethernet.png" alt="" /> 
    <span>已联通网络端口 <a class="vtip_description" title="仅提供交换机使用"></a>:</span> 
    <select name="conn[NIC][OUT]" onchange="setports($(this).val(), 'NIC', 'out')" class="w50">
        <option value="0" {if $ports.NIC.out.count=='0'}selected="selected"{/if}>0</option>
        {section name=foo loop=196}
            <option value="{$smarty.section.foo.iteration}" {if $smarty.section.foo.iteration==$ports.NIC.out.count}selected="selected"{/if}>{$smarty.section.foo.iteration}</option>
        {/section}
    </select>
</div>
<div class="crow clearfix">
    {if $ports.NIC.out.ports}
        {include file='ajax.connections.tpl' portlist=$ports.NIC.out.ports}
    {/if}
</div>

<div class="form-group">
    <img src="{$moduledir}icons/plug.png" alt="" /> 
    <span>已通电适配器:</span>
    <select name="conn[PDU][IN]"  onchange="setports($(this).val(), 'PDU', 'in')" class="w50">
        <option value="0" {if $ports.PDU.in.count=='0'}selected="selected"{/if}>0</option>
        {section name=foo loop=48}
            <option value="{$smarty.section.foo.iteration}" {if $smarty.section.foo.iteration==$ports.PDU.in.count}selected="selected"{/if}>{$smarty.section.foo.iteration}</option>
        {/section}
    </select>
</div>
<div class="crow clearfix">
    {if $ports.PDU.in.ports}
        {include file='ajax.connections.tpl' portlist=$ports.PDU.in.ports}
    {/if}
</div>

<div class="form-group">
    <img src="{$moduledir}icons/plug.png" alt="" /> 
    <span>未通电适配器 <a class="vtip_description" title="仅供PDU使用"></a>:</span>
    <select name="conn[PDU][OUT]" onchange="setports($(this).val(), 'PDU', 'out')" class="w50">
        <option value="0" {if $ports.PDU.out.count=='0'}selected="selected"{/if}>0</option>
        {section name=foo loop=48}
            <option value="{$smarty.section.foo.iteration}" {if $smarty.section.foo.iteration==$ports.PDU.out.count}selected="selected"{/if}>{$smarty.section.foo.iteration}</option>
        {/section}
    </select>
</div>
<div class="crow clearfix">
    {if $ports.PDU.out.ports}
        {include file='ajax.connections.tpl' portlist=$ports.PDU.out.ports}
    {/if}
</div>


<div class="fs11" style="line-height:25px;">
    <b>图例:</b>
    <ul class="port-legend">
        <li><div class="port-status port-status-1"></div> 该端口状态为UP/ON</li>
        <li><div class="port-status port-status-0"></div> 该端口状态为DOWN/OFF</li>
        <li><div class="hasconnection"></div> 该端口已通信</li>
        <li><div class="haspower"></div> 电源适配器已通电</li>
    </ul>
    {* not implemented?}<img src="{$moduledir}icons/chart.png" /> <span class="orspace">该端口分配了流量图</span>{*}
</div>

{/if}