<div id="Metered_b" {if $product.paytype!='Metered'}style="display:none"{/if} class="p5 boption">
{if $typetemplates.productconfig.metered.replace}
    {include file=$typetemplates.productconfig.metered.replace}
{else}


<div id="meteredmgr" >
    <div style="">

        <b>Following variables can be measued and billed automatically: <a title="Note: Fill price rules below with amounts you wish to charge <b>over</b> whats offered with this package as standard. Ending QTY set to 0 means &infin; (infinity)
            <br/> I.e. 100GB traffic/month is free with package, everything over that should be configured with metered billing table." class="vtip_description"></a></b>
        <div class="clear"></div>

        <ul style="list-style:none;padding:0px;margin:0px;"  >
            {foreach from=$product.metered item=varx key=k}
            <li style="background:#ffffff"><div >
                    <table width="100%" cellspacing="0" cellpadding="5" border="0">
                        <tbody><tr>
                                <td width="70" valign="top"><div style="padding:10px 0px;"><a onclick="return var_toggle('{$k}',true);"  id="enabler_{$k}" class="prices menuitm " {if $varx.enable}style="display:none"{/if} href="#"><span  class="addsth">Enable</span></a>
                                        <a onclick="return var_toggle('{$k}',false);" class="prices menuitm " href="#" {if !$varx.enable}style="display:none"{/if} id="disabler_{$k}"><span  class="rmsth">Disable</span></a></div></td>
                                <td width="300"><b>{$varx.name}</b></td>
                                <td valign="top" {if $varx.description}style="background:#F0F0F3;color:#767679;font-size:11px"{/if}>{$varx.description}
                                {if $varx.user_defined}<span class="right fs11">API variable: <b>{$k}</b> <a class="editbtn" onclick="return rmMeteredVar('{$k}')" href="">Delete this var</a></span>{/if}
                                </td>
                            </tr>
                            <tr  id="var_{$k}"  {if !$varx.enable}style="display:none"{/if}><td></td><td colspan="2">
                                    <input type="hidden" name="metered[{$k}][enable]" value="{if !$varx.enable}0{else}1{/if}" id="{$k}_enable" class="enablr" />
                                    <input type="hidden" name="metered[{$k}][id]" value="{$varx.id}"  />
                                    <table border="0" cellpadding="3" class="left" cellspacing="0" id="{$k}_table" >
                                        <tr>
                                            <td width="100" class="fs11">Starting QTY</td>
                                            <td width="100" class="fs11">Ending QTY</td>
                                            <td width="150" class="fs11">Unit price</td>
                                        </tr>
                                        {if !$varx.prices}
                                          <tr >
                                            <td><input type="text" class="inp" size="3" value="0" name="metered[{$k}][prices][0][qty]" /></td>
                                            <td><input type="text" class="inp" size="3" value="" name="metered[{$k}][prices][0][qty_max]"  /></td>
                                            <td><input type="text" class="inp" size="3" value="{0.000|price:$currency:false:false}"  name="metered[{$k}][prices][0][price]" /> /{$varx.unit_name}</td>
                                            <td><a class="fs11" href="#" onclick="return removeRow(this)">Remove</a></td>
                                        </tr>
                                        {/if}
                                        {foreach from =$varx.prices item=p key=kx}
                                        <tr >
                                            <td><input type="text" class="inp" size="3" value="{$p.qty}" name="metered[{$k}][prices][{$kx}][qty]" /></td>
                                            <td><input type="text" class="inp" size="3" value="{$p.qty_max}" name="metered[{$k}][prices][{$kx}][qty_max]"  /></td>
                                            <td><input type="text" class="inp" size="3" value="{$p.price|price:$currency:false}"  name="metered[{$k}][prices][{$kx}][price]" /> /{$varx.unit_name}</td>
                                            <td><a class="fs11" href="#" onclick="return removeRow(this)">Remove</a></td>
                                        </tr>
                                        {/foreach}
                                    </table>
                                    <div class="scheme_container" >
                                        Pricing scheme:
                                        <select class="inp" name="metered[{$k}][scheme]">
                                            <option {if $varx.scheme=='tiered'}selected="selected"{/if} value="tiered">Tiered</option>
                                            <option {if $varx.scheme=='overage'}selected="selected"{/if} value="overage">Overage</option>
                                            <option {if $varx.scheme=='volume'}selected="selected"{/if} value="volume">Volume</option>
                                            <option {if $varx.scheme=='stairstep'}selected="selected"{/if} value="stairstep">Stairstep</option>
                                        </select>
                                        <a class="vtip_description" title="{$lang.metteredschemes}"></a>
                                    </div>

                                    <div class="clear"></div><div style="padding:15px 0px 10px;"><a onclick="return addBracket('{$k}',' /{$varx.unit_name}');"   class="prices menuitm " href="#"><span  class="addsth">Add price bracket</span></a></div>
                                </td></tr>
                        </tbody></table></div></li>
                        {/foreach}
        </ul>

        {if $product.metered_editor}
            {include file=$product.metered_editor}
        {/if}

        <div class="clear"></div>
        <table width="100%" cellspacing="0" cellpadding="6" border="0">
            <tr>
                <td width="160" style="background:#F0F0F3">Generate usage invoices</td>
                <td style="background:#F0F0F3">
                    <select name="config[MeteredCycle]" class="inp">
                        <option value="Monthly" {if $configuration.MeteredCycle=='Monthly'}selected="selected"{/if}>{$lang.Monthly}</option>
                        <option value="Semi-Annually" {if $configuration.MeteredCycle=='Semi-Annually'}selected="selected"{/if}>{$lang.SemiAnnually}</option>
                        <option value="Annually" {if $configuration.MeteredCycle=='Annually'}selected="selected"{/if}>{$lang.Annually}</option>
                    </select>

                </td>
            </tr>
                <tr>
                    <td >Setup fee</td>
                    <td>{$currency.sign} <input type="text" class="inp" size="4"  value="{if $configuration.MeteredSetupFee}{$configuration.MeteredSetupFee|price:$currency:false}{else}{0|price:$currency:false:false}{/if}" name="config[MeteredSetupFee]" /> {$currency.code}</td>
                </tr>
                <tr>
                    <td>Fixed recurring fee <a title="Additional, fixed amount, recurring charge for service" class="vtip_description"></a></td>
                    <td>{$currency.sign} <input type="text" class="inp" size="4" value="{if $configuration.MeteredRecurringFee}{$configuration.MeteredRecurringFee|price:$currency:false}{else}{0|price:$currency:false:false}{/if}" name="config[MeteredRecurringFee]" /> {$currency.code}</td>
                </tr>

        </table></div></div>

<script type="text/javascript">
    var zeroamount = '{0.000|price:$currency:false:false}';;
    {literal}
    function removeRow(el) {
        $(el).parents('tr').eq(0).remove();
            return false;
    }
    
    function addBracket(v,j) {
        var t = $('#'+v+'_table');
         if(!t.length)
             return false;
        var i = t.find('tr').length;
            var br=t.find('tr:last').find('input').eq(1).val()?parseInt(t.find('tr:last').find('input').eq(1).val()):'';
        var ht='<tr >'
            +'<td><input type="text" class="inp" size="3" value="'+br+'"  name="metered['+v+'][prices]['+i+'][qty]" /></td>'
            +'<td><input type="text" class="inp" size="3" value=""   name="metered['+v+'][prices]['+i+'][qty_max]" /></td>'
            +'<td><input type="text" class="inp" size="3" value="'+zeroamount+'"   name="metered['+v+'][prices]['+i+'][price]" /> '+j+'</td>'
            +'<td><a class="fs11" href="#"  onclick="return removeRow(this)">Remove</a></td>'
            +'</tr>';
        t.append(ht);

        return false;
    }
    function var_toggle(v,e) {
        if(e) {
            $('#enabler_'+v).hide();
            $('#disabler_'+v).show();
            $('#var_'+v).show();
            $('#'+v+'_enable').val(1);
        } else {
            $('#enabler_'+v).show();
            $('#disabler_'+v).hide();
            $('#var_'+v).hide();
            $('#'+v+'_enable').val(0);
        }
    return false;
    }
    {/literal}
</script>
<style type="text/css">
{literal}
    .scheme_container {
        margin:10px 0px 10px 80px;
        padding:10px;
        background:#F0F0F3;
        border-radius:5px;
        float:left;
        color:#767679;
    }

    {/literal}
</style>




 {/if}
</div>