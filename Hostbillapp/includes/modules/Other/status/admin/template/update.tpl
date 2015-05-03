<link media="all" rel="stylesheet" href="{$moduleurl}css/jquery.timepicker.css" />
<link media="all" rel="stylesheet" href="{$moduleurl}css/styles.css" />
<script type="text/javascript" src="{$moduleurl}js/jquery.timepicker.min.js" ></script>
<script type="text/javascript" src="{$moduleurl}js/script.js" ></script>
<script type="text/javascript">
    var __dateformat = "{$date_format}";
    __status_update()
</script>

<div id="newshelfnav" class="newhorizontalnav">
    <div class="list-1">
        <ul>
            <li>
                <a href="?cmd=status"><span>网络维护</span></a>
            </li>
            <li>
                <a href="?cmd=status&action=edit&id={$entry.id}"><span>{$entry.name}</span></a>
            </li>
            <li class="active last">
                <a href="#"><span>状况更新</span></a>
            </li>
        </ul>
    </div>
</div>

<form method="post" action="?cmd=status&action={$action}" id="status_plugin" >
    <input type="hidden" name="id" value="{$entry.id}"/>
    <input type="hidden" name="update" value="1"/>
    <table cellpadding="5" style="width: 100%">
        <tr>
            <td ><label>日期</label> 
            <td class="datepickers">
                <input type="text" value="{$entry.date|dateformat:$date_format}" name="date" class="inp haspicker" placeholder="eg. {"2014-05-16"|dateformat:$date_format}">
                <input type="text" value="{$entry.time}" name="time" class="inp timepicker" placeholder="eg. 01:35">
            </td>
        </tr>
        <tr>
            <td ><label>情况</label></td>
            <td>
                <select name="status" class="inp">
                    <option {if $entry.status == "Scheduled"}selected="selected"{/if} value="Scheduled">计划内</option>
                    <option {if $entry.status == "InProgress"}selected="selected"{/if} value="InProgress">处理中 </option>
                    <option {if $entry.status == "Cancelled"}selected="selected"{/if} value="Cancelled">Cancelled </option>
                    <option {if $entry.status == "ResolvedFaultIssue"}selected="selected"{/if} value="ResolvedFaultIssue">已解决故障/问题</option>
                    <option {if $entry.status == "CompletedMaintenance"}selected="selected"{/if} value="CompletedMaintenance">完成维护</option>
                    <option {if $entry.status == "Finished"}selected="selected"{/if} value="Finished">已完成</option>
                </select>
            </td>
        </tr>
        <tr>
            <td ><label>说明</label></td>
            <td >
                <textarea name="description" class="inp">{$entry.description}</textarea>
            </td>
        </tr>
        {if $ticketsno}
            <tr>
                <td ><label>更新服务工单</label></td>
                <td>
                    <input type="checkbox" {if $entry.notify}checked="checked"{/if} name="notify" class="inp" onchange="if ($(this).is(':checked'))
                $(this).parents('tr').eq(0).nextAll('tr').show();
            else
                $(this).parents('tr').eq(0).nextAll('tr').hide();"/>
                    使用服务工单通知受影响客户, {$ticketsno} 工单将被更新
                    <a href="#" class="vtip_description" 
                       title="一旦启用客户可以在服务工单上看到更新的说明"></a>
                </td>
            </tr>
        {/if}
    </table>
    <div class="clearfix">
        <button type="submit">保存更改</button>
    </div>
</form>