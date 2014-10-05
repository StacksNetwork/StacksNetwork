<table border="0" cellpadding="6" cellspacing="0" width="100%" class="pricingtable" {if !$item.pricing_enabled}style="display:none"{/if}>
       <tr  class="free_p" style="display:none">
        <td colspan="2">
            {$lang.freenopricing}
        </td>
    </tr>
    <tr  class="once_p" style="display:none">

        <td align="right" width="150" >
            <strong>{$lang.Once}</strong></td>

        <td>
            {$lang.Price}: <input type="text" value="{$item.m|price:$currency:false}" size="4" name="items[{$k}][m1]" class="inp"/> &nbsp;&nbsp;
            <span class="sfee">{$lang.setupfee}:<input type="text" value="{$item.m_setup|price:$currency:false}" size="4" name="items[{$k}][m_setup1]" class="inp"/></span>
        </td>
    </tr>
    <tr  class="hpricing">

        <td align="right" width="150" >
            <strong>{$lang.Hourly}</strong></td>

        <td>
            {$lang.Price}: <input type="text" value="{$item.h|price:$currency:false}" size="4" name="items[{$k}][h]" class="inp"/> &nbsp;&nbsp;
            <span class="sfee">{$lang.setupfee}: <input type="text" value="{$item.h_setup|price:$currency:false}" size="4" name="items[{$k}][h_setup]" class="inp"/></span>
        </td>
    </tr>
    <tr  class="dpricing">

        <td align="right" width="150" >
            <strong>{$lang.Daily}</strong></td>

        <td>
            {$lang.Price}: <input type="text" value="{$item.d|price:$currency:false}" size="4" name="items[{$k}][d]" class="inp"/> &nbsp;&nbsp;
            <span class="sfee">{$lang.setupfee}: <input type="text" value="{$item.d_setup|price:$currency:false}" size="4" name="items[{$k}][d_setup]" class="inp"/></span>
        </td>
    </tr>

    <tr  class="wpricing"  >
        <td align="right" width="150">
            <strong>{$lang.Weekly}</strong></td>
        <td>
            {$lang.Price}: <input type="text" value="{$item.w|price:$currency:false}" size="4" name="items[{$k}][w]" class="inp"/> &nbsp;&nbsp;
            <span class="sfee">{$lang.setupfee}: <input type="text" value="{$item.w_setup|price:$currency:false}" size="4" name="items[{$k}][w_setup]" class="inp"/></span>
        </td>
    </tr>

    <tr class="mpricing" >
        <td align="right" width="150">
            <strong class="mpricelabel">{$lang.Monthly}</strong></td>
        <td>
            {$lang.Price}: <input type="text" value="{$item.m|price:$currency:false}" size="4" name="items[{$k}][m]" class="inp"/> &nbsp;&nbsp;
            <span class="sfee">{$lang.setupfee}: <input type="text" value="{$item.m_setup|price:$currency:false}" size="4" name="items[{$k}][m_setup]" class="inp"/></span>
        </td>
    </tr>
    <tr class="qpricing" >
        <td align="right" width="150">
            <strong>{$lang.Quarterly}</strong></td>
        <td>
            {$lang.Price}: <input type="text" value="{$item.q|price:$currency:false}" size="4" name="items[{$k}][q]" class="inp"/> &nbsp;&nbsp;
            <span class="sfee">{$lang.setupfee}: <input type="text" value="{$item.q_setup|price:$currency:false}" size="4" name="items[{$k}][q_setup]" class="inp"/></span>
        </td>
    </tr>

    <tr class="spricing" >
        <td align="right" width="150">
            <strong>{$lang.SemiAnnually}</strong></td>
        <td>
            {$lang.Price}: <input type="text" value="{$item.s|price:$currency:false}" size="4" name="items[{$k}][s]" class="inp"/> &nbsp;&nbsp;
            <span class="sfee">{$lang.setupfee}:  <input type="text" value="{$item.s_setup|price:$currency:false}" size="4" name="items[{$k}][s_setup]" class="inp"/></span>
        </td>
    </tr>

    <tr class="apricing" >
        <td align="right" width="150">
            <strong>{$lang.Annually}</strong></td>
        <td>
            {$lang.Price}: <input type="text" value="{$item.a|price:$currency:false}" size="4" name="items[{$k}][a]" class="inp"/> &nbsp;&nbsp;
            <span class="sfee">{$lang.setupfee}:  <input type="text" value="{$item.a_setup|price:$currency:false}" size="4" name="items[{$k}][a_setup]" class="inp"/></span>
        </td>
    </tr>

    <tr class="bpricing">
        <td align="right" width="150">
            <strong>{$lang.Biennially}</strong></td>
        <td>
            {$lang.Price}: <input type="text" value="{$item.b|price:$currency:false}" size="4" name="items[{$k}][b]" class="inp"/> &nbsp;&nbsp;
            <span class="sfee">{$lang.setupfee}:  <input type="text" value="{$item.b_setup|price:$currency:false}" size="4" name="items[{$k}][b_setup]" class="inp"/></span>
        </td>
    </tr>

    <tr class="tpricing" >
        <td align="right" width="150">
            <strong>{$lang.Triennially}</strong></td>
        <td>
            {$lang.Price}: <input type="text" value="{$item.t|price:$currency:false}" size="4" name="items[{$k}][t]" class="inp"/> &nbsp;&nbsp;
            <span class="sfee">{$lang.setupfee}:  <input type="text" value="{$item.t_setup|price:$currency:false}" size="4" name="items[{$k}][t_setup]" class="inp"/></span>
        </td>
    </tr>
   

</table>{literal}
<script type="text/javascript">
    updatepricingform_calbacks['regular'] =function() {
        var w= $('input[name=paytype]:checked').val() 
            || $('#pricing_overide:visible input[name=bundle_paytype]:checked').val()
            || $('input[name=dynamic_paytype]:checked').val();
        switch(w) {
            case 'Once':
                $('#Regular_b tr').each(function(){
                    var id=$(this).attr('id');
                    if(id)
                        $('.pricingtable .'+id,'#facebox').hide();
                });
                $('.pricingtable .once_p','#facebox').show();
                break;
            case 'Regular':
            $('.pricingtable .once_p','#facebox').hide();
            $('#Regular_b tr').each(function(){
                var id=$(this).attr('id');
                if(id) {
                    if($(this).css('display')=='none') {
                        $('.pricingtable .'+id,'#facebox').hide();
                    } else {
                        $('.pricingtable .'+id,'#facebox').show();
                    }
                }
            });
                break;
            case 'SSLRegular':
            case 'DomainRegular':
                 $('.pricingtable tr','#facebox').hide();
                $('.pricingtable tr.apricing','#facebox').show();
                break;
            case 'Metered':
            case 'Bandwidth':
                 $('.pricingtable tr','#facebox').hide();
                if($('#metered_btype').length && $('#metered_btype').val()=='PrePay') {
                    $('.pricingtable tr.mpricing','#facebox').show().find('.sfee').hide();
                    $('.pricingtable tr.mpricing .mpricelabel','#facebox').hide();
                } else {
                    $('.pricingtable tr.apricing','#facebox').show();
                    $('.pricingtable tr.spricing','#facebox').show();
                    $('.pricingtable tr.qpricing','#facebox').show();
                    $('.pricingtable tr.mpricing','#facebox').show();
                }
                    
                break;
            case 'BundleRegular':
                $('.pricingtable tr','#facebox').hide();
                $('#pricing_dynamo .like-table-row').each(function(){
                    var id = $(this).attr('rel') || $(this).attr('id');
                    if(id) {
                        $('.pricingtable .'+id, '#facebox').show();
                    }
                });
                break;
            case 'Flavor':
                var t = $('select[name="config[FlavorCycle]"]').val();
                $('.pricingtable tr','#facebox').hide();
                switch(t){
                    case 'Monthly': 
                        $('.pricingtable tr.mpricing','#facebox').show();
                        break;
                    case 'Semi-Annually': 
                        $('.pricingtable tr.spricing','#facebox').show();
                        break;
                    case 'Annually': 
                        $('.pricingtable tr.apricing','#facebox').show();
                        break;
                }
                
                break;
            default:
            case 'Free':
                $('.pricingtable tr:not(.free_p)','#facebox').hide();
                $('.pricingtable tr.free_p','#facebox').show();
                break;
                    
        }
            
    };

</script>{/literal}