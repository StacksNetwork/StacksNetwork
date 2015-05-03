<div id="helpcontainer"><a class="menuitm" href="#" onclick="return helptoggle()" ><span >显示帮助</span></a>

    <div class="blank_state_smaller blank_forms" style="display:none">
        <div class="blank_info">
            <h3>设备厂商</h3>
            <span class="fs11">厂商的分类, 有助于保障您硬件的保修与维护. 在下面输入最常见的厂商.<br/>
                - 增加新的交付时您会被要求选择库存配件的厂商
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
        var grid = jQuery("#list2").jqGrid(GridTemplates.producers.grid);
        grid.jqGrid.apply(grid, ['navGrid', '#pager2'].concat(GridTemplates.producers.nav));
        setjGridHeight();
    });



    </script>
{/literal}