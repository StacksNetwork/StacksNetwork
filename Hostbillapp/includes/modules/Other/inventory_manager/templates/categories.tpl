<div id="helpcontainer"><a class="menuitm" href="#" onclick="return helptoggle()" ><span >显示帮助</span></a>

    <div class="blank_state_smaller blank_forms" style="display:none">
        <div class="blank_info">
            <h3>库存配件分类和类别内容</h3>
            <span class="fs11">在您的库存中每一个配件必须分配到两个组: <br/>
                - 配件分类 - 类似 CPUs, HDDs, 内存, 配线架等.<br/>
                - 配件类别 - 对配件分类的补充, 配件类别是给予配件参数 - 如 1GB内存, Intel XEON7 CPU等.
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
        var grid = jQuery("#list2").jqGrid(GridTemplates.categories.grid);
        grid.jqGrid.apply(grid, ['navGrid', '#pager2'].concat(GridTemplates.categories.nav));
        setjGridHeight();
    });



    </script>{/literal}