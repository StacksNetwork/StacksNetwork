<link media="all" rel="stylesheet" href="{$moduleurl}css/jquery.timepicker.css" />
<link media="all" rel="stylesheet" href="{$moduleurl}css/styles.css" />
<script type="text/javascript" src="{$moduleurl}js/jquery.timepicker.min.js" ></script>
<script type="text/javascript" src="{$moduleurl}js/script.js" ></script>
<script type="text/javascript">
    var __dateformat = "{$date_format}";
    __status_add_edit()
</script>

<div id="newshelfnav" class="newhorizontalnav">
    <div class="list-1">
        <ul>
            <li class="{if $action == 'default'}active{/if}">
                <a {if $action != 'default'} href="?cmd=status"{/if}><span>网络维护</span></a>
            </li>
            {if $action == 'edit'}
                <li class="active last">
                    <a href="#"><span>{$entry.name|truncate}</span></a>
                </li>
            {else}
                <li class="{if $action == 'add'}active last{/if}">
                    <a {if $action != 'add'}href="?cmd=status&action=add"{/if}><span>新维护</span></a>
                </li>
            {/if}
        </ul>
    </div>
    {if $action == 'edit'}
        <div class="list-2">
            <div class="subm1 haveitems" style="display: block;">
                <ul>
                    <li>
                        <a href="?cmd=status&action=update&id={$entry.id}"><span>添加新的维护数据</span></a>
                    </li>
                </ul>
            </div>
        </div>
    {/if}
</div>
<form method="post" action="?cmd=status&action={$action}" id="status_plugin" >
    {if $action=="edit"}
        <input type="hidden" name="id" value="{$entry.id}"/>
        <input type="hidden" name="edit" value="1"/>
    {else}
        <input type="hidden" name="add" value="1"/>
    {/if}
    <table cellpadding="5" style="width: 100%">
        <tr>
            <td ><label>命名/主题</label></td>
            <td><input type="text" value="{$entry.name}" name="name" class="inp" /></td>
        </tr>
        <tr>
            <td ><label>日期</label> 
            <td>
                <input type="text" value="{$entry.date|dateformat:$date_format}" name="date" class="haspicker inp" placeholder="eg. {"2014-05-14"|dateformat:$date_format}" />
            </td>
        </tr>
        <tr>
            <td ><label>情况</label></td>
            <td>
                <select name="status" class="inp">
                    <option {if $entry.status == "Scheduled"}selected="selected"{/if} value="Scheduled">计划内</option>
                    <option {if $entry.status == "InProgress"}selected="selected"{/if} value="InProgress">处理中 </option>
                    <option {if $entry.status == "Cancelled"}selected="selected"{/if} value="Cancelled">已取消 </option>
                    <option {if $entry.status == "ResolvedFaultIssue"}selected="selected"{/if} value="ResolvedFaultIssue">已解决故障/问题</option>
                    <option {if $entry.status == "CompletedMaintenance"}selected="selected"{/if} value="CompletedMaintenance">完成维护</option>
                    <option {if $entry.status == "Finished"}selected="selected"{/if} value="Finished">已完成</option>
                </select>
            </td>
        </tr>
        <tr>
            <td ><label>开始时间</label></td>
            <td class="datepickers">
                <input type="text" value="{$entry.startdate|dateformat:$date_format}" name="startdate" class="inp haspicker" placeholder="eg. {"2014-05-15"|dateformat:$date_format}">
                <input type="text" value="{$entry.start}" name="start" class="inp timepicker" placeholder="eg. 21:35">
            </td>
        </tr>
        <tr>
            <td ><label>完成时间</label></td>
            <td class="datepickers">
                <input type="text" value="{$entry.enddate|dateformat:$date_format}" name="enddate" class="inp haspicker" placeholder="eg. {"2014-05-16"|dateformat:$date_format}">
                <input type="text" value="{$entry.end}" name="end" class="inp timepicker" placeholder="eg. 01:35">
            </td>
        </tr>
        <tr>
            <td ><label>说明</label></td>
            <td >
                <textarea name="description" class="inp">{$entry.description}</textarea>
            </td>
        </tr>
        <tr>
            <td ><label>相关服务信息</label></td>
            <td>
                <textarea name="relatedinfo" class="inp">{$entry.relatedinfo}</textarea>
            </td>
        </tr>
        {if $action=="add"}
            <tr>
                <td ><label>通知</label></td>
                <td>
                    <input type="checkbox" {if $entry.notify}checked="checked"{/if} name="notify" class="inp" onchange="if ($(this).is(':checked'))
                $(this).parents('tr').eq(0).nextAll('tr').show();
            else
                $(this).parents('tr').eq(0).nextAll('tr').hide();"/>
                    通知受影响客户使用支持工单
                    <a href="#" class="vtip_description" 
                       title="一旦启用后客户界面将会自动开启一份服务工单, 并在维护完成后自动关闭"></a>
                </td>
            </tr>
            <tr {if !$entry.notify}style="display: none;"{/if}>
                <td ><label>相关的服务</label></td>
                <td>
                    <select id="servers" multiple="multiple" name="servers[]" class="inp">
                        {foreach from=$servers item=category}
                            <optgroup label="{$category.name}">
                                {foreach from=$category.servers item=server}
                                    <option value="{$server.id}"  {if in_array($server.id,$entry.servers)}selected="selected"{/if}>{$server.name}</option>
                                {/foreach}
                            </optgroup>
                        {foreachelse}
                            <option value="">{$lang.none}</option>
                        {/foreach}
                    </select>
                </td>
            </tr>
            <tr {if !$entry.notify}style="display: none;"{/if}>
                <td ><label>相关的产品</label></td>
                <td>
                    <select id="products" multiple="multiple" name="products[]" class="inp">
                        {foreach from=$products item=category}
                            <optgroup label="{$category.name}">
                                {foreach from=$category.products item=product}
                                    <option value="{$product.id}" {if in_array($product.id,$entry.products)}selected="selected"{/if}>{$product.name}</option>
                                {/foreach}
                            </optgroup>
                        {foreachelse}
                            <option value="">{$lang.none}</option>
                        {/foreach}
                    </select>
                </td>
            </tr>
            <tr {if !$entry.notify}style="display: none;"{/if}>
                <td ><label>服务支持中心</label></td>
                <td>
                    <select name="department" class="inp">
                        {foreach from=$departments item=dept}
                            <option value="{$dept.id}" {if in_array($dept.id,$entry.department)}selected="selected"{/if}>{$dept.name}</option>
                        {/foreach}
                    </select>
                </td>
            </tr>
            <tr {if !$entry.notify}style="display: none;"{/if}>
                <td ><label>服务工单模板</label></td>
                <td>
                    <select name="meta[template_id]" class="inp">
                        {foreach from=$emails item=email}
                            <option value="{$email.id}" {if $email.tplname == '工单: 管理员通知'}selected="selected"{/if}>{$email.tplname}</option>
                        {/foreach}
                    </select>
                    <div style="background: #EBEBEB; color: #7F7F7F; font-size: 11px; padding: 2px 5px; width: 345px; margin-top: 0.5em">
                    选择电子邮件模板将包含下述变量:<br />
                    {literal}- {$status.name}<br />
                        - {$status.startdate}<br />
                        - {$status.enddate}<br />
                        - {$status.description}<br />
                        - {$status.relatedinfo}<br />
                    {/literal}
                    </div>
                </td>
            </tr>
        {elseif $updates}
            <tr>
                <th>以往的维护数据</th>
                <th></th>
            </tr>
            {foreach from=$updates item=update}
                <tr class="update-row havecontrols">
                    <td>
                        <input type="hidden" name="updates[]" value="{$update.id}">
                        <a title="删除" class="delbtn" 
                           href="#" 
                           onclick="if (confirm('您确定要删除该维护数据?'))
                $(this).parents('tr').eq(0).remove();
            return false;"
                           style="display: inline-block">
                        </a>
                        {$update.date|dateformat:$date_format}
                    </td>
                    <td>
                        {$update.description}
                    </td>
                </tr>
            {/foreach}
        {/if}
    </table>
    <div class="clearfix">
        <button type="submit">保存更改</button>
    </div>
    {securitytoken}
</form>