<table border="0" cellpadding="0" cellspacing="0" width="100%">
    
	<tr>
	<td class="leftNav" style="line-height:20px;position:relative" rowspan="2">
		<strong>{$lang.Shortcuts}:</strong><br />
		<a href="?cmd=newclient">{$lang.addcustomer}</a><br />
		<a href="?cmd=tickets&action=new">{$lang.opensupticket}</a><br />
		<a href="?cmd=orders&action=add">{$lang.placeneworder}</a><br />
		<a href="?cmd=stats">{$lang.systemstatistics}</a><br />
              
                      
                   <br />
	
	
	
	<div style="font-size:11px;line-height:15px;">
	<strong>{$lang.whosonline}</strong><br />
	
		{foreach from=$others item=o}
			{$o.username} 
		{/foreach}


		<br />
		<br />	
	<span style="font-size:11px;">{$lang.Licenseto}: <strong>{$license.to}</strong><br />
		{$lang.Expires}: <strong>{$license.expires}</strong><br />
	{$lang.Version}: <strong>{$version}</strong>{if $build}<em>:{$build}</em>{/if}
	{if $newversion}<br /><span style="color:red">{$lang.newVersion}: <strong>{$newversion}</strong></span> (<a class="external" target="_blank" href="http://hostbillapp.com/changelog" >{$lang.more|capitalize}</a>){/if}</span><br />
	
	{if $forecast}
	<br />

<strong>{$lang.incomeforecast}</strong>
		<div id="forecast">
		

	
<strong>{$lang.i6m}:</strong> <br />
<div style="text-align:right"><strong>{$forecast.total6|price:$currency}</strong></div>
<strong>{$lang.i12m}:</strong> <br />
<div style="text-align:right"><strong>{$forecast.total|price:$currency}</strong></div>
<strong>{$lang.i24m}:</strong> <br />
<div style="text-align:right"><strong>{$forecast.total24|price:$currency}</strong></div>

	</div>	
	{/if}
	
        
        
	</div>
        
        <br/><br/>
        <div>
            <strong>Latest modules: </strong>
            <iframe src="https://hostbillapp.com/latest_items.html" border="0" frameborder="0" width="179"></iframe>
        </div>
	</td>
	<td valign="top">
            {if $stats}
	<div  class="gbox1">
		
		<div class="left">
		{$lang.incometoday}: <strong>{$stats.today|price:$currency}</strong>,
		{$lang.thismonth}: <strong>{$stats.month|price:$currency}</strong>,
		{$lang.thisyear}: <strong>{$stats.year|price:$currency}</strong>
		</div>
		
		<div class="right">
		<a href="?cmd=orders">{$lang.orderstoday}: <strong>{$stats.orders}</strong></a>&nbsp;&nbsp;
		<a href="?cmd=orders&list=active">{$lang.Activated}: <strong>{$stats.active_orders}</strong></a>&nbsp;&nbsp;
		<a href="?cmd=orders&list=pending">{$lang.Pending}: <strong>{$stats.pending_orders}</strong></a>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="?cmd=logs&action=cancelations"><strong>{$stats.requests}</strong> {$lang.pendingtocancel}</a>
		</div>
		
		<div class="clear"></div>
		
	</div>
            {/if}
	</td>
	</tr>

	<tr>
	<td  valign="top">
	
	
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
                    {if $qc_features}
                    <script type="text/javascript" src="{$template_dir}js/facebox/facebox.js"></script>
                    <link rel="stylesheet" href="{$template_dir}js/facebox/facebox.css" type="text/css" />
                    <script type="text/javascript">
                         {literal}  function appendMe1() {
                             $.facebox({ ajax: '?cmd=root&action=initialconfig' });
                        }  {/literal}
                        appendLoader('appendMe1');
                     </script>
                    {/if}
	
			<tr>
			<td width="50%" valign="top" id="fp_leftcol">
			{if $orders}
			<div class="bborder">
			
				<div class="bborder_header">
					<div style="float:left">{$lang.recentorders}</div>
				
					<div style="float:right;font-weight:normal;font-size:11px;color:#535353;"><span class="pord"></span>&nbsp; {$lang.paymentreceived}</div>
					<div style="clear:both"></div>
				</div>
				<div class="bborder_content">
				
				 <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike" style="">
        <tbody>
          <tr>
          
            <th>{$lang.orderhash}</th>
            <th>{$lang.clientname}</th>
            <th>{$lang.Date}</th>
            <th>{$lang.Total}</th>
            <th>{$lang.Status}</th>
           
          </tr>
		  {foreach from=$orders item=order}
     <tr {if $order.balance=='Completed'}class="compor"{/if}>
         
              <td><a href="?cmd=orders&action=edit&id={$order.id}&list=all">{$order.number}</a></td>
          <td><a href="?cmd=clients&action=show&id={$order.client_id}">{$order.name}</a></td>
          <td>{$order.date_created|dateformat:$date_format}</td>
          <td>{$order.total|price:$order.currency_id}</td>
         
          <td><span class="{$order.status}">{if $order.status == 'Active'}{$lang.Active}{elseif $order.status == 'Pending'}{$lang.Pending}{elseif $order.status == 'Fraud'}{$lang.Fraud}{elseif $order.status == 'Cancelled'}{$lang.Cancelled}{elseif $order.status == 'Imported'}{$lang.Imported}{else}{$order.status}{/if}</span></td>
         
        </tr>
    {/foreach}
        </tbody>
		</table>
				</div>
				
				</div>
				{/if}
			
			{if $activity.domains}
			<div class="bborder">
			
				<div class="bborder_header">
				{$lang.recentdomains}
				</div>
				<div class="bborder_content">
				<table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike" style="">
            <tbody>
			<tr>
                <th>{$lang.Domain}</th>
                <th>{$lang.Action}</th>
                <th>{$lang.Success}</th>
                <th>{$lang.Date}</th>
            </tr>
			
			
			{foreach from=$activity.domains item=dom}
				<tr>
					<td width="30%"><a href="?cmd=domains&action=edit&id={$dom.domain_id}">{$dom.name}</a></td>
                <td>{$dom.action}</td>
                <td>{if $dom.result=='1'}{$lang.Yes}{else}<font color="red">{$lang.No}</font>{/if}</td>
                <td>{$dom.date|dateformat:$date_format}</td>
					
				</tr>
			{/foreach}
			</tbody>
				
			</table>
				</div>
			</div>
		
			{/if}
			
			{if $HBaddons.mainpage}
				<div class="bborder">
			
				<div class="bborder_header">
				{$lang.Plugins}
				</div>
				<div class="bborder_content">
				{foreach from=$HBaddons.mainpage item=module}
					<div class="addon_module"><strong><a href="?cmd=module&module={$module.id}">{$module.name}</a></strong></div>
					<div class="clear"></div>
				{/foreach}
				</div>
					
				</div>
			{/if}
			
			</td>
			<td width="50%" valign="top" style="padding-left:7px"  id="fp_rightcol">
			{if $mytickets}
			
			<div class="bborder">
			
				<div class="bborder_header">
				{$lang.mysuptickets} <a href="?cmd=tickets">({$mytickets_count} {$lang.unread})</a>
				</div>
				<div class="bborder_content">
			
				
				 <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike"  style="">
    <tbody>
      <tr>
        <th>{$lang.Date}</th>
        <th width="30%">{$lang.Subject}</th>
        <th>{$lang.Submitter}</th>
        <th>{$lang.Status}</th>
   
      </tr>
	    {foreach from=$mytickets item=ticket}
    <tr>
      
      <td>{$ticket.date|dateformat:$date_format}</td>
      <td>{if $ticket.admin_read=='0'}<strong>{/if}<a href="?cmd=tickets&action=view&list=all&num={$ticket.ticket_number}" >{$ticket.tsubject}</a>{if $ticket.admin_read=='0'}<strong>{/if}</td>
      <td>{if $ticket.client_id!='0'}<a href="?cmd=clients&action=show&id={$ticket.client_id}">{/if}{$ticket.name}{if $ticket.client_id!='0'}</a>{/if}</td>
      <td><span class="{$ticket.status}">{if $ticket.status == 'Open'}{$lang.Open}{elseif $ticket.status == 'Answered'}{$lang.Answered}{elseif $ticket.status == 'Closed'}{$lang.Closed}{elseif $ticket.status == 'Client-Reply'}{$lang.Clientreply}{elseif $ticket.status == 'In-Progress'}{$lang.Inprogress}{else}{$ticket.status}{/if}</span></td>
    </tr>
    {/foreach}
    
	  
    </tbody>
	</table>	</div>
				
				</div>
			{/if}
			
			{if $activity.accounts}
			<div class="bborder">
			
				<div class="bborder_header">
				{$lang.recentaccfailures}
				</div>
				<div class="bborder_content">
				<table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike" style="">
            <tbody>
			
				<tr>
				<th>{$lang.Account}</th>
                                <th>{$lang.Action}</th>
                                <th>{$lang.Error}</th>
                                <th>{$lang.Date}</th>
					
				</tr>
			
			{foreach from=$activity.accounts item=acc}
			<tr>
               <td width="120"><a href="?cmd=accounts&action=edit&id={$acc.account_id}">{if $acc.domain}{$acc.domain}{else}<em>#{$acc.account_id} <font style="font-size: 8px">( {$lang.emptyhost} )</font></em>{/if}</a></td>
               <td width="25%">{$acc.action}</td>
               <td>{$acc.error}</td>          
               <td width="80">{$acc.date|dateformat:$date_format}</td>
            </tr>
			{/foreach}
			
			</tbody>
				
			</table>
				</div>
			</div>
		{/if}
			
			
			</td>
			</tr>
		</table>

	 {include file='adminwidgets/todolist.tpl'}
         
         <div id="fp_bottomcol">

	</div>

	 {include file='adminwidgets/systeminfo.tpl'}

		
           
	
	</td>
	</tr>
</table>
         {literal}
<style type="text/css">.banner-el {
        
                    box-shadow: 0px 2px 2px 0px  rgba(1, 1, 1, 0.5);
                    color:#fff !important;
                    line-height:13px;
                    padding:10px 5px;
                    width:120px;
                    text-align:right;
                    margin-top:20px;
                    margin-bottom:5px;
                        background-image: -moz-linear-gradient(top, #E72626 0%, #CF1B1B 100%);
                        background-image: -o-linear-gradient(top, #E72626 0%, #CF1B1B 100%);
                        background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0, #E72626), color-stop(1, #CF1B1B));
                        background-image: -webkit-linear-gradient(top, #E72626 0%, #CF1B1B 100%);
                        background-image: linear-gradient(to bottom, #E72626 0%, #CF1B1B 100%);
                        }
                        
                        </style>
         {/literal}