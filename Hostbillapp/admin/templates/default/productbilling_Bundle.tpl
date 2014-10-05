<div class="bundle-capsule" id="bundle_pricngopt">
    {include file="ajax.productbilling_Bundle.tpl" show='pricingopt'}
</div>
{*Breaking out fom td#priceoptions *}
</td>
</tr>
<tr>
    <td style="text-align: right; font-weight: bold; vertical-align: top">Items</td>
    <td>
        
        <div>
            <select class="bundle-select-type inp" id="bundledprodctstype">
                <option value="Product" >Product</option>
                <option value="Domain" >Domain</option>
                <option value="Addon" >Addon</option>
            </select>
            <select class="bundle-select inp" id="bundledprodcts">
                <option value="0" id="empty_opt" >Select product..</option>
                {foreach from=$bundle_categories item=category}
                    <optgroup class="{if $category.product_type=='DomainsType'}group_Domain{else}group_Product{/if}" label="{$category.name}">
                        {foreach from=$category.products item=catproduct}
                            <option value="{$catproduct.id}" >{$catproduct.name}</option>
                        {/foreach}
                    </optgroup>
                {/foreach}
                <optgroup class="group_Addon" label="Addons">
                    {foreach from=$addons.addons item=addon}
                        <option value="{$addon.id}" >{$addon.name}</option>
                    {/foreach}
                </optgroup>
            </select>
        </div>
        <div class="bundle-items clearfix">
            <div class="overlay">
                {$lang.nothingtodisplay}
            </div>
            <ul class="bundle-list">
                {foreach from=$bundle_config.products item=bundled}
                    <li class="bundled-item" id="bundle_{$bundled.id}_{$bundled.bunid}_{$bundled.type}">
                        <span class="grab-sorter left"><a class="sorter-handle"></a></span>
                        <span class="remove right"><a class="delbtn" href="#" title="Remove this item" onclick="bundle_remove(this); return false"></a></span>
                        <span class="edit right"><a class="delbtn" href="{if $bundled.type=='Addon'}?cmd=productaddons&action=addon&id={else}?cmd=services&action=product&id={/if}{$bundled.id}" target="_blank" title="Go to product page"></a></span>
                        <span class="config right"><a class="editbtn" href="#" onclick="bundle_config(this); return false;" title="Configure this item"></a></span>
                        <input type="hidden" value="{$bundled.bunid}" class="bundle-sort" name="bundle_sort[]">
                        <input type="hidden" value="{$bundled.type}" name="bundle_type[{$bundled.bunid}]">
                        <input type="hidden" value="{$bundled.id}" name="bundle_item[{$bundled.bunid}]">
                        <div>
                            <a href="#config" title="Configure" class="loadname" onclick="bundle_config(this); return false;">
                                {if $bundled.type=='Addon'}
                                    {foreach from=$addons.addons item=addon}
                                        {if $addon.id == $bundled.id}Addons - {$addon.name}{break}
                                        {/if}
                                    {/foreach}
                                {else}
                                    {$bundled.name}
                                {/if}
                            </a>
                        </div>
                    </li>
                {/foreach}
                <li class="bundled-item template" id="bundle_">
                    <span class="grab-sorter left"><a class="sorter-handle"></a></span>
                    <span class="remove right"><a class="delbtn" href="#" title="Remove this item" onclick="bundle_remove(this); return false"></a></span>
                    <span class="edit right"><a class="delbtn" href="" target="_blank" title="Go to product page"></a></span> 
                    <span class="config right"><a class="editbtn" href="#" onclick="bundle_config(this); return false;" title="Configure this item"></a></span>
                    <input type="hidden" value="" name="bundle_sort[]" class="bundle-sort">
                    <input type="hidden" value="" name="bundle_item[]">
                    <input type="hidden" value="" name="bundle_type[]">
                    <div><a href="#config" title="Configure" class="loadname" onclick="bundle_config(this); return false;"></a></div>
                </li>
            </ul>
            <div id="bundle_config">
            </div>
            <div id="bundle_ajax" class="overlay">
            </div>
        </div>
        <script type="text/javascript" src="{$template_dir}js/bundle.js"></script>
        <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}js/bundle.css" />
        
{* breaking out fom td*}
    </td>
</tr>
{if ($product.valid_to && $product.valid_to!='0000-00-00') || ($product.valid_from && $product.valid_from!='0000-00-00')}
    {assign var=showtimecontrol value=true}
{/if}
<tr class="timecontrol" {if $showtimecontrol}style="display:table-row"{/if} >
    <td style="text-align: right; font-weight: bold; vertical-align: top">Time validation</td>
    <td>
        <a href="#" title="Control for what period of time this product will be available" class="vtip_description"></a> 
    </td>
</tr>
<tr class="timecontrol" {if $showtimecontrol}style="display:table-row"{/if} >
    <td style="text-align: right; vertical-align: top">Valid from</td>
    <td><input name="valid_from" value="{if $product.valid_from && $product.valid_from!='0000-00-00'}{$product.valid_from|dateformat:$date_format}{/if}" class="inp haspicker"/></td>
</tr>
<tr class="timecontrol" {if $showtimecontrol}style="display:table-row"{/if} >
    <td style="text-align: right; vertical-align: top">Valid to</td>
    <td><input name="valid_to" value="{if $product.valid_to && $product.valid_to!='0000-00-00'}{$product.valid_to|dateformat:$date_format}{/if}" class="inp haspicker"/></td>
</tr>
<tr><td>
            