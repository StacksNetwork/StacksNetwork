<div id="helpcontainer"><a class="menuitm" href="#" onclick="return helptoggle()" ><span >显示帮助</span></a> 
    <a class="menuitm" href="#" style="margin-left: 30px;font-weight:bold;" onclick="return showFacebox('?cmd=inventory_manager&action=newproduct')"><span class="addsth">添加新的设备配置方案</span></a>

    <div class="blank_state_smaller blank_forms" style="display:none">
        <div class="blank_info">
            <h3>新建设备调试方案</h3>
            <span class="fs11">根据您的设备调试方案调试您的设备. <br/> 新建设备所分配硬件配件类型.
                <br/>一旦您定义好了产品, 您可以把它添加到 设置->产品与服务. 通过使用 <b>库存管理配置</b> 模块 - 这种方法可以自动配置配件. <br/>
                <br/>
                <h3>如何配置使用</h3>
                一旦您配置了您的产品, 连接到您的系统产品配置模块, 您就准备好了的自动配置配件设置.<br/>
                当您的客户购买相关的套餐, 会创建新的账户(在付款后自动或手动, 这取决于设置), 系统将以下面定义的规范从您的硬件产品库存中选择闲置的配件.
            </span>
            </span>
            <div class="clear"></div><br/>

            <a class="menuitm" href="#" onclick="return helptoggle()" ><span >隐藏帮助</span></a>
            <div class="clear"></div>

        </div>
    </div>
</div>

<table id="list2"></table>
<div id="pager2"></div>


{literal}<script>
    $(document).ready(function() {
        var grid = jQuery("#list2").jqGrid(GridTemplates.deployments.grid);
        grid.jqGrid.apply(grid, ['navGrid', '#pager2'].concat(GridTemplates.deployments.nav));
        setjGridHeight();
    });



    </script>{/literal}