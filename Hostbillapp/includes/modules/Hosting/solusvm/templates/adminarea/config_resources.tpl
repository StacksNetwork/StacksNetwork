<div class="onapptab form" id="resources_tab">
    <div class="odesc_ odesc_single_vm pdx">Your client Virtual Machine will be provisioned using options configured here</div>
    <div class="odesc_ odesc_cloud_vm pdx">Your client will be able to use resource with limits configured here</div>
    <table border="0" cellspacing="0" cellpadding="6" width="100%" >
        <tr><td colspan="4" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from SolusVM, please wait...</td></tr>
 
        <tr class="odesc_ odesc_single_vm">
            <td width="160">
                <label >Type </label>
            </td>
            <td>
                <select name="options[option1]" id="option1" style="margin:0px;" onchange="return filter_types()">
                    <option value="openvz" {if $default.option1=='openvz' || $default.option1=='OpenVZ' || !$default.option1}selected="selected"{else}disabled="disabled"{/if}>OpenVZ</option>
                    <option value="xen" {if $default.option1=='xen'  || $default.option1=='Xen'}selected="selected"{/if}>Xen PV</option>
                    <option value="xenhvm" {if $default.option1=='xenhvm'  || $default.option1=='Xen HVM'}selected="selected"{/if}>Xen HVM</option>
                    <option value="kvm" {if $default.option1=='kvm'  || $default.option1=='KVM'}selected="selected"{/if}>KVM</option>
                </select>
            </td>
        </tr>
        <tr class="odesc_ odesc_cloud_vm odesc_reseller">
            <td width="160">
                <label >Allowed VPS types <a class="vtip_description" title="Select witch virtual server types your client is allowed to build"></a></label>
            </td>
            <td>
                <select name="options[allowedvpstypes][]" id="allowedvpstypes" multiple="multiple" class="multi" onchange="return filter_types()">
                    <option value="openvz" {if in_array("openvz",$default.allowedvpstypes) || !$default.allowedvpstypes}selected="selected"{/if}>OpenVZ</option>
                    <option value="xen" {if in_array("xen",$default.allowedvpstypes)}selected="selected"{/if}>Xen Pv</option>
                    <option value="xenhvm" {if in_array("xenhvm",$default.allowedvpstypes)}selected="selected"{/if}>Xen HVM</option>
                    <option value="kvm" {if in_array("kvm",$default.allowedvpstypes)}selected="selected"{/if}>KVM</option>
                </select>
            </td>
            <td></td>
        </tr>
        <tr class="odesc_ odesc_single_vm odesc_cloud_vm">
            <td width="160">
                <label >VPS Plan 
                    <a class="vtip_description odesc_ odesc_single_vm" title="Select plan that will be used while creating new vps, if you set your own resource limits here, they will owerwrite plan values"></a>
                    <a class="vtip_description odesc_ odesc_cloud_vm" title="Select plans that will be used while creating new vps, this is required, but users will be able to define their own settings within their limits, for each vps"></a>
                </label>
            </td>
            <td>
                <div id="option5container" class="tofetch">
                    {if $default.option5}
                        <select class="odesc_ odesc_single_vm disable_ disable_single_vm" name="options[option5]" id="option5" >
                            {if is_array($default.option5)}
                                <option value="{$default.option5[$default.option1]}" selected="selected">{$default.option5[$default.option1]}</option>
                            {else}
                                <option value="{$default.option5}" selected="selected">{$default.option5}</option>
                            {/if}
                        </select>
                    {else}
                        <input class="odesc_ odesc_single_vm" name="options[option5]" id="option5" />
                    {/if}
                    <div id="vpstypeplanscontainer" class="odesc_ odesc_cloud_vm disable_ disable_cloud_vm" >
                        <select name="options[option5][openvz]">
                            <optgroup class="opt_openvz" label="OpenVZ">
                                {if $default.option5 && !is_array($default.option5)}<option value="{$default.option5}" selected="selected">{$default.option5}</option>
                                {elseif !$default.option5 || !$default.option5.openvz}<option value="" selected="selected">--none--</option>
                                {elseif $default.option5.openvz}
                                    <option value="{$default.option5.openvz}" selected="selected">{$default.option5.openvz}</option>
                                {/if}
                            </optgroup>
                        </select> 
                        <select name="options[option5][xen]" >
                            <optgroup class="opt_xen" label="Xen PV">
                                {if $default.option5 && !is_array($default.option5)}<option value="{$default.option5}" selected="selected">{$default.option5}</option>
                                {elseif !$default.option5 || !$default.option5.xen}<option value="" selected="selected">--none--</option>
                                {elseif $default.option5.xen}
                                    <option value="{$default.option5.xen}" selected="selected">{$default.option5.xen}</option>
                                {/if}
                            </optgroup>
                        </select> 
                        <select name="options[option5][xenhvm]" >
                            <optgroup class="opt_xenhvm" label="Xen HVM">
                                {if $default.option5 && !is_array($default.option5)}<option value="{$default.option5}" selected="selected">{$default.option5}</option>
                                {elseif !$default.option5 || !$default.option5.xenhvm}<option value="" selected="selected">--none--</option>
                                {elseif $default.option5.xenhvm}
                                    <option value="{$default.option5.xenhvm}" selected="selected">{$default.option5.xenhvm}</option>
                                {/if}
                            </optgroup>
                        </select> 
                        <select name="options[option5][kvm]">
                            <optgroup class="opt_kvm" label="KVM">
                                {if $default.option5 && !$default.option5 || !$default.option5.kvm}<option value="" selected="selected">--none--</option>
                                {elseif !is_array($default.option5)}<option value="{$default.option5}" selected="selected">{$default.option5}</option>
                                {elseif $default.option5.kvm}
                                    <option value="{$default.option5.kvm}" selected="selected">{$default.option5.kvm}</option>
                                {/if}
                            </optgroup>
                        </select>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td width="160">
                <label >Disk size [GB] 
                    <a class="vtip_description odesc_ odesc_single_vm" title="Custom disk size, if left empty disk space allocated for new VPS will be taken from selected plan"></a>
                </label>
            </td>
            <td id="option6container"><input type="text" size="3" name="options[option7]" value="{$default.option7}" id="option7"/>
                <span class="fs11"  ><input type="checkbox" class="formchecker" rel="disk_size" />Allow client to adjust with slider during order</span>
            </td>
        </tr>
        <tr class="odesc_ odesc_single_vm odesc_cloud_vm">
            <td width="160">
                <label >CPU Cores
                    <a class="vtip_description odesc_ odesc_single_vm" title="If left empty, number of allocated CPUs for new VPS will be taken from selected plan"></a>
                </label>
            </td>
            <td id="option9container"><input type="text" size="3" name="options[option9]" value="{$default.option9}" id="option9"/>
                <span class="fs11"><input type="checkbox" class="formchecker"  rel="cpu_cores" /> Allow client to adjust with slider during order</span>
            </td>
            <td></td>
        </tr>
        <tr class="odesc_ odesc_cloud_vm odesc_reseller">
            <td width="160"><label >Max Virtual Machines</label></td>
            <td><input type="text" size="3" name="options[maxallowed]" value="{$default.maxallowed}" id="maxallowed"/>
                <span class="fs11"><input type="checkbox" class="formchecker"  rel="vpslimit" /> Allow client to adjust with slider during order</span>
            </td>
            <td></td>
        </tr>
        <tr class="odesc_ odesc_single_vm odesc_cloud_vm">
            <td width="160">
                <label >Nodes <a class="vtip_description" title="If more than one selected HostBill will choose least used Node"></a></label>
            </td>
            <td >
                <div id="option2container" class="tofetch">
                    <select class="multi" name="options[option2][]" id="option2" multiple="multiple">
                        <option value="Auto-Assign" {if in_array('Auto-Assign',$default.option2) || empty($default.option2)}selected="selected"{/if}>Auto-Assign</option>
                        {foreach from=$default.option2 item=vx}
                            {if $vx=='Auto-Assign'}{continue}
                            {/if}
                            <option value="{$vx}" selected="selected">{$vx}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="clear"></div>
                <span class="fs11"> <input type="checkbox" class="formchecker"  rel="node" />Allow to select by client during checkout</span>
            </td>
            <td></td>
        </tr>
        <tr>
            <td width="160">
                <label >Node Group 
                    <a class="vtip_description odesc_ odesc_single_vm" title="If node group is set, it will be used instead of Nodes settings. Selected node group has to be valid for selected VPS Type"></a>
                    <a class="vtip_description odesc_ odesc_cloud_vm" title="If node group is set, it will be used instead of Nodes settings, if you want to use this settings you have to set a valid node group for related VPS Type"></a>
                </label>
            </td>
            <td>
                <div id="nodegroupcontainer" class="tofetch">

                    <select class="odesc_ odesc_single_vm disable_ disable_single_vm" name="options[nodegroup]" id="nodegroup" >
                        <option value="0" {if !$default.nodegroup}selected="selected"{/if}>--none--</option>
                        {if is_array($default.nodegroup)}
                            {foreach from=$default.nodegroup item=vx key=type}
                                {if $vx}
                                    <option value="{$vx}" {if $type == $default.option1}selected="selected"{/if}>{$vx}</option>
                                {/if}
                            {/foreach}
                        {else}
                            <option value="{$default.nodegroup}" selected="selected">{$default.nodegroup}</option>
                        {/if}
                    </select>

                    <div id="nodegroup2container" class="odesc_ odesc_cloud_vm disable_ disable_cloud_vm" >
                        <select name="options[nodegroup][openvz]">
                            <optgroup class="opt_openvz" label="OpenVZ">
                                {if $default.nodegroup && !is_array($default.nodegroup)}<option value="{$default.nodegroup}" selected="selected">{$default.nodegroup}</option>
                                {elseif !$default.nodegroup || !$default.nodegroup.openvz }<option value="0" selected="selected">--none--</option>
                                {else}
                                    <option value="{$default.nodegroup.openvz}" selected="selected">{$default.nodegroup.openvz}</option>
                                {/if}
                            </optgroup>
                        </select> 
                        <select name="options[nodegroup][xen]" >
                            <optgroup class="opt_xen" label="Xen PV">
                                {if $default.nodegroup && !is_array($default.nodegroup)}<option value="{$default.nodegroup}" selected="selected">{$default.nodegroup}</option>
                                {elseif !$default.nodegroup || !$default.nodegroup.xen}<option value="0" selected="selected">--none--</option>
                                {elseif $default.nodegroup.xen}
                                    <option value="{$default.nodegroup.xen}" selected="selected">{$default.nodegroup.xen}</option>
                                {/if}
                            </optgroup>
                        </select> 
                        <select name="options[nodegroup][xenhvm]" >
                            <optgroup class="opt_xenhvm" label="Xen HVM">
                                {if $default.nodegroup && !is_array($default.nodegroup)}<option value="{$default.nodegroup}" selected="selected">{$default.nodegroup}</option>
                                {elseif !$default.nodegroup || !$default.nodegroup.xenhvm }<option value="0" selected="selected">--none--</option>
                                {elseif $default.nodegroup.xenhvm}
                                    <option value="{$default.nodegroup.xenhvm}" selected="selected">{$default.nodegroup.xenhvm}</option>
                                {/if}
                            </optgroup>
                        </select> 
                        <select name="options[nodegroup][kvm]">
                            <optgroup class="opt_kvm" label="KVM">
                                {if $default.nodegroup && !is_array($default.nodegroup)}<option value="{$default.nodegroup}" selected="selected">{$default.nodegroup}</option>
                                {elseif !$default.nodegroup || !$default.nodegroup.kvm}<option value="0" selected="selected">--none--</option>
                                {elseif $default.nodegroup.kvm}
                                    <option value="{$default.nodegroup.kvm}" selected="selected">{$default.nodegroup.kvm}</option>
                                {/if}
                            </optgroup>
                        </select>
                    </div>
                    <div id="nodegroup3container" class="odesc_ odesc_reseller disable_ disable_reseller" >
                        <select name="options[nodegroup][]" id="nodegroup" multiple="multiple" class="multi" >
                            {if is_array($default.nodegroup)}
                                {foreach from=$default.nodegroup item=vx}
                                    <option value="{$vx}" selected="selected">{$vx}</option>
                                {/foreach}
                            {else}
                                <option value="{$default.nodegroup}" selected="selected">{$default.nodegroup}</option>
                            {/if}
                        </select>
                    </div>
                </div>
                <div class="clear"></div>
                <span class="fs11 odesc_ odesc_single_vm"> <input type="checkbox" class="formchecker"  rel="nodegroup" />Allow to select by client during checkout</span>
            </td>
            <td></td>
        </tr>

        {*
        <tr>
        <td width="160"><label >User Role<a class="vtip_description" title="HostBill will create new user for client in onapp using this role."></a></label></td>
        <td id="option1container" class="tofetch"><input type="text" size="3" name="options[option1]" value="{$default.option1}" id="option1"/>
        </td>
        </tr>
        *}
    </table>
    {literal}
        <script type="text/javascript" >
            filter_types();
        </script>
    {/literal}
    <div class="nav-er"  id="step-2">
        <a href="#" class="prev-step">Previous step</a>
        <a href="#" class="next-step">Next step</a>
    </div>
</div>