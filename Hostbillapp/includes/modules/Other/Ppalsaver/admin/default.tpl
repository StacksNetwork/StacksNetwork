<div class="lighterblue">
{if !$result}
This simple tool can save you lot of money spent on PayPal fees - it changes invoice dates of accounts and addons with supplied tolerance,
so they will be put as invoice items on single invoice instead of many invoices. This tool comes with <strong>no warranty</strong>, so make sure that:<br />
- you've created <strong>HostBill database backup</strong> before using it<br />
- your clients are ok with generating one invoice instead of couple in few days <br />
<br />

<div class="blu">

<form method="post">
Tolerance: <input size="4" name="tolerance" value="4" /> days
<input type="submit" value="Proceed" style="font-weight:bold" name="process"/>
</form>
</div>
<br />
<br />

Tolerance field is maximum difference in days between invoices to merge them. So for example:<br />
- Invoice A for client XYZ will be generated on 2010-10-11<br />
- Invoice B for client XYZ will be generated on 2010-10-14<br />
- Invoice C for client XYZ will be generated on 2010-10-15<br />
Tolerance is 4 days, so after using this tool Invoice D  will be generated on 2010-10-14
containg items from Invoice A and B


{else}
<strong>Changed {$result.changed} next invoice dates:</strong><br />
{foreach from=$result.items item=i}
 {if $i.type=='account'} 
 	Account <strong>#{$i.id}</strong><br />
 {else}
	 Addon <strong>#{$i.id}</strong><br />
 {/if}

{/foreach}


{/if}
</div>