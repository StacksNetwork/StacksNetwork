{literal}<script type='text/javascript'>
function addTask() {
var des=$('#description').val();
	ajax_update('?cmd=module&module=todolist&do=addnew',
		{
		 description:des,
		 to_who:$('#to_who').val()
		},
	'#todolist');
$('#description').val('');
	return false;
}

function editTask(tid) {
ajax_update('?cmd=module&module=todolist&do=update',
		{
		 description:$('#todolist .ti_'+tid+' .descr1').val(),
		 id:tid
		},
	'#todolist');
	return false;
}

function showEditor(el) {
var e=$(el).parents('.task');
	e.find('.editor').show();
	e.find('.descript').hide();
	return false;
}

function markMe(el) {
	var action='markundone';
	if($(el).is(':checked'))
		action='markdone';

	ajax_update('?cmd=module&module=todolist&do='+action,
		{
		 id:$(el).attr('id')
		},
	'#todolist');
	return false;
}

function deleteMe(tid) {
ajax_update('?cmd=module&module=todolist&do=delete',
		{
		 id:tid
		},
	'#todolist');
	return false;
}

</script>
<style type='text/css'>
#todolist {
	background:#fff890;
	padding:5px 0px 5px 5px;
	margin-bottom:8px;
        font-size:11px;
}
#todolist .task {
	padding:0px 0px 5px;

	margin:5px 0px;
}
#todolist .descript {
	padding:2px 3px;
}
#todolist .descript .done {
	color:#666666;
	
}
#todolist .ittem {

}
#todolist .inp  {
font-size:11px !important; font-weight:bold;
}
#todolist input.inp {

        padding-right:20px !important;
}
#todolist .hover {
background: #ffc30d !important;
-webkit-border-top-left-radius: 5px;
-webkit-border-top-right-radius: 0px;
-webkit-border-bottom-right-radius: 0px;
-webkit-border-bottom-left-radius: 5px;
-moz-border-radius-topleft: 5px;
-moz-border-radius-topright: 0px;
-moz-border-radius-bottomright: 0px;
-moz-border-radius-bottomleft: 5px;
border-top-left-radius: 5px;
border-top-right-radius: 0px;
border-bottom-right-radius: 0px;
border-bottom-left-radius: 5px;
}
#todolist h3 {
    margin:0px 0px 5px;
}
#todolist a.savebtn {
display:inline-block !important;
margin-left:-20px;
}
#todolist .editor {
	display:none;
}
#todolist .controls {
	display:none;
}
#todolist .havecontrols {
	width:40px;
        float:left;
        padding:3px 1px 0px;
}
#todolist small {
display:none;
color:#ff0000;
clear:both;
}
</style>{/literal}
<div class="blu">
<strong>添加新的任务:</strong>
For: <select id="to_who" class="inp">
	<option value="Me">仅自己</option>
	<option value="All">所有人</option>
</select>
Todo:
<input id="description" class="inp" style="width:300px"/>
<a href="#" onclick="return addTask()" class="savebtn" style="display:inline-block !important;margin-left:-20px;">保存</a>
</div>
<div id="todolist">
{include file=ajax.default.tpl}
</div>