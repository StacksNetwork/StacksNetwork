<div style="padding:10px">
    {if !$transactions}
        There are no transactions available to refund for this invoice. <a href="#"  onclick="$('#refunds').hide();
                return false;">{$lang.Cancel}</a>
    {else}
        <form action="?cmd=invoices&action=edit&id={$invoice_id}&list={$currentlist}" method="post" onsubmit="$('#bodycont').addLoader();" >
            <table cellspacing="1" cellpadding="3" border="0" style="width:100%" class="whitetable" >
                <tr>
                    <th colspan="6">Refund invoice</th>
                </tr>
                <tr>
                    <td style="text-align: right; width:180px">
                        <label>Refund type</label>
                    </td>
                    <td>
                        <select name="refund_type" id="refundtype">
                            {foreach from=$rtypes item=rt}
                                <option value="{$rt}">
                                   {$lang[$rt]}
                                </option>
                            {/foreach}
                        </select>
                    </td>
                    <td style="text-align: right; width:180px">
                        <label class="credit_transaction">Transaction to refund</label>
                    </td>
                    <td>
                        <select name="target_transaction_id" class="credit_transaction">
                            {foreach from=$transactions item=t}
                                <option value="{$t.id}">{$t.trans_id}</option>
                            {/foreach}
                        </select>
                    </td>
                    <td style="text-align: right; width:180px">
                        {if "config:CnoteEnable:on"|checkcondition }<label>Create Credit Note</label>
                        {/if}
                    </td>
                    <td>
                        {if "config:CnoteEnable:on"|checkcondition }<input name="creditnote" type="checkbox" value="1" checked="checked" onclick="$('#refundbox').toggle()" />
                        {/if}
                    </td>
                </tr>                
            </table>
            <table cellspacing="1" cellpadding="3" border="0" style="width:100%;{if "config:CnoteEnable:on"|checkcondition }{else}display:none{/if}" class="whitetable" id="refundbox" >
                <thead>
                    <tr>
                        <th colspan="2">Description</th>
                        <th>Amount to refund</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$items item=item}
                        <tr>
                            <td style="width:30px"><input type="checkbox" id="item{$item.id}" value="1" data-rel="{$item.id}" name="credititem[{$item.id}]" checked="checked" class="credititem"></td>
                            <td>{$item.description|nl2br}</td>
                            <td><input type=text value="{$item.amount}" max="{$item.amount}" min="0" id="amount{$item.id}" name="creditamount[{$item.id}]" class="creditamount"/></td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
            <table cellspacing="1" cellpadding="3" border="0" style="width:100%" class="whitetable" >
                <tr>
                    <td style="text-align: right; width:180px">
                        <label>Amount to refund</label>
                    </td>
                    <td>
                        <input id="refundamount" name="amount" type="text" value="{$maxref}" style="font-weight: bold; font-size: 12px"/>
                        / <span id="maxrefund">{$maxref|price:$currency}</span> <a href="#" class="vtip_description" title="If you want to use automatic gateway refund, maximum refund amount will be capped to selected transaction amount"></a>

                    </td>
                    <td style="text-align: right; width:180px">
                        <label>Post action</label>
                    </td>
                    <td>
                        <select name="post_action">
                            <option value="nothing">Return to invoice</option>
                            <option value="terminate">Terminate related account</option>
                            <option value="close">Close client profile</option>
                            <option value="close_ban">Close client profile, ban client IP</option>
                            <option value="delete">Delete client account</option>
                            <option value="suspend">Suspend client account</option>
                        </select>
                    </td>
                    <td style="text-align: right; width:180px">
                        <label>Notify customer</label>
                    </td>
                    <td><input type="checkbox" value="1" name="notify" /></td>
                </tr>
                <tr>
                    <td colspan="6" align="center">
                        <input id="confirmrefund" type="submit" name="refund" value="{$lang.refund}"  class="btn btn-small btn-primary"/>
                        <input type="reset" onclick="$('#refunds').hide();" value="{$lang.Cancel}"  class="btn btn-small " />
                    </td>
                </tr>

            </table>  
            {securitytoken}
        </form>
        <script type="text/javascript">
            var colective_max = parseFloat('{$maxref}'),    
                dec_precision = {$decprecision},
                    transaction_max = {literal}{{/literal}{foreach from=$transactions item=t}'{$t.trans_id}':parseFloat('{$t.amount}'),{/foreach}{literal} }{/literal}
            {literal}
                $(function() {
                    function getLimit() {
                        var type = $('#refundtype').val(),
                                limit = colective_max;
                        if (type == 'refund_gateway') {
                            limit = transaction_max[$('.credit_transaction option:selected').text()];
                        }
                        return limit;
                    }
                    function setRefundAmount(v) {
                    
                        $('#refundamount').val(v.toFixed(dec_precision)).change();
                    
                    }
                    function parseStr2Int(str) {
                        var val = parseFloat(str.replace(/[^\d.]+/g, ''));
                        return isNaN(val) ? 0 : val;
                    }

                    $('.credititem').change(function() {
                        var that = $(this),
                                id = that.attr('data-rel');
                        if (that.is(':checked')) {
                            $('#amount' + id).prop('disabled', false);
                        } else {
                            $('#amount' + id).prop('disabled', true);
                        }
                        var refund = 0;
                        $($('.creditamount:not(:disabled)').get().reverse()).each(function() {
                            refund += parseStr2Int($(this).val());
                        }).keyup();
                        setRefundAmount(refund);
                    });

                    $('#refundamount').change(function() {
                        var that = $(this),
                                limit = getLimit(),
                                val = parseFloat(that.val());
                        $('#maxrefund').text(limit);
                        if (val > limit) {
                            val = limit;
                            that.val(val);
                        }
                        window.console.log(typeof val, val);
                        $('#confirmrefund').prop('disabled', !(val > 0));
                        var w=that.val().toString().length * 7.5;
                        w=w<35?35:w;
                        that.width(w);
                    }).change();

                    $('#refundtype, #credittransid').change(function() {
                        var itemcredit = 0,
                                refundLimit = getLimit();
                        $('.creditamount').unbind('keyup').each(function(x) {
                            var that = $(this),
                                    val = parseStr2Int(that.val());
                            if (itemcredit >= refundLimit)
                                that.prop('disabled', true).parents('tr').eq(0).find('.credititem').prop('checked', false);//.change();
                            else if (itemcredit + val > refundLimit) {
                                
                                that.val((refundLimit - itemcredit).toFixed(dec_precision));
                                }
                            itemcredit += val;

                            that.keyup(function() {
                                if (that.is(':disabled'))
                                    return false;
                                var val = parseStr2Int(that.val()),
                                        creditval = 0,
                                        refundLimit = getLimit();
                                $('.creditamount:not(:disabled)').not(this).each(function(y) {
                                    creditval += parseStr2Int($(this).val());
                                });
                                if (creditval + val > refundLimit) {
                                    val = refundLimit - creditval;
                                    that.val(val.toFixed(dec_precision));
                                }
                                setRefundAmount(creditval + val);
                            })
                        }).eq(0).keyup();
                    });

                    
                    if($('input[name=creditnote]').is(':checked')) { 
                        $('.credititem').eq(0).change()
                    }
                });
            {/literal}    
        </script>
    {/if}
</div>