{if $accounts}
    {foreach from=$accounts item=account }
		
			<tr>
			<td width="20"><input type="checkbox" class="check" value="{$account.id}" name="selected[]"/></td>
			<td><a href="?cmd=accounts&action=edit&id={$account.id}&list={$currentlist}">{$account.id}</a></td>
			<td><a href="?cmd=clients&action=show&id={$account.client_id}">{$account.lastname} {$account.firstname}</a></td>
			<td>{$account.name}</td>
                        <td style="text-align:center">{$account.domains}</td>
			<td><span class="{$account.status}">{$lang[$account.status]}</span></td>
			<td>{if $account.billingcycle=='Free'}{$lang.Free}{else}
                            {$account.total|price:$account.currency_id} <span class="fs11">({$lang[$account.billingcycle]})</span>{/if}</td>
			<td>{if $account.next_due == '0000-00-00'}-{else}{$account.next_due|dateformat:$date_format}{/if}</td>
                        <td><a href="../?action=adminlogin&id={$account.client_id}&redirect=%3Fcmd%3Dclientarea%26action%3Dservices%26service%3D{$account.id}" target="_blank" class="editbtn">{$lang.Manage}</a></td>
        </tr>
    {/foreach}
{/if}