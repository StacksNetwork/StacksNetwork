<table border="0" cellspacing="0" width="100%" cellpadding="6">
    <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> 从CloudStack社区获取数据, 请稍候...</td></tr>
    <tr>
        <td width="160">
            <label>自动重置root密码</label>
        </td>
        <td>
            <input type="radio" value="1" name="options[autopass]" {if $default.autopass=='1'}checked="checked"{/if}> {$lang.yes}, 试图获得root口令立即创建虚拟机. <br />
            <input type="radio" value="0" name="options[autopass]" {if !$default.autopass || $default.autopass=='0'}checked="checked"{/if}> {$lang.no}, 客户要求手工修改密码. <br />
        </td>
    </tr>
    <tr>
        <td width="160">
            <label>动态缩放</label>
        </td>
        <td>
            <div id="dynamicscaling" class="formcheckerbox">
                <input type="radio" value="1" name="options[dynamicscaling]" {if $default.dynamicscaling=='1'}checked="checked"{/if} > 
                {$lang.yes}, 允许一个运行中的虚拟机不停机升级CPU/内存. <br />
                <input type="radio" value="0" name="options[dynamicscaling]" {if !$default.dynamicscaling || $default.dynamicscaling=='0'}checked="checked"{/if} > 
                {$lang.no}, 升级CPU /内存将重启增加资源的虚拟机. <br />
            </div>
            <span class="fs11"> <input type="checkbox" class="formchecker" rel="dynamicscaling" />允许由客户在结帐时选择</span>
        </td>
    </tr>
    <tr>
        <td><label>自定义云名称: </label></td>
        <td> 
            <span><input type="checkbox" class="formchecker" rel="cloudname"/> 启用</span>
            <a class="vtip_description" title="允许该云选择自定义名称. 这将影响域名和网络名称"></a> 
        </td>
    </tr>
    <tr><td colspan="2">&nbsp;</td></tr>

    <tr class="odesc_ odesc_cloud_vm">
        <td colspan="2" >
            <b>限制单一服务器的数据磁盘的大小: 
                <a class="vtip_description" title="您可以限制数据的最大磁盘空间, 客户端可以创建私有云. 它允许控制在客户区存储滑块"></a>
            </b>
        </td>
    </tr>
    <tr class="odesc_ odesc_cloud_vm">
        <td width="160" align="right">启用:</td>
        <td>
            <span><input type="checkbox" class="formchecker" rel="limitvmdatadisk"/></span>
        </td>
    </tr>
</table>
<div class="nav-er"  id="step-5">
    <a href="#" class="prev-step">上一步</a>
    <a href="#" class="next-step">下一步</a>
</div>