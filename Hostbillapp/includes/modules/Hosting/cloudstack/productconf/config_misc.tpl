<table border="0" cellspacing="0" width="100%" cellpadding="6">
    <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from CloudStack, please wait...</td></tr>
    <tr>
        <td width="160">
            <label>Auto reset root pasword</label>
        </td>
        <td>
            <input type="radio" value="1" name="options[autopass]" {if $default.autopass=='1'}checked="checked"{/if}> {$lang.yes}, try to obtain root password for VM as soon as it is created. <br />
            <input type="radio" value="0" name="options[autopass]" {if !$default.autopass || $default.autopass=='0'}checked="checked"{/if}> {$lang.no}, clients should request root password manualy. <br />
        </td>
    </tr>
    <tr>
        <td width="160">
            <label>Dynamic Scaling</label>
        </td>
        <td>
            <div id="dynamicscaling" class="formcheckerbox">
                <input type="radio" value="1" name="options[dynamicscaling]" {if $default.dynamicscaling=='1'}checked="checked"{/if} > 
                {$lang.yes}, allows updating CPU/RAM for a running VM avoiding any downtime. <br />
                <input type="radio" value="0" name="options[dynamicscaling]" {if !$default.dynamicscaling || $default.dynamicscaling=='0'}checked="checked"{/if} > 
                {$lang.no}, updating CPU/RAM will restart the VM with increased resources. <br />
            </div>
            <span class="fs11"> <input type="checkbox" class="formchecker" rel="dynamicscaling" />Allow to select by client during checkout</span>
        </td>
    </tr>
    <tr class="odesc_ odesc_cloud_vm">
        <td><label>Custom Cloud Name: </label></td>
        <td> 
            <span><input type="checkbox" class="formchecker" rel="cloudname"/> Enable</span>
            <a class="vtip_description" title="Allow selecting custom name for this cloud. This will affect domain and network name"></a> 
        </td>
    </tr>
    <tr class="odesc_ odesc_single_vm">
        <td>
            <label>Reinstall space limit: </label>
        </td>
        <td> 
            <input type="radio" value="1" name="options[limreinstalldisk]" {if $default.limreinstalldisk=='1'}checked="checked"{/if} > 
                {$lang.yes}, customers won't be able to use templates with more disk space than their current one. <br />
                <input type="radio" value="0" name="options[limreinstalldisk]" {if !$default.limreinstalldisk || $default.limreinstalldisk=='0'}checked="checked"{/if} > 
                {$lang.no}, customers can resinstall using any template. <br />
            
        </td>
    </tr>

    <tr><td colspan="2">&nbsp;</td></tr>

    <tr class="odesc_ odesc_cloud_vm odesc_single_vm">
        <td colspan="2" ><b>Limit single server data disk size: 
                <a class="vtip_description" title="You can limit maximum data disk space client can create for single machine in his cloud. It allows controll over storage slider in client area"></a>
            </b>
        </td>
    </tr>
    <tr class="odesc_ odesc_cloud_vm ">
        <td width="160" align="right">Enable:</td>
        <td>
            {if $default.sw_limitvmdatadisk!=''}
                {* DEPRECATED - BACKWARD COMPATIBILITY *}
                <span class="formcheckerbox">
                    <input type="checkbox" {if $default.sw_limitvmdatadisk!=''}checked="checked"{/if} name="options[sw_limitvmdatadisk]" value="1" />
                    <input type="text" size="3" name="options[limitvmdatadisk]" value="{$default.limitvmdatadisk}"/> GB
                </span>
            {/if}
            <span class="fs11">
                <input type="checkbox" class="formchecker" rel="limitvmdatadisk"/>
                {if $default.sw_limitvmdatadisk!=''}
                    Use advanced controlls
                {/if}
            </span>
        </td>
    </tr>

    <tr class="odesc_ odesc_cloud_vm">
        <td colspan="2" ><b>Limit single server memory: 
                <a class="vtip_description" title="You can limit amount of memory client can select for single machine in his cloud"></a></b>
        </td>
    </tr>

    <tr class="odesc_ odesc_cloud_vm">
        <td width="160" align="right">Enable:</td>
        <td><input type="checkbox" {if $default.sw_limitvmmemory!=''}checked="checked"{/if} name="options[sw_limitvmmemory]" value="1" />
            <input type="text" size="3" name="options[limitvmmemory]" value="{$default.limitvmmemory}"/> MB
        </td>
    </tr>

    <tr class="odesc_ odesc_cloud_vm">
        <td colspan="2" ><b>Limit single server cores per VM: <a class="vtip_description" title="You can limit number cores client can create for single machine in his cloud"></a></b></td>
    </tr>

    <tr class="odesc_ odesc_cloud_vm">
        <td width="160" align="right">Enable:</td>
        <td><input type="checkbox" {if $default.sw_limitvmcpu!=''}checked="checked"{/if} name="options[sw_limitvmcpu]" value="1" />
            <input type="text" size="3" name="options[limitvmcpu]" value="{$default.limitvmcpu}"/> 
        </td>
    </tr>

    <tr class="odesc_ odesc_cloud_vm vcpu-disabled">
        <td colspan="2" ><b>Limit single server CPU speed: 
                <a class="vtip_description" title="You can limit cpu speed client can divide beetween cpu cores for one machine in his cloud."></a></b>
        </td>
    </tr>

    <tr class="odesc_ odesc_cloud_vm vcpu-disabled">
        <td width="160" align="right">Enable:</td>
        <td><input type="checkbox" {if $default.sw_limitvmcpuspeed!=''}checked="checked"{/if} name="options[sw_limitvmcpuspeed]" value="1" id="sw_limitvmcpuspeed" />
            <input type="text" size="3" name="options[limitvmcpuspeed]" value="{$default.limitvmcpuspeed}"/> MHz
        </td>
    </tr>

    <tr class="odesc_ odesc_cloud_vm vcpu-disabled">
        <td colspan="2" ><b>Set fixed CPU speed per core: 
                <a class="vtip_description" title="Set fixed speed for single core (eg. 2 cores -> 2 x this value), enabling this option will remove cpu speed slider 
                   from client area. This ignores &quot;Limit single server CPU speed&quot;"></a></b>
        </td>
    </tr>

    <tr class="odesc_ odesc_cloud_vm vcpu-disabled">
        <td width="160" align="right">Enable:</td>
        <td><input type="checkbox" {if $default.sw_fixedvmcpuspeed!=''}checked="checked"{/if} name="options[sw_fixedvmcpuspeed]" value="1" data-toggle-op="#sw_limitvmcpuspeed" />
            <input type="text" size="3" name="options[fixedvmcpuspeed]" value="{$default.fixedvmcpuspeed}"/> MHz
        </td>
    </tr>
    
</table>
<div class="nav-er"  id="step-5">
    <a href="#" class="prev-step">Previous step</a>
    <a href="#" class="next-step">Next step</a>
</div>