<div class="ipam-left" >
    <form action="" method="post" id="vlanleftform">
        <input type="hidden" value="vlan" name="action" />
        <div id="vlansearch" class="ipam-search">
            <input type="text" value="{$searchterm}" name="stemp" autocomplete="off" />{*}
            {*}<button onclick="$(this).prev().val('').keypress(); return false"><img src="{$plugin_dir}/img/bimg.png" alt="clear" title="Clear" /></button>
        </div>
        <div id="vlanearch_filters" class="ipam-filters">
            <label>List name</label>	<input value="1" type="checkbox" name="name">
            <label>VLAN name</label>	<input value="1" type="checkbox" name="vname" checked="checked">
            <label>Description</label>	<input value="1" type="checkbox" name="descripton"><br>
            <label>Last Update</label>	<input value="1" type="checkbox" name="lastupdate"><br>
            <label>Changed by</label>	<input value="1" type="checkbox" name="changedby"><br>
        </div>
        <div style="padding:10px 5px">
            <a onclick="addlist();return false;" id="ip_add" href="#" class="menuitm">
                <span class="addsth">添加VLAN群组</span>
            </a>
        </div>
        <ul class="tree" id="vlantreecont">
            {include file='ajax.servertree.tpl'}
        </ul>
    </form>
</div><!-- !LEFT -->
<div id="vlanright" class="ipam-right">
    {if $action=='vlan_details'}
        {include file='ajax.vlan_details.tpl'}
        {literal}
            <script type="text/javascript">
                $(function(){
                    console.log('bind2')
                    var gotovlanpage = false
                    var h = $(document).ajaxStop(function() {
                        if (!gotovlanpage) {
                            gotovlanpage = true;
                            $('#bodycont > .blu').eq(1).click()
                        }
                    });
                })
            </script>
        {/literal}
    {else}
        {include file='vlan_dashboard.tpl'}
    {/if}
</div>
<div class="clear"></div>

{if $searchterm}
{literal}
    <script>
    $(document).ready(function(){
        $('#ipamsearch input').eq(0).trigger('keypress');
    });</script>
{/literal}
{/if}