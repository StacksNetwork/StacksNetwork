{if $make=='getservice' || $make=='editservice'}
    {counter name=alter print=false start=1 assign=alter }
    {if $deleted.service || $deleted.domain}
        <tr style="display:none">
            <td colspan="12">
                {foreach from=$deleted.service item=key}
                    <input class="inp" type="hidden" name="service[{$key}][remove]" value="{$key}" />
                {/foreach}
                {foreach from=$deleted.domain item=key}
                    <input class="inp" type="hidden" name="domain[{$key}][remove]" value="{$key}" />
                {/foreach}
            </td>
        </tr>
    {/if}
    {if $draft.domains}
        <!-- DOMAINS -->
        {foreach from=$draft.domains item=domain key=did}
            <tr  class="havecontrols domain_{$did} {counter name=alter}{if $alter%2==0}even{/if}">
                <td>
                    <input class="inp" type="checkbox" name="domain[{$did}][product]" checked="checked" value="{$domain.product.id}" />
                    <input type="hidden" class="fold" name="domain[{$did}][fold]" value="{$fold.domain.$did}" />
                </td>
                <td >
                    <strong>域名</strong>
                </td>
                <td>
                    <strong>{$lang[$domain.action]}: </strong>
                    {$domain.name}
                    <input class="inp" type="hidden" name="domain[{$did}][name]" value="{$domain.sld}" />
                    {if $domain.action=='Transfer' ||  $domain.customizations} 
                        <a href="#" class="right editbtn" {if !$fold.domain.$did}style="display:none"{/if} onclick="order.fold(this);$(this).hide().next().show(); return false;" rel="domain_{$did}"" >{$lang.showdetails}</a>
                        <a href="#" class="right editbtn" {if $fold.domain.$did}style="display:none"{/if} onclick="order.fold(this);$(this).hide().prev().show(); return false;" rel="domain_{$did}" >{$lang.Hide}</a>
                    {/if}
                </td>
                <td>
                    {if $domain.product.periods}
                        <select class="inp" name="domain[{$did}][action]">
                            <option {if $domain.action=='Register'} selected="selected"{/if} value="Register">注册</option>
                            <option {if $domain.action=='Transfer'} selected="selected"{/if} value="Transfer">转账</option>
                        </select>
                        <select class="inp" name="domain[{$did}][period]">
                            {foreach from=$domain.product.periods item=tld}
                                <option {if $domain.action!='Register'}style="display:none"{/if} class="register_p" value="{$tld.period}" {if $tld.period == $domain.period && $domain.action=='Register'}selected="selected" {/if}>{$tld.period}{if $tld.period == 1} {$lang.Year}{else} {$lang.Years}{/if} - {$tld.register|price:$draft.currency}</option>
                                <option {if $domain.action!='Transfer'}style="display:none"{/if} class="transfer_p" value="{$tld.period}" {if $tld.period == $domain.period && $domain.action=='Transfer'}selected="selected" {/if}>{$tld.period}{if $tld.period == 1} {$lang.Year}{else} {$lang.Years}{/if} - {$tld.transfer|price:$draft.currency}</option>
                            {/foreach}
                        </select>

                    {/if}
                </td>
                <td class="editbtn_flash">
                    <span {if $fold.domain.$did}style="display:none"{/if} class="product_price foldable">
                        {$domain.price|price:$draft.currency}
                    </span>
                    {assign value=false var=pricemod}{assign value=false var=custompricemod}
                    {foreach from=$draft.dom_customizations[$did] item=cf key=cfk}
                        {foreach from=$cf item=ci key=cik}
                            {if "smarty:ci.customdata.billing.price"|checkcondition || $domain.customizations[$cfk].items[$cik].org_price}
                                {assign value=true var=custompricemod}
                            {/if}
                        {/foreach}
                    {/foreach}
                    {if $custompricemod || $domain.org_price }{assign value=true var=pricemod}{/if}
                    <span {if !$fold.domain.$did}style="display:none"{/if} class="total_price foldable {if $pricemod}pricemod{/if}" {if $pricemod}title="该价格被修改"{/if}>
                        {$domain.total.total|price:$draft.currency}
                    </span>
                    <input style="display:none; width: 98px"  class="custom_product_price" type="text" 
                           name="domain[{$did}][billing][price]" value="{if $domain.org_price}{$domain.price}{/if}" 
                           placeholder="{if $domain.org_price}{$domain.org_price|price:$draft.currency}{else}{$domain.price|price:$draft.currency}{/if}" />
                    <a href="#" class="editbtn" onclick="return order.edit_back(this);" >{$lang.Edit}</a>
                </td>
            </tr>
            {if $domain.action == 'Transfer'}
            <tr style="{if $fold.domain.$did}display:none{/if}" class="foldable havecontrols domain_{$did} {if $alter%2==0}even{/if}">
                <td></td>
                <td>{$lang.Configuration}</td>
                <td>{$lang.Eppcode}</td>
                <td><input class="inp" type="text" value="{$domain.epp_code|escape}" name="domain[{$did}][eppcode]"/></td>
                <td></td>
            </tr>
            {/if}
            {if $domain.customizations}
                {foreach from=$domain.customizations item=c key=kk}
                    {if $c.items}
                        <tr style="vertical-align: top; {if $fold.domain.$did}display:none{/if}" class="foldable havecontrols domain_{$did} {if $alter%2==0}even{/if}">
                            <td></td>
                            <td>Custom field</td>
                            <td>{$c.name} </td>
                            <td class="domain_{$did}_custom_{$kk}">
                                {include file=$c.configtemplates.accounts currency=$draft.currency forcerecalc=true}
                                <script type="text/javascript">var did = '{$did}'; $('.domain_{$did}_custom_{$kk}').find('input, select').addClass('inp').filter('[name]').each({literal}function(){$(this).attr('name','domain['+did+']'+$(this).attr('name').replace(/^([a-z_]*)/,"[$1]"))}{/literal})</script>
                            </td>
                            <td class="editbtn_flash">
                                {foreach from=$draft.dom_customizations[$did][$c.id] item=ci key=cfk}
                                    <span {if $c.items[$cfk].org_price}class="pricemod" title="This price was modified"{/if}>{$c.price|price:$draft.currency}</span>
                                    <input style="display:none; width: 98px"  class="custom_product_price" type="text" 
                                        name="domain[{$did}][custom_cdata][{$c.id}][{$cfk}][billing][price]" value="{if $c.items[$cfk].org_price}{$c.items[$cfk].price}{/if}" 
                                        placeholder="{if $c.items[$cfk].org_price}{$c.items[$cfk].org_price|price:$draft.currency}{else}{$c.items[$cfk].price|price:$draft.currency}{/if}" />
                                    <a href="#" class="editbtn" onclick="return order.edit_back(this);" >{$lang.Edit}</a>
                                {/foreach}
                            </td>
                        </tr>
                    {/if}
                {/foreach}
            {/if}
        {/foreach}
    {/if}
    {if $draft.services}
        <!-- SERVICES -->
        {foreach from=$draft.services item=service key=sid}

            <tr class="havecontrols service_{$sid} {counter name=alter}{if $alter%2==0}even{/if}" >
                <td>
                    <input class="inp" type="checkbox" name="service[{$sid}][product]" checked="checked" value="{$service.product.id}" />
                    <input class="fold" type="hidden" name="service[{$sid}][fold]" value="{$fold.service.$sid}" />
                </td>
                <td><strong>{$service.category.name}</strong></td>
                <td>
                    {if $service.account_id}
                        <a href="?cmd=accounts&action=edit&id={$service.account_id}" target="_blank">
                            <strong>{$service.product.name}</strong> - 账户 #{$service.account_id}
                        </a>
                    {else}
                        <strong>{$service.product.name}</strong>
                        <span class="editbtn_flash">
                            {if $service.domain}: {$service.domain} 
                                <a href="#" class="editbtn" {if !$fold.service.$sid}style="display:none"{/if} onclick="$(this).parent().hide().next().show();return false;">{$lang.Change}</a>
                            {else}
                                <a href="#" class="editbtn" {if !$fold.service.$sid}style="display:none"{/if} onclick="$(this).parent().hide().next().show();return false;">{$lang.Change} {$lang.Hostname}</a>
                            {/if}
                        </span>
                        {if $service.product.hostname || $service.product.owndomain || $service.product.domain_options}
                            <span style="display:none">: 
                                {if $draft.domains}
                                    <select class="inp" name="service[{$sid}][domain]" onchange="if($(this).val() === '0') $(this).hide().next().show(); else if($(this).val().length) order.get_service($(this).parents('form')[0])" class="noevent">
                                        <option value="">------</option>
                                        {foreach from=$draft.domains item=domain}
                                            <option {if $domain.name == $service.domain}selected="selected"{assign value=true var=seleteddom}{/if}>{$domain.name}</option>
                                        {/foreach}
                                        {if $service.domain && !$seleteddom} <option selected="selected">{$service.domain}</option>
                                        {/if}
                                        <option value="0">使用其它域名</option>
                                    </select>
                                {/if}
                                <input class="inp" {if $draft.domains}style="display:none"{/if} name="service[{$sid}][host]" value="{$service.domain|escape}"  />
                            </span>
                        {/if}
                    {/if}
                    {if $service.addons ||  $service.customizations} 
                        <a href="#" id="showdetails{$sid}" class="right editbtn" onclick="order.fold(this);$(this).hide().next().show(); return false;" rel="service_{$sid}" >{$lang.showdetails}</a>
                        <a href="#" class="right editbtn" style="display:none" onclick="order.fold(this);$(this).hide().prev().show(); return false;" rel="service_{$sid}" >{$lang.Hide}</a>
                    {/if}
                </td>
                <td>
                    {include file='_common/billing_select.tpl' product=$service.product format=$draft.currency cycle=$service.cycle name="service[`$sid`][cycle]" }
                </td>
                <td class="editbtn_flash">
                    <span {if $fold.service.$sid}style="display:none"{/if} class="product_price foldable {if $service.org_price}pricemod{/if}" {if $service.org_price}title="该价格被修改"{/if}>
                        {$service.price|price:$draft.currency} 
                    </span>
                    {assign value=false var=pricemod}{assign value=false var=addonpricemod}{assign value=false var=custompricemod}
                    {foreach from=$draft.customizations[$sid] item=cf key=cfk}
                        {foreach from=$cf item=ci key=cik}
                            {if "smarty:ci.customdata.billing.price"|checkcondition || $service.customizations[$cfk].items[$cik].org_price}
                                {assign value=true var=custompricemod}
                            {/if}
                        {/foreach}
                    {/foreach}
                    {foreach from=$service.addons item=addon}
                        {if $addon.org_price}
                            {assign value=true var=addonpricemod}
                        {/if}
                    {/foreach}
                    {if $custompricemod || $addonpricemod || $service.org_price}{assign value=true var=pricemod}{/if}
                    <span {if !$fold.service.$sid}style="display:none"{/if} class="total_price foldable {if $pricemod}pricemod{/if}" {if $pricemod}title="该价格被修改"{/if}>
                        {$service.total.total|price:$draft.currency}
                    </span>
                    <input style="display:none; width: 98px"  class="custom_product_price" type="text" 
                           name="service[{$sid}][billing][price]" value="{if $service.org_price}{$service.price}{/if}" 
                           placeholder="{if $service.org_price}{$service.org_price|price:$draft.currency}{else}{$service.price|price:$draft.currency}{/if}" />
                    <a href="#" class="editbtn" onclick="{if $fold.service.$sid && ($service.addons ||  $service.customizations) }if(!$('.service_{$sid}:visible').length) $('#showdetails{$sid}').click();{/if}return order.edit_back(this);" >{$lang.Edit}</a>
                </td>
            </tr>
            {if $service.addons}
                {foreach from=$service.addons item=addon}
                    <tr {if $fold.service.$sid}style="display:none"{/if} class="foldable havecontrols service_{$sid} {if $alter%2==0}even{/if}">
                        <td></td>
                        <td>{$lang.accountaddon}</td>
                        <td>{$addon.name}</td>
                        <td>
                            <input class="inp" type="text" onkeypress="if(event.charCode != 0 && (event.charCode < 48 || event.charCode > 57)) return false;" size="2" value="{$addon.qty}" name="service[{$sid}][addons][{$addon.id}][qty]"/> x
                            {include file='_common/billing_select.tpl' product=$addon format=$draft.currency cycle=$addon.recurring name="service[`$sid`][addons][`$addon.id`][cycle]" }
                        </td>
                        <td class="editbtn_flash">
                            <span {if $addon.org_price}class="pricemod" title="该价格被修改"{/if}>{$addon.price|price:$draft.currency}</span>
                            <input style="display:none; width: 98px"  class="custom_product_price" type="text" 
                                name="service[{$sid}][addons][{$addon.id}][billing][price]" value="{if $addon.org_price}{$addon.price}{/if}" 
                                placeholder="{if $addon.org_price}{$addon.org_price|price:$draft.currency}{else}{$addon.price|price:$draft.currency}{/if}" />
                            <a href="#" class="editbtn" onclick="return order.edit_back(this);" >{$lang.Edit}</a>
                        </td>
                    </tr>
                {/foreach}
            {/if}
            {if $service.customizations}
                {foreach from=$service.customizations item=c key=kk}
                    {if $c.items}
                        <tr style="vertical-align: top; {if $fold.service.$sid}display:none{/if}" class="foldable havecontrols service_{$sid} {if $alter%2==0}even{/if}">
                            <td></td>
                            <td>自定义字段</td>
                            <td>{$c.name} </td>
                            <td class="service_{$sid}_custom_{$kk}">
                                {include file=$c.configtemplates.accounts currency=$draft.currency forcerecalc=true}
                                <script type="text/javascript">var sid = '{$sid}'; $('.service_{$sid}_custom_{$kk}').find('input, select').addClass('inp').filter('[name]').each({literal}function(){$(this).attr('name','service['+sid+']'+$(this).attr('name').replace(/custom/,'[custom]'))}{/literal})</script>
                            </td>
                            <td class="editbtn_flash">
                                {foreach from=$draft.customizations[$sid][$c.id] item=ci key=cfk}
                                    {assign value=$draft.customizations[$sid][$c.id][$cfk] var=draftcustomization}
                                    <span {if $c.items[$cfk].org_price}class="pricemod" title="This price was modified"{/if}>{$c.price|price:$draft.currency}</span>
                                    <input style="display:none; width: 98px"  class="custom_product_price" type="text" 
                                        name="service[{$sid}][custom_cdata][{$c.id}][{$cfk}][billing][price]" value="{if $c.items[$cfk].org_price}{$c.items[$cfk].price|price}{/if}" 
                                        placeholder="{if $c.items[$cfk].org_price}{$c.items[$cfk].org_price|price:$draft.currency}{else}{$c.items[$cfk].price|price:$draft.currency}{/if}" />
                                    <a href="#" class="editbtn" onclick="return order.edit_back(this);" >{$lang.Edit}</a>
                                {/foreach}
                            </td>
                        </tr>
                    {/if}
                {/foreach}
            {/if}
        {/foreach}
    {/if}
    {if $draft.price.discount > 0}
        <tr {if $alter%2==0}class="even"{/if}>
            <td style="text-align: right" colspan="4">-</td>
            <td>{$draft.price.discount|price:$draft.currency}</td>
        </tr>
    {/if}
    {if !$draft.services && !$draft.domains}
        <tr class="even">
            <td style="text-align: center" colspan="15">{$lang.no_items}</td>
        </tr>
    {/if}
    {if $unsaved}
        <tr style="display:none">
            <td colspan="15"><input type="hidden" id="unsaved" value="1" /></td>p
        </tr>
    {/if}
{elseif $make == 'listitems'}
    {if $services}
        <tr>
            <td>
                <strong>{$lang.prodslashservice}</strong>
            </td>
            <td>
                <select class="inp" name="product" id="product_id" onchange="order.get_product(this);">
                    <option selected="selected" >-</option>
                    {foreach from=$services item=category}
                        {if $category.products}
                            <optgroup label="{$category.name}">
                            {foreach from=$category.products item=prod}
                                <option value="{$prod.id}" {if $submit.product == $prod.id}selected="selected" {/if}>{$category.name} - {$prod.name}</option>
                            {/foreach}
                            </optgroup>
                        {/if}
                    {/foreach}
                    <option value="new" style="font-weight: bold">{$lang.newservice}</option>
                </select>
                <a class="external" href="#" style="display:none;" target="_blank">检查产品配置</a>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div class="product_config" ></div>
            </td>
        </tr>
    {elseif $domains}
        <tr>
            <td>
                <strong>{$lang.Action}</strong>
            </td>
            <td>
                <label><input class="inp" {if !$submit.domain_action || $submit.action == "Register"}checked="checked"{/if} type="radio" name="domain_action" value="注册" onclick="$('#eppcode').parent().parent().hide();" /> {$lang.Register}</label>
                <label><input class="inp" {if $submit.domain_action == "Transfer"}checked="checked"{/if} type="radio" name="domain_action" value="转账" onclick="$('#eppcode').parent().parent().show();" /> {$lang.Transfer}</label>
            </td>
        </tr>
        <tr>
            <td>
                <strong>{$lang.domainname}</strong>
            </td>
            <td>
                <input class="inp" id="domain_sld" name="domain_sld" value="{$submit.domain_sld}" size="20" />
                <select class="inp" name="domain_tld" id="domain_tld" onchange="order.get_domain(this);">
                    <option selected="selected" >-</option>
                    {foreach from=$domains item=tlds}
                        {if $tlds.products}
                            <optgroup label="{$tlds.name}">
                            {foreach from=$tlds.products item=tld}
                                <option value="{$tld.id}" >{$tld.name}</option>
                            {/foreach}
                            </optgroup>
                        {/if}
                    {/foreach}
                </select>
                <a class="external" href="#" style="display:none;" target="_blank">TLD配置检查</a>
            </td>
        </tr>
        <tr style="display:none">
            <td>
                <strong>{$lang.Eppcode}</strong>
            </td>
            <td>
                <input class="inp" id="eppcode" size="30" value="" name="domain_eppcode">
            </td>
        </tr>
        <tr>
            <td>
                <a href="javascript:void(0);" onclick="order.check_availability()" style="menuitm">{$lang.checkavailability}</a>
            </td>
            <td id="avail_field">
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div id="domain_config" ></div>
            </td>
        </tr>
    {else}
        <tr>
            <td></td>
            <td colspan="2">
                {$lang.nothingwasfound}
            </td>
        </tr>
    {/if}
{elseif $make == 'getclientservice'}
    {if $product}
        <div class="like-table-row">
            <div style="width: 160px">{$lang.prodslashservice}</strong></div>
            <div>
                <select class="inp" name="product" id="product_id" onchange="order.get_product(this);">
                    {foreach from=$upgrades item=category}
                        {if $category.products}
                            <optgroup label="{$category.name}">
                                {foreach from=$category.products item=prod}
                                    <option value="{$prod.id}" {if $submit.product == $prod.id}selected="selected" {/if}>{$category.name} - {$prod.name}</option>
                                {/foreach}
                            </optgroup>
                        {/if}
                    {/foreach}
                </select>
            </div>
        </div>
        <div class="product_config" >
            {include file="orders/ajax.add.tpl" make="getproduct"}
        </div>
    {/if}
{elseif $make == 'getproduct'}
    {if $product}
        <div class="like-table-row">
            <div style="width: 160px">{$lang.billingcycle}</div>
            <div>
                {include file='_common/billing_select.tpl' product=$product format=$draft.currency cycle=$submit.cycle atributes='onchange="order.get_product(this);"'}
            </div>
        </div>

        {if $product.hostname || $product.owndomain || $product.domain_options}
            <div class="like-table-row">
                <div style="width: 160px">{$lang.Domain}</div>
                <div>
                    {if $draft.domains}
                        <select class="inp" name="domain" onchange="if($(this).val() == 0) $(this).hide().next().show(); ">
                            {if $submit.host}<option>{$submit.host}</option>
                            {/if}
                            {foreach from=$draft.domains item=domain}
                                <option>{$domain.name}</option>
                            {/foreach}
                            <option value="0">使用其它域名</option>
                        </select>
                    {/if}
                    <input class="inp"  {if $draft.domains}style="display:none"{/if} name="host" value="{$submit.host|escape}"  />
                </div>
            </div>
        {/if}
        {if $product_addons}
            {foreach from=$product_addons item=addon key=addon_id}
                <div class="like-table-row">
                    <div style="width: 160px">{$addon.name}</div>
                    <div>
                        <input class="inp" type="text" onkeypress="if(event.charCode != 0 && (event.charCode < 48 || event.charCode > 57)) return false;" size="2" value="{$submit.addons[$addon_id].qty}" name="addons[{$addon_id}][qty]" /> x
                        {include file='_common/billing_select.tpl' product=$addon format=$draft.currency cycle=$submit.addons[$addon_id].cycle name="addons[`$addon.id`][cycle]" atributes='onchange="order.get_product(this);"' }
                        {if $addon.description}
                            <small>{$addon.description}</small>
                        {/if}
                    </div>
                </div>
            {/foreach}
        {/if}
        {if $product_forms}
            {*debug output=ajax like=product_forms*}
            {foreach from=$product_forms item=c key=kk}

                {if $c.items}
                    <div class="like-table-row">
                        <div style="width: 160px"><span>{$c.name} </span></div>
                        <div class="product_cf_{$kk}" default="{if $submit.custom.$kk}{foreach from=$submit.custom.$kk item=ci}{$ci}{/foreach}{else}{$c.config.initialval}{/if}">
                            {include file=$c.configtemplates.accounts currency=$draft.currency}
                        </div>
                        <script type="text/javascript">var sid = '{$sid}'; $('.product_cf_{$kk}').find('input, select').each({literal}function(){$(this).addClass('inp')}{/literal})</script>
                    </div>
                {/if}
            {/foreach}
        {/if}
        <script type="text/javascript">order.initFormValues();</script>
        <div class="like-table-row">
            <div style="padding-top: 8px;">&nbsp;
                <a class="menuitm " href="#" onclick="$(this).parents('form').submit(); return false;">
                    {if $submit.service}
                        <span>升级服务</span>
                    {else}
                        <span>添加产品</span>
                    {/if}
                    
                </a>
            </div>
        </div>
    {/if}
{elseif $make == 'getdomain'}

    {if $period}
        <div class="like-table-row">
            <div style="min-width: 160px">{$lang.Period}</div>
            <select class="inp" name="domain_period">
                {foreach from=$period item=years}
                    <option value="{$years}" {if $years == $submit.domain_period}selected="selected" {/if}>{$years}{if $years == 1} {$lang.Year}{else} {$lang.Years}{/if}</option>
                {/foreach}
            </select>
        </div>
        {if $domain_forms}
            {foreach from=$domain_forms item=c key=kk}
                {if $c.items}
                    <div class="like-table-row">
                        <div style="width: 160px">{$c.name} </div>
                        <div class="product_cf_{$kk}" default="{$c.config.initialval}">
                            {include file=$c.configtemplates.accounts currency=$draft.currency}
                        </div>
                        <script type="text/javascript">var sid = '{$sid}'; $('.product_cf_{$kk}').find('input, select').each({literal}function(){$(this).addClass('inp')}{/literal})</script>
                    </div>
                {/if}
            {/foreach}
        {/if}
        <script type="text/javascript">order.initFormValues();</script>
        <div class="like-table-row">
            <div style="padding-top: 8px;">
                <input class="inp" type="hidden" name="prod_type" value="domain" />
                &nbsp;<a class="menuitm " href="#" onclick="$(this).parents('form').submit(); return false;"><span>添加域名</span></a>
            </div>
        </div>
    {else}
        {$lang.cantgetperiods}.
    {/if}
{else}
    <div id="client_nav">
        <!--navigation-->
        <a class="nav_el nav_sel left" href="#">{$lang.orderdetails}</a>
        <div class="clear"></div>
    </div>
    <div class="ticketmsg ticketmain" id="client_tab" style="margin-bottom:10px;">
        <div class="slide" style="display:block">
            <form action="" method="post">
                <input class="inp" type="hidden" value="{$draft_id}" class="draft_id" name="id" />
                <table  width="100%" cellspacing="2" cellpadding="3" border="0" style="table-layout: fixed;">
                    <tbody>
                        <tr>
                            <td width="15%" >{$lang.draftid}</td>
                            <td >{$draft.id}</td>
                            <td width="15%" >{$lang.paymethod}</td>
                            <td >
                                <span class="editbtn_flash">
                                    <a href="?cmd=managemodules&action=payment{if $draft.module}&expand=true&id={$draft.module}{/if}" target="_blank" >
                                        {if $draft.module}
                                            {if $modules}
                                                {foreach from=$modules item=module key=id}
                                                    {if $draft.module == $id}{$module}
                                                    {/if}
                                                {/foreach}
                                            {else}
                                                {$draft.module}
                                            {/if}
                                        {else}{$lang.none}
                                        {/if}
                                    </a>
                                    {if $modules}<a href="#" class="editbtn" onclick="$(this).parent().hide().next().show();return false;">{$lang.Edit}</a>
                                    {/if}
                                </span>
                                <span style="display:none" class="editbtn_flash">
                                    <select class="inp" name="module" onchange="order.new_gateway(this)">
                                        <option value="0">{$lang.none}</option>
                                        {foreach from=$modules item=module key=id}
                                            <option value="{$id}"  {if $draft.module==$id}selected="selected"{/if}>{$module}</option>
                                        {/foreach}
                                        <option value="new" style="font-weight: bold">{$lang.newgateway}</option>

                                    </select>
                                    <a href="#" class="editbtn saved" style="visibility: visible" onclick="order.save_details(); return false;">{$lang.Save}</a>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td>{$lang.Discount}</td>
                            <td>
                                <span class="editbtn_flash">
                                    {if !$draft.discount}
                                        {$lang.none}
                                        <a href="#" class="editbtn" onclick="$(this).parent().hide().next().show();return false;">{$lang.Add}</a>
                                    {else}
                                        {foreach from=$draft.discount item=discount key=couponid}
                                            {if $discount.group_id && $client.group_color}
                                                <a href="?cmd=clients&action=editgroup&id={$discount.group_id}" target="_blank" {if $client.group_color}style="color:{$client.group_color}"{/if} >{$discount.code} </a>
                                            {elseif $discount.code}
                                                <a href="?cmd=coupons&action=edit&id={$couponid}" target="_blank" {if $discount.group_id && $client.group_color}style="color:{$client.group_color}"{/if} >{$discount.code} </a>
                                            {/if}
                                            {if $discount.type == 'percent'}{$discount.value}%
                                            {else}{$discount.value|price:$draft.currency}
                                            {/if}
                                        {/foreach}
                                        <a href="#" class="editbtn" onclick="$(this).parent().next().remove(); order.save_details(); return false;">{$lang.Remove}</a>
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
                                        {if $discount.group_id}
                                            <input name="discount_group_id" type="hidden" value="{$discount.group_id}" />
                                        {/if}
                                        <input class="inp" name="discount_value" type="text" size="3" value="{$discount.value}" />
                                        <select class="inp" name="discount_type">
                                            <option {if $discount.type == 'fixed'}selected="selected"{/if} value="fixed">定额</option>
                                            <option {if $discount.type == 'percent'}selected="selected"{/if} value="percent">百分比</option>
                                        </select>
                                    </span>
                                    <button class="saved" onclick="order.save_details(); return false;">{$lang.Add}</button>
                                </span>
                            </td>
                            <td >{$lang.Client}</td>
                            <td >
                                {if $draft.client_id}
                                    <span class="editbtn_flash">
                                        {if $clients} 
                                            {foreach from=$clients item=cl}
                                                {if $draft.client_id == $cl.id}
                                                    <a href="?cmd=clients&action=show&id={$draft.client_id}">{$cl.lastname} {$cl.firstname}</a>
                                                {/if}
                                            {/foreach}
                                        {else}
                                            <a href="?cmd=clients&action=show&id={$draft.client_id}">#{$draft.client_id}</a>
                                        {/if}
                                        <a href="#" class="editbtn" onclick="$(this).parent().hide().next().show();return false;">{$lang.Change}</a>
                                    </span>
                                {/if}
                                {if $clients} 
                                    <span {if $draft.client_id}style="display:none"{/if} class="editbtn_flash">
                                        <select class="inp" name="client_id" load="clients" default="{$draft.client_id}" style="width: 180px">
                                            <option value="0">{$lang.selectcustomer}</option>
                                            {*foreach from=$clients item=cl}
                                                <option {if $draft.client_id == $cl.id}selected="selected"{/if} value="{$cl.id}">#{$cl.id} {if $cl.companyname!=''}{$lang.Company}: {$cl.companyname}{else}{$cl.lastname} {$cl.firstname}{/if}</option>
                                            {/foreach*}
                                        </select>
                                        <a href="#" class="editbtn saved" style="visibility: visible" onclick="order.save_details(); return false;">{$lang.Save}</a>
                                    </span>
                                {else}
                                    {$lang.thereisnoclients}. {$lang.Click} <a href="?cmd=newclient">{$lang.here}</a> {$lang.toregisternew}.
                                {/if}
                            </td>

                        </tr>
                        <tr>
                            <td >{$lang.Amount}</td>
                            <td class="order_price">
                                {$draft.price.cost|price:$draft.currency}
                            </td>
                            <td >{$lang.staffownership}</td>
                            <td >
                                <span class="editbtn_flash">
                                    {if $draft.staff_member_id}
                                        {if $staff} 
                                            {foreach from=$staff item=cl}
                                                {if $draft.staff_member_id == $cl.id}
                                                    <a href="?cmd=clients&action=show&id={$draft.client_id}">{$cl.lastname} {$cl.firstname}</a>
                                                {/if}
                                            {/foreach}
                                        {else}
                                            <a href="?cmd=clients&action=show&id={$draft.staff_member_id}">#{$draft.staff_member_id}</a>
                                        {/if}
                                    {else}
                                        <a href="#"><em>{$lang.none}</em></a>
                                    {/if}
                                    <a href="#" class="editbtn" onclick="$(this).parent().hide().next().show();return false;">{$lang.Change}</a>
                                </span>
                                {if $staff} 
                                    <span style="display:none" class="editbtn_flash">
                                        <select class="inp" name="staff_member_id" default="{$draft.staff_member_id}" style="width: 180px">
                                            <option value="0">{$lang.none}</option>
                                            {foreach from=$staff item=cl}
                                                <option {if $draft.client_id == $cl.id}selected="selected"{/if} value="{$cl.id}">{$cl.lastname} {$cl.firstname}</option>
                                            {/foreach}
                                        </select>
                                        <a href="#" class="editbtn saved" style="visibility: visible" onclick="order.save_details(); return false;">{$lang.Save}</a>
                                    </span>
                                {/if}
                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align: top">{$lang.Recurring}</td>
                            <td class="order_price_r" style="vertical-align: top">
                                {foreach from=$draft.price.recurring_cost item=price key=cycle}
                                    {$lang.$cycle}: {$price|price:$draft.currency}<br />
                                {/foreach}
                            </td>
                            <td style="vertical-align: top">{$lang.orderdate}</td>
                            <td style="vertical-align: top">
                                <span class="editbtn_flash">
                                    {$draft.date|dateformat:$date_format|regex_replace:'! [^\s]*$!':''} {$draft.date|regex_replace:'!^[^\s]* !':''}
                                    <a href="#" class="editbtn" onclick="$(this).parent().hide().next().show().children().eq(0).datePicker({literal}{startDate:startDate}{/literal}); return false;">{$lang.Change}</a>
                                </span>
                                <span style="display:none" class="editbtn_flash">
                                    <input class="inp" size="12" value="{$draft.date|dateformat:$date_format|regex_replace:'! [^\s]*$!':''}" name="orderdate"/>
                                    <input class="inp" size="6" value="{$draft.date|regex_replace:'!^[^\s]* !':''}" name="ordertime" />
                                    <a href="#" class="editbtn" style="visibility: visible" onclick="order.save_details(); return false;">{$lang.Save}</a>
                                </span>
                            </td>
                        </tr>
                        
                        <tr>
                            {if !$scenarios}
                            <td style="vertical-align: top">订单场景</td>
                            <td style="vertical-align: top">
                                <span class="editbtn_flash">
                                    {if $draft.scenario_id}
                                    <a href="?cmd=configuration&action=orderscenarios&do=edit&id={$draft.scenario_id}" target="_blank" >
                                          {foreach from=$scenarios item=scenario name=scloop}{if $draft.scenario_id==$scenario.id}{$scenario.name}{break}{/if}
                                        {/foreach}
                                    </a>
                                    {else}
                                        <a href="#"><em>无, 使用分类/客户默认</em></a>
                                        {/if}
                                   <a href="#" class="editbtn" onclick="$(this).parent().hide().next().show();return false;">{$lang.Edit}</a>
                                   
                                </span>
                                <span style="display:none" class="editbtn_flash">
                                    <select class="inp" name="scenario_id" >
                                            <option value="0" {if !$draft.scenario_id}selected="selected"{/if}>无, 使用分类/客户默认</option>
                                       {foreach from=$scenarios item=scenario name=scloop}
                                            <option value="{$scenario.id}"  {if $draft.scenario_id==$scenario.id}selected="selected"{/if}>{$scenario.name}</option>
                                        {/foreach}

                                    </select>
                                    <a href="#" class="editbtn saved" style="visibility: visible" onclick="order.save_details(); return false;">{$lang.Save}</a>
                                </span>
                            </td>
                            {/if}
                            <td style="vertical-align: top" rowspan="2">{$lang.additional_options}</td>
                            <td style="vertical-align: top" rowspan="2">
                                <div>
                                    <input type="checkbox" value="1" name="confirm" {if $draft.options.confirm_email}checked="checked"{/if} onclick="$('#order_options').css('visibility','visible')" />
                                    {$lang.sendconfirmemail}
                                </div>
                                <div>
                                    <input type="checkbox" value="1" name="invoice_generate" {if $draft.options.generate_invoice}checked="checked"{/if} onclick="var to = true; if($(this).prop('checked')) to = false; $(this).parent().next().children().attr('disabled', to).prop('disable',to); $('#order_options').css('visibility','visible')"/>
                                    {$lang.generateinvoice}
                                </div>
                                <div>
                                    <input type="checkbox" value="1" name="invoice_info" {if !$draft.options.generate_invoice}disabled="disabled"{/if} {if $draft.options.send_invoice && $draft.options.generate_invoice}checked="checked"{/if} id="invsend" onchange="$('#order_options').css('visibility','visible')"/>
                                  {$lang.sendinvoiceinfo}
                                </div>
                                <a href="#" id="order_options" class="editbtn saved" style="visibility: hidden" onclick="order.save_details(); return false;">{$lang.savechanges}</a>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
    </div>
{/if}
