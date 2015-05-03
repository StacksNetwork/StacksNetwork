 <form action='' method='post' onsubmit="$('#ccpcontent').addLoader()">
    <input type="hidden" name="invoice_id" value="{$invoice_id}" />
	<input type="hidden" name="client[client_id]" value="{$cadetails.id}" />

<div class="wbox">
  	<div class="wbox_header">
	<strong>{$xlang.provide_bank_details}</strong></div>
	<div class="wbox_content" id="ccpcontent">
            <table  width="100%" cellpadding="0" cellspacing="0"  class="checker">
                <tr><td colspan="2"  class="even"><input type="radio" name="dtaus_details" value="existing" {if !$dtaus}disabled="disabled" /> {$xlang.dtaus_exists} {else} checked="checked"  onclick="$('#newcard').hide();" /> {$xlang.dtaus_exists} ({$dtaus.bank_account}){/if}</td></tr>
                <tr class="even"><td colspan="2"><input type="radio" name="dtaus_details" value="new" {if !$dtaus}checked="checked"{/if} onclick="$('#newcard').show();"/> {$xlang.new_dtaus}</td></tr>
                <tbody id="newcard" {if $dtaus}style="display:none"{/if}>
                    <tr><td align="right">{$xlang.name}</td><td><input type="text" name="dtaus[name]" size="25" value="{if $cadetails.companyname != ''}{$cadetails.companyname}{else}{$cadetails.lastname} {$cadetails.firstname}{/if}" maxlenght="16"  class="styled"  autocomplete="off"/></td></tr>
                    <tr><td align="right">{$xlang.bank_code}</td><td><input type="text" name="dtaus[bank_code]" size="25" class="styled" /></td></tr>
                    <tr><td align="right">{$xlang.account_number}</td><td><input type="text" name="dtaus[bank_account]" size="25" class="styled" /></td></tr>
                </tbody>
                <tr class="even"><td colspan="2" align="center"><input type="submit" value="{$lang.continue}" name="continue"  class="padded" style="font-weight:bold"/></td></tr>

            </table>
        </div>
</div>
 </form>