{if $action=='default'}
    {if $affiliates}
        {foreach from=$affiliates item=affiliate}
            <tr>
                <td><input type="checkbox" class="check" value="{$affiliate.client_id}" name="selected[]"/></td>
                <td><a href="?cmd=affiliates&amp;action=affiliate&amp;id={$affiliate.id}">{$affiliate.id}</a></td>
                <td><a href="?cmd=clients&amp;action=show&amp;id={$affiliate.client_id}">{$affiliate.lastname}</a></td>		  
                <td><a href="?cmd=clients&amp;action=show&amp;id={$affiliate.client_id}">{$affiliate.firstname}</a></td>
                <td >{$affiliate.visits}</td>
                <td>{$affiliate.signups}</td>
                <td>{$affiliate.balance|price:$affiliate.currency_id}</td>
                <td>{$affiliate.total_withdrawn|price:$affiliate.currency_id}</td>

                <td><a href="?cmd=affiliates&amp;action=affiliate&amp;id={$affiliate.id}" class="editbtn">{$lang.Edit}</a></td>
                <td><a href="?cmd=affiliates&amp;make=delete&amp;id={$affiliate.id}&security_token={$security_token}"  class="delbtn" onclick="return confirm('{$lang.affdelconf}')">{$lang.Remove}</a></td>
            </tr>

        {/foreach}
    {else}
        <tr>
            <td colspan="10"><p align="center">{$lang.nothingtodisplay}</p></td>
        </tr>
    {/if}
{elseif $action=='configuration'}
    {if $commisions}
        {foreach from=$commisions item=commision}
            <tr>
                <td><input type="checkbox" class="check" value="{$commision.id}" name="selected[]"/></td>
                <td><a href="?cmd={$cmd}&action=commision&make=edit&id={$commision.id}">{$commision.id}</a></td>
                <td><a href="?cmd={$cmd}&action=commision&make=edit&id={$commision.id}">{$commision.name}</a></td>
                <td> {$currency_id}
                    {if $commision.type!='Percent'}{$commision.rate|price:$currency}{/if}
                    {if $commision.type=='Percent'}{$commision.rate}%{/if}
                </td>		  
                <td>{$commision.notes}</td>
            </tr>
        {/foreach}
    {else}
        <tr>
            <td colspan="10"><p align="center">{$lang.nothingtodisplay}</p></td>
        </tr>
    {/if}
{elseif $action=='vouchers'}
    {if $vouchers}
        {foreach from=$vouchers item=voucher}
            <tr>
                <td><input type="checkbox" class="check" value="{$voucher.id}" name="selected[]"/></td>
                <td>{$voucher.code}</td>
                <td><a href="?cmd={$cmd}&action=affiliate&id={$voucher.aff_id}">{$voucher.lastname} {$voucher.firstname}</a></td>
                <td>{if $voucher.type == 'percent'}{$voucher.value}%{else}{$voucher.value|price:$currency}{/if}</td>		  
                <td>{$voucher.num_usage}</td>
            </tr>
        {/foreach}
    {else}
        <tr>
            <td colspan="10"><p align="center">{$lang.nothingtodisplay}</p></td>
        </tr>
    {/if}
{elseif $action=='commissions'}
    {if $commissions}
        {foreach from=$commissions item=order}
            <tr {if $order.paid=='1'}class="compor"{/if}>
                <td>{$order.id}</td>
                <td><a href="?cmd=orders&action=edit&id={$order.order_id}" >{$order.number}</a></td>
                <td>{$order.date_created|dateformat:$date_format}</td>
                <td><a href="?cmd=affiliate&action=show&id={$order.aff_id}">{$order.lastname} {$order.firstname}</a></td>
                <td><a href="?cmd=clients&action=show&id={$order.client_id}">{$order.c_lastname} {$order.c_firstname}</a></td>
                <td>{$order.total|price:$order.c_currency_id}</td>
                <td>{$order.commission|price:$order.currency_id}</td>
                <td>
                    {if $order.paid!='1'}
                       {* <a href="?cmd=affiliates&action=affiliate&id={$affiliate.id}&acceptref={$order.id}&security_token={$security_token}">{$lang.No}</a> *}
                       {$lang.No}
                    {else}
                        {$lang.Yes}
                    {/if}
                </td>
                <td>
                    {if $order.coupon_id}{$lang.Yes}{else}{$lang.No}{/if}
                </td>
            </tr> 
        {/foreach}
    {else}
        <tr>
            <td colspan="10"><p align="center">{$lang.nothingtodisplay}</p></td>
        </tr>
    {/if}
{/if}