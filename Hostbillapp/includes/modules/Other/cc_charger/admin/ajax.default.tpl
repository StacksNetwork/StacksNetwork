<form method="post" action="?cmd=module&module={$moduleid}&do=chargecc">
    <input type="hidden" name="invoice_id" value="{$invoice_id}"/>
<h3>Charge client's credit card</h3>
    {if $current_cc}
        <input type="radio" name="make" value="chargecurrent" checked="checked"  onclick="$('#nctable').hide()"/> Charge credit card on file ({$current_cc}) <br/>
    {else}
        <input type="radio" name="make" value="chargecurrent" disabled="disabled" /> Charge credit card on file <br/>
    {/if}
         <input type="radio" name="make" value="chargenew" {if !$current_cc}checked="checked"{/if} onclick="$('#nctable').show()" /> Charge new credit card <br/>
         <table  width="100%" cellpadding="6" cellspacing="0"  id="nctable" {if $current_cc}style="display: none"{/if}>
			<tbody id="newcard" >
                <tr><td align="right" width="160" >Card type</td><td>
                        <select name="cc[cardtype]" class="inp">
                        <option>Visa</option>
                        <option>MasterCard</option>
                        <option>Discover</option>
                        <option>American Express</option>
                        <option>Laser</option>
                        <option>Maestro</option>
                    </select>
                </td></tr>
                <tr><td align="right">Card number</td><td><input type="text" name="cc[cardnum]" size="25" maxlenght="16"   autocomplete="off" class="inp" /></td></tr>
                <tr><td align="right">Expiration date</td>
                    <td><input type="text" name="cc[expirymonth]" size="2" maxlength="2" class="inp" />/
                    <input type="text" name="cc[expiryyear]" size="2" maxlength="2"  class="inp" /> (MM/YY)</td></tr>

			</tbody>


                </table>
         <center><input type="submit" value="Charge"   class="padded" style="font-weight:bold;padding:3px 5px;" /></center>
         {securitytoken}
</form>
