<b>库存分类: {$category.name}</b> <a href="?cmd=inventory_manager">返回控制台</a>


<table id="list2"></table>
<div id="pager2"></div>
<script>
    var category_id = '{$category.id}';
    GridTemplates.inventorylist.grid.url += category_id;
    GridTemplates.inventorylist.grid.editurl += category_id;
    {literal}
        $(document).ready(function() {
            var grid = jQuery("#list2").jqGrid(GridTemplates.inventorylist.grid);
            grid.jqGrid.apply(grid, ['navGrid', '#pager2'].concat(GridTemplates.inventorylist.nav));
            setjGridHeight();
        });
    </script>
{/literal}