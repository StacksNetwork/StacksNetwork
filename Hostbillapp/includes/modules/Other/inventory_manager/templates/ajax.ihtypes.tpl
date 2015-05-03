 <label class="nodescr">配件类型</label>
    <select class="w250" name="p_ihtype" id="p_ihtype" {if $firstblank}onchange="ihtype_change($(this).val())"{/if}>
        {if $firstblank}<option value="0">选择配件类型</option>{/if}
        {foreach from=$types item=m key=l}
            <option value="{$l}">{$m}</option>
        {/foreach}
    </select>