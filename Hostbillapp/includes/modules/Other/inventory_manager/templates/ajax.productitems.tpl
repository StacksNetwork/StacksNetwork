<h3 class="left">库存物品/配件:</h3>
<a onclick="$('#porteditor').show();
        return false;" class=" menuitm right greenbtn" href="#"><span><b>添加配件</b></span></a>
<div class="clear"></div>
<div style="min-height:400px">

    <table id="list4"></table>

</div>
<div id="porteditor">
    <h3 style="margin-bottom:10px;" class="left">
        一次添加多个配件:
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

    <div id="ihtype_container" style="display:none">
    </div>

    <a onclick="addItem();
        return false;" class=" menuitm right greenbtn" href="#"><span><b>添加配件</b></span></a>
    <div class="clear"></div>
</div>
<input type="hidden" name="tabledata" value="" id="tabledata" />
{literal}
    <script>
    $('#porteditor').insertAfter($('.tabb:last'));
    function loadIhtypes(id) {
        if (id == "0") {
            $('#ihtype_container').hide().html('');
        } else {
            $('#ihtype_container').html('').show();
            ajax_update('?cmd=inventory_manager&action=loadihtypes&ictype_id=' + id, {}, '#ihtype_container');
        }
    }

    function onFaceboxSubmit() {
        var data = JSON.stringify(jQuery("#list4").jqGrid('getGridParam', 'data'));
        $('#tabledata').val(data);
        return true;
    }

    function addItem() {
        if (!$('#p_ihtype').val()) {
            return false;
        }
        var name = $('#p_ihtype option').eq($('#p_ihtype')[0].selectedIndex).text().split(" ");
        var code = name.pop().replace(/[\(\)]/g, "");
        name = name.join(" ");
        var struct = {
            row_id: 'new',
            ihtype_id: $('#p_ihtype').val(),
            name: name,
            category: $('#p_ictype option').eq($('#p_ictype')[0].selectedIndex).text(),
            code: code
        };
        $('#porteditor').hide();
        var j = jQuery("#list4").jqGrid('getGridParam', 'data').length;
        j++;
        jQuery("#list4").jqGrid('addRowData', 'new' + j, struct);
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
        height: 350,
        editurl: 'clientArray',
        cellEdit: false,
        autowidth: true,
        colNames: ['', '', '', '分类', '名称', '开发环境'],
        colModel: [
            {name: 'myac', width: 80, fixed: true, sortable: false, resize: false, formatter: 'actions',
                formatoptions: {keys: false, delOptions: myDelOptions, editbutton: false
                }},
            {name: 'row_id', index: 'row_id', hidden: true, editable: false},
            {name: 'ihtype_id', index: 'ihtype_id', hidden: true},
            {name: 'category', index: 'category', width: 200},
            {name: 'name', index: 'name', width: 200, editable: false},
            {name: 'code', index: 'code', width: 100, editable: false}
        ]
    });
    var mydata = {/literal}{$product.items}{literal};
    for (var i = 0; i <= mydata.length; i++)
        jQuery("#list4").jqGrid('addRowData', i + 1, mydata[i]);

    </script>
{/literal}

