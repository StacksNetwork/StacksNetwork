<h3>配件日志</h3>


<table id="list6"></table>
<div id="pager6"></div>
{literal}<script>
            jQuery("#list6").jqGrid({
                url:'index.php?cmd=inventory_manager&action=entitylog&id={/literal}{$product.id}{literal}',
                autowidth:true,
                datatype: "json",
                colNames:['ID','日期', '启用'],
                colModel:[
                    
                        {name:'id',index:'id', width:55,editable:false,hidden:true},
                        {name:'date',index:'date', width:120},
                        {name:'entry',index:'entry', width:500}		
                ],
                rowNum:20,
                 height: 350,
                rowList:[20,35,50],
                pager: '#pager6',
                sortname: 'date',
            viewrecords: true,
            sortorder: "desc"
        });
        jQuery("#list6").jqGrid('navGrid','#pager6',
        {edit:false,del:false,search:false,add:false});
        
    </script>
    {/literal}