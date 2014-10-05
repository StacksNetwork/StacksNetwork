<form action="" method="post">
    <input type="hidden" value="update" name="make" />
    <div class="blu"><a href="?cmd=transactions"  data-pjax><strong>&laquo; {$lang.backtotransactions}</strong></a></div>


    <div id="ticketbody">

        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td><h1>{$lang.transactionhash}: {$transaction.trans_id}</h1></td>
            </tr>
        </table>
        <div id="client_nav">
            <!--navigation-->
            <a class="nav_el nav_sel left" href="#">{$lang.transaction}</a>
            {foreach from=$clients item=client}
                {if $transaction.client_id==$client.id}
                    {include file="_common/quicklists.tpl" }
                    {break}
                {/if}
            {/foreach}
            <div class="clear"></div>
        </div>

        <div class="ticketmsg ticketmain" id="client_tab">

            <div class="slide" style="display:block">

                <div class="tdetails">

                    <table width="100%" cellspacing="2" cellpadding="3" border="0">
                        <tbody>
                            <tr>
                                <td width="15%">{$lang.Date}</td>
                                <td width="35%"><input type="text" class="haspicker" value="{$transaction.date|dateformat:$date_format}" name="date" size="20" /></td>
                                <td width="15%">{$lang.relatedclient}</td>
                                <td width="35%">
                                    <select name="client_id"  style="width: 180px" name="client_id" load="clients" default="{$transaction.client_id}">

                                        {*foreach from=$clients item=client}
                                        <option value="{$client.id}"  {if $transaction.client_id==$client.id}selected="selected"{/if}>#{$client.id} {if $client.companyname!=''}{$lang.Company}: {$client.companyname}{else}{$client.firstname} {$client.lastname}{/if}</option>
                                        {/foreach*}
                                    </select></td>
                            </tr>
                            <tr>
                                <td>{$lang.Description}</td>
                                <td colspan="3"><input type="text" size="40" name="description" value="{$transaction.description}"/></td>

                            </tr>
                            <tr>
                                <td>{$lang.invoiceids}</td>
                                <td><input type="text" size="4" name="invoice_id" value="{$transaction.invoice_id}"/> {if $transaction.invoice_id}<a href="?cmd=invoices&action=edit&id={$transaction.invoice_id}&list=all" class="editbtn" target="_blank">{$lang.findrelatedinv}</a>{/if}</td>
                                <td>{$lang.amountin}</td>
                                <td><span class="currency_sign">{$transaction.currency.sign}</span> <input type="text" value="{$transaction.in}" size="10" name="in"/> <span class="currency_code">{$transaction.currency.code}</span></td>
                            </tr>
                            <tr>
                                <td>{$lang.Transactionid}</td>
                                <td><input type="text" size="40" name="trans_id" value="{$transaction.trans_id}"/></td>
                                <td>{$lang.fees}</td>
                                <td><span class="currency_sign">{$transaction.currency.sign}</span> <input type="text" value="{$transaction.fee}" size="10" name="fee"/> <span class="currency_code">{$transaction.currency.code}</span></td>
                            </tr>
                            <tr>
                                <td>{$lang.paymethod}</td>
                                <td><select name="module">

                                        {foreach from=$modules item=module key=id}
                                            <option value="{$id}"  {if $transaction.module==$id}selected="selected"{/if}>{$module}</option>
                                        {/foreach}
                                    </select></td>
                                <td>{$lang.amountout}</td>
                                <td><span class="currency_sign">{$transaction.currency.sign}</span> <input type="text" value="{$transaction.out}" size="10" name="out"/> <span class="currency_code">{$transaction.currency.code}</span></td>
                            </tr>
                        </tbody>
                    </table>

                </div>


            </div>
            {include file="_common/quicklists.tpl" _placeholder=true}
        </div>
        {if !$forbidAccess.editTransactions}
            <div style="text-align:center;margin-bottom:7px;padding:15px 0px;" class="p6 secondtd">
                <a onclick="$('#savedetailsform').click();
                        return false;" href="#" class="new_control greenbtn"><span>{$lang.savechanges}</span></a>
            </div>
        {/if}

        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td><h1>{$lang.relatedentries}</h1></td>
            </tr>
        </table>

        {if !$logentries}
            {$lang.nothingwasfound}
        {else}


            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike">
                <tbody>
                    <tr>
                        <th>{$lang.idhash}</th>
                        <th>{$lang.Date}</th>
                        <th>{$lang.Gateway}</th>
                        <th>{$lang.Output}</th>
                        <th>{$lang.Result}</th>
                    </tr>
                </tbody>
                <tbody>
                    {foreach from=$logentries item=log}
                        <tr>
                            <td>{$log.id}</td>
                            <td>{$log.date|dateformat:$date_format}</td>
                            <td><strong>{$log.module}</strong></td>
                            <td width="60%">
                                <div style="max-height:100px; overflow:auto">
                                    <div style="{*display:none;*} white-space: pre; font-size:8pt;">{$log.output}</div>
                                </div>
                            </td>
                            <td><span class="{$log.result}">{$lang[$log.result]}</span></td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        {/if}
    </div>
    <div class="blu"><a href="?cmd=transactions"  data-pjax><strong>&laquo; {$lang.backtotransactions}</strong></a>
        <input type="submit" value="{$lang.savechanges}" style="font-weight:bold;display: none" id="savedetailsform" />
    </div>
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
    </script>
    {/literal}
    {securitytoken}
</form>
