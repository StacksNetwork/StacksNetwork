{if $do=='itemadder'}
{include file='ajax.additem.tpl'}
{elseif $do=='inventory' && $subdo=='category'}

<label class="nodescr">添加物品至:</label>
<select name="type_id" class="w250" onchange="loadItemEditor(this)" >
    <option value="0">选择物品来自分类 {$category.name}</option>
    {foreach from=$items item=c}
    <option value="{$c.id}">{$c.name}</option>
    {/foreach}

</select>
{elseif $do=='itemeditor'}
{include file='ajax.edititem.tpl'}
{/if}