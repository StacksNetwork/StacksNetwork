{if !$frontpage}

{else}
<h3>计划任务插件</h3>
{/if}
<div id="tdcont">
{if $todo}


{foreach from=$todo item=task}
<div class="task ti_{$task.id}">
<div class="havecontrols">

	<div class="controls">	
		{if $task.addwho==$task.me}<a class="editbtn" href="#"  onclick="return showEditor(this)">编辑</a> 
		<a class="delbtn" href="#" onclick="return deleteMe({$task.id})">删除</a>{/if}
	</div>	
</div>
<div class="ittem">
	<input type="checkbox" {if $task.status=='Done'}checked="checked"{/if} onclick="return markMe(this)" id="{$task.id}" style="float:left"/>
	<div class="descript">{if $task.status=='Done'}<span class="done">{/if}{$task.description}{if $task.status=='Done'}</span>{/if} <small>添加人 {if $task.addwho==$task.me}我{else}{$task.headdit}{/if} {if $task.status=='Done'}Completed by {if $task.didwho==$task.me}me{else}{$task.hedidit}{/if}{/if}</small></div>
	<div class="editor">
		<input class="descr1 inp" value="{$task.description}"/> <a href="#" onclick="return editTask({$task.id})" class="savebtn">保存</a>
	</div>
</div>
</div>
{/foreach}
<script type="text/javascript">{literal}
$('.task').hover(function(){
$(this).find('.controls').show();
$(this).addClass('hover');
$(this).find('small').show();
},function(){$(this).find('.controls').hide();$(this).removeClass('hover');$(this).find('small').hide();});
{/literal}</script>

{/if}


{if $frontpage}
<a href="#" onclick="$('#addnewtask').slideDown();return false;"><strong>+ 添加新任务</strong></a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="?cmd=module&module={$moduleid}">更多任务</a>
<div id="addnewtask">
<strong>添加新任务:</strong>
For: <select id="to_who" class="inp">
	<option value="Me">仅自己</option>
	<option value="All">所有人</option>
</select>
Todo:
<input id="description" class="inp"/>
<a href="#" onclick="return addTask()" class="savebtn">保存</a></div>
{/if}
</div>
