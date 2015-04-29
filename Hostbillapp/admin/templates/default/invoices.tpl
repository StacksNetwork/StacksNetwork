<script type="text/javascript">loadelements.invoices=true;</script>
<script type="text/javascript" src="{$template_dir}js/invoices.js?v={$hb_version}"></script>
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
	<tr>
		<td ><h3>{$lang.Invoices}</h3></td>
		<td  class="searchbox">
			<div id="hider2" style="text-align:right"><a href="?cmd=invoices&action=getadvanced" class="fadvanced">{$lang.filterdata}</a>
				<a href="?cmd=invoices&resetfilter=1" {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
			</div>
			<div id="hider" style="display:none"></div>
		</td>
	</tr>
	<tr>
		<td class="leftNav">
			<a href="?cmd=invoices&list=all&showall=true"  class="tstyled {if $currentlist!='recurring' && $currentlist!='creditnote'}tload{/if} {if $currentlist=='all' || !$currentlist}selected{/if}">{$lang.Allinvoices} {if $stats}<span>({$stats.All})</span>{/if}</a>
			<a href="?cmd=invoices&list=paid&showall=true"  class="tstyled tsubit {if $currentlist!='recurring' && $currentlist!='creditnote'}tload{/if} {if $currentlist=='paid'}selected{/if}">{$lang.Paidinvoices} {if $stats}<span>({$stats.Paid})</span>{/if}</a>
			<a href="?cmd=invoices&list=unpaid&showall=true"  class="tstyled tsubit  {if $currentlist!='recurring' && $currentlist!='creditnote'}tload{/if} {if $currentlist=='unpaid'}selected{/if}">{$lang.Unpaidinvoices} {if $stats}<span>({$stats.Unpaid})</span>{/if}</a>
			<a href="?cmd=invoices&list=cancelled&showall=true"  class="tstyled tsubit  {if $currentlist!='recurring' && $currentlist!='creditnote'}tload{/if} {if $currentlist=='cancelled'}selected{/if}">{$lang.Cancelledinvoices} {if $stats}<span>({$stats.Cancelled})</span>{/if}</a>
			<a href="?cmd=invoices&list=refunded&showall=true"  class="tstyled tsubit  {if $currentlist!='recurring' && $currentlist!='creditnote'}tload{/if} {if $currentlist=='refunded'}selected{/if}">{$lang.Refundedinvoices} {if $stats}<span>({$stats.Refunded})</span>{/if}</a>

                         {if "config:CnoteEnable:on"|checkcondition}
			<br/>
                             <a href="?cmd=invoices&list=creditnote&showall=true"  class="tstyled   {if $currentlist=='creditnote'}selected{/if}">{$lang.Creditnotes} {if $stats}<span>({$stats.Creditnote})</span>{/if}</a>

                         {/if}
			<br/>
			<a href="?cmd=invoices&list=recurring&showall=true"  class="tstyled {if $currentlist=='recurring'}selected{/if}">{$lang.Recurringinvoices} {if $stats}<span>({$stats.Recurring})</span>{/if}</a>
			<br />


			<a href="?cmd=estimates"  class="tstyled">{$lang.Estimates}</a><br />
			<a href="?cmd=transactions"  class="tstyled">{$lang.Transactions}</a>
			<a href="?cmd=gtwlog"  class="tstyled ">{$lang.Gatewaylog}</a>
		</td>
		<td  valign="top"  class="bordered"><div id="bodycont"> 


				{include file='ajax.invoices.tpl'}


			</div>
		</td>
	</tr>
</table>