
<div class="tdetails">

    <form action="" method="post">
        <input type="hidden" name="make" value="editdetails" />
        <input type="hidden" name="action" value="changething" />
        <input type="hidden" name="id" value="{$invoice.id}" />

        <input type="hidden" id="client_id" name="invoice[client_id]" value="{$invoice.client_id}" />
        <input  value="{'1997-01-01'|dateformat:$date_format}"  type="hidden" id="old_recurring_start_date" />
        <input type="hidden" id="is_recurring" name="invoice[recurring][recurr]" value="0" />

        <div class="clear"></div>
        <div class="left recurringinvoice" style="display:none">
            <table border="0" width="300" cellspacing="3" cellpadding="0">
                <tr>
                    <td width="100" align="right" class="light">{$lang.start_date}:</td>
                    <td width="200" align="left"><input name="invoice[recurring][start_from]" value="{$invoice.recurring.start_from|dateformat:$date_format}" class="haspicker" id="recurring_start_date" /></td>
                </tr>
                <tr>
                    <td width="100" align="right" class="light">{$lang.frequency}:</td>
                    <td width="200" align="left"><select name="invoice[recurring][frequency]" >
                            <option value="1w" {if $invoice.recurring.frequency=='1w'}selected="selected"{/if}>{$lang.1w}</option>
                            <option value="2w" {if $invoice.recurring.frequency=='2w'}selected="selected"{/if}>{$lang.2w}</option>
                            <option value="4w" {if $invoice.recurring.frequency=='4w'}selected="selected"{/if}>{$lang.4w}</option>
                            <option value="1m" {if $invoice.recurring.frequency=='1m'}selected="selected"{/if}>{$lang.1m}</option>
                            <option value="2m" {if $invoice.recurring.frequency=='2m'}selected="selected"{/if}>{$lang.2m}</option>
                            <option value="3m" {if $invoice.recurring.frequency=='3m'}selected="selected"{/if}>{$lang.3m}</option>
                            <option value="6m" {if $invoice.recurring.frequency=='6m'}selected="selected"{/if}>{$lang.6m}</option>
                            <option value="1y" {if $invoice.recurring.frequency=='1y'}selected="selected"{/if}>{$lang.1y}</option>
                            <option value="2y" {if $invoice.recurring.frequency=='2y'}selected="selected"{/if}>{$lang.2y}</option>
                        </select></td>
                </tr>
                <tr>
                    <td width="100" align="right" class="light">{$lang.occurrences}:</td>
                    <td width="200" align="left" class="light" valign="middle"><input name="invoice[recurring][occurrences]" value="{if  $invoice.recurring.occurrences}{$invoice.recurring.occurrences}{else}0{/if}" size="2" id="recurring_occurrences" {if !$invoice.recurring.occurrences}disabled="disabled"{/if} /> #
                        <input type="checkbox" name="invoice[recurring][infinite]" value="1" onclick="if ($(this).is(':checked'))
                                  $('#recurring_occurrences').attr('disabled', true);
                              else
                                  $('#recurring_occurrences').removeAttr('disabled');" {if !$invoice.recurring.occurrences}checked="checked"{/if}  id="inp_recurring_occurrences"  /> <label for="inp_recurring_occurrences"> {$lang.infinite}</label>
                    </td>
                </tr>
            </table>
        </div>
        <div class="left">
            <table border="0" cellspacing="3" cellpadding="0">
                <tr>
                    <td width="100" align="right" class="light standardinvoice"><span class="standardinvoice">{$lang.invoicedate}:</span></td>
                    <td width="200" align="left" class="standardinvoice"><div ><input name="invoice[date]" value="{$invoice.date|dateformat:$date_format}" class="haspicker"/></div></td>

                    <td width="100" align="right" class="light">{$lang.Gateway}:</td>
                    <td width="200" align="left" colspan="2"><select name="invoice[payment_module]"  onclick="new_gateway(this)">
                            <option value="0" >{$lang.none}</option>
                            {foreach from=$gateways key=gatewayid item=paymethod}
                                <option value="{$gatewayid}"{if $invoice.payment_module == $gatewayid} selected="selected"{/if} >{$paymethod}</option>
                            {/foreach}
                            <option value="new" style="font-weight: bold">{$lang.newgateway}</option>

                        </select>
                    </td>
                </tr>
                <tr>
                    <td width="100" align="right"  class="light standardinvoice"><span >{$lang.duedate}:</span></td>
                    <td width="200" align="left" class="standardinvoice"><div ><input name="invoice[duedate]" value="{$invoice.duedate|dateformat:$date_format}" class="haspicker"/></div></td>

                    <td width="100" align="right" class="light">{$lang.taxlevel1}:</td>
                    <td width="120" align="left"><input name="invoice[taxrate]" size="7" value="{$invoice.taxrate}" /> %</td>

                    <td width="170" align="right"><input type="submit" value="{$lang.savechanges}" id="savedetailsform" style="display:none"/></td>
                </tr>
                <tr>
                    <td width="100" align="right"  class="light standardinvoice">{$lang.Amount}:</td>
                    <td width="200" align="left" class="standardinvoice"><strong>{$invoice.total|price:$currency}</strong></td>

                    <td width="100" align="right" class="light">{$lang.taxlevel2}:</td>
                    <td width="200" align="left" colspan="2"><input name="invoice[taxrate2]" size="7" value="{$invoice.taxrate2}" /> %</td>

                </tr>
                <tr>
                    <td width="100" align="right" class="light standardinvoice">{$lang.balance}</td>
                    <td width="200" align="left" class="standardinvoice">{$balance|price:$currency}</td>


                    <td width="100" align="right" class="light">{$lang.Credit}:</td>
                    <td width="200" align="left" colspan="2"><input name="invoice[credit]" size="7" value="{$invoice.credit}" /> </td>

                </tr>
            </table></div><div class="clear"></div>
        {securitytoken}
    </form>
</div>
