<div class="onapptab form" id="memory_tab">
    <div class="odesc_ odesc_single_vm pdx">You can set custom memory limit for your client Virtual Private Server here, those settings are optional</div>
    <div class="odesc_ odesc_cloud_vm pdx">Your client will be able to use memory resource with limits configured here</div>
    <table border="0" cellspacing="0" cellpadding="6" width="100%" >
        
        <tr>
            <td width="160"><label >Memory [MB]</label></td>
            <td id="option6container"><input type="text" size="3" name="options[option6]" value="{$default.option6}" id="option6"/>
                <span class="fs11"/><input type="checkbox" class="formchecker"  rel="memory"> Allow client to adjust with slider during order</span>
            </td>
            <td><div class="resource"><div class="used_resource"></div></div></td>
        </tr>
        <tr class="opt_xen opt_openvz">
            <td width="160"><label >Burst Memory or Swapspace [MB]
                    <a class="vtip_description odesc_ odesc_single_vm" title="Burst ram/Swap space must be equal or higher than guaranteed ram. If you set it too low a sum of those two will be used."></a>
                </label>
            </td>
            <td id="option10container"><input type="text" size="3" name="options[option10]" value="{$default.option10}" id="option10"/>
                <span class="fs11"><input type="checkbox" class="formchecker" rel="burstmem" /> Allow client to adjust with slider during order</span>
            </td>
            <td><div class="resource"><div class="used_resource"></div></div></td>
        </tr>
    </table>
    <div class="nav-er"  id="step-2">
        <a href="#" class="prev-step">Previous step</a>
        <a href="#" class="next-step">Next step</a>
    </div>
</div>