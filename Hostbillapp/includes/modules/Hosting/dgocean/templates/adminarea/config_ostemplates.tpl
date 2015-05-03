<div class="onapptab form" id="ostemplates_tab">
    <div class=" pdx">Limit access to OS templates available in your DigitalOcean, you can also add charge to selected OS templates</div>
    <table border="0" cellspacing="0" cellpadding="6" width="100%" >
        <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from DigitalOcean, please wait...</td></tr>

        <tr >
            <td width="160"><label >OS Template <a class="vtip_description" title="Your client VM will be automatically provisioned with this template"></a></label></td>
            <td id="imagescontainer" >
                <div  class="tofetch" style="display:inline">
                    <input type="text" size="50" name="options[images]" value="{$default.images}" id="images"/>
                </div>
                <span class="fs11" ><input type="checkbox" class="formchecker osloader" rel="images" />Allow client to select during checkout</span>
            </td>
            <td></td>
        </tr>

    </table>
    <div class="nav-er"  id="step-3">
        <a href="#" class="prev-step">Previous step</a>
        <a href="#" class="next-step">Next step</a>
    </div>
</div>