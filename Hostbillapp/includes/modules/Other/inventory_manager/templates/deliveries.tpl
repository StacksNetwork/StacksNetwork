<div id="helpcontainer"><a class="menuitm" href="#" onclick="return helptoggle()" ><span >显示帮助</span></a>
    <a class="menuitm" href="#" style="margin-left: 30px;font-weight:bold;" onclick="return showFacebox('?cmd=inventory_manager&action=newdelivery')"><span class="addsth">添加新的采购清单</span></a>
    <div class="blank_state_smaller blank_forms" style="display:none">
        <div class="blank_info">
            <h3>想要上架新的产品? 请需要先使用采购功能</h3>
            <span class="fs11">下面您可以找到您采购的硬件/软件清单. 添加新配件添加新的采购内容. <br/> 
                采购用于数据中心的物品 <span class="ui-icon ui-icon-triangle-1-e" style="display:inline-block"></span>
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
        var grid = jQuery("#list2").jqGrid(GridTemplates.deliveries.grid);
        grid.jqGrid.apply(grid, ['navGrid', '#pager2'].concat(GridTemplates.deliveries.nav));
        setjGridHeight();
    });



    </script>{/literal}