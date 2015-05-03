<label class="nodescr">受影响的服务</label>
<select name="related_account_id" >
    <option value="0">无</option>
    {foreach from=$accounts item=d key=k}
        <option value="{$d.id}" {if $d.id==$case.related_account_id}selected="selected"{/if}>#{$d.id} {$d.domain}</option>
        {/foreach}
</select>
<div class="clear"></div>