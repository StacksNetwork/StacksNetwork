<table id="list4"></table>


{literal}
    <script>
        var grid = jQuery("#list4");
        grid.jqGrid({
            datatype: "local",
            height: 'auto',
            editurl: 'clientArray',
            cellEdit: false,
            autowidth: true,
            colNames: ['', 'category', '类型', 'SN', '厂商'],
            colModel: [
                {name: 'id', index: 'id', hidden: true, editable: false},
                {name: 'category', index: 'category', width: 120},
                {name: 'name', index: 'name', width: 120},
                {name: 'sn', index: 'sn', width: 160},
                {name: 'Manufacturer', index: 'manufacturer', width: 150}
            ]
        });
        var mydata = {/literal}{$items}{literal};
        for (var i = 0; i <= mydata.length; i++)
            jQuery("#list4").jqGrid('addRowData', i + 1, mydata[i]);
    </script>
{/literal}

