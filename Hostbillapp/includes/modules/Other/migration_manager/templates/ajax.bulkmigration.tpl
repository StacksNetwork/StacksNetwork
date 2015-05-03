<h3>割接路线图应用工具</h3>

<label class="nodescr" >割接方案</label>
<select name="scenario" class="w250">
    {foreach from=$scenarios item=d key=k}
        <option value="{$k}" >{$d}</option>
        {/foreach}
</select>

<div class="clear"></div>

<label >受影响的应用/功能 <small>该应用/功能的所有关联活动的帐户将受割接工程影响</small></label>
<select name="server" class="w250">
    <option value="0">无对应应用/功能</option>
    {foreach from=$servers item=d key=k}
        <option value="{$d.id}" >{$d.groupname} {$d.name}</option>
        {/foreach}
</select>
<div class="clear"></div>


<label >或者受影响的产品 <small>购买并正在使用该产品的所有关联活动的帐户将受割接工程影响</small></label>
<select name="package"  class="w250">
    <option value="0">无对应的产品</option>
    {foreach from=$products item=d key=k}
        <option value="{$d.id}" >{$d.catname} - {$d.name}</option>
        {/foreach}
</select>


<div class="clear"></div>



<label >割接工程相关责任人 <small>所选人数大于1时, 将自动平均分配到各进程中</small></label>
{foreach from=$staff  item=d key=k}
<input type="checkbox" name="staff[]" value="{$k}" style="margin-right:10px" /> {$d} <br/>
{/foreach}


<div class="clear"></div>


<label class="nodescr">实施日期</label>
<input type="text" name="date_scheduled_d" value="" class="haspicker "><div class="clear"></div>


<label >实施时间 <small>HH:MM</small></label>
<input type="text" name="date_scheduled_h" value="12:00" class=""><div class="clear"></div>
