<h3>关闭该内容, 设置为已解决或没有问题</h3>


<label>已解决: <small>可选, 版本编号</small></label>
<input type="text" name="resolved_version" value="{$bug.resolved_version}" />
<div class="clear"></div>

 <label class="nodescr">状态</label>
 <select name="status" class="w250" >
            <option value="Open" {if $bug.status=='Open'}selected="selected"{/if}>进行中</option>
            <option value="Resolved" {if $bug.status=='Resolved'}selected="selected"{/if}>已解决</option>
            <option value="Not-A-Bug" {if $bug.status=='Not-A-Bug'}selected="selected"{/if}>非Bug</option>
</select>
<div class="clear"></div>

<label>工作人员的评论 <small>可选</small></label>
<div class="w250 left" style="clear: right; margin: 2px 0px 10px 10px;">
    <textarea name="admin_comment" class="inp " cols="" rows="" style="margin:0px;width:450px;height:100px;" >{$bug.admin_comment}</textarea>
</div>
<div class="clear"></div>