<h3 class="left">添加新配件到该设备</h3>
<a onclick="$('#porteditor').show();
        return false;" class=" menuitm right greenbtn" href="#"><span><b>添加新配件</b></span></a>

<div class="clear"></div>

<div style="min-height:400px">

    <table id="list4"></table>

</div>

<div id="porteditor">
    <h3 style="margin-bottom:10px;" class="left">
        选择添加的分类/类型/配件:
    </h3>

    <a onclick="$('#porteditor').hide();
        return false;" class=" menuitm right" href="#"><span><b>关闭</b></span></a>
    <div class="clear"></div>

    <label class="nodescr">配件分类</label>
    <select class="w250" name="p_ictype" id="p_ictype" onchange="loadIhtypes($(this).val());">
        <option value="0">---选择分类---</option>
        {foreach from=$categories item=m key=l}
            <option value="{$l}">{$m}</option>
        {/foreach}
    </select>
    <div class="clear"></div>

    <div id="ihtype_container" style="display:none"></div>

    <div id="ientity_container" style="display:none"></div>

    <a onclick="addItem();
        return false;" class=" menuitm right greenbtn" href="#"><span><b>添加配件</b></span></a>
    <div class="clear"></div>
</div>


<input type="hidden" name="tabledata" value="" id="tabledata" />
{literal}
    <script>
    var category_id = {/literal}{$product.id}{literal};
    $('#porteditor').insertAfter($('.tabb:last'));
    function loadIhtypes(id) {
        if (id == "0") {
            $('#ihtype_container').hide().html('');
        } else {
            $('#ihtype_container').html('').show();
            ajax_update('?cmd=inventory_manager&action=loadihtypes&firstblank=true&ictype_id=' + id, {}, '#ihtype_container');
        }
    }
    function ihtype_change(val) {
        if (val == '0') {
            $('#ientity_container').hide().html('');
            return;
        } else {
            $('#ientity_container').html('').show();
            ajax_update('?cmd=inventory_manager&action=loadentities&ihtype_id=' + val, {}, '#ientity_container');
        }
    }

    function onFaceboxSubmit() {
        var data = JSON.stringify(jQuery("#list4").jqGrid('getGridParam', 'data'));
        $('#tabledata').val(data);
        return true;
    }

    function addItem() {
        if (!$('#p_ientity').val()) {
            return false;
        }
        var v_sn, v_producer, b = $('#p_ientity option').eq($('#p_ientity')[0].selectedIndex).text().split(" ");
        v_sn = b[1].replace("SN:", "");
        v_producer = b[2].replace("BY:", "");
        var struct = {
            id: $('#p_ientity').val(),
            price: $('#p_price').val(),
            sn: v_sn,
            name: $('#p_ihtype option').eq($('#p_ihtype')[0].selectedIndex).text(),
            manufacturer: v_producer,
            category: $('#p_ictype option').eq($('#p_ictype')[0].selectedIndex).text()
        };
        $('#porteditor').hide();
        jQuery("#list4").jqGrid('addRowData', struct.id, struct);
        $('#porteditor').hide();
    }


    var grid = jQuery("#list4");

    myDelOptions = {
        onclickSubmit: function(rp_ge, rowid) {

            grid.delRowData(rowid);
            grid_id = grid[0].id,
                    $.jgrid.hideModal("#delmod" + grid_id,
                    {gb: "#gbox_" + grid_id});



            return true;
        },
        processing: true
    };



    jQuery("#list4").jqGrid({
        datatype: "local",
        height: '100%',
        editurl: 'clientArray',
        cellEdit: true,
        cellsubmit: 'clientArray',
        autowidth: true,
        colNames: ['', '', '分类', '名称', 'SN', '厂商'],
        colModel: [
            {name: 'myac', width: 80, fixed: true, sortable: false, resize: false, formatter: 'actions',
                formatoptions: {edit: false, keys: false, delOptions: myDelOptions, editbutton: false}},
            {name: 'id', index: 'id', hidden: true, editable: false},
            {name: 'category', index: 'category', width: 120},
            {name: 'name', index: 'name', width: 120},
            {name: 'sn', index: 'sn', width: 160},
            {name: 'manufacturer', index: 'manufacturer', width: 150}
        ]
    });

    </script>
{/literal}

