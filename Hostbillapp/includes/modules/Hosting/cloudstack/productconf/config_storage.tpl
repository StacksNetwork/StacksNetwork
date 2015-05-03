<table border="0" cellspacing="0" cellpadding="6" width="100%" >
    <tr>
        <td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from CloudStack, please wait...</td>
    </tr>
    <tr>
        <td width="160"><label >Data Disk size [GB]</label></td>
        <td id="option6container">
            <input type="text" size="3" name="options[option6]" value="{$default.option6}" id="option6"/>
            <span class="fs11"  ><input type="checkbox" class="formchecker" rel="disk_size" />Allow client to adjust with slider during order</span> <br>
        </td>
    </tr>
    <tr>
        <td width="160"><label >Max Volume snapshots</label></td>
        <td><input type="text" size="3" name="options[option15]" value="{$default.option15}" id="option15"/></td>
    </tr>
    <tr>
        <td width="160"><label >Max VM snapshots</label></td>
        <td><input type="text" size="3" name="options[vmsnaplimit]" value="{$default.vmsnaplimit}" id="optvmsnaplimit"/></td>
    </tr>

    <tr>
        <td width="160"><label >Max templates</label></td>
        <td><input type="text" size="3" name="options[option16]" value="{$default.option16}" id="option16"/></td>
    </tr>

    <tr>
        <td width="160"><label > HA-enabled <a class="vtip_description" title="HA features work with iSCSI or NFS primary storage.  HA with local storage is not supported."></label></td>
            {*If yes, the administrator can choose to have the VM be monitored and as highly available as possible*}
        <td id="offerhacontainer">
            <input type="checkbox"  name="options[offerha]" {if $default.offerha}checked="checked"{/if} value="1" id="offerha"/>
        </td>
    </tr>

    <tr>
        <td width="160"><label >Primary storage type<a class="vtip_description" title="Select where you want to deploy your VMs"></label></td>
        <td>
            <div id="primarystoragtypecontainer" class="tofetch">
                <select name="options[primarystoragtype]" id="primarystoragtype" >
                    <option value="shared" {if !$default.primarystoragtype || $default.offerha || $default.primarystoragtype == 'shared'}selected="selected"{/if} >Shared</option>
                    <option class="local" value="local" {if $default.primarystoragtype == 'local' && !$default.offerha}selected="selected"{/if} {if $default.offerha}disabled="disabled"{/if}>Local</option>
                </select>
                {literal}
                    <script type="text/javascript">
                        $('#primarystoragtypecontainer option').unbind('click').click(function(event) {
                            $(this).parent().siblings().children().removeProp('selected')
                        });
                        $('#offerha').unbind('change').change(function() {
                            if ($(this).is(':checked'))
                                $('#primarystoragtype option.local').prop('disabled', true).siblings().prop('selected', true);
                            else
                                $('#primarystoragtype option.local').prop('disabled', false);
                        }).change();
                    </script>
                {/literal}
            </div>
            <div class="clear"></div>                    
        </td>
    </tr>
    <tbody class="tofetch">
        <tr>
            <td width="160" style="vertical-align: top;">
                <label >
                    Storage tags <span class="tier2storage">- Tier 1</span>
                    <a class="vtip_description" title="Default storage tags that will be used when deploying VMs"></a>
                </label>
            </td>
            <td>
                <div id="primarystoragecontainer" class="clearfix left">
                    <span>Primary storage (ROOT)</span><br/>
                    <select name="options[primarystorage][]" id="primarystorage" multiple="multiple" class="multi" style="min-width: 150px">
                        <option value="Auto-Assign" {if in_array('Auto-Assign',$default.primarystorage)}selected="selected"{/if}>Auto-Assign</option>
                        {foreach from=$default.primarystorage item=vx}
                            {if $vx=='Auto-Assign'}{continue}
                            {/if}
                            <option value="{$vx}" selected="selected" >
                                {$vx|regex_replace:"/^local:(.*)/":'$1'}
                            </option>
                        {/foreach} 
                    </select>
                </div>
                <div id="datastoragecontainer" class="tofetch2 clearfix left" style="margin: 0 0 0 25px">
                    <span>Data storage (DATA)</span><br/>
                    <select name="options[datastorage][]" id="datastorage" multiple="multiple" class="multi" style="min-width: 150px">
                        <option value="Auto-Assign" {if in_array('Auto-Assign',$default.datastorage)}selected="selected"{/if}>Auto-Assign</option>
                        {foreach from=$default.datastorage item=vx}
                            {if $vx=='Auto-Assign'}{continue}
                            {/if}
                            <option value="{$vx}" selected="selected" >
                                {$vx}
                            </option>
                        {/foreach} 
                    </select>
                </div>
                <div class="clear"></div>
                {*<span class="fs11"> <input type="checkbox" class="formchecker"  rel="primarystorage" />Allow to select by client during checkout</span>*}
            </td>
        </tr>
        <tr class="tier2storage">
            <td width="160" style="vertical-align: top;">
                <label >
                    Storage tags - Tier 2
                    <a class="vtip_description" title="Default storage tags that will be used when deploying VMs"></a>
                </label>
            </td>
            <td>
                <div id="primarystoragecontainer" class="clearfix left">
                    <span>Primary storage (ROOT)</span><br/>
                    <select name="options[primarystorage2][]" id="primarystorage" multiple="multiple" class="multi" style="min-width: 150px">
                        <option value="Auto-Assign" {if in_array('Auto-Assign',$default.primarystorage2)}selected="selected"{/if}>Auto-Assign</option>
                        {foreach from=$default.primarystorage2 item=vx}
                            {if $vx=='Auto-Assign'}{continue}
                            {/if}
                            <option value="{$vx}" selected="selected" >
                                {$vx|regex_replace:"/^local:(.*)/":'$1'}
                            </option>
                        {/foreach} 
                    </select>
                </div>
                <div id="datastoragecontainer" class="tofetch2 clearfix left" style="margin: 0 0 0 25px">
                    <span>Data storage (DATA)</span><br/>
                    <select name="options[datastorage2][]" id="datastorage" multiple="multiple" class="multi" style="min-width: 150px">
                        <option value="Auto-Assign" {if in_array('Auto-Assign',$default.datastorage2)}selected="selected"{/if}>Auto-Assign</option>
                        {foreach from=$default.datastorage2 item=vx}
                            {if $vx=='Auto-Assign'}{continue}
                            {/if}
                            <option value="{$vx}" selected="selected" >
                                {$vx}
                            </option>
                        {/foreach} 
                    </select>
                </div>
                <div class="clear"></div>
                {*<span class="fs11"> <input type="checkbox" class="formchecker"  rel="primarystorage" />Allow to select by client during checkout</span>*}
            </td>
        </tr>
    </tbody>
    <tr>
        <td width="160" style="vertical-align: top"><label >Advanced storage options</label ></td>
        <td>
            <p class="tier2storage ftr">
            <span>
                <input type="checkbox" class="formchecker" rel="storage_tier"
                       data-rem="[&#34;storage_tier&#34;, &#34;tier2_disk_size&#34;]" id="storage_tier" data-disable="storage_tier2"/>
                Old 2-tier storage
                {if !$default.primarystoragtype || $default.offerha || $default.primarystoragtype == 'shared'}{/if}
                
            </span>
            </p>
            <p class="tierXstorage ftr">
            <span>
                <input type="checkbox" class="formchecker" rel="storage_tiers" 
                       id="storage_tier2" data-disable="userstoragetags"/>
                Enable Storage tiers
            </span>
            </p>
            <div class="shownice fs11 tier2storage" style="margin: 10px 0 0; padding: 5px;">
                Enabling Tier 2 storage will add three form components to your order page:
                <ul style="list-style: disc inside none; margin: 5px 0px; padding: 0px 3px;">
                    <li>Storage Tier select box - allows clients to switch between storage tier</li>
                    <li>Data Disk Size slider - defines data storage limit for account, hidden when Storage Tier is set to "Tier 2 Storage"</li>
                    <li>Tier 2 Disk Size slider - defines limits same as Data Disk Size slider, hidden when Storage Tier is set to "Tier 1 Storage"</li>
                </ul>
            </div>
            <div id="adv_storage" class="shownice fs11" style="margin: 10px 0 0; padding: 5px;">
                Enabling Storage tiers will add hidden form component that will control any number of additional storage tier limits.<br/>
                If you want to add additional tier, just click on "Edit related form element" to edit this form and add new value to it, slider components will be created automatically.<br/>
                You can find more information on setting up your tiers on our wiki <a href="http://wiki.hostbillapp.com/index.php?title=Cloudstack:_Storage_tiers#Adding_new_storage_tier" class="external">http://wiki.hostbillapp.com/index.php?title=Cloudstack:_Storage_tiers#Adding_new_storage_tier</a>
            </div>
        </td>
    </tr>
</table>
<div class="nav-er"  id="step-4">
    <a href="#" class="prev-step">Previous step</a>
    <a href="#" class="next-step">Next step</a>
</div>