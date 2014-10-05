<form action="" method="post">
    <input type="hidden" value="add" name="make" />
    <div class="blu"><a href="?cmd=transactions"  data-pjax><strong>&laquo; {$lang.backtotransactions}</strong></a></div>


    <div id="ticketbody">

        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td><h1>{$lang.addnewtransaction}</h1></td>
            </tr>
        </table>
        <div id="client_nav">
            <!--navigation-->
            <a class="nav_el nav_sel left" href="#">{$lang.transaction}</a>
            <div class="left">

            </div>


            <div class="clear"></div>
        </div>

        <div class="ticketmsg ticketmain" id="client_tab">

            <div class="slide" style="display:block">

                <div class="tdetails">

                    <table width="100%" cellspacing="2" cellpadding="3" border="0">
                        <tbody>
                            <tr>
                                <td width="15%">{$lang.Date}</td>
                                <td width="35%"><input type="text" class="haspicker" value="{$submit.date|dateformat:$date_format}" name="date" size="20" /></td>
                                <td width="15%">{$lang.relatedclient}</td>
                                <td width="35%">
                                    <select style="width: 180px" name="client_id" load="clients"  default="{$submit.client_id}" onchange="updateCurrency($(this).val())">
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>{$lang.Description}</td>
                                <td colspan="3"><input type="text" size="40" name="description" value="{$submit.description}"/></td>

                            </tr>
                            <tr>
                                <td>{$lang.invoiceids}</td>
                                <td><input type="text" size="20" name="invoice_id" value="{$submit.invoice_id}"/></td>
                                <td>{$lang.amountin}</td>
                                <td><span class="currency_sign">{$client_currency.sign}</span> <input type="text" value="{$submit.in}" size="10" name="in"/> <span class="currency_code">{$client_currency.code}</span></td>
                            </tr>
                            <tr>
                                <td>{$lang.Transactionid}</td>
                                <td><input type="text" size="40" name="trans_id" value="{$submit.trans_id}"/></td>
                                <td>{$lang.fees}</td>
                                <td><span class="currency_sign">{$client_currency.sign}</span> <input type="text" value="{$submit.fee}" size="10" name="fee"/> <span class="currency_code">{$client_currency.code}</span></td>
                            </tr>
                            <tr>
                                <td>{$lang.paymethod}</td>
                                <td><select name="module" onclick="new_gateway(this)">

                                        {foreach from=$modules item=module key=id}
                                            <option value="{$id}"  {if $submit.module==$id}selected="selected"{/if}>{$module}</option>
                                        {/foreach}
                                        <option value="new" style="font-weight: bold">{$lang.newgateway}</option>

                                    </select></td>
                                <td>{$lang.amountout}</td>
                                <td><span class="currency_sign">{$client_currency.sign}</span> <input type="text" value="{$submit.out}" size="10" name="out"/> <span class="currency_code">{$client_currency.code}</span></td>
                            </tr>
                        </tbody>
                    </table>

                </div>


            </div>


        </div>

        <div style="text-align:center;margin-bottom:7px;padding:15px 0px;" class="p6 secondtd">
            <a onclick="$('#savedetailsform').click();
                                return false;" href="#" class="new_control greenbtn"><span>{$lang.addtransaction}</span></a>
        </div>





    </div>

    <div class="blu"><a href="?cmd=transactions"  data-pjax><strong>&laquo; {$lang.backtotransactions}</strong></a>
        <input type="submit" value="{$lang.savechanges}" style="font-weight:bold;display: none" id="savedetailsform" />
    </div>
    {securitytoken}
</form>
{literal}
    <script type="text/javascript">
        function updateCurrency(id){
            $.get('?cmd=clients&action=getClientCurrency&id='+id, function(data){
                if(data.currency){
                    $('.currency_sign').text(data.currency.sign);
                    $('.currency_code').text(data.currency.code);
                }
            })
        }
        function new_gateway(elem) {
            if ($(elem).val() == 'new') {
                window.location = "?cmd=managemodules&action=payment";
                $(elem).val(($("select[name='module'] option:first").val()));
            }
        }
    </script>
{/literal}