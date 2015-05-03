<h3 class="left">该割接工程的相关步骤</h3>
    <a onclick="$('#porteditor').show();return false;" class=" menuitm right greenbtn" href="#"><span><b>添加新的步骤</b></span></a>
        <div class="clear"></div>
<div style="min-height:400px">
    
    <table id="list4"></table>

</div>
<div id="porteditor">
    <h3 style="margin-bottom:10px;" class="left">
        添加割接方案的新步骤:
    </h3>
    <a onclick="$('#porteditor').hide();return false;" class=" menuitm right" href="#"><span><b>关闭</b></span></a>
    <div class="clear"></div>
    
    <label class="nodescr"> 该步骤的操作大纲</label>
    <input type="text"  class="w250" name="p_name" value="" id="p_name">
    <div class="clear"></div>
    
   
    
    <label class="nodescr">步骤操作具体内容</label> &nbsp;&nbsp;&nbsp;支持HTML脚本
    <textarea id="p_description" name="p_description" class="inp w250" style="height:260px;width:360px;"></textarea>
    <div class="clear"></div>
    
   

    <a onclick="addItem();return false;" class=" menuitm right greenbtn" href="#"><span><b>添加该步骤</b></span></a>
    <div class="clear"></div>
</div>
    <input type="hidden" name="tabledata" value="" id="tabledata" />
    {literal}
<script>
    $('#porteditor').insertAfter($('.tabb:last'));
    
         
         function onFaceboxSubmit() {
               var data = JSON.stringify(jQuery("#list4").jqGrid('getGridParam','data'));
               $('#tabledata').val(data); 
                   return true;
         }
      
      function addItem() {
         if(!$('#p_name').val()) {
             return false;
         }
             var struct={
                    id:'new',
                    name: $('#p_name').val(),
                    description: $('#p_description').val()
             };
          $('#porteditor').hide();
              var j =jQuery("#list4").jqGrid('getGridParam','data').length;
                  j++;
                  jQuery("#list4").jqGrid('addRowData','new'+j,struct);
                  $('#porteditor').hide();
                      $('#p_name').val('');$('#p_description').val('');
                          
      }
         
         
         var grid=jQuery("#list4");
             
              myDelOptions = {
                    onclickSubmit: function(rp_ge, rowid) {

                        grid.delRowData(rowid);
                        grid_id = grid[0].id,

                         $.jgrid.hideModal("#delmod"+grid_id,
                         {gb:"#gbox_"+grid_id});



                        return true;
                    },
                    processing:true
                };



  jQuery("#list4").jqGrid({
	datatype: "local",
	height: 350,
            width:700,
        editurl:'clientArray',
       cellEdit: false,
   	colNames:['','该步骤的操作大纲','步骤操作具体内容'],
   	colModel:[
                
   		{name:'id',index:'id', hidden:true,editable:false},
   		{name:'name',index:'name', width:100,editable:false,sortable:false},
   		{name:'description',index:'description', width:140,editable:false,sortable:false}		
   	]
});
var mydata = {/literal}{$scenario.items}{literal};
for(var i=0;i<=mydata.length;i++)
	jQuery("#list4").jqGrid('addRowData',i+1,mydata[i]);
         
</script>
    {/literal}
    
