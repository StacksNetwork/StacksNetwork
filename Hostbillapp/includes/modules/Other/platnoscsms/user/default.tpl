<div class="wbox">
    <div class="wbox_header">Premium SMS</div>
    <div id="cartSummary" class="wbox_content" style="padding: 0; text-align: center">
		<p>Kwoty podane na tej stronie są kwotami brutto (z podatkiem VAT) i stanowią całkowity koszt operacji.</p>
		<table width="100%" class="checker" cellpadding="0" cellspacing="0">
			<tr>
				<th style="width: 200px">Kwota doładowania</th>
				<th>Cena SMS</th>
				<td style="width:33%">&nbsp;</td>
			</tr>
			{foreach from=$payoptions item=sms name=alter}
				<tr {if $smarty.foreach.alter.index%2==0}class="even"{/if}>
					<td {if $smarty.foreach.alter.last}style="border: none"{/if}>{$sms.income} zł</td>
					<td {if $smarty.foreach.alter.last}style="border: none"{/if}>{$sms.total} zł</td>
					<td {if $smarty.foreach.alter.last}style="border: none"{/if}>
						<form action="{$url}" method="POST" name="payform">
							<input type="hidden" name="pos_id" value="{$posid}">
							<input type="hidden" name="pos_auth_key" value="{$poskey}">
							<input type="hidden" name="session_id" value="{$sesja}">
							<input type="hidden" name="amount_netto" value="{$sms.amount_netto}">
							
							<input type="hidden" name="desc" value="{$desc}">
							<input type="hidden" name="client_ip" value="{$ipklient}">
							<input type="hidden" name="js" value="1">
							<input type="hidden" name="ts" value="{$timestamp}">
							<input type="hidden" name="sig" value="{$sms.sig}">
							<input type="hidden" name="order_id" value="{$invoiceid}">
							<input type="submit" value="Zapłać poprzez SMS!">
						</form>
					</td>
				</tr>
			{/foreach}
		</table>
    </div>
</div>