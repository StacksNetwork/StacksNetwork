<h3>输入快速修复会直接跳转到更新日志页面</h3>

<label class="nodescr">修正版本:</label>

<input type="text" name="version" value="{$bug.version}" style="width:50px;" />


<div class="clear"></div>


 <label class="nodescr">分类</label>
 <select name="category_id" class="w250" >
    {foreach from=$categories item=category}
            <option value="{$category.id}" {if $category.id==$bug.category_id}selected="selected"{/if}>{$category.name}</option>
    {/foreach}
</select>
<div class="clear"></div>

<label class="nodescr">主题</label>
<input type="text" name="subject" value="{$bug.subject}" style="width:450px;"  />
<div class="clear"></div>
