{if $customfile}
{include file=$customfile}
{elseif $action=='getqueue'}
{foreach from=$queue item=q}
    <span class="left"  
        style="{if $q.status=='Canceled'}text-decoration:line-through;color:#808080
        {elseif $q.status=='OK'}color:#7ebd7a{elseif ($q.when<0 && $q.status!='OK') || $q.status=='Failed'}color:red{/if}"
                {if $q.interval_type}title="{$q.interval} {$q.interval_type|lower} {$q.event_when} {if $lang[$q.event]}{$lang[$q.event]}{else}{$q.event}{/if}"{/if}>
        {if $q.when<0 || $q.status=='OK'}
        {else}{$lang.in}
        {/if} 
        {if $q.wt}<b>{$q.wt}</b>
        {else}<b>{$q.when}</b> {$lang.days} 
            {if $q.when<0 || $q.status=='OK'}{$lang.ago}
            {/if}
        {/if} 
        ({$q.date|dateformat:$date_format}) 
        {if $lang[$q.task]}{$lang[$q.task]}
        {else}{$q.task}
        {/if}
        {if $q.items} 
            ({foreach from=$q.items item=i}{$lang[$i.what]} #{$i.rel_id} {/foreach}) 
        {elseif $q.what!='account'} - 
            {if $q.what=='invoice'}<a href="?cmd=invoices&action=edit&id={$q.rel_id}" target="_blank">{/if}
                {$lang[$q.what]} #{$q.rel_id} {$q.name}
                {if $q.what=='invoice'}</a>{/if}
            {/if}
        {if $q.log}{$q.log}{/if}
        {if $q.task=='nextinvoice'}- <a href="?cmd=accounts&account_id={$account_id}&action=generateinvoice{foreach from=$q.items item=i}&{$i.what}[]={$i.rel_id}{/foreach}&security_token={$security_token}" 
             onclick="return confirm('Are you sure you want to generate invoice now?')">立即生成账单</a>
        {/if}
        <br/>
    </span>
    {if ($q.status=='Pending' && $q.custom_id) || ($q.event && !$q.custom_id)}
        <a href="#" class="rembtn left" style="margin-left:6px;" onclick="if (confirm('您确定要取消该计划任务吗?'))
                    ajax_update('?cmd=accounts&action=getqueue&id={$account_id}&make=canceltask&task={$q.custom_id}&account_id={$account_id}&event={$q.event}', false, '#autoqueue', true);
                return false;">{$lang.Remove}</a>
    {/if}
    {if $q.status=='Canceled' &&  $q.custom_id}
        <a href="#" class="editbtn left" style="margin-left:6px;" onclick="ajax_update('?cmd=accounts&action=getqueue&id={$account_id}&make=activatetask&task={$q.custom_id}', false, '#autoqueue', true);
                return false;">{$lang.Activate}</a>
    {/if}
    <div class="clear"></div>
{foreachelse}
    {$lang.noupcomingtasks}
{/foreach}
{elseif $action=='addonbilling'}
{if $abilling}
			{if $abilling.paytype=='Free'} <input type="hidden" name="new_addon_cycle" value="free"  id="new_addon_cycle"/> {$lang.price}:<strong> {$lang.Free}</strong>
			{elseif $abilling.paytype=='Once'} 
			 {$lang.price}: {$abilling.m|price:$currency} {$lang.Once} {if $abilling.m_setup>0}/ {$abilling.m_setup|price:$currency} {$lang.setupfee}{/if}
			 <input type="hidden" name="new_addon_cycle" value="once"  id="new_addon_cycle"/>
			{else}
			 {$lang.price}: <select name="new_addon_cycle" id="new_addon_cycle">
       {if $abilling.h!=0}<option value="h">{$abilling.h|price:$currency} {$lang.Hourly}{if $abilling.h_setup!=0} + {$abilling.h_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
	{if $abilling.d!=0}<option value="d">{$abilling.d|price:$currency} {$lang.Daily}{if $abilling.d_setup!=0} + {$abilling.d_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
     {if $abilling.w!=0}<option value="w">{$abilling.w|price:$currency} {$lang.Weekly}{if $abilling.w_setup!=0} + {$abilling.w_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
     {if $abilling.m!=0}<option value="m">{$abilling.m|price:$currency} {$lang.Monthly}{if $abilling.m_setup!=0} + {$abilling.m_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
     {if $abilling.q!=0}<option value="q">{$abilling.q|price:$currency} {$lang.Quarterly}{if $abilling.q_setup!=0} + {$abilling.q_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
     {if $abilling.s!=0}<option value="s">{$abilling.s|price:$currency} {$lang.SemiAnnually}{if $abilling.s_setup!=0} + {$abilling.s_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
     {if $abilling.a!=0}<option value="a">{$abilling.a|price:$currency} {$lang.Annually}{if $abilling.a_setup!=0} + {$abilling.a_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
     {if $abilling.b!=0}<option value="b">{$abilling.b|price:$currency} {$lang.Biennially}{if $abilling.b_setup!=0} + {$abilling.b_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
     {if $abilling.t!=0}<option value="t">{$abilling.t|price:$currency} {$lang.Triennially}{if $abilling.t_setup!=0} + {$abilling.t_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
	
</select>
			{/if}
			{if $abilling.paytype!='Free'}
			
		<input type="checkbox" name="addon_invoice" id="new_addon_invoice" value="1" checked="checked"/> <strong>{$lang.CreateInvoice}</strong>
			 {else}
			 <input type="hidden" name="addon_invoice" id="new_addon_invoice" value="0" />
			{/if}
			
		{/if}

{elseif $action=='getacctaddons'}
<script type="text/javascript">
{literal}
function submitAddon(id) {
$('#account_form').append('<input type="hidden" name="addon_id" value="'+id+'"/>');
return true;
}
function loadTemplate(addon_id,fn)  {
	$('#dommanager').show();
	$('#man_content').addLoader();
	 $('#man_title').html(fn);
	 ajax_update('?cmd=accounts&action=addonmodule',{addon_id:addon_id,call:fn},'#man_content');
	 return false;
}
  function addAddon(){
          $.post('?cmd=accounts&action=addon_add',{
                account_id:$('#account_id').val(),
                addon_id:$('#new_addon_id').val(),
                gateway:$('#new_addon_gtw').val(),
				cycle:$('#new_addon_cycle').val(),
				invoice:$('#new_addon_invoice').is(':checked')
            }, function(data){
                var resp = parse_response(data);
                if (resp)  {

                    $('#AddAddon').hide();
                    $('#areaddons').show();

                    $('#noaddons').hide();
                    $('#addontbl').show();
                    $('#addontbl').append(resp);

                }
            });
            return false;

    }
		function editaddon(id) {
	ajax_update('?cmd=accounts&action=addon_details&addon_id='+id,{},'#addonedit_'+id);
			return false;
	}

 function saveChanges(id) {
            ajax_update('?cmd=accounts&action=addon_save&addon_id='+id+'&'+$('#innerform_'+id).serialize(),{},'#addonedit_'+id);
            $('#AddAddonT').show();
			return false;
            }
	function cancelChanges(id) {
            ajax_update('?cmd=accounts&action=addonrow&addon_id='+id,{},'#addonedit_'+id);
            $('#AddAddonT').show();
			return false;
            }

	function deleteaddon(id) {
		var answer = confirm('{/literal}{$lang.addondeleteconfirm}{literal}');
		if (answer) {
			ajax_update('?cmd=accounts&action=addon_remove&addon_id='+id);
			 $('#addonedit_'+id).remove();
			 if ($('#addontbl tr').length <2 ) {
			 	        $('#addontbl').hide();
						$('#areaddons').hide();
						 $('#noaddons').show();
			}
		}
		return false;
	}
	
	function cnbilling(sel) {
		ajax_update('?cmd=accounts&action=addonbilling',{addon_id:$(sel).val()},'#addon_billing');
	}
{/literal}
</script>
	 <table border="0" cellpadding="2" cellspacing="0" width="100%" class="glike" id="addontbl" {if !$account_addons}style="display:none"{/if}>


		<tr>
			<th>{$lang.Name}</th>
			<th>{$lang.Billing}</th>
			<th>{$lang.Status}</th>
			<th></th>
			
			<th width="20"></th>
			<th width="20"></th>
		</tr>


		 {if $account_addons}

			 {foreach from=$account_addons item=addon}

			<tr id="addonedit_{$addon.id}">
				<td>{$addon.name}</td>
				<td>{if $addon.billingcycle=='Free'} {$lang.Free} {else}{$addon.recurring_amount|price:$client.currency_id} {$lang[$addon.billingcycle]} {if $addon.setup_fee>0}+ {$addon.setup_fee|price:$client.currency_id} {$lang.setupfee}{/if}{/if}</td>
				<td><span class="{$addon.status}">{$lang[$addon.status]}</span></td>
				<td>{if $addon.methods} 
				{foreach from=$addon.methods item=met}<input type="submit" value="{$met}" name="addonmethod" onclick="return submitAddon({$addon.id});"/>{/foreach}
				{if $addon.templated} {foreach from=$addon.templated item=met}<input type="submit" value="{$met}" name="addontemplated" onclick="return loadTemplate({$addon.id},'{$met}');"/>{/foreach}{/if}
				{/if}</td>
				<td><a href="javascript:void(0);" class="editbtn" onclick="editaddon({$addon.id})">{$lang.Edit}</a></td>
				<td><a href="javascript:void(0);" class="delbtn" onclick="deleteaddon({$addon.id})">{$lang.Remove}</a></td>
			</tr>
			{/foreach}

	{/if}
		  </table>

		 <div class="lighterblue" id="AddAddon" style="padding:5px;display:none;">

	{if $addons}
	<form id="addonform">
	<table border="0" cellpadding="3" cellspacing="0" width="100%" border="0">
		<tr>
			<td>{$lang.addoncolon} <select name="addon" id="new_addon_id" onchange="cnbilling(this)">

		{foreach from=$addons  item=a}
                     <option value="{$a.id}">{$a.name}</option>	      {/foreach}					 
		</select>
		</td>
		<td id="addon_billing">
		{if $abilling}
			{if $abilling.paytype=='Free'} <input type="hidden" name="new_addon_cycle" value="free"  id="new_addon_cycle"/> {$lang.price}:<strong> {$lang.Free}</strong>
			{elseif $abilling.paytype=='Once'} 
			 {$lang.price}: {$abilling.m|price:$client.currency_id:true:true} {$lang.Once} {if $abilling.m_setup>0}/ {$abilling.m_setup|price:$client.currency_id:true:true} {$lang.setupfee}{/if}
			 <input type="hidden" name="new_addon_cycle" value="once"  id="new_addon_cycle"/>
			{else}
			{$lang.price}: <select name="new_addon_cycle" id="new_addon_cycle" >
	 {if $abilling.h!=0}<option value="h">{$abilling.h|price:$client.currency_id:true:true} {$lang.Hourly}{if $abilling.h_setup!=0} + {$abilling.h_setup|price:$client.currency_id:true:true} {$lang.setupfee}{/if}</option>{/if}
     {if $abilling.d!=0}<option value="d">{$abilling.d|price:$client.currency_id:true:true} {$lang.Daily}{if $abilling.d_setup!=0} + {$abilling.d_setup|price:$client.currency_id:true:true} {$lang.setupfee}{/if}</option>{/if}
     {if $abilling.w!=0}<option value="w">{$abilling.w|price:$client.currency_id:true:true} {$lang.Weekly}{if $abilling.w_setup!=0} + {$abilling.w_setup|price:$client.currency_id:true:true} {$lang.setupfee}{/if}</option>{/if}
     {if $abilling.m!=0}<option value="m">{$abilling.m|price:$client.currency_id:true:true} {$lang.Monthly}{if $abilling.m_setup!=0} + {$abilling.m_setup|price:$client.currency_id:true:true} {$lang.setupfee}{/if}</option>{/if}
     {if $abilling.q!=0}<option value="q">{$abilling.q|price:$client.currency_id:true:true} {$lang.Quarterly}{if $abilling.q_setup!=0} + {$abilling.q_setup|price:$client.currency_id:true:true} {$lang.setupfee}{/if}</option>{/if}
     {if $abilling.s!=0}<option value="s">{$abilling.s|price:$client.currency_id:true:true} {$lang.SemiAnnually}{if $abilling.s_setup!=0} + {$abilling.s_setup|price:$client.currency_id:true:true} {$lang.setupfee}{/if}</option>{/if}
     {if $abilling.a!=0}<option value="a">{$abilling.a|price:$client.currency_id:true:true} {$lang.Annually}{if $abilling.a_setup!=0} + {$abilling.a_setup|price:$client.currency_id:true:true} {$lang.setupfee}{/if}</option>{/if}
     {if $abilling.b!=0}<option value="b">{$abilling.b|price:$client.currency_id:true:true} {$lang.Biennially}{if $abilling.b_setup!=0} + {$abilling.b_setup|price:$client.currency_id:true:true} {$lang.setupfee}{/if}</option>{/if}
     {if $abilling.t!=0}<option value="t">{$abilling.t|price:$client.currency_id:true:true} {$lang.Triennially}{if $abilling.t_setup!=0} + {$abilling.t_setup|price:$client.currency_id:true:true} {$lang.setupfee}{/if}</option>{/if}
	</select>
			{/if}
			{if $abilling.paytype!='Free'}
			
			  <input type="checkbox" name="addon_invoice" id="new_addon_invoice" value="1" checked="checked"/> <strong>{$lang.CreateInvoice}</strong>
			 {else}
			 <input type="hidden" name="addon_invoice" id="new_addon_invoice" value="0" />
			{/if}
			
		{/if}
			
		 </td>
		<td>
		{$lang.Gateway}:<select name="new_addon_gateway" id="new_addon_gtw" >
                    {foreach from=$gateways item=module key=id}
                        <option value="{$id}" >{$module}</option>
                      {/foreach}
                      </select>
					  </td>
					  <td>
		<input type="button" value="{$lang.addaddon}" id="addonSubmit" style="font-weight:bold" onclick="addAddon();"/> <span class="orspace">{$lang.Or} <a href="#" onclick="$('#AddAddon').hide();$('#AddAddonT').show();return false;" class="editbtn">{$lang.Cancel}</a></span>
		</td>
			
		</tr>
		
	</table>	{securitytoken}</form>










	{else}
	{$lang.noaddons} <a href="?cmd=productaddons&action=addaddon">{$lang.createaddon}</a>
	{/if}
</div>


		

<table border="0" cellpadding="3" cellspacing="0" width="100%" class="glike" id="AddAddonT">
	<tr>
		<th align="left">
			<a href="#" onclick="$('#AddAddon').toggle();$('#AddAddonT').toggle();return false;" class="editbtn">{$lang.addaddon}</a>
		</th>
	</tr>
</table>
			


{elseif $action=='getowners'}
<center>
	{$lang.newowner} <select name="new_owner_id">
		{foreach from=$clients item=cl}
			<option value="{$cl.id}">#{$cl.id} {if $cl.companyname!=''}{$lang.Company}: {$cl.companyname}{else}{$cl.lastname} {$cl.firstname}{/if}</option>
		{/foreach}
	</select><br />

	<input type="submit" name="changeowner" value="{$lang.changeowner}"  style="font-weight:bold"/>

	<input type="button" value="{$lang.Cancel}" onclick="$('#ChangeOwner').hide();return false;"/>


</center>
{elseif $action=='cancelrequests'}
    {if $requests}
    <div style="font-size: 10px" class="cancellation_accview">
        <strong>{$lang.canceltitle}</strong>
        {foreach from=$requests item=req}
        <div class="highlight_cancrequest">
			<a href="?cmd=accounts&action=edit&id={$req.account_id}">
				#{$req.account_id} {$req.lastname} {$req.firstname}
				{*{if $req.domain && $req.domain != ''}{$req.domain}{else}<font style="font-size: 8px">( {$lang.emptyhost} )</font>{/if}*}
			</a>
			<br />
        {$req.reason}
        </div>
        {/foreach}
		<div style="text-align: right; padding: 0 4px 4px"><a href="?cmd=logs&action=cancelations">更多</a></div>
    </div>
    {/if}

{elseif $action=='getstatus'}
    <strong>{if $status}{$status}{else}未知{/if}</strong> <a href="" onclick="getStatus({$service_id}, this); return false;"><img src="{$template_dir}img/arrow_refresh_small.gif" alt="refresh" /></a>
{elseif $action == 'log'}
<table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike hover">
        <tbody>
          <tr>
            <th width="8%">{$lang.Date}</th>
            <th>{$lang.Login}</th>
            <th>{$lang.Module}</a></th>
            <th width="12%">{$lang.Action}</th>
            <th width="8%">{$lang.Result}</th>
            <th width="35%">{$lang.Change}</th>
            <th width="16%">{$lang.Error}</th>
          </tr>
        </tbody>
        <tbody >

         {if $logdata}
            {foreach from=$logdata  item=log}
                <tr {if $log.manual=='1'}class="man"{/if}>
                    <td>{$log.date}</td>
                    <td>{$log.admin_login}</td>
                    <td>{$log.module}</td>
                    <td>{$log.action}</td>
                    <td>{if $log.result == 1}<font style="color:#006633">{$lang.Success}</font>{else}<font style="color:#990000">{$lang.Failure}</font>{/if}</td>
                    <td>
                        {if $log.change}
                            {if $log.change.serialized}
                                <ul class="log_list">
                                    {foreach from=$log.change.data item=change}
                                        <li>
                                            {if $change.name}<span class="log_change">{$change.name} :</span>{/if}
                                            {$change.from}
                                            {if $change.to} -> {$change.to}{/if}
                                        </li>
                                    {/foreach}
                                </ul>
                            {else}{$log.change.data}{/if}
                        {/if}
                    </td>
                    <td>{$log.error}</td>
                </tr>
            {/foreach}
         {else}
         <tr><td colspan="7"><strong>{$lang.nothingtodisplay}</strong></td></tr>
        {/if}
        </tbody>

      </table>{if $totalpages}
			 <center class="blu"><strong>{$lang.Page} </strong>
			 {section name=foo loop=$totalpages}
			 {if $smarty.section.foo.iteration-1==$currentpage}<strong>{$smarty.section.foo.iteration}</strong>{else}
          <a href='?cmd=accounts&action=log&id={$acc_id}&page={$smarty.section.foo.iteration-1}' class="npaginer">{$smarty.section.foo.iteration}</a>
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



{elseif $action == 'getadvanced'}

    <a href="?cmd=accounts&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
        <form class="searchform filterform" action="?cmd=accounts" method="post" onsubmit="return filter(this)">
          <table width="100%" cellspacing="2" cellpadding="3" border="0">
            <tbody>
                {if !$custom_filters}

            <tr>
                <td >{$lang.clientlastname}</td>
                <td ><input type="text" value="{$currentfilter.lastname}" size="25" name="filter[lastname]"/></td>

                <td>{$lang.Domain}</td>
                <td ><input type="text" value="{$currentfilter.domain}" size="25" name="filter[domain]"/></td>

                <td>{$lang.Service}</td>
                <td ><select name="filter[product_id]">
				<option value=''>{$lang.Any}</option>
				{foreach from=$advanced.products item=o}
                                <option value="{$o.id}" {if $currentfilter.name==$o.name}selected="selected"{/if}>{$o.catname} - {$o.name}</option>
				{/foreach}
				</select></td>


            </tr>
            <tr>

                <td>Status</td>
                <td >
                    <select name="filter[status]">
                        <option value=''>{$lang.Any}</option>
                        <option value="Pending"  {if $currentfilter.status=='Pending'}selected="selected" {/if}>{$lang.Pending}</option>
                        <option value="Active"  {if $currentfilter.status=='Active'}selected="selected" {/if}>{$lang.Active}</option>
                        <option value="Suspended"  {if $currentfilter.status=='Suspended'}selected="selected" {/if}>{$lang.Suspended}</option>
                        <option value="Terminated"  {if $currentfilter.status=='Terminated'}selected="selected" {/if}>{$lang.Terminated}</option>
                        <option value="Cancelled"  {if $currentfilter.status=='Cancelled'}selected="selected" {/if}>{$lang.Cancelled}</option>
                        <option value="Fraud"  {if $currentfilter.status=='Fraud'}selected="selected" {/if}>{$lang.Fraud}</option>
                    </select>
                </td>

                <td>{$lang.nextdue}</td>
                <td ><input type="text" value="{if $currentfilter.next_due}{$currentfilter.next_due|dateformat:$date_format}{/if}" size="15" name="filter[next_due]" class="haspicker"/></td>

                <td>{$lang.billingcycle}</td>
                <td >
                    <select name="filter[billingcycle]">
                        <option value=''>{$lang.Any}</option>
                        <option {if $currentfilter.billingcycle=='Free'}selected="selected" {/if} value="Free">{$lang.Free}</option>
                        <option {if $currentfilter.billingcycle=='One Time'}selected="selected" {/if} value="One Time">{$lang.OneTime}</option>
						<option {if $currentfilter.billingcycle=='Hourly'}selected="selected" {/if} value="Hourly">{$lang.Hourly}</option>
						<option {if $currentfilter.billingcycle=='Daily'}selected="selected" {/if} value="Daily">{$lang.Daily}</option>
						<option {if $currentfilter.billingcycle=='Weekly'}selected="selected" {/if} value="Weekly">{$lang.Weekly}</option>
						
                        <option {if $currentfilter.billingcycle=='Monthly'}selected="selected" {/if} value="Monthly">{$lang.Monthly}</option>
                        <option {if $currentfilter.billingcycle=='Quarterly'}selected="selected" {/if} value="Quarterly">{$lang.Quarterly}</option>
                        <option {if $currentfilter.billingcycle=='Semi-Annually'}selected="selected" {/if} value="Semi-Annually">{$lang.SemiAnnually}</option>
                        <option {if $currentfilter.billingcycle=='Annually'}selected="selected" {/if} value="Annually">{$lang.Annually}</option>
                        <option {if $currentfilter.billingcycle=='Biennially'}selected="selected" {/if} value="Bienially">{$lang.Biennially}</option>
						<option {if $currentfilter.billingcycle=='Triennially'}selected="selected" {/if}  value="Triennially">{$lang.Triennially}</option>
                    </select>
                </td>

            </tr>
			{else}
				{include file=$custom_filters}
			{/if}
			<tr><td>{$lang.Server}</td><td colspan="5"><select name="filter[server_id]">
				<option value=''>{$lang.Any}</option>
				{foreach from=$advanced.servers item=o}

					<option {if $currentfilter.server_id==$o.id}selected="selected"{/if} value='{$o.id}'>{$o.groupname} - {$o.name}</option>
				{/foreach}
				</select></td></tr>
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


{elseif $action=='clientaccounts'}
<div class="blu" style="text-align:right;padding-bottom:0">
	<form action="?cmd=orders&action=add" method="post" class="right">
	<input type="hidden" name="related_client_id" value="{$client_id}" />
	<input type="submit"  value="{$lang.newaccount}" onclick="window.location='?cmd=orders&action=add&related_client_id={$client_id}';return false;"/>{securitytoken}
	</form>
	<a class="sub_nav {if !$currentlist}sub_nav_sel {/if}left" href="?cmd={$cmd}&action=clientaccounts&id={$client_id}" onclick="$(this).parent().next('table').children('tbody').addLoader();ajax_update(this.href,'',$(this).parents('.slide'));return false;">{$lang.All} ({$all})</a>
{foreach from=$category item=product }
	{assign var=ptype value="`$product.name`_hosting"}
	<a class="sub_nav {if $currentlist == $product.name }sub_nav_sel {/if}left" href="?cmd={$cmd}&action=clientaccounts&id={$client_id}&list={$product.name}" onclick="$(this).parent().next('table').children('tbody').addLoader();ajax_update(this.href,'',$(this).parents('.slide'));return false;">{if $lang.$ptype}{$lang.$ptype}{else}{$product.name}{/if} ({$product.count})</a>
{/foreach}
<div class="clear"></div>
</div>
{if $accounts}
 <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
	 <thead>
		<tr>
			<th>{$lang.accounthash}</th>
			<th>{$lang.Domain}</th>
			<th>{$lang.Service}</th>
			<th>{$lang.Price}</th>
			<th>{$lang.billingcycle}</th>
			<th>{$lang.Status}</th>
			<th>{$lang.nextdue}</th>
			<th width="20"/>
		  </tr>
	 </thead>

	 <tbody >
	 {foreach from=$accounts item=account} 
		 <tr>

			  <td><a href="?cmd=accounts&action=edit&id={$account.id}">{$account.id}</a></td>

			  <td>{$account.domain}</td>
			  <td>{$account.name}</td>
			  <td>{$account.total|price:$account.currency_id}</td>
			  <td>{$lang[$account.billingcycle]}</td>
			  <td><span class="{$account.status}">{$lang[$account.status]}</span></td>
			  <td>{$account.next_due|dateformat:$date_format}</td>
			  <td><a href="?cmd=accounts&action=edit&id={$account.id}"  class="editbtn">{$lang.Edit}</a></td>

			</tr>
		{/foreach}
	</tbody>

</table>
	{if $totalpages}
<center  class="blu"><strong>{$lang.Page}</strong>
{section name=foo loop=$totalpages}
{if $smarty.section.foo.iteration-1==$currentpage}<strong>{$smarty.section.foo.iteration}</strong>{else}
	  <a href='?cmd=accounts&action=clientaccounts&id={$client_id}&page={$smarty.section.foo.iteration-1}' class="npaginer">{$smarty.section.foo.iteration}</a>
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

{elseif $action=='getservers'}
<select name="server_id" id="server_id" {if $manumode}class="manumode"{/if} {if $manumode && !$show}style="display:none"{/if}>

			{foreach from=$servers item=server name=foo}

                          <option value="{$server.id}" {if $s_id==$server.id || (!$s_id && $smarty.foreach.foo.first)}selected="selected" def="def"{/if}>{$server.name} ({$server.accounts}/{$server.max_accounts} Accounts)</option>


			{/foreach}


  </select>

{elseif $action=='customfn' && $customfn=='AttachToServer'}
<select name="AttachToServer[serverid]">
							{foreach from=$AttachToServer item=plan}
							
								<option value="{$plan.id}">{$plan.hostname}</option>
							

							{/foreach}
						</select>
<input type="hidden" name="customfn" value="AttachToServer" />
						<input type="submit"  value="Attach to this server"/>

	{elseif $action=='customfn' && $customfn=='GetOsTemplates'}
	<select name="os">
							{foreach from=$GetOsTemplates item=plan}
							{if $plan|is_array}
							   <option {if $plan[0]}selected="selected" {/if} value="{$plan[0]}">{$plan[1]}</option>
							   {else}
								<option {if $plan}selected="selected" {/if}>{$plan}</option>
								{/if}

							{/foreach}
						</select>

	{elseif $action=='customfn' && $customfn=='GetNodes'}
	<select name="node">
							{foreach from=$GetNodes item=plan}
							{if $plan|is_array}
							   <option {if $plan[0]}selected="selected" {/if} value="{$plan[0]}">{$plan[1]}</option>
							   {else}
								<option {if $plan}selected="selected" {/if}>{$plan}</option>
								{/if}

							{/foreach}
						</select>

{elseif $action=='customfn' && $customfn=='RebuildOS'}

	<table cellspacing="0" cellpadding="10" border="0" width="100%">
	<tbody><tr>
                        <td width="30%" valign="top">
						{if $RebuildOS && $RebuildOS|is_array}{$lang.choosenewos}{else}{$lang.enternewos}{/if}
						</td>

						<td  valign="top">
						{if $RebuildOS && $RebuildOS|is_array}
						<select name="RebuildOS[os]">
							{foreach from=$RebuildOS item=plan}
								{if !($plan|is_array)}
							  <option>{$plan}</option>
							   {elseif !$plan.ignore}
								 <option value="{$plan[0]}">{$plan[1]}</option>
								{/if}
							{/foreach}
						</select>
						{else}<input type="text" name="RebuildOS[os]"/>{/if}
						</td>
						<td width="30%" valign="top">
						<input type="hidden" name="customfn" value="RebuildOS" />
						<input type="submit"  value="{$lang.rebuildos}"/>
						</td>
						</tr>
						</tbody></table>
{elseif $action=='customfn' && $customfn=='Backups'}
        <input type="hidden" name="customfn" value="restoreBackup" id="bkp_fn" />
        <div style="padding:10px 10px 15px 10px">
            <button onclick="{literal}if($('#createBackup').hasClass('shown')) {$('#createBackup').hide(); $('#createBackup').removeClass('shown'); } else {$('#createBackup').show(); $('#createBackup').addClass('shown');} return false;{/literal}" style="font-weight: bold">{$lang.createBackup}</button>
            <span id="createBackup" style="display:none; margin-left:20px;">
                {$lang.backupName}: <input name="createBackup[backup_name]" id="backupName" />
                <button type="submit" onclick="if(!create_backup(this)) return false;" >{$lang.Create}</button>
                <button onclick="{literal}$('#createBackup').hide(); $('#createBackup').removeClass('shown'); return false;{/literal}" >{$lang.Cancel}</button>
            </span>
        </div>
        <table width="60%" cellspacing="0" cellpadding="3" border="0" class="glike hover">
            <tr>
                  <th>{$lang.Type}</th>
                  <th>{$lang.State}</th>
                  <th>{$lang.Date}</th>
                  <th>{$lang.Size}</th>
                  <th></th>
                  <th></th>
            </tr>
            {if $Backups && $Backups|is_array}
                {foreach from=$Backups item=bkp}
                    <tr>
                        <td><strong>{if $bkp.type != 'autobackup'}Manual{else}{$bkp.type|ucfirst}{/if}</strong></td>
                        <td><strong>{if $bkp.available}{$lang.Available}{else}{$lang.Pending}{/if}</strong></td>
                        <td>{$bkp.date}</td>
                        <td>{if $bkp.size}{$bkp.size}{else}Not build yet{/if}</td>
                        <td>{if $bkp.available}<button type="submit" value="{$backup.id}" style="font-weight: bold" onclick="if(!restore_backup(this)) return false;" >{$lang.Restore}</button>{else}{$lang.Notavailable}{/if}</td>
                        <td>{if $bkp.type != 'autobackup'}<a href="" onclick="delete_backup(this,{$bkp.id}); return false;" class="delbtn">{$lang.Delete}</a>{/if}</td>
                    </tr>
                {/foreach}
            {else}
            <tr><td colspan="6">{$lang.noBackupsToDisp}</td></tr>
            {/if}
        </table>
         <script type="text/javascript">
        {literal}
            function restore_backup(elem) {
                if(confirm('{/literal}{$lang.confirmRestoreBkp}{literal}')) {
                    $(elem).parent().append('<input type="hidden" value="'+$(elem).val()+'" name="restoreBackup[backup_id]" />');
                    return true;
                }
            }
            function create_backup() {
                if(confirm('{/literal}{$lang.confirmCreateBkp}{literal}')) {
                    $('#bkp_fn').val('createBackup');
                    return true;
                }
            }
            function delete_backup(elem,id) {
                if(confirm('{/literal}{$lang.confirmDeleteBkp}{literal}')) {
                    $('#bkp_fn').val('deleteBackup');
                    $(elem).parent().append('<input type="hidden" value="'+id+'" name="deleteBackup[backup_id]" />');
                    $("input[name='submit']").remove();
                    $('#account_form').attr('action', '?cmd=accounts&action=edit&id={/literal}{$service_id}{literal}&list=all&submit=1').submit();
                    return true;
                }
            }
        {/literal}
        </script>
{elseif $action=='customfn' && $customfn=='ConfigureBackup'}

	<table cellspacing="0" cellpadding="10" border="0" width="100%">
	<tbody><tr>
            <td width="30%" valign="top">
                {$lang.Enablebackups}:
            </td>

        <td  valign="top">
        <input type="checkbox" value="1" name="ConfigureBackup[enablebackup]" {if $ConfigureBackup}checked="checked"{/if}/>


        </td>
        <td width="30%" valign="top">
        <input type="hidden" name="customfn" value="ConfigureBackup" />
        <input type="submit"  value="{$lang.submit}"/>
        </td>
        </tr>
        </tbody></table>

{elseif $action=='addonmodule' && $customfile}
{include file=$customfile}
{elseif $action=='customfn' && $customfn=='ChangePlan'}

	<table cellspacing="0" cellpadding="10" border="0" width="100%">
	<tbody><tr>
                        <td width="30%" valign="top">
						{$lang.chooseplan}
						</td>

						<td  valign="top">
						<select name="ChangePlan[plan]">
							{foreach from=$ChangePlan item=plan}
								<option >{$plan}</option>
							{/foreach}
						</select>

						</td>
						<td width="30%" valign="top">
						<input type="hidden" name="customfn" value="ChangePlan" />
						<input type="submit"  value="{$lang.changeplan}"/>
						</td>
						</tr>
						</tbody></table>



{elseif $action=='default'}
    {if $accounts}
    {foreach from=$accounts item=account}
     <tr>
          <td><input type="checkbox" class="check" value="{$account.id}" name="selected[]"/></td>
          <td><a href="?cmd=accounts&action=edit&id={$account.id}&list={$currentlist}">{$account.id}</a></td>
          <td><a href="?cmd=clients&action=show&id={$account.client_id}">{$account.lastname} {$account.firstname}</a></td>
          <td>{$account.domain}</td>
          <td>{$account.name}</td>
          <td>{$account.total|price:$account.currency_id}</td>
          <td>{$lang[$account.billingcycle]}</td>
          <td><span class="{$account.status}">{$lang[$account.status]}</span></td>
                <td>{if $account.next_due == '0000-00-00'}-{else}{$account.next_due|dateformat:$date_format}{/if}</td>
          <td><a href="?cmd=accounts&action=edit&id={$account.id}&list={$currentlist}" class="editbtn">{$lang.Edit}</a></td>

        </tr>
    {/foreach}
    {else}
            <tr><td colspan="10"><p align="center" >{$lang.Click} <a href="?cmd=orders&action=add">{$lang.here}</a> {$lang.tocreateacc}</p></td></tr>
      {/if}

      {if $addons}

      <table border="0" cellspacing="0" cellpadding="0" width="100%" bgcolor="#cccccc">
    <script type="text/javascript">
      {literal}
            function addAddon(id) {
            ajax_update('?cmd=accounts&action=addon_add&account_id={/literal}{$account_id}{literal}&addon_id='+id+'&gateway='+$('#addon_gateway_'+id).val(),{},'#addonmanagertable',false,true);
            }
      {/literal}

      </script>
      {foreach from=$addons  item=a}
                     <tr>

            <td>{$a.name}</td>
            <td>{if $a.billingcycle=='Free'}( {$lang.Free} )  {else}({$a.recurring_amount|price:$currency} {$lang[$a.billingcycle]} + {$a.setup_fee|price:$currency} {$lang.setupfee}){/if}</td>
                    <td>{$lang.Gateway}:
                    <select name="addon_gateway_{$a.id}" id="addon_gateway_{$a.id}" >
                    {foreach from=$gateways item=module key=id}
                        <option value="{$id}" {if $details.payment_module==$id}selected="selected"{/if}>{$module}</option>
                      {/foreach}
                      </select>
                      </td>
                      <td><a href="javascript:void(0)" onclick="addAddon({$a.id})">{$lang.Add}</a></td>
                    </tr>
      {/foreach}
      </table>
      {/if}



{/if}

 {if $addonedit }
{if $newaddon}<tr id="addonedit_{$addonedit.id}">{/if}
      <td colspan="6" width="100%" style="padding:15px;background:#F5F9FF">
      <form action="" name="" id="innerform_{$addonedit.id}" method="post">
	<input type="hidden" value="{$addonedit.id}" name="addon_id" />
	<input type="hidden" value="true" name="submit" />
        <table border="0" cellpadding="2" cellspacing="0" width="100%" class="nostyle">
		<tr>
			<td><strong>{$lang.addonname}</strong></td> <td><input name="addon_name" value="{$addonedit.name}"/></td>
			<td><strong>{$lang.Status}</strong></td> <td><select name="addon_status">
                                            <option {if $addonedit.status=='Pending'}selected="selected"{/if} value="Pending">{$lang.Pending}</option>
                                            <option {if $addonedit.status=='Active'}selected="selected"{/if} value="Active">{$lang.Active}</option>
                                            <option {if $addonedit.status=='Suspended'}selected="selected"{/if} value="Suspended">{$lang.Suspended}</option>
                                            <option {if $addonedit.status=='Cancelled'}selected="selected"{/if} value="Cancelled">{$lang.Cancelled}</option>
											<option {if $addonedit.status=='Terminated'}selected="selected"{/if} value="Terminated">{$lang.Terminated}</option>
                                    </select></td>
			<td>{$lang.paymethod}</td>			 <td><select name="addon_payment_module">
                      {foreach from=$gateways item=module key=pid}
                        <option value="{$pid}" {if $addonedit.payment_module==$pid}selected="selected"{/if}>{$module}</option>
                      {/foreach}

                </select></td>						
			
		</tr>
		<tr>
			<td>
			<strong>	{$lang.setupfee}</strong>
			</td>
			<td><input name="addon_setup_fee" value="{$addonedit.setup_fee}" size="5"/></td>
			 <td><strong>{$lang.recurring}</strong></td> <td><input name="addon_recurring_amount" value="{$addonedit.recurring_amount}"  size="5"/></td>
			 <td><strong>{$lang.billingcycle}</strong></td><td><select name="addon_billingcycle">
                  <option value="Free" {if $addonedit.billingcycle=='Free'}selected='selected'{/if}>{$lang.Free}</option>
                  <option value="One Time" {if $addonedit.billingcycle=='One Time'}selected='selected'{/if}>{$lang.OneTime}</option>
				  <option  value="Hourly" {if $addonedit.billingcycle=='Hourly'}selected='selected'{/if}>{$lang.Hourly}</option>
				  <option  value="Daily" {if $addonedit.billingcycle=='Daily'}selected='selected'{/if}>{$lang.Daily}</option>
				  <option  value="Weekly" {if $addonedit.billingcycle=='Weekly'}selected='selected'{/if}>{$lang.Weekly}</option>
                  <option  value="Monthly" {if $addonedit.billingcycle=='Monthly'}selected='selected'{/if}>{$lang.Monthly}</option>
                  <option value="Quarterly" {if $addonedit.billingcycle=='Quarterly'}selected='selected'{/if}>{$lang.Quarterly}</option>
                  <option value="Semi-Annually" {if $addonedit.billingcycle=='Semi-Annually'}selected='selected'{/if}>{$lang.SemiAnnually}</option>
                  <option value="Annually" {if $addonedit.billingcycle=='Annually'}selected='selected'{/if}>{$lang.Annually}</option>
                  <option value="Biennially" {if $addonedit.billingcycle=='Biennially'}selected='selected'{/if}>{$lang.Biennially}</option>
                <option value="Triennially" {if $addonedit.billingcycle=='Triennially'}selected='selected'{/if}>{$lang.Triennially}</option>
                </select></td>			
			
		</tr>
		
		<tr>
		 <td><strong>{$lang.nextdue}</strong></td> <td><input name="addon_next_due" value="{$addonedit.next_due|dateformat:$date_format}" class="haspicker" size="14"/></td>
                                    <td><strong>{$lang.regdate2}</strong></td>
									
                                    <td><input name="addon_regdate" value="{$addonedit.regdate|dateformat:$date_format}"  class="haspicker" size="14"/></td>
									<td></td><td></td>
		</tr>
		
		
		
		                           
                            <tr><td colspan="6" style="text-align:right">
							{if $addonedit.methods} {foreach from=$addonedit.methods item=met}<input type="submit" value="{$met}" name="addonmethod" onclick="return submitAddon({$addon.id});"/>{/foreach}{/if}
							{if $addonedit.templated}{foreach from=$addonedit.templated item=met}<input type="submit" value="{$met}" name="addontemplated" onclick="return loadTemplate({$addonedit.id},'{$met}');"/>{/foreach}{/if}
                                    <input type="button" onclick="saveChanges({$addonedit.id})" style="font-weight:bold" value="{$lang.savechanges}"/>
									 <span class="orspace">{$lang.Or} <a href="#" class="editbtn"  onclick="cancelChanges({$addonedit.id});return false;" >{$lang.Cancel}</a></span>

                            </td></tr>

                      </table>
                      {securitytoken}</form></td><script type="text/javascript">{literal} $('.haspicker').datePicker({
        startDate:startDate
    });{/literal}</script>
{if $newaddon}</tr>{/if}
      {/if}

   {if $addonrow}	{if $newaddon}<tr id="addonedit_{$addonrow.id}">{/if}
      <td>{$addonrow.name}</td>
                                    <td>{if $addonrow.billingcycle=='Free'} {$lang.Free}  {else}{$addonrow.recurring_amount|price:$currency} {$lang[$addonrow.billingcycle]} {if $addonrow.setup_fee>0}+ {$addonrow.setup_fee|price:$currency} {$lang.setupfee}{/if}{/if}</td>
                                    <td><span class="{$addonrow.status}">{$lang[$addonrow.status]}</span></td>
									<td>{if $addonrow.methods} {foreach from=$addonrow.methods item=met}<input type="submit" value="{$met}" name="addonmethod" onclick="return submitAddon({$addonrow.id});"/>{/foreach}{/if}
									{if $addonrow.templated}{foreach from=$addonrow.templated item=met}<input type="submit" value="{$met}" name="addontemplated" onclick="return loadTemplate({$addonrow.id},'{$met}');"/>{/foreach}{/if}</td>
                                    <td><a href="javascript:void(0);" onclick="editaddon({$addonrow.id})" class="editbtn">{$lang.Edit}</a></td>
                                    <td><a href="javascript:void(0);" onclick="deleteaddon({$addonrow.id})" class="delbtn">{$lang.Remove}</a></td>

									{if $newaddon}</tr>{/if}
      {/if}

