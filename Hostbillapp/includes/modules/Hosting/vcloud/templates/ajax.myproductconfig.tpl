{if $make=='getonappval' && $valx}
    {if $valx=='role' ||  $valx=='vdc'||  $valx=='pool'}

        <select id="{$valx}" name="options[{$valx}]">
            {foreach from=$modvalues item=value}
            <option value="{$value[0]}" {if $value[0]==$defval}selected="selected"{/if}>{$value[1]}</option>
            {/foreach}
        </select>

    {/if}
{elseif $make=='importformel' && $fid}
<a href="#" onclick="return editCustomFieldForm('{$fid}','{$pid}')" class="editbtn orspace">编辑相关表单元素</a>
{if $vartype=='os'}<a href="#" onclick="return updateOSList('{$fid}')" class="editbtn orspace">从Proxmox更新模板列表</a>{/if}
<script type="text/javascript">editCustomFieldForm('{$fid}','{$pid}');</script>
{/if}