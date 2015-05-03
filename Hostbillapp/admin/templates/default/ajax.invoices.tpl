{if $action=='default'}

{if $showall}
<form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
    <div class="blu">
        <div class="left menubar">
            
                <input type="submit" name="markcancelled" class="submiter markcancelled" style="display:none" />
            
            {if !$forbidAccess.addInvoices}
                <a class="menuitm" href="?cmd=invoices&action=createinvoice&client_id=0" style="margin-right: 30px;font-weight:bold;"><span class="addsth">{$lang.createinvoice}</span></a>
            {/if}
            {if ($currentlist!='recurring' && !$forbidAccess.editInvoices) || !$forbidAccess.deleteInvoices}{$lang.withselected}{/if}
            {if $currentlist!='creditnote' && $currentlist!='recurring' && !$forbidAccess.editInvoices}{*
                *}<a class="submiter menuitm menuf" name="markpaid" {if $enablequeue}queue='push'{/if}  href="#" ><span >{$lang.markaspaid}</span></a>{*
                *}<a class="submiter menuitm menu{if !$forbidAccess.deleteInvoices}c{else}l{/if}" name="markunpaid"  href="#" ><span >{$lang.markasunpaid}</span></a>{*
            *}{/if}{if !$forbidAccess.deleteInvoices}{*
            *}<a class="submiter menuitm confirm {if $currentlist!='recurring' && !$forbidAccess.editInvoices}menul{/if}" name="delete"   href="#" ><span style="color:#FF0000">{$lang.Delete}</span></a>
            {/if}

            {if $currentlist!='recurring'}{*
                *}<a class="submiter menuitm menuf" name="send"   href="#" ><span style="font-weight:bold">{$lang.Send}</span></a>{*
                *}<a class="submiter menuitm formsubmit menuc" name="downloadpdf" href="#" ><span >PDF</span></a>{*
                *}<a class="menuitm setStatus menul" id="hd1" onclick="return false;" href="#" ><span class="morbtn">{$lang.moreactions}</span></a>
            {/if}

            <ul id="hd1_m" class="ddmenu">
                {if $currentlist!='creditnote'}<li><a href="SendReminder2">{$lang.sendreminder}</a></li>
                {if !$forbidAccess.editInvoices}<li  ><a href="MarkCancelled">{$lang.markascancelled}</a></li>{/if}{/if}
                <li><a href="#" onclick="return send_msg('invoices')">{$lang.SendMessage}</a></li>
            </ul>

        </div>
        <div class="right"><div class="pagination"></div>
        </div>
        <div class="clear"></div>
        <div id="new_invoice" style="padding: 10px; display: none"></div>

    </div>

    <a href="?cmd=invoices&list={$currentlist}" id="currentlist" style="display:none" updater="#updater"></a>
    <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
        <tbody>
            <tr>
                <th width="20"><input type="checkbox" id="checkall"/></th>

                {if $currentlist!='recurring'}
                <th><a href="?cmd=invoices&list={$currentlist}&orderby=id|ASC" class="sortorder">{$lang.invoicehash}</a></th>
                <th><a href="?cmd=invoices&list={$currentlist}&orderby=lastname|ASC"  class="sortorder">{$lang.clientname}</a></th>
                <th><a href="?cmd=invoices&list={$currentlist}&orderby=date|ASC"  class="sortorder">{$lang.invoicedate}</a></th>
                <th><a href="?cmd=invoices&list={$currentlist}&orderby=duedate|ASC"  class="sortorder">{$lang.duedate}</a></th>
                <th><a href="?cmd=invoices&list={$currentlist}&orderby=total|ASC"  class="sortorder">{$lang.Total}</a></th>
                <th><a href="?cmd=invoices&list={$currentlist}&orderby=module|ASC"  class="sortorder">{$lang.paymethod}</a></th>
                <th><a href="?cmd=invoices&list={$currentlist}&orderby=status|ASC"  class="sortorder">{$lang.Status}</a></th>
                <th width="20">&nbsp;</th>
                {else}
                <th><a href="?cmd=invoices&list={$currentlist}&orderby=recurring_id|ASC" class="sortorder">{$lang.recurringid}</a></th>
                <th><a href="?cmd=invoices&list={$currentlist}&orderby=lastname|ASC"  class="sortorder">{$lang.clientname}</a></th>
                <th><a href="?cmd=invoices&list={$currentlist}&orderby=total|ASC"  class="sortorder">{$lang.Total}</a></th>
                <th><a href="?cmd=invoices&list={$currentlist}&orderby=start_date|ASC"  class="sortorder">{$lang.start_date}</a></th>
                <th><a href="?cmd=invoices&list={$currentlist}&orderby=next_invoice|ASC"  class="sortorder">{$lang.next_invoice_date}</a></th>
                <th><a href="?cmd=invoices&list={$currentlist}&orderby=module|ASC"  class="sortorder">{$lang.paymethod}</a></th>
                <th><a href="?cmd=invoices&list={$currentlist}&orderby=frequency|ASC"  class="sortorder">{$lang.frequency}</a></th>
                {/if}
                <th width="20">&nbsp;</th>
                <th width="20">&nbsp;</th>
            </tr>
        </tbody>
        <tbody id="updater">

            {/if}
            {if $invoices}
            {foreach from=$invoices item=invoice}
            <tr>
                <td><input type="checkbox" class="check" value="{$invoice.id}" name="selected[]"/></td>
                {if $currentlist!='recurring'}
                <td>
                    <a href="?cmd=invoices&action=edit&id={$invoice.id}&list={$currentlist}" class="tload2"  rel="{$invoice.id}">
                        {if $proforma && ($invoice.status=='Paid' || $invoice.status=='Refunded' || $invoice.status == 'Creditnote') && $invoice.paid_id!=''}{$invoice.paid_id}
                        {else}{$invoice.date|invprefix:$prefix:$invoice.client_id}{$invoice.id}{/if}
                    </a>
                </td>
                <td>{if $invoice.client_id}<a href="?cmd=clients&action=show&id={$invoice.client_id}">{$invoice.lastname} {$invoice.firstname}</a>{else}<span style="font-style: italic">{$lang.no_clients_attached}</span>{/if}</td>
                <td>{$invoice.date|dateformat:$date_format}</td>
                <td>{$invoice.duedate|dateformat:$date_format}</td>
                <td>{$invoice.subtotal2|price:$invoice.currency_id}</td>
                <td>{if $invoice.credit==$invoice.subtotal2}{$lang.paidbybalance}{else}{$invoice.module} {if $invoice.credit>0}<span class="fs11">+ {$lang.paidbybalance}</span>{/if}{/if}</td>
                <td><span class="{$invoice.status}">{if $lang[$invoice.status]}{$lang[$invoice.status]}{else}{$invoice.status}{/if}</span></td>
                <td>{if $invoice.locked}<a href="?cmd=invoices&action=menubutton&make=unlock&id={$invoice.id}" title="This invoice is currently hidden in client area, click to unlock" class="invoiceUnlock padlock"></a>{/if}</td>
                {else}
                <td><a href="?cmd=invoices&action=edit&id={$invoice.id}&list={$currentlist}" class="tload2"  rel="{$invoice.id}">{$invoice.recurring_id}</a></td>
                <td><a href="?cmd=clients&action=show&id={$invoice.client_id}">{$invoice.lastname} {$invoice.firstname}</a></td>
                <td>{$invoice.total|price:$invoice.currency_id}</td>
                <td>{$invoice.start_from|dateformat:$date_format}</td>
                <td>{if $invoice.recstatus!='Stopped' &&  $invoice.next_invoice!='' && $invoice.next_invoice!='0000-00-00' && ($invoice.invoices_left || !$invoice.occurrences)}{$invoice.next_invoice|dateformat:$date_format} ({if $invoice.invoices_left && $invoice.occurrences}{$invoice.invoices_left}{else}&#8734;{/if} {$lang.remaining}){else}-{/if}</td>
                <td>{$invoice.module}</td>
                <td>{$lang[$invoice.frequency]}</td>
                {/if}

                <td><a href="?cmd=invoices&action=edit&id={$invoice.id}&list={$currentlist}" class="tload2 editbtn" rel="{$invoice.id}">{$lang.Edit}</a></td>
                <td>
                    {if !$forbidAccess.deleteInvoices}
                    <a href="?cmd=invoices&action=menubutton&make=deleteinvoice&id={$invoice.id}" class="deleteInvoice delbtn">删除</a>
                    {/if}
                </td>
            </tr>
            {/foreach}
            {else}
            <tr>
                <td colspan="10"><p align="center" > {$lang.nothingtodisplay} </p></td>
            </tr>
            {/if}
            {if $showall}
        </tbody>
        <tbody id="psummary">
            <tr>
                <th></th>
                <th colspan="9">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                </th>
            </tr>
        </tbody>
    </table>
    <div class="blu">
        <div class="left menubar">
            {if ($currentlist!='recurring' && !$forbidAccess.editInvoices) || !$forbidAccess.deleteInvoices}{$lang.withselected}{/if}
            {if $currentlist!='creditnote' && $currentlist!='recurring' && !$forbidAccess.editInvoices}{*
                *}<a class="submiter menuitm menuf" name="markpaid" {if $enablequeue}queue='push'{/if}  href="#" ><span >{$lang.markaspaid}</span></a>{*
                *}<a class="submiter menuitm menu{if !$forbidAccess.deleteInvoices}c{else}l{/if}" name="markunpaid"  href="#" ><span >{$lang.markasunpaid}</span></a>{*
            *}{/if}{if !$forbidAccess.deleteInvoices}{*
            *}<a class="submiter menuitm confirm {if $currentlist!='recurring' && !$forbidAccess.editInvoices}menul{/if}" name="delete"   href="#" ><span style="color:#FF0000">{$lang.Delete}</span></a>
            {/if}

            {if $currentlist!='recurring'}{*
                *}<a class="submiter menuitm menuf" name="send"   href="#" ><span style="font-weight:bold">{$lang.Send}</span></a>{*
                *}<a class="submiter menuitm formsubmit menuc" name="downloadpdf" href="#" ><span >PDF</span></a>{*
                *}<a class="menuitm setStatus menul" id="hd1" onclick="return false;" href="#" ><span class="morbtn">{$lang.moreactions}</span></a>
            {/if}
        </div>
        <div class="right"><div class="pagination"></div>
        </div>
        <div class="clear"></div>
    </div>
    {securitytoken}</form>

{/if}
{if $ajax}
{if $showall}<script type="text/javascript">bindEvents();</script>{/if}
<script type="text/javascript">bindInvoiceEvents();</script>
{/if}


{elseif $action=='getclients'}

{if $clients} 
<strong class="clientmsg">{$lang.Client}:</strong><select name="invoice[client_id]" onchange="$('#client_id').val($(this).val());" >
    <option value="0">{$lang.selectcustomer}</option>
		{foreach from=$clients item=cl}
    <option value="{$cl.id}">#{$cl.id} {if $cl.companyname!=''}{$lang.Company}: {$cl.companyname}{else}{$cl.lastname} {$cl.firstname}{/if}</option>
		{/foreach}
</select>


{else}
{$lang.thereisnoclients}. {$lang.Click} <a href="?cmd=newclient">{$lang.here}</a> {$lang.toregisternew}.
{/if}

{elseif $action=='clientinvoices'}
<div class="blu" style="text-align:right">
    <form action="?cmd=invoices&action=createinvoice" method="post">
        <input type="hidden" name="client_id" value="{$client_id}" />
        <input type="submit" value="{$lang.newinvoice}" onclick="window.location='?cmd=invoices&security_token={$security_token}&action=createinvoice&client_id={$client_id}';return false;"/>{securitytoken}</form></div>

{if $invoices}


<table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
    <tbody>
        <tr>
            {if $currentlist!='Recurring'}
            <th>{$lang.invoicehash}</th>
            <th>{$lang.invoicedate}</th>
            <th>{$lang.duedate}</th>
            <th>{$lang.Total}</th>
            <th>{$lang.paymethod}</th>
            <th>{$lang.Status}</th>
            {else}
            <th>{$lang.recurringid}</th>
            <th>{$lang.clientname}</th>
            <th>{$lang.Total}</th>
            <th>{$lang.start_date}</th>
            <th>{$lang.next_invoice_date}</th>
            <th>{$lang.paymethod}</th>
            <th>{$lang.frequency}</th>
            {/if}

            <th width="20">&nbsp;</th>
        </tr>
    </tbody>
    <tbody >



        {foreach from=$invoices item=invoice}
        <tr>
            {if $currentlist!='Recurring'}
            <td>
                <a href="?cmd=invoices&action=edit&id={$invoice.id}&list={$currentlist}" >
                    {if $proforma && ($invoice.status=='Paid' || $invoice.status=='Refunded' || $invoice.status == 'Creditnote') && $invoice.paid_id!=''}{$invoice.paid_id}
                    {else}{$invoice.date|invprefix:$prefix:$invoice.client_id}{$invoice.id}
                    {/if}
                </a>
            </td>
            <td>{$invoice.date|dateformat:$date_format}</td>
            <td>{$invoice.duedate|dateformat:$date_format}</td>
            <td>{$invoice.total|price:$invoice.currency_id}</td>
            <td>{$invoice.module}</td>
            <td><span class="{$invoice.status}">{if $lang[$invoice.status]}{$lang[$invoice.status]}{else}{$invoice.status}{/if}</span></td>
            {else}
            <td><a href="?cmd=invoices&action=edit&id={$invoice.id}&list={$currentlist}" class="tload2"  rel="{$invoice.id}">{$invoice.recurring_id}</a></td>
            <td><a href="?cmd=clients&action=show&id={$invoice.client_id}">{$invoice.lastname} {$invoice.firstname}</a></td>
            <td>{$invoice.total|price:$invoice.currency_id}</td>
            <td>{$invoice.start_from|dateformat:$date_format}</td>
            <td>{if $invoice.recstatus!='Stopped' &&  $invoice.next_invoice!='' && $invoice.next_invoice!='0000-00-00' && ($invoice.invoices_left || !$invoice.occurrences)}{$invoice.next_invoice|dateformat:$date_format} ({if $invoice.invoices_left && $invoice.occurrences}{$invoice.invoices_left}{else}&#8734;{/if} {$lang.remaining}){else}-{/if}</td>
            <td>{$invoice.module}</td>
            <td>{$lang[$invoice.frequency]}</td>
            {/if}
            <td><a href="?cmd=invoices&action=edit&id={$invoice.id}&list={$currentlist}" class="editbtn" rel="{$invoice.id}">{$lang.Edit}</a></td>

        </tr>
        {/foreach}

    </tbody>

</table> {if $totalpages}
<center class="blu"><strong>{$lang.Page} </strong>
			 {section name=foo loop=$totalpages}
			 {if $smarty.section.foo.iteration-1==$currentpage}<strong>{$smarty.section.foo.iteration}</strong>{else}
    <a href='?cmd=invoices&action=clientinvoices&id={$client_id}&page={$smarty.section.foo.iteration-1}&currentlist={$currentlist}' class="npaginer">{$smarty.section.foo.iteration}</a>
    {/if}
    {/section}
</center>
<script type="text/javascript">
    {literal}
    $('a.npaginer').click(function(){
        ajax_update($(this).attr('href'), {}, 'div.slide:visible');
        return false;
    });
    {/literal}
</script>
			  {/if}




{else}
<strong>{$lang.nothingtodisplay}</strong>
{/if}
{elseif $action=='edit'}
<script type="text/javascript">
    {literal}
    function new_gateway(elem) {
        if($(elem).val() == 'new') {
            window.location = "?cmd=managemodules&action=payment";
            $(elem).val(($("select[name='"+$(elem).attr('name')+"'] option:first").val()));
        }
    }
    {/literal}
</script>

<div class="blu"> 
    <div class=" menubar">
        <a href="?cmd=invoices&list={$currentlist}&showall=true"  class="tload2" id="backto"><strong>&laquo; {$lang.backto} {$currentlist} {$lang.invoices}</strong></a>
        {if $invoice.status!='Draft' && $invoice.status!='Recurring' && $invoice.status!='Creditnote'}{*
            *}<a class="setStatus menuitm menuf" name="markpaid" id="hd1"  ><span class="morbtn">{$lang.Setstatus}</span></a>{*
            *}<a class="addPayment menuitm menu{if !$forbidAccess.deleteInvoices}c{else}l{/if} {if $invoice.status=='Draft'}disabled{/if}" name="markunpaid"  href="#" ><span class="addsth">{$lang.addpayment}</span></a>{*
        *}{/if}{*
        *}{if !$forbidAccess.deleteInvoices}<a class="deleteInvoice menuitm {if $invoice.status!='Draft' && $invoice.status!='Recurring'}menul{/if}" name="delete" ><span style="color:#FF0000">{$lang.Delete}</span></a>{/if}
            
        {if $invoice.status!='Draft' && $invoice.status!='Recurring'}{*
             *}<a class="sendInvoice menuitm menuf" name="send"   href="#" ><span style="font-weight:bold">{$lang.Send}</span></a>{*
             *}<a class="menuitm setStatus menul" id="hd2" onclick="return false;"   href="#" ><span class="morbtn">{$lang.moreactions}</span></a>
        {/if}

        {if $invoice.status=='Recurring'}
        <a class="menuitm" name="send"   href="?action=download&invoice={$invoice.id}" ><span >{$lang.previewinvoice}</span></a>{*
             *}{if $invoice.recurring.recstatus!='Finished'} {$lang.generatenewinvoices}{*
                 *}<a class="menuitm menuf {if $invoice.recurring.recstatus!='Stopped'}activated{/if} recstatus recon" href="#" ><span >开</span></a>{*
                 *}<a class="menuitm menul {if $invoice.recurring.recstatus=='Stopped'}activated{/if} recstatus recoff" href="#" ><span >关</span></a>
            {/if}
        {/if}


        <ul id="hd1_m" class="ddmenu">
            <li class="act_paid {if $invoice.status=='Paid'}disabled{/if}"><a href="Paid">{$lang.Paid}</a></li>
            <li  class="act_unpaid {if $invoice.status=='Unpaid'}disabled{/if}"><a href="Unpaid">{$lang.Unpaid}</a></li>
            <li  class="act_cancelled {if $invoice.status=='Cancelled'}disabled{/if}"><a href="Cancelled">{$lang.Cancelled}</a></li>
            <li  class="act_refunded {if $invoice.status=='Refunded'}disabled{/if}"><a href="Refunded">{$lang.Refunded}</a></li>

        </ul>
        <ul id="hd2_m" class="ddmenu">
            <li><a href="?action=download&invoice={$invoice.id}"  class="directly">{$lang.downloadpdf}</a></li>
            {if count($currencies)>1}<li><a href="ChangeCurrency">{$lang.ChangeCurrency}</a></li>{/if}
            {if $invoice.status!='Creditnote'}<li><a href="IssueRefund">{$lang.issuerefund}</a></li>
            <li><a href="SendReminder">{$lang.sendreminder}</a></li>{/if}
            <li><a href="EditDetails">{$lang.editdetails}</a></li>
            <li><a href="AddNote">{$lang.invoicenotes}</a></li>
            <li ><a href="CreateInvoice">{$lang.createnewinvoice}</a></li>
            <li><a href="SendMessage">{$lang.SendMessage}</a></li>
            <li class="act_unpaid act_cancelled {if $invoice.status!='Paid'}disabled{/if}"><a href="EditNumber">{$lang.editnumber}</a></li>
            <li class="{if $invoice.status!='Unpaid'}disabled{/if}"><a href="{if $invoice.locked}UnlockInvoice{else}LockInvoice{/if}">{if $invoice.locked}解锁{else}锁定{/if} 账单</a></li>
        </ul>

    </div></div>
{if $pdfstored}<div  style="padding:5px;" class="lighterblue fs11">注意: 该账单的PDF文件已经存储在本地, 这里所作的更改不会影响PDF效果, 除非先将其删除. <a href="?cmd=invoices&action=deletepdf&id={$invoice.id}&security_token={$security_token}" class="editbtn">删除PDF</a></div>{/if}
{if count($currencies)>1}<div id="chcurr" style="display:none;padding:5px;" class="lighterblue">
    <form action="?cmd=invoices&action=edit&id={$invoice.id}&list={$currentlist}" method="post" >
        <input type="hidden" name="make" value="currchange" />
        <center>
            <table cellpadding="0" cellspacing="2" width="50%">
                <tr>
                    <td width="150">
                        {$lang.newcurrency}	
                    </td>
                    <td align="left">
                        <select name="new_currency_id" id="new_currency_id">
                            {foreach from=$currencies item=curr}
                                {if $curr.id!=$invoice.currency_id}
                                    <option value="{$curr.id}">{if $curr.code}{$curr.code}{else}{$curr.iso}{/if}</option>
                                {/if}	
                            {/foreach}
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>{$lang.calcexchange}</td>
                    <td align="left"><input type="checkbox" name="exchange" value="1" id="calcex"/></td>
                </tr>

                <tr id="exrates" style="display:none">
                    <td>{$lang.excurrency}: </td>
                    <td align="left">
                        {foreach from=$currencies item=curr}
                            {if $curr.id!=$invoice.currency_id}
                                <input value="{$curr.rate}" name="cur_rate[{$curr.id}]" style="display:none" size="3"/>
                            {/if}	
                        {/foreach}
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center"><input type="submit" value="{$lang.Apply}" style="font-weight:bold"/> <input type="reset" value="{$lang.Cancel}" onclick="$('#chcurr').hide();return false;"/></td>
                </tr>
            </table>
        </center>
        {securitytoken}
    </form>
</div>
{/if}
<div id="addpay">
    <form action="?cmd=invoices&action=edit&id={$invoice.id}&list={$currentlist}" method="post" >
        <table cellspacing="1" cellpadding="3" border="0" width="100%">
            <tr>
                <td width="50%"><table width="80%" border="0" cellspacing="2" cellpadding="3">
                        <tr>
                            <td>{$lang.Date}:</td>
                            <td><input name="newpayment[date]" value="{''|dateformat:$date_format}" class="haspicker"/>
                            </td>
                        </tr>
                        <tr>
                            <td>{$lang.paymethod}:</td>
                            <td><select name="newpayment[paymentmodule]" onclick="new_gateway(this)">
                                    {foreach from=$gateways key=gatewayid item=paymethod}
                                    <option value="{$gatewayid}" {if $invoice.payment_module == $gatewayid} selected="selected"{/if} >{$paymethod}</option>
                                    {/foreach}
                                    <option value="new" style="font-weight: bold">{$lang.newgateway}</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>{$lang.Transactionid}:</td>
                            <td><input name="newpayment[transnumber]" /></td>
                        </tr>
                    </table></td>
                <td><table width="80%" border="0" cellspacing="2" cellpadding="3">
                        <tr>
                            <td>{$lang.Amount}:</td>
                            <td><input size="6" name="newpayment[amount]" value="{$balance}" /></td>
                        </tr>
                        <tr>
                            <td>{$lang.transactionfees}:</td>
                            <td><input size="6" name="newpayment[fee]" value="0.00" /></td>
                        </tr>
                        <tr>
                            <td>{$lang.sendemail}:</td>
                            <td><input type="checkbox" value="1" name="newpayment[send_email]" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="submit" name="addpayment" value="{$lang.addpayment}" onclick="$('#bodycont').addLoader();"/>
                    <input type="reset" onclick="$('#addpay').hide();" value="{$lang.Cancel}" />
                </td>
            </tr>
        </table>
        {securitytoken}
    </form>
</div>
<div id="refunds" class="lighterblue"></div>
{include file='invoices/ajax.creditnoteinfo.tpl'}
<div id="ticketbody">
    <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <h1>
                    {if $proforma && $invoice.status!='Paid' && $invoice.status!='Draft' && $invoice.status!='Recurring' && $invoice.status != 'Creditnote'}
                    {$lang.proforma} #
                    {elseif $invoice.status=='Draft'}
                        {$lang.createinvoice}
                    {elseif $invoice.status=='Recurring'}{$lang.recinvoice} #{$invoice.recurring_id}
                    {elseif $invoice.status=='Creditnote'}{$lang.creditnote} #
                    {else}{$lang.invoicehash}{/if}
                </h1>
            </td>
            <td>
                {if $proforma && ($invoice.status=='Paid' || $invoice.status=='Refunded' || $invoice.status == 'Creditnote') && $invoice.paid_id!=''}
                    <div class="editline" id="paid_invoice_line">
                        <h1 id="invoice_number" class="line_descr" style="display:inline">{$invoice.paid_id}</h1>
                        <a class="editbtn" style="display:none;" href="#" >{$lang.Edit}</a><div style="display:none" class="editor-line">
                        <textarea  style="font-size:14px;font-weight:bold;">{$invoice.paid_id}</textarea>
                        <a class="savebtn" href="#" >{$lang.savechanges}</a>
                    </div>
                </div>
                {elseif $invoice.status!='Draft' && $invoice.status!='Recurring' && $invoice.status!='Creditnote'}
                    <h1>{$invoice.date|invprefix:$prefix:$invoice.client_id}{$invoice.id}</h1>
                {/if}
            </td>
            {if $invoice.status!='Recurring' && $invoice.status!='Creditnote'}
                <td>
                    <h1><span class="{$invoice.status}" id="invoice_status">{if $lang[$invoice.status]}{$lang[$invoice.status]}{else}{$invoice.status}{/if}</span></h1>
                </td>
            {/if}
            {if $invoice.locked}<td><a href="?cmd=invoices&action=menubutton&make=unlock&id={$invoice.id}" title="该账单目前对客户不可见, 点击解锁" class="invoiceUnlock padlock" style="margin: -4px 0 0 5px;"></a></td>{/if}
        </tr>
    </table>

    <input type="hidden" id="invoice_id" name="invoice_id" value="{$invoice.id}" />
    <input type="hidden" id="currency_id" name="inv_currency_id" value="{$invoice.currency_id}" />
    <input type="hidden" id="old_client_id" name="old_client_id" value="{$invoice.client_id}" />

    <div id="client_nav">
        <!--navigation-->
        <a class="nav_el nav_sel left" href="#">{$lang.invoicedetails}</a>
        {if $invoice.client_id} {include file="_common/quicklists.tpl"}
        {/if}


        <div class="clear"></div>
    </div>

    <div class="ticketmsg ticketmain" id="client_tab">

        <div class="slide" style="display:block">
            <div {if $invoice.status!='Draft'}class="left" {else}style="padding:5px;margin-bottom:5px;" {/if}>
                {if $invoice.client_id}<strong class="clientmsg">{$lang.Client}: 
                        <a href="?cmd=clients&action=show&id={$invoice.client_id}">{$invoice.client.lastname} {$invoice.client.firstname}</a>
                    </strong>
                {else}
                <div id="clientloader">
                    <strong class="clientmsg">{$lang.Client}:</strong>
                    <select style="width: 180px" name="invoice[client_id]" onchange="$('#client_id').val($(this).val());" load="clients" default="{$invoice.client_id}">
                        <option value="0">{$lang.selectcustomer}</option>
                    </select>
                </div>
                {/if}
                {if $invoice.status=='Draft'}<div style="padding:8px 0px 0px;">
                    <strong>{$lang.invoicetype}</strong>
                    <input type="radio" value="standardinvoice" id="standardinvoice" checked="checked" name="invoicetype" onclick="$('.standardinvoice').show();$('.recurringinvoice').hide();$('#is_recurring').val(0);"/>
                    <label for="standardinvoice">{$lang.standardinvoice}</label>

                    <input type="radio" value="recurringinvoice" id="recurringinvoice"  name="invoicetype"  onclick="$('.recurringinvoice').show();$('.standardinvoice').hide();$('#is_recurring').val(1);"/>
                    <label for="recurringinvoice">{$lang.recurringinvoice}</label>

                </div>{/if}
            </div>
            {if $invoice.status!='Draft'}<div class="right replybtn tdetail"><strong><a href="#"><span class="a1">{$lang.editdetails}</span><span class="a2">{$lang.hidedetails}</span></a></strong></div>{/if}

	{if $invoice.status == 'Paid'}<div class="right">{$lang.Paid}: {$invoice.datepaid|dateformat:$date_format}&nbsp;&nbsp;&nbsp;</div>{/if}

            <div class="clear"></div>
            <div id="detcont">
                {include file="ajax.invoices.tpl" action=false drawdetails=true}
            </div>
        </div>
		   {include file="_common/quicklists.tpl" _placeholder=true}
    </div>
    <div class="p6 secondtd" style="{if $invoice.status!='Draft'}display:none;{/if}text-align:center;margin-bottom:7px;padding:15px 0px;">
        <a class="new_control greenbtn" href="#" onclick="if(checkrecurring()) {literal}{{/literal}$('#savedetailsform').click(); {if $invoice.status!='Draft'}$(this).parent().hide(); {/if}{literal}}{/literal} return false;"><span>{$lang.savechanges}</span></a>
			{if $invoice.status!='Draft'}<span class="orspace fs11">{$lang.Or}</span> <a href="#" class="editbtn" onclick="$('.tdetail a').click();return false;">{$lang.Cancel}</a>{/if}
        <input type="submit" value="{$lang.savechanges}" id="clientsavechanges" style="display:none" name="save"/>
    </div>
    <script type="text/javascript">
        {literal}
        function checkrecurring() {
            if($('#is_recurring').val()=='1' && $('#client_id').val()!='0') {
                if($('#recurring_start_date').val()=='{/literal}{''|dateformat:$date_format}{literal}' && $('#recurring_start_date').val()!=$('#old_recurring_start_date').val()) {
                    return confirm("{/literal}{$lang.invoicerecurrnow}{literal}");
                }
            }
            return true;
        }
        {/literal}
    </script>
    <form action="" method="post" id="itemsform">
        <table class="invoice-table" width="100%" border="0" cellpadding="0" cellspacing="0">
            <head >
                <tr>
                    <th width="16" style="padding-right:0px;padding-left:0px"></th>
                    <th>{$lang.Description}</th>
                    <th width="8%" class="acenter">{$lang.qty}</th>
                    <th width="7%" class="acenter">{$lang.Taxed}</th>
                    <th width="9%" class="acenter">{$lang.Price}</th>
                    <th width="13%" class="aright">{$lang.Linetotal}</th>
                    <th width="1%" class="acenter">&nbsp;</th>
                </tr>
            </thead>
            <tbody id="main-invoice">
                {include file="invoices/items.tpl"}
            </tbody>
            <tbody id="new-item-invoice">
                <tr id="addliners">
                    <td class="summary blu acenter" style="padding-right:0px;padding-left:5px">
                        {if $invoice.status!='Draft' && $invoice.status!='Recurring'}<a id="hdx"  class="setStatus menuitm"><span class="gear_small" style="padding-left:16px;"><span class="morbtn" style="padding-right:10px;">&nbsp;</span></span></a>
                            <ul id="hdx_m" class="ddmenu">
                                <li><a href="SplitItems">Split selected into new invoice</a></li>
                            </ul>
                        {/if}
                    </td>
                    <td class="summary blu">
                        <strong>{$lang.newline}</strong>: <input name="nline" id="nline" style="width:80%"/>
                    </td>
                    <td class="summary blu acenter"><input name="nline_qty" id="nline_qty" size="7" style="text-align:center" value="1"/></td>
                    <td class="summary blu acenter"><input name="nline_tax" {if $invoice.taxexempt}disabled="disabled"{/if} type="checkbox" value="1" id="nline_tax" /></td>
                    <td class="summary blu acenter"><input name="nline_price" id="nline_price" size="13" /></td>
                    <td class="summary blu" colspan="2"><input type="button" value="{$lang.Add}" class="prodok" style="font-weight:bold"/>
                        <input type="button" id="addliner" value="{$lang.moreoptions}" />
                    </td>
                </tr>
                <tr id="addliners2" style="display:none">
                    <td class="summary blu" colspan="7">

                        <span id="catoptions_container" style="display:none;">
                            <select name="category_id"  id="catoptions">
                                <option value="0" selected="selected">{$lang.pickoneoption}</option>
					{foreach from=$categories item=cat}
                                <option value="{$cat.id}">{$lang.fromcategory}: {$cat.name}</option>
					{/foreach}
                                <option value="-2">{$lang.productaddons}</option>
                            </select>
                            <input type="button" id="rmliner" value="{$lang.Cancel}" />
                        </span>
                        <span id="products" style="display:none;"></span>
                        <span id="productname" style="display:none;"></span>

                    </td>
                </tr>
            </tbody>

            <tr>
                <td style="border:none;padding:20px 10px;margin:0px;" valign="top" colspan="2">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="fs11 nomarg">
                        <tr>
                            <td width="100%"><strong>{$lang.invoicenotes}:</strong></td>

                        </tr>
                        <tr>
                            <td>
                                <textarea class="notes_field" style="width:90%;height:60px;" name="notes" id="inv_notes">{$invoice.notes}</textarea>
                            </td>

                        </tr>
                        <tr>
                            <td  >
                                <div  class="notes_submit" id="notes_submit" style="display:none"><input value="{$lang.savechanges}" type="button" /></div>
                            </td>

                        </tr>
                    </table>

                </td>
                <td colspan="5" style="border:none;padding:10px 0px;margin:0px;" valign="top" >
                    <table width="100%">


                        <tbody id="updatetotals">
                            <tr>

                                <td class="summary aright"  colspan="2"><strong data-invoice-total>{$lang.Subtotal}</strong></td>
                                <td class="summary aright" colspan="2"><strong data-invoice-subtotal>{$invoice.subtotal|price:$currency}</strong></td>
                                <td class="summary" width="2%"></td>
                            </tr>
                           {if $invoice.status!='Creditnote'} <tr>

                                <td class="summary aright"  colspan="2"><strong>{$lang.Credit}</strong></td>
                                <td class="summary aright" colspan="2"><strong>{$invoice.credit|price:$currency}</strong></td>
                                <td class="summary"></td>
                            </tr>{/if}

				{if $invoice.taxrate!=0}
                            <tr>

                                <td class="summary aright"  colspan="2"><strong>{$lang.Tax} ({$invoice.taxrate}%)</strong></td>
                                <td class="summary aright" colspan="2"><strong>{$invoice.tax|price:$currency}</strong></td>
                                <td class="summary"></td>
                            </tr>
				{/if}
				{if $invoice.taxrate2!=0}
                            <tr>

                                <td class="summary aright"  colspan="2"><strong>{$lang.Tax} ({$invoice.taxrate2}%)</strong></td>
                                <td class="summary aright" colspan="2"><strong>{$invoice.tax2|price:$currency}</strong></td>
                                <td class="summary"></td>
                            </tr>
				{/if}
                            <tr>

                                <td class="summary aright" colspan="2" ><strong class="bigger">{$lang.Total}</strong> {if ($invoice.taxrate!=0 || $invoice.taxrate2!=0) && $invoice.taxexempt}<a href="#" class="vtip_description" title="该账单启用Tax exemptiont"></a>{/if}</td>
                                <td class="summary aright" colspan="2" ><strong class="bigger">{$invoice.total|price:$currency}</strong></td>
                                <td class="summary"></td>
                            </tr>
                        </tbody>
                    </table>

                </td>
            </tr>


        </table>
        {securitytoken}</form>

    {if $transactions}
    <strong>{$lang.relatedtransactions}:</strong><br />

    <form action="" method="post" id="transform">
        <input type="hidden" name="make" value="edittrans" />
        <table class="invoice-table-transaction" width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                
                <th>{$lang.Date}</th>
                <th width="0"></th>
                <th class="acenter">{$lang.Gateway}</th>
                <th class="acenter">{$lang.Transactionid}</th>
                <th class="acenter" width="10%">{$lang.Amount}</th>
                <th class="acenter" width="10%">{$lang.fees}</th>
                <th width="1%" class="acenter"></th>
            </tr>

            {foreach from=$transactions item=tran}
                <tr>
                    
                    <td ><input name="transaction[{$tran.id}][date]" value="{$tran.date|dateformat:$date_format}" class="haspicker transeditor"/></td>
                    <td>
                        {if $tran.invoice_id != $invoice.id && $tran.invoice_id != $invoice.invoice_id}
                            <a href="?cmd=invoices&action=edit&id={$tran.invoice_id}">Invoice #{$tran.invoice_id}</a>
                        {/if}
                    </td>
                    <td class="acenter"><select name="transaction[{$tran.id}][paymentmodule]" class="transeditor">
                            {foreach from=$gateways key=gatewayid item=paymethod}
                                <option value="{$gatewayid}"{if $tran.module == $paymethod} selected="selected"{/if} >{$paymethod}</option>
                            {/foreach}
                        </select>
                    </td>
                    <td class="acenter"><input name="transaction[{$tran.id}][trans_id]" value="{$tran.trans_id}"  class="transeditor"/></td>
                    <td class="acenter"><input name="transaction[{$tran.id}][amount]" value="{$tran.amount}" size="7"  class="transeditor"/></td>
                    <td class="acenter"><input name="transaction[{$tran.id}][fee]" value="{$tran.fee}" size="7" class="transeditor"/></td>
                    <td class="acenter"><a href="?cmd=invoices&action=removetrans&id={$tran.id}" class="removeTrans"><img src="{$template_dir}img/trash.gif" alt="{$lang.Delete}"/></a></td>
                </tr>
            {/foreach}
        </table>
        {securitytoken}</form>
    {/if}

</div>
<div class="blu"> <div class=" menubar">
        <a href="?cmd=invoices&list={$currentlist}&showall=true"  class="tload2" id="backto"><strong>&laquo; {$lang.backto} {$currentlist} {$lang.invoices}</strong></a>
        {if $invoice.status!='Draft' && $invoice.status!='Recurring' && $invoice.status!='Creditnote'}{*
            *}<a class="setStatus menuitm menuf" name="markpaid" id="hd1"  ><span class="morbtn">{$lang.Setstatus}</span></a>{*
            *}<a class="addPayment menuitm menu{if !$forbidAccess.deleteInvoices}c{else}l{/if} {if $invoice.status=='Draft'}disabled{/if}" name="markunpaid"  href="#" ><span class="addsth">{$lang.addpayment}</span></a>{*
        *}{/if}{*
        *}{if !$forbidAccess.deleteInvoices}<a class="deleteInvoice menuitm {if $invoice.status!='Draft' && $invoice.status!='Recurring'}menul{/if}" name="delete" ><span style="color:#FF0000">{$lang.Delete}</span></a>{/if}
            
        {if $invoice.status!='Draft' && $invoice.status!='Recurring'}{*
             *}<a class="sendInvoice menuitm menuf" name="send"   href="#" ><span style="font-weight:bold">{$lang.Send}</span></a>{*
             *}<a class="menuitm setStatus menul" id="hd2" onclick="return false;"   href="#" ><span class="morbtn">{$lang.moreactions}</span></a>
        {/if}

        {if $invoice.status=='Recurring'}
        <a class="menuitm" name="send"   href="?action=download&invoice={$invoice.id}" ><span >{$lang.previewinvoice}</span></a>{*
             *}{if $invoice.recurring.recstatus!='Finished'} {$lang.generatenewinvoices}{*
                 *}<a class="menuitm menuf {if $invoice.recurring.recstatus!='Stopped'}activated{/if} recstatus recon" href="#" ><span >开</span></a>{*
                 *}<a class="menuitm menul {if $invoice.recurring.recstatus=='Stopped'}activated{/if} recstatus recoff" href="#" ><span >关</span></a>
            {/if}
        {/if}
    </div>


</div>
{if $ajax}
<script type="text/javascript">bindEvents();bindInvoiceEvents();</script>
{/if}


{elseif $action=='updatetotals'}
    <tbody id="main-invoice">
         {include file="invoices/items.tpl"}
    </tbody>
    <tbody id="updatetotals">
        <tr>
            <td class="summary aright"  colspan="2"><strong>{$lang.Subtotal}</strong></td>
            <td class="summary aright" colspan="2"><strong>{$invoice.subtotal|price:$currency}</strong></td>			<td class="summary"  width="2%"></td>
        </tr>
        {if $invoice.status!='Creditnote'}<tr>
                <td class="summary aright"  colspan="2"><strong>{$lang.Credit}</strong></td>
                <td class="summary aright" colspan="2"><strong>{$invoice.credit|price:$currency}</strong></td>	<td class="summary"></td>
            </tr>
        {/if}
        {if $invoice.taxrate!=0}
            <tr>
                <td class="summary aright"  colspan="2"><strong>{$lang.Tax} ({$invoice.taxrate}%)</strong></td>
                <td class="summary aright" colspan="2"><strong>{$invoice.tax|price:$currency}</strong></td>	<td class="summary"></td>
            </tr>
        {/if}
        {if $invoice.taxrate2!=0}
            <tr>
                <td class="summary aright"  colspan="2"><strong>{$lang.Tax} ({$invoice.taxrate2}%)</strong></td>
                <td class="summary aright" colspan="2"><strong>{$invoice.tax2|price:$currency}</strong></td><td class="summary"></td>
            </tr>
        {/if}
        <tr>
            <td class="summary aright"  colspan="2"><strong class="bigger">{$lang.Total}</strong> {if ($invoice.tax!=0 || $invoice.tax2!=0) && $invoice.taxexempt}<a href="#" class="vtip_description" title="Tax exemptiont is enabled for this invoice"></a>{/if}</td>
            <td class="summary aright" colspan="2"><strong class="bigger">{$invoice.total|price:$currency}</strong></td>	<td class="summary"></td>
        </tr>
    </tbody>
    
{elseif $action=='getproduct'}
    {if $products}
        <select name="product" id="product_id">{foreach from=$products item=prod}<option value="{$prod.id}">{$prod.name}</option>{/foreach}</select>
        <input type="button" value="OK" class="prodok"/>
    {/if}
    <input type="button" value="{$lang.Cancel}" id="prodcanc"/>
    {if $ajax}
        <script type="text/javascript">bindInvoiceDetForm();</script>
    {/if}
    
{elseif $action=='getblank'}

    description: <input name="newline_name" id="newline"/>
    <input type="button" value="OK" class="prodok"/>
    <input type="button" value="{$lang.Cancel}" id="prodcanc"/>
    {if $ajax}
        <script type="text/javascript">bindInvoiceDetForm();</script>
    {/if}
    
{elseif $action=='getaddon'}
{if $addons}
<select name="addon" id="addon_id">{foreach from=$addons item=addon}<option value="{$addon.id}">{$addon.name}</option>{/foreach}</select>
<input type="button" value="OK" class="prodok"/>
	{/if}
<input type="button" value="{$lang.Cancel}" id="prodcanc"/>
{if $ajax}
<script type="text/javascript">bindInvoiceDetForm();</script>
{/if}
{elseif $action=='addline' || $action=='removeline'}
    {include file="invoices/items.tpl"}
{elseif $action=='addline'}
    {if $newline}
        <tr id="line_{$newline.id}">
            <td><input type="checkbox" name="invoice_item_id[]" value="{$newline.id}" class="invitem_checker"/></td>
            <td class="editline"><span class="line_descr">{$newline.description|nl2br}</span><a class="editbtn" style="display:none;" href="#">{$lang.Edit}</a>
                <div style="display:none" class="editor-line">
                    <textarea name="item[{$newline.id}][description]">{$newline.description}</textarea>
                    <a class="savebtn" href="#" >{$lang.savechanges}</a>
                </div></td>
            <td class="acenter"><input name="item[{$newline.id}][qty]" value="{$newline.qty}" size="7" class="foc invitem  invqty" style="text-align:center"/></td>
            <td class="acenter"><input type="checkbox" name="item[{$newline.id}][taxed]" {if $newline.taxed == 1}checked="checked" {/if}value="1" class="invitem2"/></td>
            <td class="acenter"><input name="item[{$newline.id}][amount]" value="{$newline.amount}" size="13" class="foc invitem invamount" style="text-align:right"/></td>
            <td class="aright">{$currency.sign} <span id="ltotal_{$newline.id}">{$newline.linetotal|string_format:"%.2f"}</span> {if $currency.code}{$currency.code}{else}{$currency.iso}{/if}</td>
            <td class="acenter"><a href="?cmd=invoices&action=removeline&id={$invoiceid}&line={$newline.id}" class="removeLine"><img src="{$template_dir}img/trash.gif" alt="{$lang.Delete}"/></a>{if $ajax}
                <script type="text/javascript">bindInvoiceDetForm(); invoiceItemsSubmit()</script>
            {/if}
        </td>
    </tr>
{/if}

{elseif $action=='getadvanced'}

<a href="?cmd=invoices&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
<form class="searchform filterform" action="?cmd=invoices" method="post" onsubmit="return filter(this)">  
    <table width="100%" cellspacing="2" cellpadding="3" border="0" >
        <tbody>
            <tr>
                <td width="15%">{$lang.Client} {$lang.lastname}</td>
                <td ><input type="text" value="{$currentfilter.lastname}" size="25" name="filter[lastname]"/></td>
                <td width="15%">{$lang.Client} {$lang.firstname}</td>
                <td ><input type="text" value="{$currentfilter.firstname}" size="25" name="filter[firstname]"/></td>
                </tr>
            <tr>
                <td>{$lang.invoicehash}</td>
                <td ><input type="text" value="{$currentfilter.id}" size="15" name="filter[id]"/></td>
                <td>{$lang.Total}</td>
                <td ><input type="text" value="{$currentfilter.total}" size="8" name="filter[total]"/></td>
            </tr>
            <tr>
                <td>{$lang.paymethod}</td>
                <td ><select name="filter[payment_module]">
                        <option value="">{$lang.Any}</option>
		  {foreach from=$modules item=module key=id}
                        <option value="{$id}"  {if $currentfilter.payment_module==$id}selected="selected"{/if}>{$module}</option>
		  {/foreach}

                    </select></td>
                <td>{$lang.Status}</td>
                <td ><select name="filter[status]">
                        <option value="">{$lang.All}</option>
                        <option value="Unpaid" {if $currentfilter.status=='Unpaid'}selected="selected"{/if}>{$lang.Unpaid} </option>
                        <option value="Paid" {if $currentfilter.status=='Paid'}selected="selected"{/if}>{$lang.Paid} </option>
                        <option value="Cancelled" {if $currentfilter.status=='Cancelled'}selected="selected"{/if}>{$lang.Cancelled} </option>

                    </select></td>
            </tr>
            <tr>
                <td>{$lang.recurringid}</td>
                <td><input type="text" value="{$currentfilter.recurring_id}" size="15" name="filter[recurring_id]"/></td>
                <td width="15%">{$lang.invoicedate}</td>
                <td ><input type="text" value="{if $currentfilter.date}{$currentfilter.date|dateformat:$date_format}{/if}" size="15" name="filter[date]" class="haspicker"/></td>


            </tr>
            <tr><td colspan="4"><center><input type="submit" value="{$lang.Search}" />&nbsp;&nbsp;&nbsp;<input type="submit" value="{$lang.Cancel}" onclick="$('#hider2').show();$('#hider').hide();return false;"/></center></td></tr>
        </tbody>
    </table>
    {securitytoken}</form>

<script type="text/javascript">bindFreseter();</script>
{/if} 

{if $drawdetails}
    {if $invoice.status=='Draft'}
        {include file='ajax.draftinvoice.tpl'}
    {else}
        <div class="tdetails">
            {if $invoice.status=='Recurring'}
                <div class="left">
                    <table border="0" width="300" cellspacing="3" cellpadding="0">
                        <tr>
                            <td width="100" align="right" class="light">{$lang.start_date}:</td>
                            <td width="200" align="left"><span class="livemode">{$invoice.recurring.start_from|dateformat:$date_format}</span></td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.frequency}:</td>
                            <td width="200" align="left"><span class="livemode">{$lang[$invoice.recurring.frequency]}</span></td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.occurrences}:</td>
                            <td width="200" align="left"><span class="livemode">{if  $invoice.recurring.occurrences}{$invoice.recurring.occurrences}{else}{$lang.infinite}{/if}</span>
                            </td>
                        </tr><tr>
                            <td colspan="2" class="fs11"><a href="?cmd=invoices&list=all&filter[recurring_id]={$invoice.recurring_id}" target="_blank">{$lang.find_relatedinv}</a></td>
                        </tr>
                    </table>
                </div>
                <div class="left">
                    <table border="0" width="250" cellspacing="3" cellpadding="0">
                        <tr>
                            <td width="100" align="right" class="light">{$lang.next_invoice}:</td>
                            <td width="200" align="left"><span class="livemode">{$invoice.recurring.next_invoice|dateformat:$date_format}</span></td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.remaining|ucfirst}:</td>
                            <td width="200" align="left">{if $invoice.recurring.invoices_left && $invoice.recurring.occurrences}{$invoice.recurring.invoices_left}{else}&#8734;{/if}</td>
                        </tr>
                    </table>
                </div>
            {/if}
            <div class="left">
                <table border="0" cellspacing="5" cellpadding="0">
                    <tr>
                        {if $invoice.status!='Recurring'} <td width="100" align="right" class="light">{$lang.invoicedate}:</td>
                            <td width="200" align="left"><span class="livemode">
                                    {if $proforma && $invoice.status=='Paid'}
                                        {$invoice.datepaid|dateformat:$date_format}
                                    {else}
                                        {$invoice.date|dateformat:$date_format}
                                    {/if}
                                </span>
                            </td>
                        {/if}

                        <td width="100" align="right" class="light">{$lang.Gateway}:</td>
                        <td width="200" align="left">
                            <span class="livemode">{if $invoice.gateway}{$invoice.gateway}{else}{$lang.none}{/if}</span> 
                            {if $cc && $invoice.status=='Unpaid' && $balance>0}
                                <form action="?cmd=invoices&action=edit&id={$invoice.id}&list={$currentlist}"  style="display:inline" method="post" 
                                      onsubmit="return confirm('{$lang.chargefromcc1|addslashes} {$balance|price:$currency} {$lang.chargefromcc2|addslashes}');">
                                    <input type="submit" value="{$lang.chargecc}" name="chargeCC" />{securitytoken}
                                </form>
                            {/if}
                        </td>
                        <td width="100" align="right" class="light">{$lang.currency}:</td>
                        <td width="200">
                            <span class="livemode">{$currency.iso}</span> 
                        </td>
                    </tr>
                    <tr>
                        {if $invoice.status!='Recurring' && $invoice.status!='Creditnote'} 
                            <td width="100" align="right"  class="light">{$lang.duedate}:</td>
                            <td width="200" align="left"><span class="livemode">{$invoice.duedate|dateformat:$date_format}</span></td>
                            {/if}

                        <td width="100" align="right" class="light">{$lang.taxlevel1}:</td>
                        <td width="200" align="left"><span class="livemode">{$invoice.taxrate} %</span></td>
                        
                        {if $invoice.status!='Recurring'}
                            <td width="100" align="right" class="light">{if "config:Invoice2ndcurrency:1"|checkcondition }第一货币汇率{else}当前汇率{/if}:</td>
                            <td width="200">
                                <span class="livemode">{$invoice.rate}</span> 
                            </td>
                        {/if}
                    </tr>
                    <tr>
                        {if $invoice.status!='Recurring' && $invoice.status!='Creditnote'}  
                            <td width="100" align="right"  class="light">Pay Before:</td>
                            <td width="200" align="left"><span class="livemode">{$invoice.paybefore|dateformat:$date_format}</span></td>
                            {/if}

                        <td width="100" align="right" class="light">{$lang.taxlevel2}:</td>
                        <td width="200" align="left"><span class="livemode">{$invoice.taxrate2} %</span></td>

                        {if $invoice.status!='Recurring' && "config:Invoice2ndcurrency:1"|checkcondition }
                            <td width="100" align="right" class="light">第二货币汇率:</td>
                            <td width="200">
                                <span class="livemode">{$invoice.rate2}</span> 
                            </td>
                        {/if}
                    </tr>
                    <tr>
                        {if $invoice.status!='Recurring'}  
                            <td width="100" align="right"  class="light">{$lang.Amount}:</td>
                            <td width="200" align="left"><strong>{$invoice.total|price:$currency}</strong></td>
                                {/if}

                        {if $invoice.status!='Creditnote'}
                            <td width="100" align="right" class="light">{$lang.Credit}:</td>
                            <td width="200" align="left"><span class="livemode">{$invoice.credit|price:$currency}</span></td>
                            {/if}

                    </tr>
                    <tr>

                        {if $invoice.status!='Recurring'}  
                            <td width="100" align="right" class="light">{$lang.balance}</td>
                            <td width="200" align="left">{$balance|price:$currency}</td>
                        {/if}
                        {if $invoice.status!='Creditnote' && $clientcredit>0 && $balance>0}
                            <td width="100" align="right" class="light">{$lang.clientcreditavailable}:</td>
                            <td width="200" align="left" colspan="2">{$clientcredit|price:$currency} <a class="editbtn" onclick="$('.a1').click();return false;" href="#">{$lang.clientcreditaddtoinvoice}</a></td>
                        {/if}
                    </tr>
                </table>
            </div>
            <div class="clear"></div>
        </div>
        <div class="secondtd" style="display:none">
            <form action="" method="post" id="detailsform">
                <input type="hidden" name="make" value="editdetails" />
                <input type="hidden" id="client_id" name="invoice[client_id]" value="{$invoice.client_id}" />
                {if $invoice.status=='Recurring'}
                    <div class="left">
                        <input type="hidden" id="is_recurring" name="invoice[recurring][recurr]" value="1" />
                        <table border="0" width="300" cellspacing="3" cellpadding="0" >
                            <tr>
                                <td width="100" align="right" class="light">{$lang.start_date}:</td>
                                <td width="200" align="left"><input  value="{$invoice.recurring.start_from|dateformat:$date_format}"  type="hidden" id="old_recurring_start_date" /><input name="invoice[recurring][start_from]" value="{$invoice.recurring.start_from|dateformat:$date_format}" class="haspicker" id="recurring_start_date" /></td>
                            </tr>
                            <tr>
                                <td width="100" align="right" class="light">{$lang.frequency}:</td>
                                <td width="200" align="left"><select name="invoice[recurring][frequency]" >
                                        <option value="1w" {if $invoice.recurring.frequency=='1w'}selected="selected"{/if}>{$lang.1w}</option>
                                        <option value="2w" {if $invoice.recurring.frequency=='2w'}selected="selected"{/if}>{$lang.2w}</option>
                                        <option value="4w" {if $invoice.recurring.frequency=='4w'}selected="selected"{/if}>{$lang.4w}</option>
                                        <option value="1m" {if $invoice.recurring.frequency=='1m'}selected="selected"{/if}>{$lang.1m}</option>
                                        <option value="2m" {if $invoice.recurring.frequency=='2m'}selected="selected"{/if}>{$lang.2m}</option>
                                        <option value="3m" {if $invoice.recurring.frequency=='3m'}selected="selected"{/if}>{$lang.3m}</option>
                                        <option value="6m" {if $invoice.recurring.frequency=='6m'}selected="selected"{/if}>{$lang.6m}</option>
                                        <option value="1y" {if $invoice.recurring.frequency=='1y'}selected="selected"{/if}>{$lang.1y}</option>
                                        <option value="2y" {if $invoice.recurring.frequency=='2y'}selected="selected"{/if}>{$lang.2y}</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td width="100" align="right" class="light">{$lang.occurrences}:</td>
                                <td width="200" align="left" class="light" valign="middle"><input name="invoice[recurring][occurrences]" value="{if  $invoice.recurring.occurrences}{$invoice.recurring.occurrences}{else}0{/if}" size="2" id="recurring_occurrences" {if !$invoice.recurring.occurrences}disabled="disabled"{/if} /> #
                                    <input type="checkbox" name="invoice[recurring][infinite]" value="1" onclick="if($(this).is(':checked')) $('#recurring_occurrences').attr('disabled',true);else $('#recurring_occurrences').removeAttr('disabled');" {if !$invoice.recurring.occurrences}checked="checked"{/if}  id="inp_recurring_occurrences"  /> <label for="inp_recurring_occurrences"> {$lang.infinite}</label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" class="fs11"><a href="?cmd=invoices&list=all&filter[recurring_id]={$invoice.recurring_id}" target="_blank">{$lang.find_relatedinv}</a></td>
                            </tr>
                        </table>
                    </div>
                    <div class="left">
                        <table border="0" width="250" cellspacing="3" cellpadding="0">
                            <tr>
                                <td width="100" align="right" class="light">{$lang.next_invoice}:</td>
                                <td width="200" align="left"><input name="invoice[recurring][next_invoice]" value="{$invoice.recurring.next_invoice|dateformat:$date_format}" class="haspicker" id="recurring_next_invoice" /></td>
                            </tr>
                            <tr>
                                <td width="100" align="right" class="light">{$lang.remaining|ucfirst}:</td>
                                <td width="200" align="left">{if $invoice.recurring.invoices_left && $invoice.recurring.occurrences}{$invoice.recurring.invoices_left}{else}&#8734;{/if}</td>
                            </tr>
                        </table>
                    </div>
                {/if}
                <div class="left">
                    <table border="0" width="700" cellspacing="3" cellpadding="0" style="table-layout: fixed;">
                        <tr>
                            {if $invoice.status!='Recurring'}   <td width="100" align="right" class="light">{$lang.invoicedate}:</td>
                                <td width="200" align="left">
                                    {if $proforma && $invoice.status=='Paid'}
                                        <input name="invoice[datepaid]" value="{$invoice.datepaid|dateformat:$date_format}" placeholder="{$invoice.datepaid|dateformat:$date_format}" class="haspicker"/>
                                    {else}
                                        <input name="invoice[date]" value="{$invoice.date|dateformat:$date_format}" placeholder="{$invoice.date|dateformat:$date_format}" class="haspicker"/>
                                    {/if}
                                </td>
                            {/if}

                            <td width="100" align="right" class="light">{$lang.Gateway}:</td>
                            <td width="200" align="left" ><select name="invoice[payment_module]"  onclick="new_gateway(this)">
                                    <option value="0" >{$lang.none}</option>
                                    {foreach from=$gateways key=gatewayid item=paymethod}
                                        <option value="{$gatewayid}"{if $invoice.payment_module == $gatewayid} selected="selected"{/if} >{$paymethod}</option>
                                    {/foreach}
                                    <option value="new" style="font-weight: bold">{$lang.newgateway}</option>

                                </select>
                            </td>
                            
                            <td width="100" align="right" class="light">{$lang.currency}:</td>
                            <td width="200">
                                <select name="invoice[currency_id]" >
                                    {foreach from=$currencies item=curr}
                                        <option value="{$curr.id}"{if $invoice.currency_id == $curr.id}selected="selected"{/if} >{$curr.iso}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                        <tr>
                            {if $invoice.status!='Recurring'  && $invoice.status!='Creditnote'}   
                                <td width="100" align="right"  class="light">{$lang.duedate}:</td>
                                <td width="200" align="left"><input name="invoice[duedate]" value="{$invoice.duedate|dateformat:$date_format}" class="haspicker"/></td>
                                {/if}

                            <td width="100" align="right" class="light">{$lang.taxlevel1}:</td>
                            <td width="200" align="left"><input name="invoice[taxrate]" size="7" value="{$invoice.taxrate}" /> %</td>
                            
                            {if $invoice.status!='Recurring'}
                            <td width="100" align="right" class="light">{if "config:Invoice2ndcurrency:1"|checkcondition }第一货币汇率{else}当前汇率{/if}:</td>
                            <td width="200"><input name="invoice[rate]" size="7" value="{$invoice.rate}" /></td>
                            {/if}

                        </tr>
                        <tr>
                            {if $invoice.status!='Recurring'  && $invoice.status!='Creditnote'}   
                                <td width="100" align="right"  class="light">在该日期前支付:</td>
                                <td width="200" align="left"><input name="invoice[paybefore]" value="{$invoice.paybefore|dateformat:$date_format}" class="haspicker"/></td>
                                {/if}
 
                            <td width="100" align="right" class="light">{$lang.taxlevel2}:</td>
                            <td width="200" align="left" ><input name="invoice[taxrate2]" size="7" value="{$invoice.taxrate2}" /> %</td>

                            {if $invoice.status!='Recurring' && "config:Invoice2ndcurrency:1"|checkcondition }
                                <td width="100" align="right" class="light">第二货币汇率:</td>
                                <td width="200"><input name="invoice[rate2]" size="7" value="{$invoice.rate2}" /></td>
                                {/if}
                        
                        </tr>
                        <tr>
                            {if $invoice.status!='Recurring'}
                                <td width="100" align="right"  class="light">{$lang.Amount}:</td>
                                <td width="200" align="left"><strong>{$invoice.total|price:$currency}</strong></td>
                                    {/if}

                            {if $invoice.status!='Creditnote'}
                                <td width="100" align="right" class="light">{$lang.Credit}:</td>
                                <td width="200" align="left" colspan="2"><input name="invoice[credit]" size="7" value="{$invoice.credit}" /> </td>
                                {/if}

                        </tr>
                        <tr>
                            {if $invoice.status!='Recurring'}  
                                <td width="100" align="right" class="light">{$lang.balance}</td>
                                <td width="200" align="left">{$balance|price:$currency}</td>
                            {/if}

                        {if $invoice.status!='Creditnote' && $clientcredit>0 && $balance>0}
                            <td width="100" align="right" class="light">{$lang.clientcreditavailable}:</td>
                            <td width="200" align="left" colspan="2"> <input name="invoice[apply_credit]" id="addclientcredit_value" size="7" value="{$credit_available}" /><input type="button" id="addclientcredit" value="{$lang.clientcreditapplyfromcredit}" /></td>
                        {/if}
                        </tr>
                        {if $invoice.status!='Recurring' && $invoice.status!='Draft' && $allowclientedits}
                            <tr>
                                <td  align="left" colspan="2"><a href="#" class="editbtn" id="updateclietndetails">{$lang.setcurrentclient}</a></td>
                            </tr>
                        {/if}
                    </table>
                </div>
                <div class="clear"></div>
                <input type="submit" value="{$lang.savechanges}" id="savedetailsform" style="display:none"/>
                {securitytoken}
            </form>
        </div>

    {/if}
    {if $ajax}
        <script type="text/javascript">bindInvoiceDetForm();</script>
    {/if}
{/if}