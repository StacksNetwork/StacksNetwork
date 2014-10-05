<script type="text/javascript">loadelements.estimates=true;</script>
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
  <tr>
    <td ><h3>{$lang.Estimates}</h3></td>
    <td  class="searchbox">
     <div id="hider2" style="text-align:right"><a href="?cmd=estimates&action=getadvanced" class="fadvanced">{$lang.filterdata}</a>
	  <a href="?cmd=estimates&resetfilter=1" {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
	  </div>
      <div id="hider" style="display:none"></div></td>
  </tr>
  <tr>
    <td class="leftNav">

 <a href="?cmd=invoices&list=all&showall=true"  class="tstyled">{$lang.Allinvoices} {if $stats}<span>({$stats.All})</span>{/if}</a>
 <a href="?cmd=invoices&list=paid&showall=true"  class="tstyled">{$lang.Paidinvoices} {if $stats}<span>({$stats.Paid})</span>{/if}</a>
 <a href="?cmd=invoices&list=cancelled&showall=true"  class="tstyled">{$lang.Cancelledinvoices} {if $stats}<span>({$stats.Cancelled})</span>{/if}</a>
 <a href="?cmd=invoices&list=unpaid&showall=true"  class="tstyled">{$lang.Unpaidinvoices} {if $stats}<span>({$stats.Unpaid})</span>{/if}</a><br />

 <a href="?cmd=invoices&list=recurring&showall=true"  class="tstyled">{$lang.Recurringinvoices} {if $stats}<span>({$stats.Recurring})</span>{/if}</a><br />

  <a href="?cmd=estimates"  class="tstyled selected">{$lang.Estimates}</a><br />

 <a href="?cmd=transactions"  class="tstyled">{$lang.Transactions}</a>
 <a href="?cmd=gtwlog"  class="tstyled ">{$lang.Gatewaylog}</a>
	</td>
    <td  valign="top"  class="bordered"><div id="bodycont"> 

	
		{include file='ajax.estimates.tpl'}
	
	
	</div></td>
  </tr>
</table>