<h3>完成设备的调试, 提供给目标客户, 更新配件的对应设备位置</h3>

<label >勾选标记为已交付</label><input type="checkbox" name="deliver" value="1" ><div class="clear"></div>
<label class="nodescr">分配到该帐户:</label><select name="account_id" class="w250">
    <option value="0">无</option>
    {foreach from=$accounts item=acc}
        
    <option value="{$acc.id}" {if $product.account_id==$acc.id}selected="selected"{/if}>#{$acc.id} {$acc.domain}</option>
        {/foreach}
</select><div class="clear"></div>

<label >新配件位置 <small>如果您想提供该配件您可以从设备上找到, 它们将位于 (ie. which DC/Room/Row/Rack/U)</small></label>
<div class="w250 left" style="clear: right; margin: 2px 0px 10px 10px;">
<textarea name="new_location" class="inp" cols="" rows="" style="margin:0px;width:450px;height:150px;"></textarea>
</div>
<div class="clear"></div>