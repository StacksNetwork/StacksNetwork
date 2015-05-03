{if $finished}
    <div id="helpcontainer"><a class="menuitm" href="#" onclick="return helptoggle()" ><span >显示帮助</span></a> 

        <div class="blank_state_smaller blank_forms" style="display:none">
            <div class="blank_info">
                <h3>完成设备的调试</h3>
                <span class="fs11">一旦设备标记为已采购 <b>可组合的产品</b> 会出现在这里. 
                    您可以拆分组装 (这将再次标记的所有配件 "已安装于设备"), 或从特定的设备内删除某些配件<br/><br/>

                </span>
                </span>
                <div class="clear"></div><br/>

                <a class="menuitm" href="#" onclick="return helptoggle()" ><span >隐藏帮助</span></a>
                <div class="clear"></div>

            </div>
        </div>
    </div>

{else}
    <div id="helpcontainer"><a class="menuitm" href="#" onclick="return helptoggle()" ><span >显示帮助</span></a> 
        <a class="menuitm" href="#" style="margin-left: 30px;font-weight:bold;" onclick="return showFacebox('?cmd=inventory_manager&action=newbuild')"><span class="addsth">调试新的设备</span></a>

        <div class="blank_state_smaller blank_forms" style="display:none">
            <div class="blank_info">
                <h3>待售的组装设备</h3>
                <span class="fs11">客户购买设备之后 <b>库存管理配置</b> 引用帐户创建 
                    (付款后手动或自动修改账户信息部分, 根据产品配置), 库存管理将准备设备的组装配件:<br/>
                    - 它将为建立储备所需的所有配件, 并在这里给出列表<br/><br/>
                    点击图标编辑/批准设备的组装/管理自己的配件. 您也可以查看通过扩展建立的行新建所需配件
                </span>
                </span>
                <div class="clear"></div><br/>

                <a class="menuitm" href="#" onclick="return helptoggle()" ><span >隐藏帮助</span></a>
                <div class="clear"></div>

            </div>
        </div>
    </div>


{/if}


<table id="list2"></table>
<div id="pager2"></div>




{literal}
    <script>
        GridTemplates.builds.grid.colModel = [
{/literal}{if !$finished}{literal}{name: 'myac', width:10, sortable:false, search:false, resize:false}, {/literal}{/if}{literal}
        {name:'id', index:'id', width:55},
        {name:'date', index:'date', width:100},
        {name:'product', index:'product'},
        {name:'account_link', index:'account_link', width:120, search:false},
        {name:'client_link', index:'client_link', width:120, search:false},
{/literal}{if $finished}{literal}
{name:'buildby', index:'buildby', width:120},{/literal}{/if}{literal}
        ]; ;
        GridTemplates.builds.grid.colNames = [
{/literal}{if !$finished}'',{/if}{literal}
                '调试ID', '添加日期', '产品名称', '相关账户', '相关客户'
{/literal}{if $finished}, '组装人员'{/if}{literal}
        ]; ;

        $(document).ready(function() {
            var grid = jQuery("#list2").jqGrid(GridTemplates.builds.grid);
            grid.jqGrid.apply(grid, ['navGrid', '#pager2'].concat(GridTemplates.builds.nav));
            setjGridHeight();
        });



</script>{/literal}


