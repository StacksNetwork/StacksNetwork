{foreach from=$invoice.items item=item}
    <tr id="line_{$item.id}">
        <td style="padding-right:0px;padding-left:0px" class="acenter"><input type="checkbox" name="invoice_item_id[]" value="{$item.id}" class="invitem_checker"/></td>
        <td class="editline">
            {if $item.type=='Hosting' && $item.item_id!='0'}
                <a href="?cmd=accounts&action=edit&id={$item.item_id}&list=all" class="line_descr">{$item.description|nl2br}</a>
            {elseif ($item.type=='Domain Register' || $item.type=='Domain Transfer' || $item.type=='Domain Renew') && $item.item_id!='0'}
                <a href="?cmd=domains&action=edit&id={$item.item_id}" class="line_descr">{$item.description|nl2br}</a>
            {elseif $item.type=='Invoice' && $item.item_id!='0'}
                <a href="?cmd=invoices&action=edit&id={$item.item_id}&list=all" class="line_descr">{$item.description|nl2br}</a>
            {elseif $item.type=='Support' && $item.item_id!='0'}
                <a href="?cmd=tickettimetracking&action=item&id={$item.item_id}" class="line_descr">{$item.description|nl2br}</a>
            {else}
                <span class="line_descr">{$item.description|nl2br}</span>
            {/if}
            <a class="editbtn" style="display:none;"  href="#">{$lang.Edit}</a>
            <div style="display:none" class="editor-line">
                <textarea name="item[{$item.id}][description]">{$item.description}</textarea>
                <a class="savebtn" href="#" >{$lang.savechanges}</a>
            </div>
        </td>
        <td class="acenter"><input name="item[{$item.id}][qty]" value="{$item.qty}" size="8" class="foc invitem invqty" style="text-align:center"/></td>
        <td class="acenter">
            <input type="checkbox" name="item[{$item.id}][taxed]" 
                   {if $item.taxed == 1}checked="checked" {/if}
                   {if $invoice.taxexempt}disabled="disabled"{/if}
                   value="1" class="invitem2"/>
        </td>
        <td class="acenter"><input name="item[{$item.id}][amount]" value="{$item.amount}" size="16" class="foc invitem invamount" style="text-align:right"/></td>
        <td class="aright">{$currency.sign} <span id="ltotal_{$item.id}">{$item.linetotal|string_format:"%.2f"}</span> {if $currency.code}{$currency.code}{else}{$currency.iso}{/if}</td>
        <td class="acenter"><a href="?cmd=invoices&action=removeline&id={$invoice.id}&line={$item.id}" class="removeLine"><img src="{$template_dir}img/trash.gif" alt="{$lang.Delete}"/></a></td>
    </tr>
{/foreach}