{if $show=='pricingopt'}
    {if $product_x}
        {assign var=product value=$product_x}
    {/if}
    <input id="pricing_overide_switch" type="checkbox" value="1" name="bundle_fixedprice" {if $bundle_config.fixedprice}checked="checked"{/if} onchange="bundle_pricingopt(this); return false;" /> Set fixed price
    <div id="pricing_overide" {if !$bundle_config.fixedprice}style="display: none"{/if} >
        <input type="hidden" value="Bundle" name="paytype" />
        {foreach from=$bundle_billingmodels item=bm name=boptloop}
            <a href="#" class="billopt {if $smarty.foreach.boptloop.first}bfirst{/if} {if $product.paytype==$bm}checked{/if}" onclick='return switch_t2(this,"{$bm}");'>
                {if $lang[$bm]}{$lang[$bm]}
                {else}{$bm}
                {/if}
            </a>
            <input type="radio" value="{$bm}" name="bundle_paytype" {if $product.paytype==$bm}checked="checked"{/if}  id="{$bm}" style="display:none"/>
        {/foreach}
        {foreach from=$bundle_billingmodels item=bm name=boptloop}
            {include file="productbilling_`$bm`.tpl"}
        {/foreach}
    </div>
    {foreach from=$product key=p_cycle item=p_price }
        {if $p_price > 0 && ($p_cycle == 'd' || $p_cycle == 'w' || $p_cycle == 'm' || $p_cycle == 'q' || $p_cycle == 's' || $p_cycle == 'a' || $p_cycle == 'b' || $p_cycle == 't' || $p_cycle == 'p4' || $p_cycle == 'p5')}
            {assign value=true var=showpricebox}
        {/if}
    {/foreach}
    {if $bundle_config.discount || ($product.paytype!='Free' && $showpricebox)}
    <div id="pricing_dynamo" {if $bundle_config.fixedprice}style="display: none"{/if} class="p5">
        {if $product.paytype=='Once'}
            <input type="checkbox" value="Once" name="dynamic_paytype" disabled="disabled" checked="checked"  style="display:none"/>
            <div class="like-table-row once">
                <div style="padding-left:2px;width: 125px;"><b>{$lang.Once} </b></div> 
                <div> Price: <b>{$product.m|price:$currency}</b></div>
                {if $product.$p_setup>0}
                    <div style="width: 120px; text-align: right"><b> {$lang.setupfee}</b> </div> 
                    <div>{$product.m_setup|price:$currency}} </div> 
                {/if}
            </div> 
        {else}
        <input type="checkbox" value="BundleRegular" name="dynamic_paytype" disabled="disabled" checked="checked" style="display:none" />
        {foreach from=$product key=p_cycle item=p_price }
            {if $p_price > 0 && ($p_cycle == 'd' || $p_cycle == 'w' || $p_cycle == 'm' || $p_cycle == 'q' || $p_cycle == 's' || $p_cycle == 'a' || $p_cycle == 'b' || $p_cycle == 't' || $p_cycle == 'p4' || $p_cycle == 'p5')}
                <div class="like-table-row" rel="{$p_cycle}pricing" >
                    <div style="padding-left:2px;width: 125px;"><b>{$lang.$p_cycle} </b></div> 
                    <div> Price: <b>{$p_price|price:$currency}</b></div>
                    {assign value="`$p_cycle`_setup" var=p_setup}
                    {if $product.$p_setup>0}
                        <div style="width: 120px; text-align: right"><b> {$lang.setupfee}</b> </div> 
                        <div>{$product.$p_setup|price:$currency} </div> 
                    {/if}
                </div> 
            {/if}
        {/foreach}
        {/if}
        <div id="bundle_discount" class="like-table-row">
            <div style="padding-left:2px;width: 125px;"><b>{$lang.Discount} </b></div> 
            <div>
                <span class="editbtn_flash">
                    {if !$bundle_config.discount}
                        {$lang.none}
                        <a href="#" class="editbtn" onclick="$(this).parent().hide().next().show();return false;">{$lang.Add}</a>
                    {else}
                        {if $bundle_config.discount.code}
                            <a href="?cmd=coupons&action=edit&id={$bundle_config.discount.id}" target="_blank" >{$bundle_config.discount.code} </a>
                        {/if}
                        {if $bundle_config.discount.type == 'percent'}{$bundle_config.discount.value}%
                        {else}{$bundle_config.discount.value|price:$currency}
                        {/if}
                        <a href="#" class="editbtn" onclick="$(this).parent().next().remove(); bundle_discount(); return false;">{$lang.Remove}</a>
                    {/if}
                </span>
                <span style="display:none">
                    {if $coupons}
                        <select class="inp" name="discount_coupon" onchange="if($(this).val() == 0) $(this).hide().next().show();">
                            <option value="">------</option>
                            {foreach from=$coupons item=coupon}
                                <option {if $couponid == $coupon.id}selected="selected"{/if} value="{$coupon.id}">{$coupon.code} (-{if $coupon.type == 'percent'}{$coupon.value}%{else}{$coupon.value|price:$draft.currency}{/if})</option>
                            {/foreach}
                            <option value="0">自定义折扣</option>
                        </select>
                    {/if}
                    <span {if $coupons}style="display:none" {/if}>
                        <input class="inp" name="discount_value" type="text" size="3" value="{$discount.value}" />
                        <select class="inp" name="discount_type">
                            <option {if $discount.type == 'fixed'}selected="selected"{/if} value="fixed">定额</option>
                            <option {if $discount.type == 'percent'}selected="selected"{/if} value="percent">百分比</option>
                        </select>
                    </span>
                    <button onclick="bundle_discount(); return false;">{$lang.Add}</button>
                </span>
            </div>
        </div> 
    </div>
    {/if}
{else} {* DEFAULT *}
<div class="bundle-item-config" id="config{$details.id}_{$bundleid}_{$type}">
    {if $type == 'Product'}
        <h3>{$details.category_name} - {$details.name}</h3>
        <div class="like-table-row">
            <div style="width: 160px">{$lang.billingcycle}</div>
            <div>
                {if $details.paytype=='Free'}
                    {$lang.freeproduct} 
                    <input name="product_cycle[{$bundleid}][free]" value="free" type="hidden" />
                {elseif $details.paytype=='Once'}
                    <input name="product_cycle[{$bundleid}][once]" value="once" type="hidden" />
                    {$details.m|price:$currency} {$lang.Once} / {$details.m_setup|price:$currency} {$lang.setupfee} 
                {else}
                    {foreach from=$details item=p_price key=p_cycle}
                        {if $p_cycle == 'd' || $p_cycle == 'w' || $p_cycle == 'm' || $p_cycle == 'q' || $p_cycle == 's' || $p_cycle == 'a' || $p_cycle == 'b' || $p_cycle == 't' || $p_cycle == 'p4' || $p_cycle == 'p5'}
                            {if $p_price > 0}
                                <input name="product_cycle[{$bundleid}][{$p_cycle}]" value="1" {if $draft.services[$p_cycle]}checked="checked"{/if} type="checkbox" />{$p_price|price:$currency} {$lang.$p_cycle} {assign value="`$p_cycle`_setup" var=p_setup}{if $details.$p_setup>0}  + {$details.$p_setup|price:$currency} {$lang.setupfee} {/if}
                            {/if}
                        {/if}
                    {/foreach}
                {/if}
            </div>
        </div>
        {*
        {if $details.hostname || $details.owndomain || $details.domain_options}
            <div class="like-table-row">
                <div style="width: 160px">{$lang.Domain}</div>
                <div>
                    <input class="inp" name="host" value="{$submit.host}"  />
                </div>
            </div>
        {/if}
        *}
        {if $details.addons}
            {foreach from=$details.addons item=addon key=addon_id}
                <div class="like-table-row">
                    <div style="width: 160px">{$addon.name}</div>
                    <div>
                        <input class="inp" type="text" onkeypress="if(event.charCode != 0 && (event.charCode < 48 || event.charCode > 57)) return false;" size="2" value="{$addon.qty}" name="addons[{$bundleid}][{$addon_id}][qty]" /> x
                        {include file='_common/billing_select.tpl' product=$addon format=$draft.currency cycle=$addon.recurring name="addons[`$bundleid`][`$addon.id`][cycle]" atributes='onchange=""' }
                        {if $addon.description}
                            <small>{$addon.description}</small>
                        {/if}
                    </div>
                </div>
            {/foreach}
        {/if}

        {if $details.forms}
            {foreach from=$details.forms item=c key=kk}
                {if $c.items}
                    <div class="like-table-row">
                        <label class="right">
                            <input class="form-disabler" {if $submit.bundle_custom[$bundleid][$c.id]}checked="checked"{/if} type="checkbox" value="1" name="bundle_custom[{$bundleid}][{$c.id}]" onchange="bundle_optionalconfig(this);" >
                            在购物车显示
                        </label>
                        <div style="width: 160px"><span>{$c.name} </span></div>
                        <div class="details_cf_{$kk}" default="{$c.config.initialval}">
                            {include file=$c.configtemplates.accounts}
                        </div>
                    </div>
                {/if}
            {/foreach}
        {/if}

        {*foreach from=$draft.services item=service key=scycle}
            <div class="like-table-row">
                <div style="width: 160px">{$lang.$scycle} 循环</div>
                <div>
                    合计: {$service.total.total|price:$currency} 
                    {foreach from=$service.total.recurring item=price key=cycle}
                        <br />
                        {$price|price:$currency} {$lang.$cycle}
                    {/foreach}
                </div>
            </div>
        {/foreach*}
    {elseif $type=='Domain'}
        <h3>{$details.category_name} - {$details.name}</h3>
        {if $details.periods}
            <div class="like-table-row">
                <div style="min-width: 160px">{$lang.Period}</div>
                <div>
                    {foreach from=$details.periods item=period}
                        <input value="{$period.period}" name="domain_period[{$bundleid}][{$period.period}]" type="checkbox" {if $draft.domains[$period.period]}checked="checked" {/if} />{$period.period}{if $period.period == 1} {$lang.Year}{else} {$lang.Years}{/if}
                    {/foreach}
                </div>
            </div>
            {if $details.forms}
                {foreach from=$details.forms item=c key=kk}
                    {if $c.items}
                        <div class="like-table-row">
                            <div style="width: 160px">{$c.name} </div>
                            <div class="product_cf_{$kk}" default="{$c.config.initialval}">
                                {include file=$c.configtemplates.accounts}
                            </div>
                        </div>
                    {/if}
                {/foreach}
            {/if}
        {else}
            {$lang.cantgetperiods}.
        {/if}
    {else}
        <h3>Addon - {$details.name}</h3>
        <div class="like-table-row">
            <div style="width: 160px">{$lang.billingcycle}</div>
            <div>
                {if $details.paytype=='Free'}{$lang.freeproduct}
                {elseif $details.paytype=='Once'}{$details.m|price:$format} {$lang.Once} / {$details.m_setup|price:$format} {$lang.setupfee}
                {else}
                    {foreach from=$details item=p_price key=p_cycle}
                        {if $p_cycle == 'd' || $p_cycle == 'w' || $p_cycle == 'm' || $p_cycle == 'q' || $p_cycle == 's' || $p_cycle == 'a' || $p_cycle == 'b' || $p_cycle == 't' || $p_cycle == 'p4' || $p_cycle == 'p5'}
                            {if $p_price > 0}
                                <input name="addon_cycle[{$bundleid}][{$p_cycle}]" value="1" {if $draft.addons[$p_cycle]}checked="checked"{/if} type="checkbox">{$p_price|price:$currency} {$lang.$p_cycle} {assign value="`$p_cycle`_setup" var=p_setup}{if $details.$p_setup>0}  + {$details.$p_setup|price:$currency} {$lang.setupfee} {/if}</option>
                            {/if}
                        {/if}
                    {/foreach}
                {/if}
            </div>
        </div>
    {/if}
</div>
{/if}