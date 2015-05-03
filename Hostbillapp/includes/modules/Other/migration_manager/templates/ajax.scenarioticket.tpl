<h3>当割接工程开始时, 为受影响的客户开启一份服务工单</h3>


<label >开启一份服务工单 <small>当割接工程开始时 </small></label>
<input type="checkbox"  name="ticket" value="1" {if $scenario.ticket=='1'}checked="checked"{/if} />
<div class="clear"></div>

<label class="nodescr">部门</label>
<select name="ticket_department">
    {foreach from=$departments item=d key=k}
        <option value="{$k}" {if $k==$scenario.ticket_department}selected="selected"{/if}>{$d}</option>
        {/foreach}
</select>
<div class="clear"></div>



    <label class="nodescr">工单主题</label>
    <input type="text"  style="width:450px" class="w250" name="ticket_subject" value="{$scenario.ticket_subject}" />
    <div class="clear"></div>
    
    
    <label class="nodescr">工单内容</label>
    <textarea name="ticket_body" class="inp" cols="" rows="" style="width:450px;height:150px;">{$scenario.ticket_body}</textarea>
    <div class="clear"></div>