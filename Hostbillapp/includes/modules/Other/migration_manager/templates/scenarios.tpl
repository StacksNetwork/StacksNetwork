<div id="helpcontainer"><a class="menuitm" href="#" onclick="return helptoggle()" ><span >显示帮助</span></a>
<a class="menuitm" href="#" style="margin-left: 30px;font-weight:bold;" onclick="return showFacebox('?cmd=migration_manager&action=newscenario')"><span class="addsth">添加新方案</span></a>
    <div class="blank_state_smaller blank_forms" style="display:none">
                    <div class="blank_info">
                        <h3>要描述的割接工程的详细过程步骤? 使用割接方案应用</h3>
                        <span class="fs11">下面可以找到员工们创建的方案列表. 每一个方案组成的步骤, 进行割接工程成功次数<br/> 
                            获得在特殊的情况下所使用的步骤列表 <span class="ui-icon ui-icon-triangle-1-e" style="display:inline-block"></span>
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
    $(document).ready(function(){
            jQuery("#list2").jqGrid({
                url:'index.php?cmd=migration_manager&action=scenarios',
                editurl:'index.php?cmd=migration_manager&action=scenarios',
                autowidth:true,
                datatype: "json",
                colNames:['','工程ID','工程目标/主题名称','方案设计人', '方案系统ID', '方案相关描述'],
                colModel:[
                    
                        {name: 'myac', width:10,  sortable:false, search:false, resize:false},
                        {name:'id',index:'id', width:25},
                        {name:'name',index:'name', width:90},
                        {name:'author',index:'author', width:50},
                        {name:'migrations',index:'migrations', width:50, search:false},
                        {name:'description',index:'description', width:120}		
                ],
                rowNum:50,
                    height: 500,
                rowList:[50,100,150],
                pager: '#pager2',
                sortname: 'id',
                subGrid: true,
            viewrecords: true, 
            sortorder: "asc",
                gridComplete: function(){
                    var ids = jQuery("#list2").jqGrid('getDataIDs');
                    for(var i=0;i < ids.length;i++){
                            var cl = ids[i];
                               be = "<div title='编辑选定的行' style='float:left;cursor:pointer;' class='ui-pg-div ui-inline-edit'  onclick='showFacebox(\"?cmd=migration_manager&action=newscenario&id="+cl+"\")'><span class='ui-icon ui-icon-pencil'></span></div>";
                                jQuery("#list2").jqGrid('setRowData',ids[i],{myac:be});
                    }	
                },
                subGridOptions: {
                        "plusicon"  : "ui-icon-triangle-1-e",
                        "minusicon" : "ui-icon-triangle-1-s",
                        "openicon"  : "ui-icon-arrowreturn-1-e"
                },
                subGridRowExpanded: function(subgrid_id, row_id) {
		// we pass two parameters
		// subgrid_id is a id of the div tag created whitin a table data
		// the id of this elemenet is a combination of the "sg_" + id of the row
		// the row_id is the id of the row
		// If we wan to pass additinal parameters to the url we can use
		// a method getRowData(row_id) - which returns associative array in type name-value
		// here we can easy construct the flowing
		var subgrid_table_id, pager_id, category_id=row_id;
		subgrid_table_id = subgrid_id+"_t";
		pager_id = "p_"+subgrid_table_id;
		$("#"+subgrid_id).html("<table id='"+subgrid_table_id+"' class='scroll' ></table><div id='"+pager_id+"' class='scroll'></div>").css('margin',5);
		jQuery("#"+subgrid_table_id).jqGrid({

                url:'index.php?cmd=migration_manager&action=scenariosteps&scenario_id='+category_id,
                editurl:'index.php?cmd=migration_manager&action=scenariosteps&scenario_id='+category_id,
                autowidth:true,
                datatype: "json",
                colNames:[' ', 'ID','该步骤的操作大纲'],
                colModel:[
                    {name: 'myac', width:5,  sortable:false, search:false, resize:false},
                        {name:'id',index:'id',  width:10, search:false},
                        {name:'name',index:'name', width:100}	
                ],
                rowNum:50,
                height: '100%',
                rowList:[50,100,150],
                pager: pager_id,
                sortname: 'name',
            viewrecords: true,
            sortorder: "desc",
                gridComplete: function(){
                    var ids = jQuery("#"+subgrid_table_id).jqGrid('getDataIDs');
                    for(var i=0;i < ids.length;i++){
                            var cl = ids[i];
                               be = "<div title='编辑选定的行' style='float:left;cursor:pointer;' class='ui-pg-div ui-inline-edit'  onclick='showFacebox(\"?cmd=migration_manager&action=scenariostep&id="+cl+"\")'><span class='ui-icon ui-icon-pencil'></span></div>";
                            jQuery("#"+subgrid_table_id).jqGrid('setRowData',ids[i],{myac:be});
                    }	
                }
        
});
		jQuery("#"+subgrid_table_id).jqGrid('navGrid',"#"+pager_id,
        {edit:false,add:false}, //options editfunc:function(id){console.log(id)}
        {}, // edit options
        {height:380,reloadAfterSubmit:true}, // add options
        {reloadAfterSubmit:true}, // del options
        {} // search options
        );	
}
        });
        jQuery("#list2").jqGrid('navGrid','#pager2',
        {edit:false,del:true,search:true,add:false}, //options
        {}, // edit options
        {}, // add options
        {reloadAfterSubmit:true}, // del options
        {} // search options
        );
    });
        
        
        
</script>{/literal}