<div class="ipam-left" >
    <form action="" method="post" id="ipamleftform">
        <div id="ipamsearch" class="ipam-search">
            <input type="text" value="{$searchterm}" name="stemp" autocomplete="off" /><button onclick="$(this).prev().val('').keypress(); return false"><img src="{$plugin_dir}/img/bimg.png" alt="clear" title="清除" /></button>
        </div>
        <div id="ipamsearch_filters" class="ipam-filters">
            <label>列表名称</label>	<input value="1" type="checkbox" name="name">
            <label>IP地址</label>	<input value="1" type="checkbox" name="ipaddress" checked="checked"><br>
            <label>标识</label>		<input value="1" type="checkbox" name="domains"><br>
            <label>反向DNS解析</label>		<input value="1" type="checkbox" name="revdns"><br>
            <label>说明</label>	<input value="1" type="checkbox" name="descripton"><br>
            <label>客户ID</label>	<input value="1" type="checkbox" name="client_id"><br>
            <label>最后一次更新</label>	<input value="1" type="checkbox" name="lastupdate"><br>
            <label>修改人</label>	<input value="1" type="checkbox" name="changedby"><br>
            <label>包含旗标</label>	<input value="1" type="checkbox" name="flag">
        </div>
        <div style="padding:10px 5px"><a onclick="addlist('server');return false;" id="ip_add" href="#" class="menuitm"><span class="addsth">添加新列表</span></a></div>
        <ul class="tree" id="treecont">
		{include file='ajax.servertree.tpl'}
        </ul>
    </form>
</div><!-- !LEFT -->
<div id="ipamright" class="ipam-right">
    {if $action=='details'}
        {include file='ajax.details.tpl'}
    {else}
        {include file='dashboard.tpl'}
    {/if}
    
</div>
<div class="clear"></div>


{if $searchterm}
{literal}<script>
    $(document).ready(function(){
        $('#ipamsearch input').eq(0).trigger('keypress');
    });</script>{/literal}
{/if}