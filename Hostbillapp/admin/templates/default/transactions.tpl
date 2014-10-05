<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
       <tr>
        <td ><h3>{$lang.Transactions}</h3></td>
        <td  class="searchbox"><div id="hider2" style="text-align:right">

                &nbsp;&nbsp;&nbsp;<a href="?cmd=transactions&action=getadvanced" class="fadvanced">{$lang.filterdata}</a> <a href="?cmd=transactions&resetfilter=1" {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>

            </div>
            <div id="hider" style="display:none"></div></td>
    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=invoices&list=all&showall=true"  class="tstyled">{$lang.Allinvoices}</a>
            <a href="?cmd=invoices&list=paid&showall=true"  class="tstyled">{$lang.Paidinvoices}</a>
            <a href="?cmd=invoices&list=cancelled&showall=true"  class="tstyled">{$lang.Cancelledinvoices}</a>
            <a href="?cmd=invoices&list=unpaid&showall=true"  class="tstyled">{$lang.Unpaidinvoices}</a><br />

            <a href="?cmd=invoices&list=recurring&showall=true"  class="tstyled">{$lang.Recurringinvoices}</a><br />

            <a href="?cmd=estimates"  class="tstyled">{$lang.Estimates}</a><br />
            <a href="?cmd=transactions"  data-pjax class="tstyled selected">{$lang.Transactions}</a> <a href="?cmd=gtwlog"  class="tstyled ">{$lang.Gatewaylog}</a>
            <div style="font-size:11px; margin-top: 50px;">
                {$lang.totalincome}: <strong>{$total.income|price:$currency}</strong><br />
                {$lang.totalfees}: <strong>{$total.fees|price:$currency}</strong><br />
                {$lang.balance}: <strong>{$total.balance|price:$currency}</strong><br />
            </div>
        </td>
        <td  valign="top"  class="bordered"><div id="bodycont"> 
            {include file='ajax.transactions.tpl'}   
            </div></td>
    </tr>
</table>
