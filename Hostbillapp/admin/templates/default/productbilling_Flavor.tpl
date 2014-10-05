<div id="Flavor_b" {if $product.paytype!='Flavor'}style="display:none"{/if} class="p5 boption">



<div id="Flavormgr" >
    <div style="">
        {if $product.flav_inactive}
             <div style="padding:10px;color:red">
            <b>This billing model requires Cloud Flavor Manager module to be active</b>
        </div>
        {/if}
        <div style="padding:10px">
            <b>Client account total will be updated every hour by current flavor usage, with prices set trough <a href='?cmd=flavormanager' target='_blank'>Cloud Flavor Manager</a></b>
        </div>
            <div class="clear"></div>

        

        <div class="clear"></div>
        <table width="100%" cellspacing="0" cellpadding="6" border="0">
            <tr>
                <td width="160" style="background:#F0F0F3">Generate usage invoices</td>
                <td style="background:#F0F0F3" colspan="2">
                    <select name="config[FlavorCycle]" class="inp">
                        <option value="Monthly" {if $configuration.FlavorCycle=='Monthly'}selected="selected"{/if}>{$lang.Monthly}</option>
                        <option value="Semi-Annually" {if $configuration.FlavorCycle=='Semi-Annually'}selected="selected"{/if}>{$lang.SemiAnnually}</option>
                        <option value="Annually" {if $configuration.FlavorCycle=='Annually'}selected="selected"{/if}>{$lang.Annually}</option>
                    </select>

                </td>
            </tr>
               <tr>
                <td width="160" style="background:#F0F0F3">Add setup fee to client credit balance</td>
                <td style="background:#F0F0F3">
                    <select name="config[FlavorIncreaseCredit]" class="inp">
                        <option value="on" {if $configuration.FlavorIncreaseCredit=='on'}selected="selected"{/if}>{$lang.yes}</option>
                        <option value="off" {if $configuration.FlavorIncreaseCredit=='off'}selected="selected"{/if}>{$lang.no}</option>
                    </select>

                </td>
            </tr>
                <tr>
                    <td >Setup fee / initial credit</td>
                    <td width="160">{$currency.sign} <input type="text" class="inp" size="4"  value="{if $configuration.FlavorSetupFee}{$configuration.FlavorSetupFee|price:$currency:false}{else}{0|price:$currency:false:false}{/if}" name="config[FlavorSetupFee]" /> {$currency.code}</td>
                    <td style="background:#F0F0F3" class="fs11"> If enabled above, this fee will be added to client credit balance to lower with next recurring invoices.</td>
                </tr>
                <tr>
                    <td>Fixed recurring fee <a title="Additional, fixed amount, recurring charge for service" class="vtip_description"></a></td>
                    <td>{$currency.sign} <input type="text" class="inp" size="4" value="{if $configuration.FlavorRecurringFee}{$configuration.FlavorRecurringFee|price:$currency:false}{else}{0|price:$currency:false:false}{/if}" name="config[FlavorRecurringFee]" /> {$currency.code}</td>
                    <td style="background:#F0F0F3" class="fs11">You can add flat recurring fee to be added to each invoice</td>
                </tr>

        </table></div></div>




</div>