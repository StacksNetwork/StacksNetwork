function parseSubmit(response, postdata) {
    var data = response.responseText;
    var codes = eval('(' + data.substr(data.indexOf('<!-- ') + 4, data.indexOf('-->') - 4) + ')');
    var pass = true;
    var msg = "";
    for (var i = 0; i < codes.ERROR.length; i++) {
        msg += codes.ERROR[i];
        pass = false;
    }
    return [pass, msg]
}

function helptoggle() {
    $('#helpcontainer > .menuitm').toggle();
    $('#helpcontainer .blank_state_smaller').eq(0).toggle();
    return false;
}


function getportdetails(url) {
    $('.spinner').show();
    $('#porteditor').hide().html('');
    $.get(url, function(data) {
        $('.spinner').hide();
        $('#porteditor').html(data).show();
    });
}

function highlight() {
    var post = $.extend({}, this.p.postData),
            search = this.p.search === true;

    if (post.sn && post.sn.length) {
        search = true;
        post.searchField = 'sn';
        post.searchString = post.sn;
    }
    if (search === true) {
        for (var i = 0; i < this.p.colModel.length; i++) {
            if (this.p.colModel[i].index == post.searchField) {
                $('>tbody>tr.jqgrow>td:nth-child(' + (i + 1) +
                        ')', this).highlight(post.searchString);
            }
        }
    }
}

function printQr() {
    var printp = window.open(document.getElementById('qrcodeimage').src, '_blank')
    printp.onload = function() {
        printp.print();
    };
    return false;
}

function showFacebox(url) {
    $.facebox({
        ajax: url,
        width: 900,
        nofooter: true,
        opacity: 0.8,
        addclass: 'modernfacebox'
    });
    return false;
}

function setjGridHeight() {
    $("#list2").jqGrid('setGridHeight', $(window).height() - $('.ui-jqgrid-bdiv').offset().top -
            ($('#bodycont').offset().top + $('#bodycont').height() - $('#pager2').offset().top + $('#pager2').height()))
}

$(function() {
    if (window.location.hash && window.location.hash.match(/^#e\d+$/))
        showFacebox('?cmd=inventory_manager&action=entity&id=' + window.location.hash.match(/^#e(\d+)$/)[1])
})

var DefaultGRID = {
    autowidth: true,
    datatype: "json",
    rowNum: 50,
    height: 'auto',
    rowList: [50, 100, 150],
    pager: '#pager2',
    sortname: 'id',
    viewrecords: true,
    sortorder: "desc"
}

var GridTemplates = {
    vendors: {
        grid: $.extend({}, DefaultGRID, {
            url: 'index.php?cmd=inventory_manager&action=vendors',
            editurl: 'index.php?cmd=inventory_manager&action=vendors',
            colNames: [' ', '供应商ID', '产品平台', '供应商名称', '供应商详细信息', '联系人/联系方式'],
            colModel: [
                {name: 'myac', width: 80, fixed: true, sortable: false, resize: false, formatter: 'actions', formatoptions: {editformbutton: true, keys: true}},
                {name: 'id', index: 'id', width: 55, editable: false, editoptions: {readonly: true, size: 10}},
                {name: 'code', index: 'code', width: 80, editable: true, editoptions: {size: 10}},
                {name: 'name', index: 'name', width: 90, editable: true, editoptions: {size: 25}},
                {name: 'contact', index: 'contact', width: 100, editable: true, edittype: "textarea", editoptions: {rows: "5", cols: "35"}},
                {name: 'description', index: 'escription', width: 100, sortable: false, editable: true, edittype: "textarea", editoptions: {rows: "5", cols: "35"}}
            ],
        }),
        nav: [
            {}, //options
            {height: 380, reloadAfterSubmit: true, afterSubmit: parseSubmit, closeAfterEdit: true, closeOnEscape: true}, // edit options
            {height: 380, reloadAfterSubmit: true, afterSubmit: parseSubmit, closeAfterAdd: true, closeOnEscape: true}, // add options
            {reloadAfterSubmit: true}, // del options
            {} // search options
        ]
    },
    settings: {
        grid: $.extend({}, DefaultGRID, {
            url: 'index.php?cmd=inventory_manager&action=settings',
            editurl: 'index.php?cmd=inventory_manager&action=settings',
            colNames: [' ', '配置ID', '配置内容', '值', '配置详细说明'],
            colModel: [
                {name: 'myac', width: 80, fixed: true, sortable: false, resize: false, formatter: 'actions', formatoptions: {editformbutton: true, keys: true, del: false, delbutton: false}},
                {name: 'id', index: 'id', width: 55, hidden: true, editable: false, editoptions: {readonly: true, size: 10}},
                {name: 'name', index: 'name', width: 90, editable: false, editoptions: {size: 25}},
                {name: 'value', index: 'value', width: 90, editable: true, formatter: "checkbox", formatoptions: {disabled: true}, edittype: 'checkbox', editoptions: {value: "True:False"}},
                {name: 'description', index: 'description', width: 500, sortable: false, editable: false}
            ],
        }),
        nav: [
            {search: false, del: false, add: false, edit: false}, //options
            {height: 280, reloadAfterSubmit: true, afterSubmit: parseSubmit, closeAfterEdit: true, closeOnEscape: true}, // edit options
            {}, // add options
            {}, // del options
            {} // search options
        ]
    },
    producers: {
        grid: $.extend({}, DefaultGRID, {
            url: 'index.php?cmd=inventory_manager&action=producers',
            editurl: 'index.php?cmd=inventory_manager&action=producers',
            colNames: ['', '厂商ID', '产品平台', '厂商品牌名称', '服务支持网站', '备注'],
            colModel: [
                {name: 'myac', width: 80, fixed: true, sortable: false, resize: false, formatter: 'actions', formatoptions: {editformbutton: true, keys: true}},
                {name: 'id', index: 'id', width: 55, editable: false, editoptions: {readonly: true, size: 10}},
                {name: 'code', index: 'code', width: 80, editable: true, editoptions: {size: 10}},
                {name: 'name', index: 'name', width: 90, editable: true, editoptions: {size: 25}},
                {name: 'website', index: 'website', formatter: 'link', width: 100, editable: true, editoptions: {size: 25}},
                {name: 'description', index: 'escription', width: 100, sortable: false, editable: true, edittype: "textarea", editoptions: {rows: "5", cols: "35"}}
            ],
        }),
        nav: [
            {}, //options
            {height: 280, reloadAfterSubmit: true, afterSubmit: parseSubmit, closeAfterEdit: true, closeOnEscape: true}, // edit options
            {height: 280, reloadAfterSubmit: true, afterSubmit: parseSubmit, closeAfterAdd: true, closeOnEscape: true}, // add options
            {reloadAfterSubmit: true}, // del options
            {} // search options
        ]
    },
    deliveries: {
        grid: $.extend({}, DefaultGRID, {
            url: 'index.php?cmd=inventory_manager&action=deliveries',
            editurl: 'index.php?cmd=inventory_manager&action=deliveries',
            colNames: ['', '交付批次ID', '交付日期', '收款总金额', '对应订单ID', '对应账单ID', '包含配件总数', '供应商', '录入人员'],
            colModel: [
                {name: 'myac', width: 10, sortable: false, search: false, resize: false},
                {name: 'id', index: 'id', width: 55},
                {name: 'date', index: 'date', width: 90},
                {name: 'total', index: 'total', width: 90, formatter: 'currency', formatoptions: currencySettings},
                {name: 'order_id', index: 'order_id', width: 90},
                {name: 'invoice_id', index: 'invoice_id', width: 90},
                {name: 'items', index: 'items', width: 55, search: false},
                {name: 'vendor', index: 'vendor', width: 55},
                {name: 'received_by', index: 'received_by', width: 80}
            ],
            subGrid: true,
            sortorder: "asc",
            gridComplete: function() {
                var ids = $(this).jqGrid('getDataIDs');
                for (var i = 0; i < ids.length; i++) {
                    var cl = ids[i];
                    be = "<div title='编辑选定的行' style='float:left;cursor:pointer;' class='ui-pg-div ui-inline-edit'  onclick='showFacebox(\"?cmd=inventory_manager&action=newdelivery&id=" + cl + "\")'><span class='ui-icon ui-icon-pencil'></span></div>";
                    $(this).jqGrid('setRowData', ids[i], {myac: be});
                }
            },
            subGridOptions: {
                "plusicon": "ui-icon-triangle-1-e",
                "minusicon": "ui-icon-triangle-1-s",
                "openicon": "ui-icon-arrowreturn-1-e"
            },
            subGridRowExpanded: function(subgrid_id, row_id) {
// we pass two parameters
// subgrid_id is a id of the div tag created whitin a table data
// the id of this elemenet is a combination of the "sg_" + id of the row
// the row_id is the id of the row
// If we wan to pass additinal parameters to the url we can use
// a method getRowData(row_id) - which returns associative array in type name-value
// here we can easy construct the flowing
                var subgrid_table_id, pager_id, category_id = row_id;
                subgrid_table_id = subgrid_id + "_t";
                pager_id = "p_" + subgrid_table_id;
                $("#" + subgrid_id).html("<table id='" + subgrid_table_id + "' class='scroll' ></table><div id='" + pager_id + "' class='scroll'></div>").css('margin', 5);
                jQuery("#" + subgrid_table_id).jqGrid($.extend({}, DefaultGRID, {
                    url: 'index.php?cmd=inventory_manager&action=inventorylist&delivery_id=' + category_id,
                    editurl: 'index.php?cmd=inventory_manager&action=inventorylist&delivery_id=' + category_id,
                    colNames: [' ', 'ID', '名称', '厂商', 'S/N', '采购单价', '保修期', '售后服务期', '当前位置', '状态'],
                    colModel: [
                        {name: 'myac', width: 10, sortable: false, search: false, resize: false},
                        {name: 'id', index: 'id', hidden: true, search: false},
                        {name: 'name', index: 'name', width: 80},
                        {name: 'manufacturer', index: 'manufacturer', width: 80},
                        {name: 'sn', index: 'sn', width: 80},
                        {name: 'price', index: 'price', width: 80, formatter: 'currency', formatoptions: currencySettings},
                        {name: 'guarantee', index: 'guarantee', width: 90},
                        {name: 'support', index: 'support', width: 90},
                        {name: 'localisation', index: 'localisation', width: 90},
                        {name: 'status', index: 'status', width: 80}
                    ],
                    pager: pager_id,
                    sortname: 'name',
                    gridComplete: function() {
                        var ids = jQuery("#" + subgrid_table_id).jqGrid('getDataIDs');
                        for (var i = 0; i < ids.length; i++) {
                            var cl = ids[i];
                            be = "<div title='编辑选定的行' style='float:left;cursor:pointer;' class='ui-pg-div ui-inline-edit'  onclick='showFacebox(\"?cmd=inventory_manager&action=entity&id=" + cl + "\")'><span class='ui-icon ui-icon-pencil'></span></div>";
                            jQuery("#" + subgrid_table_id).jqGrid('setRowData', ids[i], {myac: be});
                        }
                    }

                }));
                jQuery("#" + subgrid_table_id).jqGrid('navGrid', "#" + pager_id,
                        {edit: false, add: false}, //options editfunc:function(id){console.log(id)}
                {}, // edit options
                        {height: 380, reloadAfterSubmit: true}, // add options
                {reloadAfterSubmit: true}, // del options
                {} // search options
                );
            }
        }),
        nav: [
            {edit: false, del: true, search: true, add: false}, //options
            {}, // edit options
            {}, // add options
            {reloadAfterSubmit: true}, // del options
            {} // search options
        ]
    },
    deployments: {
        grid: $.extend({}, DefaultGRID, {
            url: 'index.php?cmd=inventory_manager&action=deployments',
            editurl: 'index.php?cmd=inventory_manager&action=deployments',
            colNames: ['', '类型ID', '品牌名称', '可销售产品说明', '已激活使用数量', '是否可供货状态'],
            colModel: [
                {name: 'myac', width: 10, sortable: false, search: false, resize: false},
                {name: 'id', index: 'id', width: 55},
                {name: 'name', index: 'name', width: 90},
                {name: 'description', index: 'description', width: 120},
                {name: 'inuse', index: 'inuse', width: 55, search: false},
                {name: 'status', index: 'status', width: 90}

            ],
            subGrid: true,
            sortorder: "asc",
            subGridOptions: {
                "plusicon": "ui-icon-triangle-1-e",
                "minusicon": "ui-icon-triangle-1-s",
                "openicon": "ui-icon-arrowreturn-1-e"
            }, gridComplete: function() {
                var ids = $(this).jqGrid('getDataIDs');
                for (var i = 0; i < ids.length; i++) {
                    var cl = ids[i];
                    var be = "<div title='编辑选定的行' style='float:left;cursor:pointer;' class='ui-pg-div ui-inline-edit'  onclick='showFacebox(\"?cmd=inventory_manager&action=newproduct&id=" + cl + "\")'><span class='ui-icon ui-icon-pencil'></span></div>";
                    $(this).jqGrid('setRowData', ids[i], {myac: be});
                }
            },
            subGridRowExpanded: function(subgrid_id, row_id) {
//debugger;
                var subgrid_table_id, pager_id, category_id = row_id;
                subgrid_table_id = subgrid_id + "_t";
                pager_id = "p_" + subgrid_table_id;
                $("#" + subgrid_id).html("<table id='" + subgrid_table_id + "' class='scroll' ></table><div id='" + pager_id + "' class='scroll'></div>").css('margin', 5);
                jQuery("#" + subgrid_table_id).jqGrid({
                    url: 'index.php?cmd=inventory_manager&action=deploymentitems&deployment_id=' + category_id,
                    editurl: 'index.php?cmd=inventory_manager&action=deploymentitems&deployment_id=' + category_id,
                    autowidth: true,
                    datatype: "json",
                    colNames: ['ID', '分类', '名称', '产品平台', '组合的配件'],
                    colModel: [
                        {name: 'id', index: 'id', hidden: true, search: false},
                        {name: 'category', index: 'category', width: 80},
                        {name: 'name', index: 'name', width: 120},
                        {name: 'code', index: 'code', width: 80},
                        {name: 'totl', index: 'totl', width: 80}

                    ],
                    rowNum: 10,
                    height: '100%',
                    rowList: [10, 20, 30],
                    pager: pager_id,
                    sortname: 'name',
                    viewrecords: true,
                    sortorder: "desc",
                    gridComplete: function() {
                        var ids = jQuery("#" + subgrid_table_id).jqGrid('getDataIDs');
                        for (var i = 0; i < ids.length; i++) {
                            var cl = ids[i];
                            be = "<div title='编辑选定的行' style='float:left;cursor:pointer;' class='ui-pg-div ui-inline-edit'  onclick='showFacebox(\"?cmd=inventory_manager&action=entity&id=" + cl + "\")'><span class='ui-icon ui-icon-pencil'></span></div>";
                            jQuery("#" + subgrid_table_id).jqGrid('setRowData', ids[i], {myac: be});
                        }
                    }

                });
                jQuery("#" + subgrid_table_id).jqGrid('navGrid', "#" + pager_id,
                        {edit: false, add: false, del: true, search: false}, //options editfunc:function(id){console.log(id)}
                {}, // edit options
                        {height: 380, reloadAfterSubmit: true}, // add options
                {reloadAfterSubmit: true}, // del options
                {} // search options
                );
            }
        }),
        nav: [
            {edit: false, del: true, search: true, add: false}, //options
            {}, // edit options
            {}, // add options
            {reloadAfterSubmit: true}, // del options
            {} // search options
        ]
    },
    inventory: {
        grid: $.extend({}, {}, DefaultGRID, {
            url: 'index.php?cmd=inventory_manager&action=inventory',
            editurl: 'index.php?cmd=inventory_manager&action=categories',
            colNames: ['', 'ID', '配件名称', '相同配件总数', '是否闲置', '配件相关说明'],
            colModel: [
                {name: 'myac', width: 10, sortable: false, resize: false},
                {name: 'id', index: 'id', width: 55, editable: false, editoptions: {readonly: true, size: 10}},
                {name: 'name', index: 'name', width: 90, editable: true, editoptions: {size: 25}},
                {name: 'items', index: 'items', width: 55, editable: false, editoptions: {readonly: true, size: 10}},
                {name: 'freeitems', index: 'freeitems', width: 55, editable: false, editoptions: {readonly: true, size: 10}},
                {name: 'description', index: 'escription', width: 100, sortable: false, editable: true, edittype: "textarea", editoptions: {rows: "5", cols: "35"}}
            ],
            subGrid: true,
            sortorder: "asc",
            gridComplete: function() {
                var ids = $(this).jqGrid('getDataIDs');
                for (var i = 0; i < ids.length; i++) {
                    var cl = ids[i];
                    be = "<div title='类别列表' style='float:left;cursor:pointer;' class='ui-pg-div ui-inline-edit'  onclick='window.location=\"?cmd=inventory_manager&action=inventorylist&category_id=" + cl + "\"'><span class='ui-icon ui-icon-folder-open'></span></div>";
                    $(this).jqGrid('setRowData', ids[i], {myac: be});
                }
            },
            subGridOptions: {
                "plusicon": "ui-icon-triangle-1-e",
                "minusicon": "ui-icon-triangle-1-s",
                "openicon": "ui-icon-arrowreturn-1-e"
            },
            subGridRowExpanded: function(subgrid_id, row_id) {
                var subgrid_table_id, pager_id, category_id = row_id;
                subgrid_table_id = subgrid_id + "_t";
                pager_id = "p_" + subgrid_table_id;
                $("#" + subgrid_id).html("<table id='" + subgrid_table_id + "' class='scroll' ></table><div id='" + pager_id + "' class='scroll'></div>").css('margin', 5);
                jQuery("#" + subgrid_table_id).jqGrid($.extend({}, DefaultGRID, DefaultGRID, {
                    url: 'index.php?cmd=inventory_manager&action=inventorylist&category_id=' + category_id,
                    editurl: 'index.php?cmd=inventory_manager&action=inventorylist&category_id=' + category_id,
                    colNames: [' ', 'ID', '名称', '厂商', '供应商', 'SN', '采购单价', '保修期', '售后服务期', '当前位置', '状态'],
                    colModel: [
                        {name: 'myac', width: 10, sortable: false, search: false, resize: false},
                        {name: 'id', index: 'id', hidden: true, search: false},
                        {name: 'name', index: 'name', width: 80},
                        {name: 'manufacturer', index: 'manufacturer', width: 80},
                        {name: 'vendor', index: 'vendor', width: 80},
                        {name: 'sn', index: 'sn', width: 80},
                        {name: 'price', index: 'price', width: 80, formatter: 'currency', formatoptions: currencySettings},
                        {name: 'guarantee', index: 'guarantee', width: 90},
                        {name: 'support', index: 'support', width: 90},
                        {name: 'localisation', index: 'localisation', width: 90},
                        {name: 'status', index: 'status', width: 80}
                    ],
                    pager: pager_id,
                    sortname: 'name',
                    gridComplete: function() {
                        var ids = jQuery("#" + subgrid_table_id).jqGrid('getDataIDs');
                        for (var i = 0; i < ids.length; i++) {
                            var cl = ids[i];
                            be = "<div title='编辑选定的行' style='float:left;cursor:pointer;' class='ui-pg-div ui-inline-edit'  onclick='showFacebox(\"?cmd=inventory_manager&action=entity&id=" + cl + "\")'><span class='ui-icon ui-icon-pencil'></span></div>";
                            jQuery("#" + subgrid_table_id).jqGrid('setRowData', ids[i], {myac: be});
                        }
                    }

                }));
                jQuery("#" + subgrid_table_id).jqGrid('navGrid', "#" + pager_id,
                        {edit: false, add: false}, //options editfunc:function(id){console.log(id)}
                {}, // edit options
                        {height: 380, reloadAfterSubmit: true}, // add options
                {reloadAfterSubmit: true}, // del options
                {} // search options
                );
            }
        }),
        nav: [
            {edit: false, del: false, search: false, add: false}, //options
            {}, // edit options
            {}, // add options
            {reloadAfterSubmit: true}, // del options
            {} // search options
        ]
    },
    inventorylist: {
        grid: $.extend({}, DefaultGRID, {
            url: 'index.php?cmd=inventory_manager&action=inventorylist&category_id=',
            editurl: 'index.php?cmd=inventory_manager&action=inventorylist&category_id=',
            colNames: [' ', 'ID', '名称', '厂商', '供应商', 'SN', '采购单价', '保修期', '售后服务期', '当前位置', '状态'],
            colModel: [
                {name: 'myac', width: 10, sortable: false, search: false, resize: false},
                {name: 'id', index: 'id', hidden: true},
                {name: 'name', index: 'name', width: 80},
                {name: 'manufacturer', index: 'manufacturer', width: 80},
                {name: 'vendor', index: 'vendor', width: 80},
                {name: 'sn', index: 'sn', width: 80},
                {name: 'price', index: 'price', width: 80},
                {name: 'guarantee', index: 'guarantee', width: 90},
                {name: 'support', index: 'support', width: 90},
                {name: 'localisation', index: 'localisation', width: 90},
                {name: 'status', index: 'status', width: 80}
            ],
            gridComplete: function() {

                var ids = $(this).jqGrid('getDataIDs');
                for (var i = 0; i < ids.length; i++) {
                    var cl = ids[i];
                    be = "<div title='编辑选定的行' style='float:left;cursor:pointer;' class='ui-pg-div ui-inline-edit'  onclick='showFacebox(\"?cmd=inventory_manager&action=entity&id=" + cl + "\")'><span class='ui-icon ui-icon-pencil'></span></div>";
                    $(this).jqGrid('setRowData', ids[i], {myac: be});
                }
            }
        }),
        nav: [
            {edit: false, add: false}, //options editfunc:function(id){console.log(id)}
            {}, // edit options
            {height: 380, reloadAfterSubmit: true}, // add options
            {reloadAfterSubmit: true}, // del options
            {} // search options
        ]
    },
    categories: {
        grid: {
            url: 'index.php?cmd=inventory_manager&action=categories',
            editurl: 'index.php?cmd=inventory_manager&action=categories',
            autowidth: true,
            datatype: "json",
            colNames: ['', 'ID', '分类名称', '相关说明'],
            colModel: [
                {name: 'myac', width: 80, fixed: true, sortable: false, resize: false, formatter: 'actions', search: false,
                    formatoptions: {editformbutton: true, keys: true}},
                {name: 'id', index: 'id', width: 55, editable: false, editoptions: {readonly: true, size: 10}},
                {name: 'name', index: 'name', width: 90, editable: true, editoptions: {size: 25}},
                {name: 'description', index: 'escription', width: 100, sortable: false, editable: true, edittype: "textarea", editoptions: {rows: "5", cols: "35"}}
            ],
            rowNum: 50,
            height: 100,
            rowList: [50, 100, 150],
            pager: '#pager2',
            sortname: 'id',
            subGrid: true,
            viewrecords: true,
            sortorder: "desc",
            subGridOptions: {
                "plusicon": "ui-icon-triangle-1-e",
                "minusicon": "ui-icon-triangle-1-s",
                "openicon": "ui-icon-arrowreturn-1-e"
            },
            subGridRowExpanded: function(subgrid_id, row_id) {
                var subgrid_table_id, pager_id;
                subgrid_table_id = subgrid_id + "_t";
                pager_id = "p_" + subgrid_table_id;
                $("#" + subgrid_id).html("<table id='" + subgrid_table_id + "' class='scroll' ></table><div id='" + pager_id + "' class='scroll'></div>").css('margin', 5);
                jQuery("#" + subgrid_table_id).jqGrid({
                    url: "index.php?cmd=inventory_manager&action=ihtype&category_id=" + row_id,
                    editurl: "index.php?cmd=inventory_manager&action=ihtype&category_id=" + row_id,
                    datatype: "json",
                    autowidth: true,
                    colNames: ['', 'ID', '产品平台', '名称', '说明'],
                    colModel: [
                        {name: 'myac', width: 80, fixed: true, sortable: false, resize: false, formatter: 'actions', search: false,
                            formatoptions: {editformbutton: true, keys: true}},
                        {name: 'id', index: 'id', width: 55, editable: false, editoptions: {readonly: true, size: 10}},
                        {name: 'code', index: 'code', width: 80, editable: true, editoptions: {size: 10}},
                        {name: 'name', index: 'name', width: 90, editable: true, editoptions: {size: 25}},
                        {name: 'description', index: 'escription', width: 100, sortable: false, editable: true, edittype: "textarea", editoptions: {rows: "5", cols: "35"}}
                    ],
                    rowNum: 20,
                    rowList: [20, 50, 75],
                    pager: pager_id,
                    sortname: 'id',
                    sortorder: "asc",
                    height: '100%'
                });
                jQuery("#" + subgrid_table_id).jqGrid('navGrid', "#" + pager_id, {search: false},
                {height: 280, reloadAfterSubmit: true, afterSubmit: parseSubmit, closeAfterEdit: true, closeOnEscape: true}, // edit options
                {height: 280, reloadAfterSubmit: true, afterSubmit: parseSubmit, closeAfterAdd: true, closeOnEscape: true});
            }
        },
        nav: [
            {}, //options
            {height: 280, reloadAfterSubmit: true, afterSubmit: parseSubmit, closeAfterEdit: true, closeOnEscape: true}, // edit options
            {height: 280, reloadAfterSubmit: true, afterSubmit: parseSubmit, closeAfterAdd: true, closeOnEscape: true}, // add options
            {reloadAfterSubmit: true}, // del options
            {} // search options
        ]
    },
    builds: {
        grid: {
            url: 'index.php?cmd=inventory_manager&action=builds',
            editurl: 'index.php?cmd=inventory_manager&action=builds',
            autowidth: true,
            datatype: "json",
            colNames: ['', '调试ID', '添加日期', '产品名称', '相关账户', '相关客户'],
            colModel: [
                {name: 'myac', width: 10, sortable: false, search: false, resize: false},
                {name: 'id', index: 'id', width: 55},
                {name: 'date', index: 'date', width: 100},
                {name: 'product', index: 'product'},
                {name: 'account_link', index: 'account_link', width: 120, search: false},
                {name: 'client_link', index: 'client_link', width: 120, search: false}
            ],
            rowNum: 10,
            height: 500,
            rowList: [10, 20, 30],
            pager: '#pager2',
            sortname: 'id',
            subGrid: true,
            viewrecords: true,
            sortorder: "asc",
            gridComplete: function() {
                var ids = $(this).jqGrid('getDataIDs');
                for (var i = 0; i < ids.length; i++) {
                    var cl = ids[i];
                    be = "<div title='完成调试配置/交付' style='float:left;cursor:pointer;' class='ui-pg-div ui-inline-edit'  onclick='showFacebox(\"?cmd=inventory_manager&action=newbuild&id=" + cl + "\")'><span class='ui-icon ui-icon-circle-check'></span></div>";
                    $(this).jqGrid('setRowData', ids[i], {myac: be});
                }
            },
            subGridOptions: {
                "plusicon": "ui-icon-triangle-1-e",
                "minusicon": "ui-icon-triangle-1-s",
                "openicon": "ui-icon-arrowreturn-1-e"
            },
            subGridRowExpanded: function(subgrid_id, row_id) {

                var subgrid_table_id, pager_id, category_id = row_id;
                subgrid_table_id = subgrid_id + "_t";
                pager_id = "p_" + subgrid_table_id;
                $("#" + subgrid_id).html("<table id='" + subgrid_table_id + "' class='scroll' ></table><div id='" + pager_id + "' class='scroll'></div>").css('margin', 5);
                jQuery("#" + subgrid_table_id).jqGrid({
                    url: 'index.php?cmd=inventory_manager&action=buildlist&build_id=' + category_id,
                    editurl: 'index.php?cmd=inventory_manager&action=buildlist&build_id=' + category_id,
                    autowidth: true,
                    datatype: "json",
                    colNames: [' ', 'ID', 'S/N', '分类', '名称', '厂商', '采购单价', '当前位置', '状态'],
                    colModel: [
                        {name: 'myac', width: 10, sortable: false, search: false, resize: false},
                        {name: 'id', index: 'id', hidden: true, search: false},
                        {name: 'sn', index: 'sn', width: 80},
                        {name: 'category', index: 'category', width: 80},
                        {name: 'name', index: 'name', width: 80},
                        {name: 'manufacturer', index: 'manufacturer', width: 80},
                        {name: 'price', index: 'price', width: 80, formatter: 'currency', formatoptions: currencySettings},
                        {name: 'localisation', index: 'localisation', width: 90},
                        {name: 'status', index: 'status', width: 80}
                    ],
                    rowNum: 50,
                    height: '100%',
                    rowList: [50, 100, 150],
                    pager: pager_id,
                    sortname: 'name',
                    viewrecords: true,
                    sortorder: "desc",
                    gridComplete: function() {
                        var ids = jQuery("#" + subgrid_table_id).jqGrid('getDataIDs');
                        for (var i = 0; i < ids.length; i++) {
                            var cl = ids[i];
                            be = "<div title='编辑选定的行' style='float:left;cursor:pointer;' class='ui-pg-div ui-inline-edit'  onclick='showFacebox(\"?cmd=inventory_manager&action=entity&id=" + cl + "\")'><span class='ui-icon ui-icon-pencil'></span></div>";
                            jQuery("#" + subgrid_table_id).jqGrid('setRowData', ids[i], {myac: be});
                        }
                    }

                });
                jQuery("#" + subgrid_table_id).jqGrid('navGrid', "#" + pager_id,
                        {edit: false, add: false}, //options editfunc:function(id){console.log(id)}
                {}, // edit options
                        {height: 380, reloadAfterSubmit: true}, // add options
                {reloadAfterSubmit: true, msg: "您确定希望从已调试或组装设备中删除 \r\n 该物品吗?  \r\n它的状态会变成 '仓库中'."}, // del options
                {} // search options
                );
            }
        },
        nav: [
            {edit: false, del: true, search: true, add: false}, //options
            {}, // edit options
            {}, // add options
            {reloadAfterSubmit: true, msg: "您确定希望删除 \r\n 该已调试或组装设备吗? \r\n 所有的内容状态都会变更为 '仓库中'"}, // del options
            {} // search options
        ]
    }
}

GridTemplates['itemsearch'] = {
    grid: $.extend({}, GridTemplates.inventorylist.grid, {
        url: 'index.php?cmd=inventory_manager&action=inventorylist',
        editurl: 'index.php?cmd=inventory_manager&action=inventorylist',
        beforeRequest: function(a) {
            $(this).jqGrid('setGridParam', {
                postData: {sn: $('#itemsearch').val()}
            });
        }
    }),
    nav: GridTemplates.inventorylist.nav
}

GridTemplates['guarantee'] = {
    grid: $.extend({}, GridTemplates.inventorylist.grid, {
        url: 'index.php?cmd=inventory_manager&action=guarantee',
        editurl: 'index.php?cmd=inventory_manager&action=guarantee',
    }),
    nav: GridTemplates.inventorylist.nav
}

GridTemplates['support'] = {
    grid: $.extend({}, GridTemplates.inventorylist.grid, {
        url: 'index.php?cmd=inventory_manager&action=support',
        editurl: 'index.php?cmd=inventory_manager&action=support',
    }),
    nav: GridTemplates.inventorylist.nav
}

GridTemplates['lowqty'] = {
    grid: $.extend({}, DefaultGRID, {
        url: "index.php?cmd=inventory_manager&action=lowqty",
        editurl: "index.php?cmd=inventory_manager&action=lowqty",
        datatype: "json",
        autowidth: true,
        colNames: ['', 'ID', '产品平台', '名称', '分类', '说明'],
        colModel: [
            {name: 'priority', index: 'priority', width: 5, editable: false, editoptions: {size: 1}},
            {name: 'id', index: 'id', width: 25, editable: false, editoptions: {readonly: true, size: 1}},
            {name: 'code', index: 'code', width: 80, editable: true, editoptions: {size: 10}},
            {name: 'name', index: 'name', width: 90, editable: true, editoptions: {size: 25}},
            {name: 'catname', index: 'catname', width: 90, editable: true, editoptions: {size: 25}},
            {name: 'description', index: 'escription', width: 100, sortable: false, editable: true, edittype: "textarea", editoptions: {rows: "5", cols: "35"}}
        ],
        rowNum: 10,
        rowList: [10, 20, 50],
        sortname: 'sort',
        sortorder: "asc",
        loadonce: true,
        gridComplete: function() {
            var ids = $(this).jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                var cl = ids[i],
                        data = $(this).jqGrid('getRowData', ids[i]),
                        priority = parseInt(data.priority),
                        color = priority == 1 ? '#D90404' : (priority == 2 ? '#E38700' : '#93927B'),
                        be = "<span class='fa fa-warning' style=\"color:" + color + "\"></span>";
                if (!isNaN(priority))
                    $(this).jqGrid('setRowData', ids[i], {priority: be});

            }
        }
    }),
    nav: [
        {search: false, del: false, add: false, edit: false}, //options
        {height: 280, reloadAfterSubmit: true, afterSubmit: parseSubmit, closeAfterEdit: true, closeOnEscape: true}, // edit options
        {}, // add options
        {}, // del options
        {} // search options
    ]
}