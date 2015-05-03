{if $action=='assigntask' || ($action=='taskdetails' && $task.id) }{literal}

<style type="text/css">
    #msgcomposer input, #msgcomposer select, #msgcomposer textarea {
        float:none !important;
        clear:none !important;
        margin:auto !important;
    }
    .pricingtable input {
        float:none !important;
        margin:0px !important;
    }
    .modernfacebox .form input,   .modernfacebox .form select {
    margin: 2px 0 20px 10px !important;
}
</style>
<script type="text/javascript">

    function wbw(val) {
        $('#what_before, #what_after').hide();
        $('#what_'+val).show();
        if(val=='before') {
            if($('#interval_type').val()=='MINUTE')
                $('#interval_type').val('HOUR');
            $('#interval_type option:eq(2)').hide();
        } else {
            $('#interval_type option:eq(2)').show();
        }
    }
       
    function saveChangesTask() {
        $('.spinner','#facebox').show();
        ajax_update('index.php?cmd=tasklist&x='+Math.random(),$('#saveform').serializeObject(),function(){
            refreshTaskView($('#saveform').find('input[name=product_id]').val());
            $(document).trigger('close.facebox');
        });
    }
    function changeTaskType(taskid,place) {
        $('#msgcomposer').html('').show();
        if(taskid==0) {
            $('#taskoptions').hide();
            $('#usepredefined','#facebox').show();
            $('#savechanges','#facebox').hide();
            return false;
        }
        $('#savechanges','#facebox').show();
        $('#usepredefined','#facebox').hide();
        $('.spinner','#facebox').show();
        $.post('?cmd=tasklist&action=taskdetails',{task:taskid,place:place},function(data){
            var d= parse_response(data);
            $('.spinner','#facebox').hide();
            if(typeof(d)=='string') {
                $('#taskoptions').html(d).show();
            }
        });
    }
    function composemsg(href) {
        $('#msgcomposer').html('').show();
        ajax_update(href,false,'#msgcomposer');
    }
</script>
{/literal}{/if}{if $cmd=='services' || $action=='getproducttasks'}
{if $tasks}
<b>自定义自动化任务: </b>
<div class="p5">
    <table width="100%" cellspacing="0" cellpadding="6" border="0">

        {foreach from=$tasks item=task}
        <tr  class="havecontrols"><td width="60">
                <div style="padding:10px 0px;"><a href="#"  class="menuitm menuf" title="{$lang.Edit}" onclick="return TaskDetails({$task.id},{$product_id});" style="width:14px;"><span class="editsth"></span></a><!--
							--><a  href="#" class="menuitm menul" title="{$lang.Remove}"  onclick="return removeTask({$product_id},{$task.id});"><span class="delsth"></span></a>


                </div>
            </td>
            <td align="left">
                {$task.interval} {if $task.interval_type=='DAY'}{$lang.days}{elseif $task.interval_type=='MINUTE'}{$lang.minutes}{else}{$lang.hours}{/if} {if $lang[$task.when]}{$lang[$task.when]}{else}{$task.when}{/if} {if $lang[$task.event]}{$lang[$task.event]}{else}{$task.event}{/if}
                -
                {if $task.action_config.email_id}<a href="?cmd=emailtemplates&action=edit&id={$task.action_config.email_id}" target="_blank">{/if}
                    {if $task.langid} {$lang[$task.langid]}{elseif $task.name}{$task.name} {else}{$task.task}{/if}
                    {if $task.action_config.email_id}</a>{/if}
            </td>
        </tr>
        {/foreach}
        <tr><td colspan="2"><a id="addnew_addon_btn" onclick="return assignNewTask({$product_id});" class="new_control" href="#"><span class="addsth">添加新的自定义任务</span></a></td></tr>
    </table>
</div>
{/if}
<script type="text/javascript">

    {literal}
    var HBTasklist={};
    HBTasklist.place = {/literal}"{$place}"{literal};
    HBTasklist.pid = {/literal}"{$product_id}"{literal};
    function assignNewTask(pid,place) {
        if(!place || place==undefined)
            place=HBTasklist.place;
        $.facebox({ ajax: "?cmd=tasklist&action=assigntask&product_id="+pid+"&place="+place,width:900,nofooter:true,opacity:0.8,addclass:'modernfacebox' });
        return false;
    }
    function TaskDetails(id,pid) {
        $.facebox({ ajax: "?cmd=tasklist&action=taskdetails&id="+id+'&product_id='+pid,width:900,nofooter:true,opacity:0.8,addclass:'modernfacebox' });
        return false;
    }
    function removeTask(pid,id) {
        if(confirm("{/literal}{$lang.task_remove_confirm}{literal}"))
            ajax_update('index.php?cmd=tasklist&action=getproducttasks',{product_id:pid,make:'removetask',task:id,place:HBTasklist.place},"#tasklistloader");
        return false;
    }
		
    function refreshTaskView(pid) {
        ajax_update('index.php?cmd=tasklist&action=getproducttasks',{product_id:pid,place:HBTasklist.place},"#tasklistloader");
    }
    {/literal}
</script>
{elseif $action=='taskdetails' && $task}
{if $task.id}

<div id="formcontainer">
    <div id="formloader" style="background:#fff;padding:10px;">
        <form action="" method="post" id="saveform">
            <input type="hidden" name="product_id" value="{$product_id}"/>
            <input type="hidden" name="make" value="savechanges" />
            <input type="hidden" name="action" value="savetask" />
            <input type="hidden" name="id" value="{$task.id}" />
            <div class="tabb">
                <h3 style="margin:0px;">编辑任务: {$task.name}</h3>
                <div class="clear"></div>

                <div class="form" style="margin:10px 0px">

                    <label class="nodescr">任务:</label>
                    <input type="text" disabled="disabled" value="{if $task.langid}{$lang[$task.langid]}{else}{$task.name}{/if}" class="w250" />

                    <div class="clear"></div>
                    {/if}
                    {if $task.description}<div class="clear" style="padding: 5px 0px 15px 160px;font-size:11px;color:#707070">{$task.description}</div>{/if}
                    <label class="nodescr">运行</label>
                    <input name="days" size="2" value="{if $task.interval}{$task.interval}{else}1{/if}" type="text"  />
                    <select name="interval_type" id="interval_type">
                        <option value="DAY" {if $task.interval_type=='DAY'}selected="selected"{/if}>{$lang.days}</option>
                        <option value="HOUR" {if $task.interval_type=='HOUR'}selected="selected"{/if}>{$lang.hours}</option>
                        <option value="MINUTE" {if $task.interval_type=='MINUTE'}selected="selected"{/if} {if $task.when=='before' or !$task.id}style="display:none"{/if}>{$lang.minutes}</option>
                    </select>
                    <select name="when" onchange="wbw($(this).val())">
                        {if $task.havebefore} <option value="before" {if $task.when=='before'}selected="selected"{/if}>{$lang.before}</option>{/if}
                        {if $task.haveafter}  <option value="after" {if $task.when=='after'}selected="selected"{/if}>{$lang.after}</option>{/if}
                    </select>
                    {if $task.havebefore}
                    <select name="what_before" id="what_before" {if $task.when=='after'}style='display:none'{/if}>
                            {foreach from=$task.events item=event key=eventname}
                            {if $event.before} <option value="{$eventname}" {if $eventname==$task.event}selected="selected"{/if}>{if $lang[$eventname]}{$lang[$eventname]}{else}{$eventname}{/if}</option>{/if}
                        {/foreach}
                    </select>
						{/if}
                    {if $task.haveafter}
                    <select name="what_after" id="what_after"  {if $task.havebefore && $task.when!='after'}style="display:none"{/if}>
                            {foreach from=$task.events item=event key=eventname}
                            {if $event.after} <option value="{$eventname}" {if $eventname==$task.event}selected="selected"{/if}>{if $lang[$eventname]}{$lang[$eventname]}{else}{$eventname}{/if}</option>{/if}
                        {/foreach}
                    </select>
						{/if}
                    <div class="clear"></div>

                    {foreach from=$task.config item=conf key=k}
                    <label class="nodescr">{$conf.name}</label>
                    {if $k=='email_id'}

                    <div id="new_taskmail_msg"><select name="config[email_id]"  >
                            {foreach from=$conf.default.All item=email}
                            <option value="{$email.id}" {if $conf.value==$email.id}selected="selected"{/if}>{$email.tplname}</option>
                            {/foreach}
                        </select></div>
                    <div class="left" style="padding-top:7px">
                        <span class="orspace">{$lang.Or} </span>
                        <a href="?cmd=emailtemplates&action=add&inline=true&to=new_taskmail&dontclose=true" class="new_control colorbox"  target="_blank" onclick="composemsg($(this).attr('href'));return false;"><span class="addsth" >{$lang.composenewmsg}</span></a>

                    </div>


                    {else}
						{if $conf.type=='select'}
                    <select name="config[{$k}]"  >
                        {foreach from=$conf.default item=i}
                        <option  {if $conf.value==$i}selected="selected"{/if}>{$i}</option>
                        {/foreach}
                    </select>
						{elseif $conf.type=='loadable'}
                    <select name="config[{$k}]"  >
                        {foreach from=$conf.default item=i}
                        <option value="{if $i.id}{$i.id}{else}{$i.name}{/if}"  {if $conf.value==$i.id}selected="selected"{/if}>{if $i.name}{$i.name}{/if}</option>
                        {/foreach}
                    </select>
						{elseif $conf.type=='textarea'}
                    <textarea name="config[{$k}]"  style="width:600px" rows="6">{$conf.value}</textarea>
						{elseif $conf.type=='input'}
                    <input name="config[{$k}]" class="w250" rows="6" value="{$conf.value}" type="text" />

						{/if}

                    {/if}
                    <div class="clear"></div>
                    {/foreach}



                    {if $task.id}
                </div></div>{securitytoken}</form><div id="msgcomposer"></div></div>
    <div class="dark_shelf dbottom">
        <div class="left spinner"><img src="ajax-loading2.gif"></div>
        <div class="right">
            <span id="savechanges" >
                <span class="bcontainer " ><a class="new_control greenbtn" href="#" onclick="saveChangesTask(); return false"><span><b>{$lang.savechanges}</b></span></a></span>
                <span >{$lang.Or}</span>
            </span>
            <span class="bcontainer"><a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');return false;"><span>{$lang.Close}</span></a></span>
        </div>
        <div class="clear"></div>
    </div>
</div>

{/if}

{elseif $action=='assigntask'}
<div id="formcontainer">
    <div id="formloader" style="background:#fff;padding:10px;">
        <form action="" method="post" id="saveform">
            <input type="hidden" name="product_id" value="{$product_id}"/>
            <input type="hidden" name="make" value="savechanges" />
            <input type="hidden" name="action" value="savetask" />
            <input type="hidden" name="id" value="{$task.id}" />
            <input type="hidden" name="place" value="{$place}" />
            <div class="tabb">
                <h3 style="margin:0px;">创建新的自定义自动化任务</h3>
                <div class="clear"><small>要对某些事件自动执行, 您可以安排任何任务</small></div>

                <div class="form" style="margin:10px 0px">

                    <label class="nodescr">任务:</label>
                    <select class="w250" name="task" onchange="changeTaskType($(this).val(),'{$place}');" >
                        <option value="0">选择任务类型</option>
                        {foreach from=$tasks item=task key=k}
                        <option value="{$k}">{if $task.langid}{$lang[$task.langid]}{else}{$task.name}{/if}</option>
                        {/foreach}
                    </select>
                    <div class="clear"></div>
                    <div id="taskoptions" style="display:none">

                    </div>
				{if $premade}	<div id="usepredefined" class="shownice" style="padding:5px 0px">
                        <div class="clear"></div><label>预设任务<small>为了节省配置时间, 您可以使用预设任务</small></label>
                        <select onchange="$('#savechanges').hide(); if($(this).val()=='1')$('#loadurl').show();else if($(this).val()=='0') $('#loadurl').hide(); else {literal}{ $('#loadurl').hide(); $('#savechanges').show(); }{/literal}" id="premade_val" style="width:120;margin-right:10px;" name="premade">
                            <option value="0">无</option>
                            <!--<option style="font-weight:bold" value="1">Load from URL</option>-->
						{foreach from=$premade item=p}
                            <option value="{$p.file}">{$p.name}</option>
						{/foreach}
                        </select>
                        <div class="fs11" style="padding: 2px ">
                            <!--
						<strong>您还可以在这里找到其他的预设任务:</strong>
						<a class="external" target="_blank" href="http://hostbillapp.com/fastconfig/forms/">http://hostbillapp.com/fastconfig/forms/</a>
						-->
                        </div>
                        <div class="clear"></div>
                        <div style="display:none" id="loadurl">
                            <label>Step 1. <small>粘贴 <a target="_blank" href="http://hostbillapp.com/fastconfig/forms/">配置URL</a></small></label>
                            <input type="text" id="premadeurl_val" name="premadeurl" class="w250"><div class="clear"></div>
                            <label>Step 2. <small>提交并确认设置</small></label>
                            <div class="left" style="margin:2px 10px">
                                <span class="bcontainer dhidden" style=""><a class="new_control greenbtn" href="#" onclick="return createField()"><span>创建新任务</span></a></span>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </div>{/if}
                </div>
            </div>

            {securitytoken}</form>

        <div id="msgcomposer"></div>


    </div>
    <div class="dark_shelf dbottom">
        <div class="left spinner"><img src="ajax-loading2.gif"></div>
        <div class="right">
            <span id="savechanges" style="display:none">
                <span class="bcontainer " ><a class="new_control greenbtn" href="#" onclick="saveChangesTask(); return false"><span><b>{$lang.addnewtask}</b></span></a></span>
                <span >{$lang.Or}</span>
            </span>
            <span class="bcontainer"><a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');return false;"><span>{$lang.Close}</span></a></span>
        </div>
        <div class="clear"></div>
    </div>

</div>
{/if}