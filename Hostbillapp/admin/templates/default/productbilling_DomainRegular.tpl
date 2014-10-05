<div id="DomainRegular_b" {if $product.paytype!='DomainRegular'}style="display:none"{/if} class="p5 boption">

    <table border="0" cellpadding="6" cellspacing="0" width="100%">

        {foreach from=$product.periods item=p}
        <tr  id="pricing_{$p.period}" class="havecontrols" >

            <td align="right" width="120" >
                <div class="controls"><a href="#" class="editbtn">{$lang.Edit}</a> <a href="#" class="delbtn">{$lang.Delete}</a></div>
                <strong>{$p.period} {$lang.Years}</strong></td>

            <td><div class="e1">
                    <table border="0" cellpadding="3" cellspacing="0">
                        <tr>
                            <td >{if $p.register!=-1}{$lang.Register}: <strong>{$currency.sign} <span class="pricer">{$p.register|price:$currency:false}</span> {$currency.code}</strong>{/if}</td>
                            <td >{if $p.transfer!=-1} {$lang.Transfer}: <strong>{$currency.sign} <span class="pricer">{$p.transfer|price:$currency:false}</span> {$currency.code}</strong>{/if}</td>
                            <td >{if $p.renew!=-1} {$lang.Renew}: <strong>{$currency.sign} <span class="pricer">{$p.renew|price:$currency:false}</span> {$currency.code}</strong>{/if}</td>
                        </tr>
                    </table>
                </div>
                <div class="e2">
                    <table border="0" cellpadding="3" cellspacing="0">
                        <tr>
                            <td >{$lang.Register}: <input type="checkbox"  value="1"   onclick="check_i(this)" {if $p.register!=-1}checked="checked"{/if} /><input type="text" value="{$p.register|price:$currency:false}" size="4" name="periods[{$p.period}][register]" class="config_val inp" /></td>
                            <td >{$lang.Transfer}: <input type="checkbox"  value="1"   onclick="check_i(this)" {if $p.transfer!=-1}checked="checked"{/if} /><input type="text" value="{$p.transfer|price:$currency:false}" size="4" name="periods[{$p.period}][transfer]" class="config_val inp" /></td>
                            <td >{$lang.Renew}: <input type="checkbox"  value="1"  onclick="check_i(this)" {if $p.renew!=-1}checked="checked"{/if} /><input type="text" value="{$p.renew|price:$currency:false}" size="4" name="periods[{$p.period}][renew]" class="config_val inp" /></td>
                        </tr>
                    </table>
                </div></td>
        </tr>
        {/foreach}

        <tr id="addpricingrow"><td align="left">
                <a href="#" class="new_control" onclick="$(this).hide();$('#tbpricingd').show();$('#tbpricingd select option:visible').eq(0).attr('selected','selected');return false;" id="addpricingd" ><span class="addsth" >{$lang.addpricingoption}</span></a>


            </td>
            <td align="right">{if $product.id!='new'}<a href="?cmd=services&action=product&id={$product.id}&category_id={$product.category_id}&security_token={$security_token}&make=applycatpricing" class="editbtn" onclick="return confirm('Are you sure? All tld prices from this category will be changed')">Apply this pricing to all tlds from {foreach from=$categories item=c}{if $c.id==$product.category_id}{$c.name}{break}{/if}{/foreach}</a>{/if}</td>
        </tr>
    </table>

</div>
<div id="tbpricingd"  style="display:none;" class="p6">
    <div >
        <table border="0" cellpadding="3" cellspacing="0" width="100%">
            <tr>
                <td><strong>{$lang.Period}:</strong></td>
                <td ><input id="pediodid" size="4" value="1" /> {$lang.Years}</td>

                <td ><strong>{$lang.Register}</strong><input type="checkbox"  value="1"  id="register_on" onclick="check_i(this)" checked="checked"/> <input id="register_p" value="{0|price:$currency:false:false}" size="4" class="config_val price inp"/></td>
                <td ><strong>{$lang.Transfer}</strong><input type="checkbox"  value="1"  id="transfer_on" onclick="check_i(this)" checked="checked"/> <input id="transfer_p" value="{0|price:$currency:false:false}" size="4" class="config_val price inp"/></td>
                <td ><strong>{$lang.Renew}</strong><input type="checkbox"  value="1"  id="renew_on" onclick="check_i(this)" checked="checked"/> <input id="renew_p" value="{0|price:$currency:false:false}" size="4" class="config_val price inp"/></td>

                <td colspan="2" align="center"><input type="button" value="{$lang.Add}"  onclick="addopt_domain();return false;"/> <span class="orspace">{$lang.Or} </span> <a href="#" onclick="$('#addpricingd').show();$('#tbpricingd').hide();return false;" class="editbtn" id="hidepricingadd">{$lang.Cancel}</a></td>
        </table>
    </div>
</div>
{literal}
<script type="text/javascript">
    var zero_value = '{/literal}{0|price:$currency:false:false}{literal}';
    function addopt_domain() {
        var per= $('#pediodid').val();
        if((!$('#register_on').is(':checked') && !$('#transfer_on').is(':checked') && !$('#renew_on').is(':checked'))|| !per || $('#pricing_'+per).length) {
            $('#register_p').val(zero_value);$('#renew_p').val(zero_value);$('#transfer_p').val(zero_value);$('#register_on').attr('checked','checked');
            $('#transfer_on').attr('checked','checked');
            $('#renew_on').attr('checked','checked');
            $('#addpricingd').show();$('#tbpricingd').hide();
            return false;
        }
        var v = '<tr  id="pricing_'+per+'" class="havecontrols" >'+
            '<td align="right" width="120" ><strong>'+per+' '+lang['Years']+'</strong></td><td> <table border="0" cellpadding="3" cellspacing="0"><tr>';





        v+='<td >'+lang['Register']+': <input type="checkbox"  value="1"   onclick="check_i(this)" ';
        if ($('#register_on').is(':checked'))
            v+='checked="checked"';
        v+=' /><input type="text" value="'+$('#register_p').val()+'" size="4" name="periods['+per+'][register]" class="config_val inp" ';
        if (!$('#register_on').is(':checked'))
            v+='disabled="disabled"';
        v+=' /></td>';
        v+='<td >'+lang['Transfer']+': <input type="checkbox"  value="1"   onclick="check_i(this)" ';
        if ($('#transfer_on').is(':checked'))
            v+='checked="checked"';
        v+=' /><input type="text" value="'+$('#transfer_p').val()+'" size="4" name="periods['+per+'][transfer]" class="config_val inp" ';
        if (!$('#transfer_on').is(':checked'))
            v+='disabled="disabled"';
        v+=' /></td>';
        v+='<td >'+lang['Renew']+': <input type="checkbox"  value="1"  onclick="check_i(this)" ';
        if ($('#renew_on').is(':checked'))
            v+='checked="checked"';
        v+=' /><input type="text" value="'+$('#renew_p').val()+'" size="4" name="periods['+per+'][renew]" class="config_val inp" ';
        if (!$('#renew_on').is(':checked'))
            v+='disabled="disabled"';
        v+=' /></td>';
        v+='</tr></table> </td></tr>';

        $('#addpricingrow').before(v);
        $('#register_on').attr('checked','checked');
        $('#transfer_on').attr('checked','checked');
        $('#renew_on').attr('checked','checked');
        $('#register_p').val(zero_value);$('#renew_p').val(zero_value);$('#transfer_p').val(zero_value);
        $('#addpricingd').show();$('#tbpricingd').hide();
        return false;
    }
    function bindMe2() {

        $('#DomainRegular_b .controls .editbtn').click(function(){
            var e=$(this).parent().parent().parent();
            e.find('.e1').hide();
            e.find('.e2').show();
            e.parents('tbody.sectioncontent').find('.savesection').show();
            return false;
        });
        $('#DomainRegular_b .controls .delbtn').click(function(){
            $(this).parents('.havecontrols').eq(0).remove();

            return false;
        });

    }
    appendLoader('bindMe2');
</script>


{/literal}