<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
  <tr>
    <td ><h3>{$lang.logsection}</h3></td>
     {if $cmd=='emails'}
	<td  class="searchbox">
    
	 <div id="hider2" style="text-align:right"><a href="?cmd=emails&action=getadvanced" class="fadvanced">{$lang.filterdata}</a>
	  <a href="?cmd=emails&resetfilter=1" {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
	  </div>
      <div id="hider" style="display:none"></div>
	  {elseif $cmd=='clientcredit'}
	<td  class="searchbox">
    
	 <div id="hider2" style="text-align:right"><a href="?cmd=clientcredit&action=getadvanced" class="fadvanced">{$lang.filterdata}</a>
	  <a href="?cmd=clientcredit&resetfilter=1" {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
	  </div>
      <div id="hider" style="display:none"></div>
	  {else} 
          <td>
	  {/if}
	  </td>
  </tr>
  <tr>
    <td class="leftNav">

 <a href="?cmd=logs&action=manage"  data-pjax class="tstyled {if $cmd=='logs' && $action=='manage'}selected{/if}"><strong>{$lang.managelogs}</strong></a>
 <br />
    <a href="?cmd=logs"  data-pjax class="tstyled {if $cmd=='logs' && $action=='default'}selected{/if}">{$lang.systemlog}</a>
    <a href="?cmd=logs&action=adminactivity"  data-pjax class="tstyled  {if $action=='adminactivity'}selected{/if}">{$lang.adminactivity}</a>
    <a href="?cmd=logs&action=clientactivity"  data-pjax class="tstyled  {if $action=='clientactivity'}selected{/if}">{$lang.clientactivity}</a>
    
    <a href="?cmd=clientcredit"  data-pjax class="tstyled  {if $cmd=='clientcredit'}selected{/if}">{$lang.clientcreditlog}</a>
    <a href="?cmd=logs&action=coupons"  data-pjax class="tstyled  {if $action=='coupons'}selected{/if}">{$lang.couponsusage}</a>
    <a href="?cmd=logs&action=cancelations" data-pjax class="tstyled  {if $action=='cancelations'}selected{/if}">{$lang.canceltitle}</a>
    <a href="?cmd=logs&action=apilog" data-pjax class="tstyled  {if $action=='apilog'}selected{/if}">{$lang.apilog}</a>
    <a href="?cmd=logs&action=errorlog" data-pjax class="tstyled  {if $action=='errorlog'}selected{/if}">{$lang.errorlog}</a>
 <br />
 
 <a href="?cmd=emails"  data-pjax class="tstyled  {if $cmd=='emails'}selected{/if}">{$lang.emailssent}</a>
 <a href="?cmd=logs&action=importlog"  data-pjax class="tstyled  {if $action=='importlog' || $action=='getimportlog'}selected{/if}">{$lang.ticketimplog}</a>

	</td>
    <td  valign="top"  class="bordered"><div id="bodycont"> 

	
		{if $cmd=='emails'}
                    {include file='ajax.emails.tpl'}
		{elseif $cmd=='clientcredit'}
                    {include file='ajax.clientcredit.tpl'}
		{elseif $cmd=='logs'}
                    {include file='ajax.logs.tpl'}	
                {/if} 
	
	
	</div></td>
  </tr>
</table>