<div class="odesc_ odesc_single_vm pdx">在这里您将提供限制客户虚拟机的配置</div>
<div class="odesc_ odesc_cloud_vm pdx">在这里您将提供限制客户的资源配置</div>
<table border="0" cellspacing="0" cellpadding="6" width="100%" >
    <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> 从项目的获取数据, 请稍候...</td></tr>

    <tr>
        <td width="160"><label >区域</label></td>
        <td ><div id="option23container" class="tofetch"><select name="options[option23][]" id="option23" multiple="multiple" class="multi">
                    <option value="Auto-Assign" {if in_array('Auto-Assign',$default.option23)}selected="selected"{/if}>自动分配</option>
                    {foreach from=$default.option23 item=vx}
                        {if $vx=='Auto-Assign'}{continue}
                        {/if}
                        <option value="{$vx}" selected="selected">{$vx}</option>
                    {/foreach} 
                </select></div><div class="clear"></div>
            <span class="fs11"> <input type="checkbox" class="formchecker"  rel="hypervisorzone" />允许在客户在结帐选择</span>
        </td>
    </tr>
    <tr class="odesc_">
        <td width="160"><label >最大的虚拟机</label></td>
        <td><input type="text" size="3" name="options[option14]" value="{$default.option14}" id="option14"/></td>
    </tr>

</table>
<div class="nav-er"  id="step-2">
    <a href="#" class="prev-step">上一步</a>
    <a href="#" class="next-step">下一步</a>
</div>