<div class="onapptab form" id="network_tab">
    <div class="odesc_ odesc_single_vm pdx">You can set custom bandwidth limit for your client Virtual Private Server here, those settings are optional</div>
    <div class="odesc_ odesc_cloud_vm pdx">Your client will be able to use network resources with limits configured here</div>
    <table border="0" cellspacing="0" cellpadding="6" width="100%" >
         <tr>
            <td width="160">
                <label >IP Address Count
                    <a class="vtip_description odesc_ odesc_single_vm" title="Number of ip addresses that wll be delagated for new VPS, minimum is 1"></a>
                    <a class="vtip_description odesc_ odesc_cloud_vm odesc_reseller" title="Number of ip addresses that will be available for this account"></a>
                </label>
            </td>
            <td id="option13container">
                <input type="text" size="3" name="options[option3]" value="{$default.option3}" id="option13"/> 
                <span class="fs11"><input type="checkbox"  class="formchecker" rel="ip_address" />Allow client to adjust with slider during order</span>
            </td>
        </tr>
        <tr class="odesc_ odesc_reseller">
            <td width="160">
                <label >IP v6 Address Count
                    <a class="vtip_description" title="Number of ip v6 addresses that will be available for this account"></a>
                </label>
            </td>
            <td id="option13container">
                <input type="text" size="3" name="options[ipsv6]" value="{$default.ipsv6}" id="ipsv6"/> 
                <span class="fs11"><input type="checkbox"  class="formchecker" rel="ipv6_address" />Allow client to adjust with slider during order</span>
            </td>
        </tr>
        {* MAYBE SOMEDAY
        <tr>
            <td width="160"><label >Port Speed [Mbps] <a class="vtip_description" title="Leave blank to unlimited. For cloud hosting this value will be used for each Virtual Machine created by client"></a></label></td>
            <td id="option9container"><input type="text" size="3" name="options[option9]" value="{$default.option9}" id="option9"/>
                <span class="fs11"><input type="checkbox" class="formchecker" rel="rate"  />Allow client to select during order</span>
            </td>
        </tr>
        *}
        <tr>
            <td width="160">
                <label >Bandwidth [GB] 
                    <a class="vtip_description odesc_ odesc_single_vm" title="This is a monthly limit for single VPS"></a>
                    <a class="vtip_description odesc_ odesc_cloud_vm" title="This is Total monthly limit for all VPS created under this account"></a>
                </label>
            </td>
            <td>
                <input type="text" size="3" name="options[option8]" value="{$default.option8}" id="option16"/>
                <span class="fs11"><input type="checkbox"  class="formchecker" rel="bandwidth" />Allow client to adjust with slider during order</span>
            </td>
        </tr>
</table>
<div class="nav-er"  id="step-5">
    <a href="#" class="prev-step">Previous step</a>
    <a href="#" class="next-step">Next step</a>
</div>
</div>