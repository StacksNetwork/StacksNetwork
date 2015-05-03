<div id="helpcontainer"><a class="menuitm" href="#" onclick="return helptoggle()" ><span >显示帮助</span></a>

    <div class="blank_state_smaller blank_forms" style="display:none">
        <div class="blank_info">
            <h3>欢迎来到您的硬件仓库</h3>
            <span class="fs11">下面您可以找到您的库存物品分类列表. <br/> 
                需要得到某些类别的配件清单, 拓展它的使用 <span class="ui-icon ui-icon-triangle-1-e" style="display:inline-block"></span> <br/>
                进入 <a href="?cmd=inventory_manager&action=settings"><b>设置</b></a>, 安装测试数据.
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
        var grid = jQuery("#list2").jqGrid(GridTemplates.inventory.grid);
        grid.jqGrid.apply(grid, ['navGrid', '#pager2'].concat(GridTemplates.inventory.nav));
       setjGridHeight();
    });



    </script>{/literal}