<h3 class="left">本次需要交付的内容</h3>
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

    <label >处理 <small>这次交付配件的价格与详细规格如下</small></label>
    <input type="text" size="3" style="width:30px" class="w250" name="p_count" value="1" id="p_count">
    <div class="clear"></div>

    <label class="nodescr">配件价格</label>
    <input type="text" size="3" style="width:30px" class="w250" name="p_price" value="0.00" id="p_price">
    <div class="clear"></div>


    <label class="nodescr">保修期</label>
    <input type="text" style="width:100px" class="w250 haspicker" name="p_guarantee" value="" id="p_guarantee">
    <div class="clear"></div>
    <label class="nodescr">售后服务期</label>
    <input type="text" style="width:100px" class="w250 haspicker" name="p_support" value="" id="p_support">
    <div class="clear"></div>

    <label class="nodescr">厂商</label>
    <select class="w250" name="p_manufacturer"  id="p_manufacturer" >
        {foreach from=$manufacturers item=m key=l}
            <option value="{$l}">{$m}</option>
        {/foreach}
    </select>
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
        var struct = {
            id: 'new',
            iproducer_id: $('#p_manufacturer').val(),
            ihtype_id: $('#p_ihtype').val(),
            localisation: '机位插槽',
            price: $('#p_price').val(),
            sn: '',
            name: $('#p_ihtype option').eq($('#p_ihtype')[0].selectedIndex).text(),
            status: '已安装于设备',
            guarantee: $('#p_guarantee').val(),
            support: $('#p_support').val(),
            manufacturer: $('#p_manufacturer option').eq($('#p_manufacturer')[0].selectedIndex).text()
        };
        $('#porteditor').hide();
        var j = jQuery("#list4").jqGrid('getGridParam', 'data').length;
        var z = parseInt($('#p_count').val());
        for (var i = 0; i < z; i++) {
            j++;
            jQuery("#list4").jqGrid('addRowData', 'new' + j, struct);
        }
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
        cellEdit: true,
        cellsubmit: 'clientArray',
        autowidth: true,
        colNames: ['', '', '', '', '配件当前位置', '名称', '采购单价', 'SN', '状态', '保修期', '售后服务期', '厂商'],
        colModel: [
            {name: 'myac', width: 80, fixed: true, sortable: false, resize: false, formatter: 'actions',
                formatoptions: {keys: false, delOptions: myDelOptions
                }},
            {name: 'row_id', index: 'row_id', hidden: true, editable: false},
            {name: 'iproducer_id', index: 'iproducer_id', hidden: true, editable: false},
            {name: 'ihtype_id', index: 'ihtype_id', hidden: true, editable: false},
            {name: 'localisation', index: 'localisation', hidden: true, editable: false},
            {name: 'name', index: 'name', width: 100, editable: false},
            {name: 'price', index: 'price', width: 90, formatter: 'currency', formatoptions: currencySettings, editable: true},
            {name: 'sn', index: 'sn', width: 100, editable: true},
            {name: 'status', index: 'status', width: 100},
            {name: 'guarantee', index: 'guarantee', width: 100, editable: true},
            {name: 'support', index: 'support', width: 100, editable: true},
            {name: 'manufacturer', index: 'manufacturer', width: 150, editable: false}
        ]
    });
    var mydata = {/literal}{$delivery.items}{literal};
    for (var i = 0; i <= mydata.length; i++)
        jQuery("#list4").jqGrid('addRowData', i + 1, mydata[i]);

    </script>
{/literal}

