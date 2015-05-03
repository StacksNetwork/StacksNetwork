 {if $product.id=='new'}
<center>
    <strong>{$lang.save_product_first}</strong>
</center>
			 {else}

<div class="blank_state_smaller blank_domains" id="bsmetered" {if $product.show_metered}style="display:none"{/if}>
    <div class="blank_info">
        <h3>You can offer metered billing for this product.</h3>
        With HostBill you can charge customer precisely for what he used in given period
        <div class="clear"></div>
        <br>
        <a onclick="$('#bsmetered').hide();$('#meteredmgr').show();return false" class="new_control" href="#"><span class="addsth"><strong>Enable metered billing</strong></span></a>
        <div class="clear"></div>
    </div>
</div>

<div id="meteredmgr" {if !$product.show_metered}style="display:none"{/if}>
    <div style="">
        <a style="" href="#" class="prices menuitm " onclick="$('#bsmetered').show();$('#meteredmgr').hide();$('#meteredmgr ul .rmsth').parent().click();return false"><span class="rmsth">Disable metered billing component</span></a><span class="orspace">and switch back to regular billing</span><br/><br/>
        
        <b>Following variables can be measued and billed automatically: <a title="Note: Fill price rules below with amounts you wish to charge <b>over</b> whats offered with this package as standard. Ending QTY set to 0 means &infin; (infinity)
            <br/> I.e. 100GB traffic/month is free with package, everything over that should be configured with metered billing table." class="vtip_description"></a></b>
        <div class="clear"></div>

        <ul style="border:solid 1px #ddd;border-bottom:none;list-style:none;padding:0px;"  >
            {foreach from=$product.metered item=varx key=k}
            <li style="background:#ffffff"><div style="border-bottom:solid 1px #ddd;">
                    <table width="100%" cellspacing="0" cellpadding="5" border="0">
                        <tbody><tr>
                                <td width="70" valign="top"><div style="padding:10px 0px;"><a onclick="return var_toggle('{$k}',true);"  id="enabler_{$k}" class="prices menuitm " {if $varx.enable}style="display:none"{/if} href="#"><span  class="addsth">Enable</span></a>
                                        <a onclick="return var_toggle('{$k}',false);" class="prices menuitm " href="#" {if !$varx.enable}style="display:none"{/if} id="disabler_{$k}"><span  class="rmsth">Disable</span></a></div></td>
                                <td width="300"><b>{$varx.name}</b></td>
                                <td valign="top" style="background:#F0F0F3;color:#767679;font-size:11px">{$varx.description}</td>
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
                                            <td><input type="text" class="inp" size="3" value="0.00"  name="metered[{$k}][prices][0][price]" /> /{$varx.unit_name}</td>
                                            <td><a class="fs11" href="#" onclick="return removeRow(this)">Remove</a></td>
                                        </tr>
                                        {/if}
                                        {foreach from =$varx.prices item=p key=kx}
                                        <tr >
                                            <td><input type="text" class="inp" size="3" value="{$p.qty}" name="metered[{$k}][prices][{$kx}][qty]" /></td>
                                            <td><input type="text" class="inp" size="3" value="{$p.qty_max}" name="metered[{$k}][prices][{$kx}][qty_max]"  /></td>
                                            <td><input type="text" class="inp" size="3" value="{$p.price}"  name="metered[{$k}][prices][{$kx}][price]" /> /{$varx.unit_name}</td>
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


        <div class="clear"></div>

        
        <br/>

    </div>

</div>

{/if}
<script type="text/javascript">{literal}
    function removeRow(el) {
    $(el).parents('tr').eq(0).remove();
        return false;
}
   
        //check if metered billing notice should be displayed
        function checkForNotify() {
            return false;
        }
        appendLoader('checkForNotify');
    function addBracket(v,j) {
        var t = $('#'+v+'_table');
         if(!t.length)
             return false;
        var i = t.find('tr').length;
            var br=t.find('tr:last').find('input').eq(1).val()?parseInt(t.find('tr:last').find('input').eq(1).val())+1:'';
        var ht='<tr >'
                                    +'<td><input type="text" class="inp" size="3" value="'+br+'"  name="metered['+v+'][prices]['+i+'][qty]" /></td>'
                                    +'<td><input type="text" class="inp" size="3" value=""   name="metered['+v+'][prices]['+i+'][qty_max]" /></td>'
                                    +'<td><input type="text" class="inp" size="3" value="0.00"   name="metered['+v+'][prices]['+i+'][price]" /> '+j+'</td>'
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
        checkForNotify();
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