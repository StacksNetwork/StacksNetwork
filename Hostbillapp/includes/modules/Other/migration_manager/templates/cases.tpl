    <div id="helpcontainer"><a class="menuitm" href="#" onclick="return helptoggle()" ><span >显示帮助</span></a> 
        <a class="menuitm" href="#" style="margin-left: 30px;font-weight:bold;" onclick="return showFacebox('?cmd=migration_manager&action=mcase')"><span class="addsth">建立/新割接工程时间表</span></a>
 <a class="menuitm" href="#" style="margin-left: 30px;font-weight:bold;" onclick="return showFacebox('?cmd=migration_manager&action=bulkmigrate')"><span class="addsth">割接路线图应用工具</span></a>


    <div class="blank_state_smaller blank_forms" style="display:none">
                    <div class="blank_info">
                        <h3>割接工程</h3>
                        <span class="fs11"><ul><li>每个由我们的员工进行实施的割接工程案例</li>
<li>割接在一般情况下使用新割接工程时间表建立整个步骤, 员工们按部就班完成割接</li>
<li>可以在将来实现自动化割接</li>
<li>相关工作人员会得知当前步骤所需要执行的具体任务</li>
<li>可选: 通过使用工单自动更新设置通知客户割接状态 </li>
</ul>
                       
                        </span>
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
                url:'index.php?cmd=migration_manager&action=cases{/literal}{if $finished}&finished=true{/if}{literal}',
                editurl:'index.php?cmd=migration_manager&action=cases{/literal}{if $finished}&finished=true{/if}{literal}',
                autowidth:true,
                datatype: "json",
                colNames:[
'',
'工程ID','状态','计划开始时间','割接方案目标与主题','受影响的具体业务','受影响的客户','责任工程师','工单ID'

],
                colModel:[
                       {name: 'myac', width:10,  sortable:false, search:false, resize:false}, 
                        {name:'id',index:'id', width:55},
                        {name:'status',index:'status', width:60},
                        {name:'date_scheduled',index:'date_scheduled', width:80},
                        {name:'name',index:'name', width:130},
                        {name:'related_account',index:'related_account', width:100},
                        {name:'related_client',index:'related_client', width:100},
                        {name:'assigned_staff',index:'assigned_staff', width:100},
                        {name:'related_ticket',index:'related_ticket', width:100}
                            
                ],
                rowNum:10,
                    height: 300,
                rowList:[10,20,30],
                pager: '#pager2',
                sortname: 'id',
                subGrid: true,
            viewrecords: true, 
            sortorder: "asc",
                gridComplete: function(){
                    var ids = jQuery("#list2").jqGrid('getDataIDs');
                    for(var i=0;i < ids.length;i++){
                            var cl = ids[i];
                               be = "<div title='编辑选定的行' style='float:left;cursor:pointer;' class='ui-pg-div ui-inline-edit'  onclick='showFacebox(\"?cmd=migration_manager&action=mcase&id="+cl+"\")'><span class='ui-icon ui-icon-pencil'></span></div>";
                                jQuery("#list2").jqGrid('setRowData',ids[i],{myac:be});
                    }	
                },
                subGridOptions: {
                        "plusicon"  : "ui-icon-triangle-1-e",
                        "minusicon" : "ui-icon-triangle-1-s",
                        "openicon"  : "ui-icon-arrowreturn-1-e"
                },
                subGridRowExpanded: function(subgrid_id, row_id) {
	
		var subgrid_table_id, pager_id, category_id=row_id;
		subgrid_table_id = subgrid_id+"_t";
		pager_id = "p_"+subgrid_table_id;
		$("#"+subgrid_id).html("<table id='"+subgrid_table_id+"' class='scroll' ></table><div id='"+pager_id+"' class='scroll'></div>").css('margin',5);
		jQuery("#"+subgrid_table_id).jqGrid({

                url:'index.php?cmd=migration_manager&action=casesteps&case_id='+category_id,
                editurl:'index.php?cmd=migration_manager&action=casesteps&case_id='+category_id,
                autowidth:true,
                datatype: "json",
                colNames:[' ','ID', '步骤', '该步骤的操作大纲', '状态'],
                colModel:[
                        {name: 'myac', width:10,  sortable:false, search:false, resize:false},
                        {name:'id',index:'id', width:10, search:false,hidden:true},
                        {name:'step',index:'step', width:10, search:false,sortable:false},
                        {name:'name',index:'name', width:180,sortable:false},
                        {name:'status',index:'status', width:80,sortable:false}	
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
                               be = "<div title='编辑选定的行' style='float:left;cursor:pointer;' class='ui-pg-div ui-inline-edit'  onclick='showFacebox(\"?cmd=migration_manager&action=casestep&id="+cl+"\")'><span class='ui-icon ui-icon-pencil'></span></div>";
                            jQuery("#"+subgrid_table_id).jqGrid('setRowData',ids[i],{myac:be});
                    }	
                }
        
});
		jQuery("#"+subgrid_table_id).jqGrid('navGrid',"#"+pager_id,
        {edit:false,add:false}, //options editfunc:function(id){console.log(id)}
        {}, // edit options
        {height:380,reloadAfterSubmit:true}, // add options
        {reloadAfterSubmit:true, msg: "您确定需要从建立的表单中删除 \r\n 该内容吗?  \r\n它的状态将会变更为 '库存'."}, // del options
        {} // search options
        );	
}
        });
        jQuery("#list2").jqGrid('navGrid','#pager2',
        {edit:false,del:true,search:true,add:false}, //options
        {}, // edit options
        {}, // add options
        {reloadAfterSubmit:true, msg: "您确定需要删除 \r\n 该表单吗? \r\n 所有内容状态都将变更为 '库存'"}, // del options
        {} // search options
        );
    });
        
        
        
</script>{/literal}


