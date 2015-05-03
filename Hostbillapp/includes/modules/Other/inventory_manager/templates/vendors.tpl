<div id="helpcontainer"><a class="menuitm" href="#" onclick="return helptoggle()" ><span >显示帮助</span></a>

    <div class="blank_state_smaller blank_forms" style="display:none">
        <div class="blank_info">
            <h3>设备供应商</h3>
            <span class="fs11">
                提供您的硬件供应商名单(厂商), 增加新的采购时您会被要求选择库存配件的供应商
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
        var grid = jQuery("#list2").jqGrid(GridTemplates.vendors.grid);
        grid.jqGrid.apply(grid, ['navGrid', '#pager2'].concat(GridTemplates.vendors.nav));
        setjGridHeight();
    });
    </script>
{/literal}