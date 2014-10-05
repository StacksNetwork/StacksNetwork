<ul id="customitemseditor" class="grab-sorter" style="border:solid 1px #ddd;border-bottom:none;">
    {if $field.items}

						{foreach from=$field.items item=item key=k}{if $item.id!=0}
    <li style="background:#ffffff">
        <div style="border-bottom:solid 1px #ddd;">
            <table width="100%" cellspacing="0" cellpadding="5" border="0">
                <tbody><tr>
                        <td width="20" valign="top"><div style="padding:5px 0px;"><input type="hidden" name="items[{$k}][id]" value="{$item.id}"/>
                                <input type="hidden" name="sort[]" value="{$item.id}" class="ser2"/><a onclick="return false" class="sorter-ha menuitm" href="#"><span title="move" class="movesth">&nbsp;</span></a></div></td>
                        <td valign="top">
                            {hbinput value=$item.tag_name  class="w250" name="items[$k][name]" style="margin:0px;"  wrapper="div"  wrapper_class="w250 left" wrapper_style="clear:right;margin: 0px;"}

                           

                        </td>
                        <td align="right" valign="top">
                            <div style="padding:5px 0px;">{if $field.type.info.pricing}<a onclick="$('#fpricing_{$k}').toggle();$(this).toggleClass('activated');return false;" title="{$lang.enablepricing}" class="menuitm menuf" href="#"><span class="billsth">&nbsp;</span></a>{/if}<!--
                               --><a onclick="$('#fvar_{$k}').toggle();$(this).toggleClass('activated');return false;" title="Advanced options" class="menuitm {if !$field.type.info.pricing}menuf{else}menuc{/if}" href="#"><span class="gear">&nbsp;</span></a><!--
                                --><a onclick="return deleteItem(this)" title="delete" class="menuitm menul" href="?cmd=configfields&action=deleteitem&id={$item.id}"><span class="delsth"></span></a>
                            </div>
                        </td>
                    </tr>
                    <tr style="display:none" id="fvar_{$k}">
                        <td></td>
                        <td colspan="2">
                            <label class="nodescr">Value passed to App:</label> <input type="text" value="{$item.variable_id}" style="margin:0px 0px 0px 10px;width:80px;" name="items[{$k}][variable_id]">
                        </td>
                    </tr>
                    {if $field.type.info.pricing}<tr style="display:none" id="fpricing_{$k}">
                        <td colspan="3">
                            <label >{$lang.enablepricing}</label>
                            <input  type="checkbox" name="items[{$k}][pricing]" value="1" {if isset($item.d)}checked="checked"{/if} onclick="$(this).parent().find('.pricingtable').toggle()"/> 
                            <small>&nbsp;&nbsp;&nbsp;{$lang.chargeforvalue}</small>

                            {if $paytypeform}
                                {include file="formbilling_`$paytypeform`.tpl"}
                            {else}
                                {include file='formbilling_Regular.tpl'}
                            {/if}
                        </td>
                    </tr>{/if}
                </tbody></table>
        </div>
    </li>{/if}
						{/foreach}


			   {/if}

</ul>
<script type="text/javascript">latebindme();if(typeof updatePricingForms == 'function')  updatePricingForms();</script>
<div style="border:solid 1px #ddd;border-top:none;background:#F5F9FF;width:365px" class="left">
    <table width="100%" cellspacing="0" cellpadding="5" border="0">
        <tbody><tr>
                <td width="20" valign="top"><div style="padding:5px 0px;">{$lang.New}:</div></td>
                <td valign="top"><input name="new_value_name" type="text" class="w250" style="margin:0px" value="" /></td>
                <td align="right" valign="top">
                    <div style="padding:5px 0px;">
                        <a {if $field.id=='new'}
                            onclick="alert('{$lang.savefirsterror}'); return false;"
                            {else}
                            onclick="$(this).addClass('activated');return addNewConfigItemValue()"
                            {/if} class="new_control greenbtn" href="#"><span>{$lang.Add}</span></a></div>
                </td>
            </tr>
        </tbody></table>
</div>
{if $premade}
<div class="right  shownice" style="padding:5px ">
    <select name="premadeid" id="premadeid" style="margin:0px">
        <option value="0">Use pre-made values</option>
        {foreach from=$premade item=p}
        <option>{$p}</option>
        {/foreach}
    </select>
    <div class="right" style="margin:7px 0px 0px 9px"><a  class="new_control" href="#"
                                                          {if $field.id=='new'}
                                                          onclick="alert('{$lang.savefirsterror}'); return false;"
                                                          {else}
                                                          onclick="return usePremade()"
                                                          {/if}
                                                          ><span><b>{$lang.submit}</b></span></a>  </div>
</div>
{/if}
<div class="clear"></div>
<input type="hidden" id="lastitm" value="{$k+1}"/>