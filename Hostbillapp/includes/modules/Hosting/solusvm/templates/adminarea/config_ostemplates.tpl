<div class="onapptab form" id="ostemplates_tab">
    <div class=" pdx">Limit access to OS templates available in your SolusVM, you can also add charge to selected OS templates</div>
    <table border="0" cellspacing="0" cellpadding="6" width="100%" >
        <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from SolusVM, please wait...</td></tr>
        
        <tr class="odesc_ odesc_cloud_vm">
            <td width="160"><label >OS Templates</label></td>
            <td><span class="fs11" ><input type="checkbox" rel="os2" class="formchecker osloader" />Set template pricing</span></td>
            <td></td>
        </tr>
        <tr class="odesc_ odesc_single_vm">
            <td width="160"><label >OS Template <a class="vtip_description" title="Your client VM will be automatically provisioned with this template"></a></label></td>
            <td id="option4container" >
                <div  class="tofetch" style="display:inline">
                    <input type="text" size="50" name="options[option4]" value="{$default.option4}" id="option4"/>
                </div>
                <span class="fs11" ><input type="checkbox" class="formchecker osloader" rel="os1" />Allow client to select during checkout</span>
            </td>
            <td></td>
        </tr>
        
        <tr class="odesc_ odesc_reseller">
            {*LISTING media groups not yet available, can be applied to resellers only*}
            <td width="160">
                <label >Media Group <a class="vtip_description" title="You can set media groups for your resellers here, comma separated"></a></label>
            </td>
            <td id="mediagroupcontainer">
                <input type="text" name="options[mediagroup]" value="{$default.mediagroup}" id="mediagroup"/>
            </td>
            <td></td>
        </tr>
    </table>
    <div class="nav-er"  id="step-3">
        <a href="#" class="prev-step">Previous step</a>
        <a href="#" class="next-step">Next step</a>
    </div>
</div>