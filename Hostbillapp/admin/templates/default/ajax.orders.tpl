{if $action =='frauddetails'}
    {if $fraud_out}
        {include file="orders/step_FraudCheck.tpl"}
    {/if}
{elseif $action == 'getadvanced'}
    <a href="?cmd=orders&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
    <form class="searchform filterform" action="?cmd=orders" method="post" onsubmit="return filter(this)">
        <table width="100%" cellspacing="2" cellpadding="3" border="0">
            <tbody>
                <tr>
                    <td>{$lang.ordernumber}</td>
                    <td ><input type="text" value="{$currentfilter.number}" size="25" name="filter[number]"/></td>
                    <td >{$lang.clientname}</td>
                    <td ><input type="text" value="{$currentfilter.lastname}" size="25" name="filter[lastname]"/></td>
                    <td>{$lang.paymentstatus}</td>
                    <td >
                        <select name="filter[balance]">
                            <option value="">{$lang.Any}</option>
                            <option value="Incomplete">{$lang.Incomplete}</option>
                            <option value="Completed">{$lang.Completed}</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>{$lang.Date}</td>
                    <td ><input type="text" value="{if $currentfilter.date_created}{$currentfilter.date_created|dateformat:$date_format}{/if}" size="15" name="filter[date_created]" class="haspicker"/></td>

                    <td >{$lang.paymethod}</td>
                    <td >
                        <select name="filter[payment_module]">
                            <option value="">{$lang.Any}</option>
                            {foreach from=$modules item=module key=id}
                                <option value="{$id}"  {if $currentfilter.payment_module==$id}selected="selected"{/if}>{$module}</option>
                            {/foreach}
                        </select>
                    </td>
                    <td >{$lang.staffownership}</td>
                    <td >
                        <select name="filter[staff_member_id]">
                            <option value="">{$lang.Any}</option>
                            {foreach from=$staff item=adm}
                                <option value="{$adm.id}"  {if $currentfilter.staff_member_id==$adm.id}selected="selected"{/if}>{$adm.lastname} {$adm.firstname}</option>
                            {/foreach}
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="6"><center>
                <input type="submit" value="{$lang.Search}" />
                &nbsp;&nbsp;&nbsp;
                <input type="submit" value="{$lang.Cancel}" onclick="$('#hider2').show();$('#hider').hide();return false;"/>
            </center></td>
            </tr>
            </tbody>
        </table>
        {securitytoken}</form>
    <script type="text/javascript">bindFreseter();</script>
{elseif $action=='get_product'}
	{if $product}
    	<tr><td colspan="2"><h3>{$lang.productdetails}</h3></td></tr>
        <tr><td width="25%">{$lang.billingcycle}</td><td>
        {if $product.paytype=='Free'}
            <input type="hidden" name="cycle" value="Free" />{$lang.freeproduct}
        {elseif $product.paytype=='Once'}
            <input type="hidden" name="cycle" value="Once" />
            {$product.m|price:$currency} {$lang.Once} / {$product.m_setup|price:$currency} {$lang.setupfee}
        {else}
            <select name="cycle">
            {if $product.h!='0.00'}
                    <option value="h">{$product.h|price:$currency} {$lang.Hourly}</option>
                {/if}
                 {if $product.d!='0.00'}        
                    <option value="d">{$product.d|price:$currency} {$lang.Daily}</option>
                {/if}
                 {if $product.w!='0.00'}
                    <option value="w">{$product.w|price:$currency} {$lang.Weekly}</option>
                {/if}
                {if $product.m!='0.00'}        
                    <option value="m">{$product.m|price:$currency} {$lang.Monthly}</option>
                {/if}
                {if $product.q!='0.00'}        
                    <option value="q">{$product.q|price:$currency} {$lang.Quarterly}</option>
                {/if}
                {if $product.s!='0.00'}        
                    <option value="s">{$product.s|price:$currency} {$lang.SemiAnnually}</option>
                {/if}
                {if $product.a!='0.00'}        
                    <option value="a">{$product.a|price:$currency} {$lang.Annually}</option>
                {/if}
                {if $product.b!='0.00'}        
                    <option value="b">{$product.b|price:$currency} {$lang.Bienially}</option>
                {/if}
				{if $product.t!='0.00'}
                    <option value="t">{$product.t|price:$currency} {$lang.Triennially}</option>
                {/if}
				{if $product.p4!='0.00'}
                    <option value="p4">{$product.p4|price:$currency} {$lang.Quadrennially}</option>
                {/if}
				{if $product.p5!='0.00'}
                    <option value="p5">{$product.p5|price:$currency} {$lang.Quinquennially}</option>
                {/if}
          </select>
          {/if} </td></tr>
        <tr><td style="vertical-align: top" >{$lang.Addons}</td><td>
        {if $addons}
            {foreach from=$addons item=addon key=addon_id}
			{if $addon_id!='categories'}
                <input type="checkbox" name="addon[{$addon_id}]" value="1" /><strong>{$addon.name}</strong>{if $addon.description!=''} - {$addon.description}{/if}<br />
				{/if}
            {/foreach}
        {else}
            {$lang.noaddonsforproduct}
        {/if}
        
        </td></tr>
        
    {/if}
    
{elseif $action=='whois'}
    {if $available}
        <span style="color:green">{$lang.Available} !</span>
    {else}
        <span style="color:red">{$lang.Notavailable} <a href="http://{$domain_name}" target="_blank">www</a> <a href="{$system_url}?cmd=checkdomain&action=whois&domain={$domain_name}" onclick="window.open(this.href,'WHOIS','width=500, height=500, scrollbars=1'); return false">whois</a></span>
    {/if}
{elseif $action=='getperiod'}
    {if $period}
        <select name="domain_period">
        {foreach from=$period item=years}
             <option value="{$years}" {if $years == $submit.domain_period}selected="selected" {/if}>{$years}{if $years == 1} {$lang.Year}{else} {$lang.Years}{/if}</option>
        {/foreach}
        </select>  
    {else}
        {$lang.cantgetperiods}.
    {/if}
{elseif $action=='clientorders'}
<div class="blu" style="text-align:right">
<form action="?cmd=orders&action=add" method="post">
<input type="hidden" name="related_client_id" value="{$client_id}" />
<input type="submit" value="{$lang.neworder}" onclick="window.location='?cmd=orders&action=add&related_client_id={$client_id}';return false;"/>{securitytoken}</form></div>

{if $orders}
 <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
        <tbody>
          <tr>
            <th>ID</th>
            <th>{$lang.orderhash}</th>
            <th>{$lang.Date}</th>
            <th>{$lang.Total}</th>
            <th>{$lang.paymethod}</th>
            <th>{$lang.paymentstatus}</th>
            <th>{$lang.Status}</th>
          </tr>
        </tbody>
        <tbody>
        
        {foreach from=$orders item=order}
     <tr>
         <td><a href="?cmd=orders&action=edit&id={$order.id}">{$order.id}</a></td>
           <td><a href="?cmd=orders&action=edit&id={$order.id}">{$order.number}</a></td>         
          <td>{$order.date_created|dateformat:$date_format}</td>
          <td>{$order.total|price:$order.currency_id}</td>
          <td>{if $order.total<0}{$lang.amountcredited}{else}{$order.module}{/if}</td>
          <td><span class="{$order.balance}">{$lang[$order.balance]}</span></td>
          <td><span class="{$order.status}">{$lang[$order.status]}</span></td>
         
        </tr>
    {/foreach}
        </tbody>
        
      </table>
{if $totalpages}
			 <center class="blu"><strong>{$lang.Page} </strong>
			 {section name=foo loop=$totalpages}
{if $smarty.section.foo.iteration-1==$currentpage}<strong>{$smarty.section.foo.iteration}</strong>{else}
          <a href='?cmd=orders&action=clientorders&id={$client_id}&page={$smarty.section.foo.iteration-1}' class="npaginer">{$smarty.section.foo.iteration}</a>
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
<p style="text-align: center">{$lang.nothingtodisplay}</p>

{/if}
	
	
{elseif $action=='getextended'}
    {if $extended}
    	<table width="100%" cellspacing="1" cellpadding="1" border="0"><tr><td colspan="2"><h3>{$lang.extendedattribs}</h3></td></tr>
        {foreach from=$extended item=attribute}
        	<tr>
            	<td width="25%">{$attribute.description}</td><td>         
		   {if $attribute.type == "input"}
            	<input type="text" name="domain_extended[{$attribute.name}]" size="20" value="{$fields.extended[$attribute.name]}"/>
            {elseif $attribute.type == "select"}
            <select name="domain_extended[{$attribute.name}]">
               
                {foreach from=$attribute.option item=value}
                    <option value="{$value.value}" {if $value.value == $fields.extended[$attribute.name]} selected="selected"{/if} >{$value.title}</option>
                {/foreach}
            </select>
            {elseif $attribute.type == "checkbox"}
            	<input type="checkbox"  name="domain_extended[{$attribute.name}]" value="1" {if $fields.extended[$attribute.name] == "1"}checked="checked" {/if}/>
            {/if}<br />
            </td></tr>
            {/foreach}
        </table>
	{/if}
{elseif $action=="draft"}
    {if $orders}
        {foreach from=$orders item=order}
            <tr>
                <td><input type="checkbox" class="check" value="{$order.id}" name="selected[]"/></td>
                <td><a href="?cmd=orders&action=createdraft&id={$order.id}">{$order.id}</a></td>
                <td>{if $order.client_id}<a href="?cmd=clients&action=show&id={$order.client_id}">{$order.lastname} {$order.firstname}</a>{else} -{/if}</td>
                <td>{$order.date_created|dateformat:$date_format}</td>
                <td>{if $order.currency_id}{$order.total|price:$order.currency_id}{else}{$order.total|price:$currency}{/if}</td>
                <td>{if $order.module}{$order.module}{else}-{/if}</td>
                <td><span class="{$order.status}">{$lang[$order.status]}</span></td>
                <td><a href="?cmd={$cmd}&action={$action}&make=delete&id={$order.id}&security_token={$security_token}" onclick="return confirm('{$lang.deleteorderconfirm}');" class="delbtn">删除</a></td>
            </tr>
        {/foreach}
    {elseif $action=="createdraft"}
        {include file='orders/add.tpl'}
    {else}
        <tr><td colspan="11"><p align="center" >{$lang.Click} <a href="?cmd=orders&action=createdraft" >{$lang.here}</a> 新建草稿.</p></td></tr>
    {/if}
{else}
    {if $orders}
    {foreach from=$orders item=order}
     <tr>
          <td><input type="checkbox" class="check" value="{$order.id}" name="selected[]"/></td>
          <td><a href="?cmd=orders&action=edit&id={$order.id}&list={$currentlist}">{$order.id}</a></td>
              <td><a href="?cmd=orders&action=edit&id={$order.id}&list={$currentlist}">{$order.number}</a></td>
          <td><a href="?cmd=clients&action=show&id={$order.client_id}">{$order.lastname} {$order.firstname}</a></td>
          <td>{$order.date_created|dateformat:$date_format}</td>
          <td>{$order.total|price:$order.currency_id}</td>
          <td>{if $order.total<0}{$lang.amountcredited}{else}{if $order.module}{$order.module}{else}-{/if}{/if}</td>
          <td><span class="{$order.balance}">{$lang[$order.balance]}</span></td>
          <td><span class="{$order.status}">{$lang[$order.status]}</span></td>
          <td>
              {if !$forbidAccess.deleteOrders}
                <a href="?cmd=orders&make=delete&id={$order.id}&security_token={$security_token}" onclick="return confirm('{$lang.deleteorderconfirm}');" class="delbtn">删除</a>
              {/if}
          </td>
        </tr>
    {/foreach}
    {elseif $action=="createdraft"}
        {include file='orders/add.tpl'}
    {else}
        <tr><td colspan="11"><p align="center" >{$lang.Click} <a href="?cmd=orders&action=add">{$lang.here}</a> {$lang.toplaceneworder}</p></td></tr>
      {/if}
{/if}