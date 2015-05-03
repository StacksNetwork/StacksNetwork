<div id="helpcontainer"><a class="menuitm" href="#" onclick="return helptoggle()" ><span >导入测试数据</span></a>

    <div class="blank_state_smaller blank_forms" style="display:none">
        <div class="blank_info">
            <h3>导入测试数据</h3>
            <span >要迅速熟悉您的新的库存管理系统, 我们建议开始安装演示数据.<br/>
                <strong style="color:red">警告: 安装演示数据将删除所有当前的库存管理内容</strong><br/>
                如果您想继续, 请输入: <b>"我希望安装测试数据"</b> 在下面的输入框中, 然后点击 "继续"</span>
            <div class="clear"></div><br/>

            <form action="" method="post" id="demoform">
                <input name="make" value="1" type="hidden"/>
                确认: <input name="confirmation" value="" style="width:300px" />
                <a class="menuitm greenbtn" href="#" onclick="$('#demoform').submit();
        return false;" ><span >导入测试数据</span></a>
                <a class="menuitm" href="#" onclick="return helptoggle()" ><span >隐藏帮助</span></a>
                {securitytoken}
            </form>
            <div class="clear"></div>

        </div>
    </div>
</div>

<table id="list2"></table>
<div id="pager2"></div>


{literal}<script>
    $(document).ready(function() {
        var grid = jQuery("#list2").jqGrid(GridTemplates.settings.grid);
        grid.jqGrid.apply(grid, ['navGrid', '#pager2'].concat(GridTemplates.settings.nav));
        setjGridHeight();
    });
    </script>
{/literal}