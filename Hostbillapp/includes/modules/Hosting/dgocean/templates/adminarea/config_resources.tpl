<div class="onapptab form" id="resources_tab">
    <div class="  pdx">Your client Virtual Machine will be provisioned using options configured here</div>
    <table border="0" cellspacing="0" cellpadding="6" width="100%" >
        <tr><td colspan="4" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from DigitalOcean, please wait...</td></tr>


        <tr>
            <td width="160" >
                <label >Size <a class="vtip_description" title="If more than one selected HostBill will choose least used Node"></a></label>
            </td>
            <td >
                <div id="sizescontainer" class="tofetch">
                    <select name="options[sizes]" id="sizes" >
                        <option value="{$default.sizes}" selected="selected">{$default.sizes}</option>
                    </select>
                </div>
                <div class="clear"></div>
                <span class="fs11"> <input type="checkbox" class="formchecker"  rel="sizes" />Allow to select by client during checkout</span>
            </td>
            <td></td>
        </tr>
        <tr>
            <td width="160">
                <label >Region
                    <a class="vtip_description " title="If node group is set, it will be used instead of Nodes settings. Selected node group has to be valid for selected VPS Type"></a>
                </label>
            </td>
            <td>
                <div id="regionscontainer" class="tofetch">

                    <select class="" name="options[regions]" id="regions" >
                        <option value="{$default.regions}" selected="selected">{$default.regions}</option>
                    </select>
                </div>
                <div class="clear"></div>
                <span class="fs11 "> <input type="checkbox" class="formchecker"  rel="regions" />Allow to select by client during checkout</span>
            </td>
            <td></td>
        </tr>
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