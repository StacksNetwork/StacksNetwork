{*
PARAMS:
product - priceing data
cycle - selected cycle
name - form name
format - currency format
caseif - set to false will disable inputs
atributes - form select atributes as a string
USAGE:
{include file='_common/billing_select.tpl' product=$your_product_variable format=$currency cycle='a'}
*}
{if !$format}
    {assign var=format value=$currency}
{/if}
{if !$name}
    {assign var=name value="cycle"}
{/if}
{if !$atributes}
    {assign var=atributes value=""}
{/if}
{if $product.paytype=='Free'}
    {if !$caseif}
        <input type="hidden" name="{$name}" value="Free" />
    {/if}
    {$lang.freeproduct}
{elseif $product.paytype=='Once'}
    {if !$caseif}
        <input type="hidden" name="{$name}" value="Once" />
    {/if}
    {$product.m|price:$format} {$lang.Once} / {$product.m_setup|price:$format} {$lang.setupfee}
{else}
    {foreach from=$product item=p_price key=p_cycle}
        {assign value=false var=not_free}
        {if $p_price > 0 && ($p_cycle == 'h' || $p_cycle == 'd' || $p_cycle == 'w' || $p_cycle == 'm' || $p_cycle == 'q' || $p_cycle == 's' || $p_cycle == 'a' || $p_cycle == 'b' || $p_cycle == 't' || $p_cycle == 'p4' || $p_cycle == 'p5')}
            {assign value=true var=not_free}
            <select class="inp" {if $caseif}disabled="disabled"{/if} name="{$name}" {$atributes}>
                {foreach from=$product item=p_price key=p_cycle}
                    {if $p_cycle == 'h' || $p_cycle == 'd' || $p_cycle == 'w' || $p_cycle == 'm' || $p_cycle == 'q' || $p_cycle == 's' || $p_cycle == 'a' || $p_cycle == 'b' || $p_cycle == 't' || $p_cycle == 'p4' || $p_cycle == 'p5'}
                        {if $p_price > 0}
                            <option value="{$p_cycle}" {if $cycle == $p_cycle}selected="selected" {/if} >{$product.$p_cycle|price:$format} {$lang.$p_cycle} {assign value="`$p_cycle`_setup" var=p_setup}{if $product.$p_setup>0}  + {$product.$p_setup} {$lang.setupfee} {/if}</option>
                        {/if}
                    {/if}
                {/foreach}
            </select>
            {break}
        {/if}
    {/foreach}
    {if !$not_free}
        {if !$caseif}
            <input type="hidden" name="{$name}" value="Free" />
        {/if}
        {$lang.free}
    {/if}
{/if}
