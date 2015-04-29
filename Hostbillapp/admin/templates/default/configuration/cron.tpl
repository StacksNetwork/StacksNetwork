
<div class="blu">
    <table border="0" width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td width="50%" align="left"><strong>{$lang.cronprofiles}</strong></td>
            <td width="50%" align="right"><a href="#" class="editbtn"  onclick="return addNewTask();">{$lang.addnewtask}</a></td>

        </tr>
    </table>

    {if !$running}
    <div class="imp_msg">
        <strong>{$lang.cronnotwork}</strong>
    </div>
    <p>{$lang.toenableauto}</p>


    <center>
        {$lang.createcronusing}<br/><input type="text" value="*/5 * * * * php -q {$cronpath}" readonly="readonly" size="100"/><br/>
    </center>
    {/if}
</div>
<div class="nicerblu" id="addtask" style="{if !$viewaddform}display:none;{/if}padding:15px;">
    <center>
        <form method="post" action=""><input type="hidden" name="make" value="addtask" />
            <table border="0" cellpadding="6" cellspacing="0">
                <tr>
                    

                    <td><strong>{$lang.taskname}</strong></td>
                    <td>
                        <select name="task" class="inp" id="addtasklist">
		{foreach from=$available item=cls }
                            <option value="{$cls.task}">{$cls.name}</option>
		{/foreach}
                        </select></td>

                    <td>
                        <input type="submit" value="{$lang.addnewtask}" style="font-weight:bold" class="submitme" /> <span class="orspace">{$lang.Or} <a href="#" class="editbtn" onclick="$('#addtask').slideUp();return false;">{$lang.Cancel}</a></span></td>

                </tr>
            </table>{securitytoken}</form>
    </center>
    <script type="text/javascript">{literal}
       
        function addNewTask() {
            $('#addtask').ShowNicely();
            return false;
        }{/literal}
    </script>
    <script type="text/javascript" src="{$template_dir}js/facebox/facebox.js?v={$hb_version}"></script>
    <link rel="stylesheet" href="{$template_dir}js/facebox/facebox.css" type="text/css" />
</div>

{if $tasks}
<script type="text/javascript">
    {literal}
    function execute_task(name,nicename,dbg) {
        $('#taskname span').text(nicename);
        $('#output').hide();
        $('#taskindicator').show();
        var d=0;
        if(dbg)
            d=1;
        $.facebox({ div:'#taskexec' });
        $.get("?cmd=configuration&action=executetask&task="+name,{debug:d},function(data){
            $('#facebox #output pre').text(data);
            $('#facebox #output').show();
            $('#facebox #taskindicator').hide();
            $('#taskindicator').hide()
        });
        return false;
    }
    {/literal}
</script>
<div id="taskexec" style="display:none">
    <h2 style="margin-bottom: 5px;" id="taskname">{$lang.taskrunning} <span></span></h2>
    <div id="taskindicator" style="display:none;padding:5px;text-align: center">
        <img src="ajax-loading.gif" alt="" />
    </div>
    <div id="output" style="display:none;">
        {$lang.taskoutput}
        <div class="consoleout">
            <pre>

            </pre>
        </div>
    </div>
</div>


<div id="ticketbody" style="padding:15px;">
    <table cellpadding="3" cellspacing="0" width="100%" class="whitetable" >
        <tr>
            <th>{$lang.taskname}</th>
            <th>{$lang.calledevery}</th>
            <th>{$lang.lastrunned}</th>

            <th width="20"></th><th width="20"></th>
            <th width="20"></th>
        </tr>

		{foreach from=$tasks item=task name=fr}
        <tr class="{if $smarty.foreach.fr.index%2==0}even{/if} havecontrols">
            <td style="padding-left:10px; {if $task.status=='0' }color:red{/if}">{if $task.task=='sendCronResults'}<strong>{/if}{if $lang[$task.taskname]}{$lang[$task.taskname]}{else}{$task.taskname}{/if}{if $task.task=='sendCronResults'}</strong>{/if}
                {if $task.status=='0' }<span class="fs11 editgray"><em>Recent task executions failed, task has been disabled
                        <a href="?cmd=configuration&action=cron&make=enabletask&task={$task.task}&security_token={$security_token}" class="editbtn" onclick="return confirm('Are you sure? If task is still broken it may block your other tasks')">enable</a>
                        <a href="#" class="editbtn" onclick="return execute_task('{$task.task}','{if $lang[$task.taskname]}{$lang[$task.taskname]}{else}{$task.taskname}{/if}',true);">debug</a></em></span>{/if}
            </td>
            <td>{if $task.run_every=='Run'}{$lang.every5min}{elseif $task.run_every=='Time'}{$lang.everyday} {$task.run_every_time_hrs}:{$task.run_every_time_min}{elseif $task.run_every=='Week'}{$lang.evw} {$lang[$task.day]}{elseif $task.run_every=='Month'}{$lang.evm} {$task.run_every_time}{elseif $task.run_every=='Hour'}{$lang.evh} {/if}</td>
            <td>{$task.lastrun|dateformat:$date_format}</td>
           <td><a href="" class="editbtn editgray" onclick="return execute_task('{$task.task}','{if $lang[$task.taskname]}{$lang[$task.taskname]}{else}{$task.taskname}{/if}');">{$lang.invoketask}</a></td>
            <td><a href="?cmd=configuration&action=gettask&task={$task.task}" class="editbtn" onclick="{literal}$.facebox({ ajax: '{/literal}?cmd=configuration&action=gettask&task={$task.task}{literal}' });{/literal} return false;">{$lang.Edit}</a></td>
            <td class="lastitm"><a href="?cmd=configuration&action=cron&make=deletetask&task={$task.task}&security_token={$security_token}" class="delbtn" onclick="return confirm('{$lang.delprofile}');">{$lang.Delete}</a></td>
        </tr>
		{/foreach}
        <tr>
            <th colspan="6"><a href="#" class="editbtn" onclick="return addNewTask();">{$lang.addnewtask}</a></th>

        </tr>
    </table>
</div>
{else}
<div class="blank_state blank_news">
    <div class="blank_info">
        <h1>{$lang.notasksyet}</h1>
        <div class="clear"></div>

        <a class="new_add new_menu" href="#" style="margin-top:10px"  onclick="return addNewTask();">
            <span>{$lang.addnewtask}</span></a>
        <div class="clear"></div>

    </div>
</div>

{/if}

