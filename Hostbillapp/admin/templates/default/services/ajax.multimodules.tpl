<table border="0" width="100%" cellpadding="6" cellspacing="0" class="module_config_tab" style="display:none" data-key="{$kl}">
    <tr>
        <td align="right"  width="160"><strong>{$lang.third_party_app}</strong></td>
        <td>
            <select name="modules[{$kl}][module]" onchange="loadMod(this)"  class="inp left modulepicker" style="width:200px;">
                <option value="0" {if !$module.module}selected="selected" {/if}>{$lang.none}</option>
                {foreach from=$modules item=mod}{if $mod.id!='-1'}
                <option value="{$mod.id}" {if $module.module==$mod.id}selected="selected" {/if}>{$mod.module}</option>{/if}
                {/foreach}
                <option value="new" style="font-weight:bold">显示未激活模块</option>
            </select>
            <a onclick="return connectMoreApps(this);" class="new_control right" href="#"><span class="addsth">连接更多Apps</span></a>

        </td>
    </tr>
    <tbody class="loadable">
        {if $module!=0}
            {include file='services/ajax.configmodule.tpl'}
        {/if}
    </tbody>
</table>