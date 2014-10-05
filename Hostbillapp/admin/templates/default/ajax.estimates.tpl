{if $action=='default'}

{if $showall}
<form action="" method="post" id="testform" >
<input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
  <div class="blu">
  	<div class="left menubar">
    <a onclick="return false;" class="menuitm" href=""  id="new_estimate_button"  style="margin-right: 30px;font-weight:bold;"><span class="addsth">{$lang.createestimate}</span></a>
    
		 {$lang.withselected}
          <a class="submiter menuitm menuf" name="send"  href="#" ><span style="font-weight:bold">{$lang.Send}</span></a>{*
          *}<a class="submiter menuitm menuc" name="markaccepted" href="#" ><span >{$lang.Accept}</span></a>{*
          *}<a class="submiter menuitm menu{if !$forbidAccess.deleteEstimates}c{else}l{/if}" name="createinvoice" href="#" ><span >{$lang.converttoinvoice}</span></a>{*
          *}{if !$forbidAccess.deleteEstimates}{*
              *}<a class="submiter menuitm confirm menul" name="delete" href="#" ><span style="color:#FF0000">{$lang.Delete}</span></a>
          {/if}
	
	</div>
	<div class="right"><div class="pagination"></div>
	</div>
	<div class="clear"></div>
        <div id="new_estimate" style="padding: 10px; display: none"></div>

  </div>

  <a href="?cmd=estimates&list={$currentlist}" id="currentlist" style="display:none" updater="#updater"></a>
  <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
    <tbody>
      <tr>
        <th width="20"><input type="checkbox" id="checkall"/></th>
        <th><a href="?cmd=estimates&list={$currentlist}&orderby=id|ASC" class="sortorder">{$lang.Estimate}</a></th>
        <th><a href="?cmd=estimates&list={$currentlist}&orderby=lastname|ASC"  class="sortorder">{$lang.clientname}</a></th>
        <th><a href="?cmd=estimates&list={$currentlist}&orderby=subject|ASC"  class="sortorder">{$lang.description}</a></th>
        <th><a href="?cmd=estimates&list={$currentlist}&orderby=date_created|ASC"  class="sortorder">{$lang.Date}</a></th>
        <th><a href="?cmd=estimates&list={$currentlist}&orderby=total|ASC"  class="sortorder">{$lang.Total}</a></th>
        <th><a href="?cmd=estimates&list={$currentlist}&orderby=status|ASC"  class="sortorder">{$lang.Status}</a></th>
        <th width="20">&nbsp;</th>
        <th width="20">&nbsp;</th>
      </tr>
    </tbody>
    <tbody id="updater">
    
    {/if}
	{if $estimates}
    {foreach from=$estimates item=estimate}
    <tr>
      <td><input type="checkbox" class="check" value="{$estimate.id}" name="selected[]"/></td>
      <td><a href="?cmd=estimates&action=edit&id={$estimate.id}"   >{$estimate.id}</a></td>
      <td><a href="?cmd=clients&action=show&id={$estimate.client_id}">{$estimate.firstname} {$estimate.lastname}</a></td>
	  <td><a href="?cmd=estimates&action=edit&id={$estimate.id}" >{$estimate.subject}</a></td>
      <td>{$estimate.date_created|dateformat:$date_format}</td>
      <td>{$estimate.total|price:$estimate.currency_id}</td>
      <td><span class="{$estimate.status}">{$lang[$estimate.status]}</span></td>
      <td><a href="?cmd=estimates&action=edit&id={$estimate.id}" class="editbtn">{$lang.Edit}</a></td>
      <td><a href="?cmd=estimates&action=menubutton&make=deleteestimate&id={$estimate.id}" class="deleteEstimate delbtn">delete</a></td>
    </tr>
    {/foreach}
	{else} 

<tr>
  <td colspan="9"><p align="center" > {$lang.nothingtodisplay} </p></td>
</tr>
{/if}
    {if $showall}
    </tbody>
    <tbody id="psummary">
            <tr>
                <th></th>
                <th colspan="8">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                </th>
            </tr>
        </tbody>
  </table>
  <div class="blu"> 
  <div class="left menubar">
        {$lang.withselected}
        <a class="submiter menuitm menuf" name="send"  href="#" ><span style="font-weight:bold">{$lang.Send}</span></a>{*
        *}<a class="submiter menuitm menuc" name="markaccepted" href="#" ><span >{$lang.Accept}</span></a>{*
        *}<a class="submiter menuitm menu{if !$forbidAccess.deleteEstimates}c{else}l{/if}" name="createinvoice" href="#" ><span >{$lang.converttoinvoice}</span></a>{*
        *}{if !$forbidAccess.deleteEstimates}{*
            *}<a class="submiter menuitm confirm menul" name="delete" href="#" ><span style="color:#FF0000">{$lang.Delete}</span></a>
        {/if}
    </div>
	<div class="right"><div class="pagination"></div>
	</div>
	<div class="clear"></div>
  </div>
{securitytoken}</form>
{if $ajax}
<script type="text/javascript">bindEvents();</script>
{/if}
{/if}
{if $ajax}

{/if}

{elseif $action=='getclients'}
<center>
{if $clients}
	{$lang.Client}: <select class="newinvoice_clientid" load="clients" style="width: 180px">
		{*foreach from=$clients item=cl}
			<option value="{$cl.id}">#{$cl.id} {if $cl.companyname!=''}{$lang.Company}: {$cl.companyname}{else}{$cl.firstname} {$cl.lastname}{/if}</option>
		{/foreach*}
	</select> 

	<input type="submit" name="createestimate" value="{$lang.createestimate}"  style="font-weight:bold" onclick="create_estimate(); return false;"/>

	<input type="button" value="{$lang.Cancel}" onclick="$('#new_estimate').hide();return false;"/>
{else}
    {$lang.thereisnoclients}. {$lang.Click} <a href="?cmd=newclient">{$lang.here}</a> {$lang.toregisternew}.
{/if}
</center>
<script type="text/javascript">
    {literal}
    Chosen.find();
    function create_estimate() {
        var id=$(".newinvoice_clientid option:selected").val();
        if(id) {
            window.location.href='?cmd=estimates&security_token={$security_token}&action=createestimate&client_id='+id;
        }
    }
    {/literal}
</script>
{elseif $action=='clientestimates'}
<div class="blu" style="text-align:right">
<form action="?cmd=estimates&action=createestimate" method="post">
<input type="hidden" name="client_id" value="{$client_id}" />
<input type="submit" value="{$lang.newestimate}" onclick="window.location='?cmd=estimates&action=createestimate&client_id={$client_id}';return false;"/>{securitytoken}</form></div>

{if $estimates}


  <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
    <tbody>
      <tr>
     
        <th>{$lang.Estimate}</th>
        <th>{$lang.description}</th>
        <th>{$lang.Date}</th>
        <th>{$lang.Total}</th>
        <th>{$lang.Status}</th>
        <th width="20">&nbsp;</th>
    
      </tr>
    </tbody>
    <tbody >
    

	
    {foreach from=$estimates item=estimate}
    <tr>
    
      <td><a href="?cmd=estimates&action=edit&id={$estimate.id}" >{$estimate.id}</a></td>
      <td><a href="?cmd=estimates&action=edit&id={$estimate.id}" >{$estimate.subject}</a></td>
      <td>{$estimate.date_created|dateformat:$date_format}</td>
      <td>{$estimate.total|price:$estimate.currency_id}</td>
      <td><span class="{$estimate.status}">{$lang[$estimate.status]}</span></td>
      <td><a href="?cmd=estimates&action=edit&id={$estimate.id}"  class="editbtn" rel="{$estimate.id}">{$lang.Edit}</a></td>
     
    </tr>
    {/foreach}

    </tbody>
    
  </table> {if $totalpages}
			 <center class="blu"><strong>{$lang.Page} </strong>
			 {section name=foo loop=$totalpages}
			 {if $smarty.section.foo.iteration-1==$currentpage}<strong>{$smarty.section.foo.iteration}</strong>{else}
          <a href='?cmd=estimates&action=clientestimates&id={$client_id}&page={$smarty.section.foo.iteration-1}' class="npaginer">{$smarty.section.foo.iteration}</a>
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
<div class="blu"> <div class="menubar"><a href="?cmd=estimates"  id="backto"><strong>&laquo; {$lang.backto} {$lang.Estimates}</strong></a>

    <a class="setStatus menuitm menuf" id="hd1"  ><span class="morbtn">{$lang.Setstatus}</span></a>{*
    *}<a class="invoiced_ menuitm menu{if !$forbidAccess.deleteEstimates}c{else}l{/if} {if $estimate.status=='Invoiced'}disabled{/if}" href="?cmd=estimates&action=createinvoice&id={$estimate.id}&security_token={$security_token}" {if $estimate.status=='Invoiced'}onclick="return false"{/if}><span>{$lang.converttoinvoice}</span></a>{*
    *}{if !$forbidAccess.deleteEstimates}{*
        *}<a class="deleteEstimate menuitm menul"    ><span style="color:#FF0000">{$lang.Delete}</span></a>
    {/if}
           
    <a class="{if $estimate.status!='Invoiced'}sendEstimate{/if} invoiced_ menuitm menuf  {if $estimate.status=='Invoiced'}disabled{/if}" name="send" {if $estimate.status=='Invoiced'}onclick="return false"{/if} ><span style="font-weight:bold">{$lang.Send}</span></a>{*
    *}<a class="menuitm setStatus menul" id="hd2" onclick="return false;"   href="#" ><span class="morbtn">{$lang.moreactions}</span></a>
  


<ul id="hd1_m" class="ddmenu">
  <li class="act_draft {if $estimate.status=='Draft'}disabled{/if}"><a href="Draft">{$lang.Draft}</a></li>
    <li class="act_sent {if $estimate.status=='Sent'}disabled{/if}"><a href="Sent">{$lang.Sent}</a></li>
	    <li class="act_accepted {if $estimate.status=='Accepted'}disabled{/if}"><a href="Accepted">{$lang.Accepted}</a></li>
	    <li class="act_invoiced {if $estimate.status=='Invoiced'}disabled{/if}"><a href="Invoiced">{$lang.Invoiced}</a></li>
	    <li class="act_dead {if $estimate.status=='Dead'}disabled{/if}"><a href="Dead">{$lang.Dead}</a></li>  

</ul>
<ul id="hd2_m" class="ddmenu">
<li><a href="?action=download&estimate={$estimate.id}" class="directly">{$lang.downloadpdf}</a></li>
{if count($currencies)>1}
<li><a href="ChangeCurrency">{$lang.ChangeCurrency}</a></li>{/if}

  <li><a href="EditDetails">{$lang.editdetails}</a></li>
  <li><a href="AddNote">{$lang.estimatenotes}</a></li>
  <li><a href="AddPrivateNote">{$lang.estimateprivatenotes}</a></li>
 
</ul>
</div>
</div>
{if count($currencies)>1}<div id="chcurr" style="display:none;padding:5px;" class="lighterblue">
<form action="?cmd=estimates&action=edit&id={$estimate.id}" method="post" >
<input type="hidden" name="make" value="currchange" />
<center><table cellpadding="0" cellspacing="2" width="50%">
	<tr>
		<td width="150">
		{$lang.newcurrency}	
		</td>
		<td align="left">
		<select name="new_currency_id" id="new_currency_id">{foreach from=$currencies item=curr}
	{if $curr.id!=$estimate.currency_id}
		<option value="{$curr.id}">{if $curr.code}{$curr.code}{else}{$curr.iso}{/if}</option>
	{/if}	

	{/foreach}</select>
		</td>
	</tr>
	<tr>
		<td>{$lang.calcexchange}</td>
		<td align="left"><input type="checkbox" name="exchange" value="1" id="calcex"/></td>
	</tr>
	
	<tr id="exrates" style="display:none">
		<td>{$lang.excurrency}: </td>
		<td align="left">{foreach from=$currencies item=curr}
			{if $curr.id!=$estimate.currency_id}
				<input value="{$curr.rate}" name="cur_rate[{$curr.id}]" style="display:none" size="3"/>
			{/if}	
	{/foreach}</td>
	</tr>
	<tr>
	<td colspan="2" align="center"><input type="submit" value="{$lang.Apply}" style="font-weight:bold"/> <input type="reset" value="{$lang.Cancel}" onclick="$('#chcurr').hide();return false;"/></td>
	</tr>
	
</table>

</center>
{securitytoken}</form>
</div>{/if}

<div id="ticketbody">
<h1><span style="padding:0px;">{$lang.estimatehash}{$estimate.id}</span><span class="{$estimate.status}" id="estimate_status">{$lang[$estimate.status]}</span>

<span class="clear"></span>
</h1>
<input type="hidden" id="estimate_id" name="invoice_id" value="{$estimate.id}" />
<input type="hidden" id="currency_id" name="inv_currency_id" value="{$estimate.currency_id}" />
<input type="hidden" id="client_id" name="client_id" value="{$estimate.client_id}" />

<div id="client_nav">
    <!--navigation-->
    <a class="nav_el nav_sel left" href="#">{$lang.estimatedetails}</a>
    {include file="_common/quicklists.tpl"}
    <div class="clear"></div>
</div>
		
<div class="ticketmsg ticketmain" id="client_tab">
 <div class="slide" style="display:block">
    <div class="left" ><strong class="clientmsg" id="curr_det">{$lang.Client}: <a href="?cmd=clients&action=show&id={$estimate.client_id}">{$estimate.client.lastname} {$estimate.client.firstname}</a> <a href="#" class="editbtn" id="changeowner">{$lang.Change}</a>&nbsp;&nbsp;&nbsp;</strong> <span id="client_container"></span></div>
    <div class="right replybtn tdetail"><strong><a href="#"><span class="a1">{$lang.editdetails}</span><span class="a2">{$lang.hidedetails}</span></a></strong></div>
	
	{if $estimate.status == 'Paid'}<div class="right">{$lang.Paid}: {$estimate.datepaid|dateformat:$date_format}&nbsp;&nbsp;&nbsp;</div>{/if}
	 
    <div class="clear"></div>
	<div id="detcont">
    <div class="tdetails">
      <table border="0" width="600" cellspacing="5" cellpadding="0">
        <tr>
          <td width="100" align="right" class="light">{$lang.Date}:</td>
          <td width="200" align="left"><span class="livemode">{$estimate.date_created|dateformat:$date_format}</span></td>
		 <td width="100" align="right" class="light">{$lang.taxlevel1}:</td>
          <td width="200" align="left"><span class="livemode">{$estimate.taxrate} %</span></td>
		  
        </tr>
        <tr>
          <td width="100" align="right"  class="light">{$lang.validuntil}:</td>
          <td width="200" align="left"><span class="livemode">{$estimate.date_expires|dateformat:$date_format}</span></td>
		  <td width="100" align="right" class="light">{$lang.taxlevel2}:</td>
          <td width="200" align="left"><span class="livemode">{$estimate.taxrate2} %</span></td>
		  
		  
        </tr>
        <tr>
          <td width="100" align="right"  class="light">{$lang.Amount}:</td>
          <td width="200" align="left"><strong>{$estimate.total|price:$currency}</strong></td>
		  
		   <td width="100" align="right" class="light">{$lang.Discount}:</td>
          <td width="200" align="left"><span class="livemode">{$estimate.credit|price:$currency}</span></td>
		  
        </tr>
        
      </table>
    </div>
	<div class="secondtd" style="display:none">
	<form action="" method="post" id="detailsform">
	<input type="hidden" name="make" value="editdetails" />
      <table border="0" width="700" cellspacing="3" cellpadding="0">
        <tr>
          <td width="100" align="right" class="light">{$lang.Date}:</td>
          <td width="200" align="left"><input name="estimate[date_created]" value="{$estimate.date_created|dateformat:$date_format}" class="haspicker" size="12"/></td>
		 <td width="100" align="right" class="light">{$lang.taxlevel1}:</td>
          <td width="120" align="left"><input name="estimate[taxrate]" size="7" value="{$estimate.taxrate}" /> %</td>
		  <td width="100" align="right"><input type="submit" value="{$lang.savechanges}"/></td>
        </tr>
        <tr>
          <td width="100" align="right"  class="light">{$lang.validuntil}:</td>
          <td width="200" align="left"><input name="estimate[date_expires]" value="{$estimate.date_expires|dateformat:$date_format}" class="haspicker" size="12"/></td>
		  
		 
		  <td width="100" align="right" class="light">{$lang.taxlevel2}:</td>
          <td width="200" align="left" ><input name="estimate[taxrate2]" size="7" value="{$estimate.taxrate2}" /> %</td>
		  
		  <td width="100" align="right"><input type="button" onclick="$('.tdetail a').click();return false;" value="{$lang.Cancel}"/></td>
        </tr>
        <tr>
          <td width="100" align="right"  class="light">{$lang.Amount}:</td>
          <td width="200" align="left" ><strong>{$estimate.total|price:$currency}</strong></td>
		  
		     <td width="100" align="right" class="light">{$lang.Discount}:</td>
          <td width="200" align="left" colspan="2"><input name="estimate[credit]" size="7" value="{$estimate.credit}" /> </td>
		  
        </tr>
        
      </table>
	  {securitytoken}</form>
    </div>
	</div>
   </div>
		   {include file="_common/quicklists.tpl" _placeholder=true}
  </div>
  


  <form action="" method="post" id="itemsform">
<table class="invoice-table" width="100%" border="0" cellpadding="0" cellspacing="0">
			<tbody id="main-invoice">
				<tr>
					<th>{$lang.Description}</th>
					<th width="8%" class="acenter">{$lang.qty}</th>
					<th width="7%" class="acenter">{$lang.Taxed}</th>
					<th width="9%" class="acenter">{$lang.Price}</th>
					<th width="13%" class="aright">{$lang.Linetotal}</th>
					<th width="1%" class="acenter">&nbsp;</th>

				</tr>
				{foreach from=$estimate.items item=item}
				<tr id="line_{$item.id}">
					<td class="editline">
					<span class="line_descr">{$item.description|nl2br}</span>
					<a class="editbtn" style="display:none;"  href="#">{$lang.Edit}</a>
						<div style="display:none" class="editor-line">
							<textarea name="item[{$item.id}][description]">{$item.description}</textarea>
							<a class="savebtn" href="#" >{$lang.savechanges}</a>
						</div>
					</td>
					<td class="acenter"><input name="item[{$item.id}][qty]" value="{$item.qty}" size="2" class="foc invitem invqty" style="text-align:center"/></td>
					<td class="acenter"><input type="checkbox" name="item[{$item.id}][taxed]" {if $item.taxed == 1}checked="checked" {/if}value="1" class="invitem2"/></td>
					<td class="acenter"><input name="item[{$item.id}][amount]" value="{$item.amount}" size="4" class="foc invitem invamount" style="text-align:right"/></td>
					<td class="aright">{$currency.sign} <span id="ltotal_{$item.id}">{$item.linetotal|string_format:"%.2f"}</span> {if $currency.code}{$currency.code}{else}{$currency.iso}{/if}</td>
					<td class="acenter"><a href="?cmd=estimates&action=removeline&id={$estimate.id}&line={$item.id}" class="removeLine"><img src="{$template_dir}img/trash.gif" alt="{$lang.Delete}"/></a></td>
				</tr>
				{/foreach}
				<tr id="addliners">
					<td class="summary blu">
					<strong>{$lang.newline}</strong>: <input name="nline" id="nline" style="width:80%"/>
					</td>
					<td class="summary blu acenter"><input name="nline_qty" id="nline_qty" size="2" style="text-align:center" value="1"/></td>
					<td class="summary blu acenter"><input name="nline_tax" type="checkbox" value="1" id="nline_tax" /></td>
					<td class="summary blu acenter"><input name="nline_price" id="nline_price" size="4" /></td>
					<td class="summary blu" colspan="2"><input type="button" value="{$lang.Add}" class="prodok" style="font-weight:bold"/>
						<input type="button" id="addliner" value="{$lang.moreoptions}" /></td>
					
					
												
				</tr>
				<tr id="addliners2" style="display:none">
					<td class="summary blu" colspan="6">					
					
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
					</div>
					
					</td>							
				</tr>
			</tbody>
					
			<tr>
				<td style="border:none;padding:20px 10px;margin:0px;" valign="top">
					<table border="0" cellpadding="0" cellspacing="0" width="100%" class="fs11 nomarg">
							<tr>
								<td width="50%"><strong>{$lang.estnotes}:</strong></td>
								<td width="50%" style="padding-left:10px"><strong>{$lang.estadminnotes}:</strong></td>
							</tr>
							<tr>
								<td width="50%">
									<textarea class="notes_field" style="width:90%;height:60px;" name="notes" id="est_notes">{$estimate.notes}</textarea>
								</td>
								<td width="50%" style="padding-left:10px">
									<textarea class="notes_field" style="width:90%;height:60px;" name="admin_notes" id="est_admin_notes">{$estimate.notes_private}</textarea>
								</td>
							</tr>
							<tr>
								<td width="50%" >
									<div  class="notes_submit" id="notes_submit" style="display:none"><input value="{$lang.savechanges}" type="button" /></div>
								</td>
								<td width="50%" style="padding-left:10px" >
									<div  class="notes_submit"  id="admin_notes_submit" style="display:none"><input value="{$lang.savechanges}" type="button" /></div>
								</td>
							</tr>
						</table>
				
				</td>
				<td colspan="5" style="border:none;padding:10px 0px;margin:0px;" valign="top">
				<table width="100%">
					<tbody id="updatetotals">
						<tr>					
					<td class="summary aright"  colspan="2"><strong>{$lang.Subtotal}</strong></td>
					<td class="summary aright" colspan="2"><strong>{$estimate.subtotal|price:$currency}</strong></td>	
					<td class="summary" width="2%"></td>				
				</tr>
				<tr>
					
					<td class="summary aright"  colspan="2"><strong>{$lang.Discount}</strong></td>
					<td class="summary aright" colspan="2"><strong>{$estimate.credit|price:$currency}</strong></td>		
					<td class="summary"></td>				
				</tr>
				
				{if $estimate.taxrate!=0}
				<tr>
					
					<td class="summary aright"  colspan="2"><strong>{$lang.Tax} ({$estimate.taxrate}%)</strong></td>
					<td class="summary aright" colspan="2"><strong>{$estimate.tax|price:$currency}</strong></td>		
					<td class="summary"></td>				
				</tr>
				{/if}
				{if $estimate.taxrate2!=0}
				<tr>
					
					<td class="summary aright"  colspan="2"><strong>{$lang.Tax} ({$estimate.taxrate2}%)</strong></td>
					<td class="summary aright" colspan="2"><strong>{$estimate.tax2|price:$currency}</strong></td>	
					<td class="summary"></td>					
				</tr>
				{/if}
				<tr>
				
					<td class="summary aright" colspan="2" valign="top"><strong class="bigger">{$lang.Total}</strong></td>
					<td class="summary aright" colspan="2" valign="top" ><strong class="bigger">{$estimate.total|price:$currency}</strong></td>	
					<td class="summary"  valign="top"></td>					
				</tr>
					</tbody>
				</table>
				
				</td>
			</tr>
			
				
			</table>
{securitytoken}</form>
 
<p align="right" style="color:#999999; {if $estimate.status=='Dead' || $estimate.status=='Draft'}display:none;{/if}" id="clientlink" >
<strong>{$lang.clientlink}</strong> {$system_url}?action=estimate&amp;id={$estimate.hash}
</p>


</div>


<div class="blu"> <div class="menubar"><a href="?cmd=estimates&list={$currentlist}"  id="backto"><strong>&laquo; {$lang.backto} {$lang.Estimates}</strong></a>
  
    <a class="setStatus menuitm menuf" id="hd1"  ><span class="morbtn">{$lang.Setstatus}</span></a>{*
    *}<a class="invoiced_ menuitm menu{if !$forbidAccess.deleteEstimates}c{else}l{/if} {if $estimate.status=='Invoiced'}disabled{/if}" href="?cmd=estimates&action=createinvoice&id={$estimate.id}&security_token={$security_token}" {if $estimate.status=='Invoiced'}onclick="return false"{/if}><span>{$lang.converttoinvoice}</span></a>{*
    *}{if !$forbidAccess.deleteEstimates}{*
        *}<a class="deleteEstimate menuitm menul"    ><span style="color:#FF0000">{$lang.Delete}</span></a>
    {/if}
           
    <a class="{if $estimate.status!='Invoiced'}sendEstimate{/if} invoiced_ menuitm menuf  {if $estimate.status=='Invoiced'}disabled{/if}" name="send" {if $estimate.status=='Invoiced'}onclick="return false"{/if} ><span style="font-weight:bold">{$lang.Send}</span></a>{*
    *}<a class="menuitm setStatus menul" id="hd2" onclick="return false;"   href="#" ><span class="morbtn">{$lang.moreactions}</span></a>
</div>
</div>
{if $ajax}
<script type="text/javascript">bindEvents();bindEstimatesEvents();</script>
{/if}








{elseif $action=='updatetotals'}


	<tr>					
					<td class="summary aright"  colspan="2"><strong>{$lang.Subtotal}</strong></td>
					<td class="summary aright" colspan="2"><strong>{$estimate.subtotal|price:$currency}</strong></td>	
					<td class="summary" width="2%"></td>				
				</tr>
				<tr>
					
					<td class="summary aright"  colspan="2"><strong>{$lang.Discount}</strong></td>
					<td class="summary aright" colspan="2"><strong>{$estimate.credit|price:$currency}</strong></td>		
					<td class="summary"></td>				
				</tr>
				
				{if $estimate.taxrate!=0}
				<tr>
					
					<td class="summary aright"  colspan="2"><strong>{$lang.Tax} ({$estimate.taxrate}%)</strong></td>
					<td class="summary aright" colspan="2"><strong>{$estimate.tax|price:$currency}</strong></td>		
					<td class="summary"></td>				
				</tr>
				{/if}
				{if $estimate.taxrate2!=0}
				<tr>
					
					<td class="summary aright"  colspan="2"><strong>{$lang.Tax} ({$estimate.taxrate2}%)</strong></td>
					<td class="summary aright" colspan="2"><strong>{$estimate.tax2|price:$currency}</strong></td>	
					<td class="summary"></td>					
				</tr>
				{/if}
				<tr>
				
					<td class="summary aright" colspan="2" valign="top"><strong class="bigger">{$lang.Total}</strong></td>
					<td class="summary aright" colspan="2" valign="top" ><strong class="bigger">{$estimate.total|price:$currency}</strong></td>	
					<td class="summary"  valign="top"></td>					
				</tr>



{elseif $action=='getproduct'}
{if $products}
	<select name="product" id="product_id">{foreach from=$products item=prod}<option value="{$prod.id}">{$prod.name} {$prod.price|price:$currency}</option>{/foreach}</select>
	<input type="button" value="OK" class="prodok"/>
	{/if}
	<input type="button" value="{$lang.Cancel}" id="prodcanc"/>
{if $ajax}
<script type="text/javascript">bindEstimatesDetForm();</script>
{/if}

{elseif $action=='getblank'}

	description: <input name="newline_name" id="newline"/>
	<input type="button" value="OK" class="prodok"/>
	<input type="button" value="{$lang.Cancel}" id="prodcanc"/>
{if $ajax}
<script type="text/javascript">bindEstimatesDetForm();</script>
{/if}


{elseif $action=='getaddon'}
{if $addons}
<select name="addon" id="addon_id">{foreach from=$addons item=addon}<option value="{$addon.id}">{$addon.name} {$addon.price|price:$currency}</option>{/foreach}</select>
	<input type="button" value="OK" class="prodok"/>
	{/if}
	<input type="button" value="{$lang.Cancel}" id="prodcanc"/>
{if $ajax}
<script type="text/javascript">bindEstimatesDetForm();</script>
{/if}

{elseif $action=='addline'}

	{if $newline}
	<tr id="line_{$newline.id}">
					<td class="editline"><span class="line_descr">{$newline.description|nl2br}</span><a class="editbtn" style="display:none;" href="#">{$lang.Edit}</a>
						<div style="display:none" class="editor-line">
							<textarea name="item[{$newline.id}][description]">{$newline.description}</textarea>
							<a class="savebtn" href="#" >{$lang.savechanges}</a>
						</div></td>
					<td class="acenter"><input name="item[{$newline.id}][qty]" value="{$newline.qty}" size="2" class="foc invitem invqty" style="text-align:center"/></td>
					<td class="acenter"><input type="checkbox" name="item[{$newline.id}][taxed]" {if $newline.taxed == 1}checked="checked" {/if}value="1" class="invitem2"/></td>
					<td class="acenter"><input name="item[{$newline.id}][amount]" value="{$newline.amount}" size="4" class="foc invitem invamount" style="text-align:right"/></td>
					<td class="aright">{$currency.sign} <span id="ltotal_{$newline.id}">{$newline.linetotal|string_format:"%.2f"}</span> {if $currency.code}{$currency.code}{else}{$currency.iso}{/if}</td>
<td class="acenter"><a href="?cmd=estimates&action=removeline&id={$estimateid}&line={$newline.id}" class="removeLine"><img src="{$template_dir}img/trash.gif" alt="{$lang.Delete}"/></a>{if $ajax}
<script type="text/javascript">bindEstimatesDetForm(); //estimatesItemsSubmit()</script>
{/if}</td>
				</tr>
	
	{/if}

{elseif $action=='changeowner'}
<form action="?cmd=estimates&action=edit&id={$estimate_id}" method="post">
<input type="hidden" name="make" value="changeowner" />
<select name="new_owner">
	{foreach from=$clients item=client}
		<option value="{$client.id}" {if $selected==$client.id}selected="selected"{/if}>#{$client.id} {if $client.companyname!=''}{$lang.Company}: {$client.companyname}{else}{$client.firstname} {$client.lastname}{/if}</option>
	{/foreach}
</select> <input type="submit" value="{$lang.Change}" style="font-size:11px;font-weight:bold;"/> &nbsp;&nbsp;<a href="#" onclick="$('#curr_det').show();$('#client_container').hide();return false;">{$lang.Cancel}</a>
{securitytoken}</form>
{elseif $action=='getadvanced'}

<a href="?cmd=estimates&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
<form class="searchform filterform" action="?cmd=estimates" method="post" onsubmit="return filter(this)">  
<table width="100%" cellspacing="2" cellpadding="3" border="0" >
  <tbody>
    <tr>
      <td width="15%">{$lang.clientname}</td>
      <td ><input type="text" value="{$currentfilter.lastname}" size="25" name="filter[lastname]"/></td>
      <td width="15%">{$lang.datecreated}</td>
      <td ><input type="text" value="{if $currentfilter.date_created}{$currentfilter.date_created|dateformat:$date_format}{/if}" size="15" name="filter[date_created]" class="haspicker"/></td>
    </tr>
    <tr>
      <td>{$lang.estimatehash}</td>
      <td ><input type="text" value="{$currentfilter.id}" size="15" name="estimate[id]"/></td>
      <td>{$lang.Total}</td>
      <td ><input type="text" value="{$currentfilter.total}" size="8" name="estimate[total]"/></td>
    </tr>
    <tr>
      <td>{$lang.estsubject}</td>
      <td ><input name="filter[subject]" value="{$currentfilter.subject}" /></td>
      <td>{$lang.Status}</td>
      <td ><select name="filter[status]">  
	   <option value="0">{$lang.All}</option>
         
		  <option value="Draft" {if $currentfilter.status=='Draft'}selected="selected"{/if}>{$lang.Draft} </option>
		  <option value="Sent" {if $currentfilter.status=='Sent'}selected="selected"{/if}>{$lang.Sent} </option>
		  <option value="Accepted" {if $currentfilter.status=='Accepted'}selected="selected"{/if}>{$lang.Accepted} </option>
		  <option value="Invoiced" {if $currentfilter.status=='Invoiced'}selected="selected"{/if}>{$lang.Invoiced} </option>
  		  <option value="Dead" {if $currentfilter.status=='Dead'}selected="selected"{/if}>{$lang.Dead} </option>
         
        </select></td>
    </tr>
	<tr><td colspan="4"><center><input type="submit" value="{$lang.Search}" />&nbsp;&nbsp;&nbsp;<input type="submit" value="{$lang.Cancel}" onclick="$('#hider2').show();$('#hider').hide();return false;"/></center></td></tr>
  </tbody>
</table>
{securitytoken}</form>
      
	  <script type="text/javascript">bindFreseter();</script>
{/if} 




{if $drawdetails}
 <div class="tdetails">
      <table border="0" width="600" cellspacing="5" cellpadding="0">
        <tr>
          <td width="100" align="right" class="light">{$lang.Date}:</td>
          <td width="200" align="left"><span class="livemode">{$estimate.date_created|dateformat:$date_format}</span></td>
		 <td width="100" align="right" class="light">{$lang.taxlevel1}:</td>
          <td width="200" align="left"><span class="livemode">{$estimate.taxrate} %</span></td>
		  
        </tr>
        <tr>
          <td width="100" align="right"  class="light">{$lang.validuntil}:</td>
          <td width="200" align="left"><span class="livemode">{$estimate.date_expires|dateformat:$date_format}</span></td>
		  <td width="100" align="right" class="light">{$lang.taxlevel2}:</td>
          <td width="200" align="left"><span class="livemode">{$estimate.taxrate2} %</span></td>
		  
		  
        </tr>
        <tr>
          <td width="100" align="right"  class="light">{$lang.Amount}:</td>
          <td width="200" align="left" ><strong>{$estimate.total|price:$currency}</strong></td>
		  
		    <td width="100" align="right" class="light">{$lang.Discount}:</td>
          <td width="200" align="left"><span class="livemode">{$estimate.credit|price:$currency}</span></td>
		  
        </tr>
        
      </table>
    </div>
	<div class="secondtd" style="display:none">
	<form action="" method="post" id="detailsform">
	<input type="hidden" name="make" value="editdetails" />
      <table border="0" width="700" cellspacing="3" cellpadding="0">
        <tr>
          <td width="100" align="right" class="light">{$lang.Date}:</td>
          <td width="200" align="left"><input name="estimate[date_created]" value="{$estimate.date_created|dateformat:$date_format}" class="haspicker" size="12"/></td>
		 <td width="100" align="right" class="light">{$lang.taxlevel1}:</td>
          <td width="120" align="left"><input name="estimate[taxrate]" size="7" value="{$estimate.taxrate}" /> %</td>
		  <td width="100" align="right"><input type="submit" value="{$lang.savechanges}"/></td>
        </tr>
        <tr>
          <td width="100" align="right"  class="light">{$lang.validuntil}:</td>
          <td width="200" align="left"><input name="estimate[date_expires]" value="{$estimate.date_expires|dateformat:$date_format}" class="haspicker" size="12"/></td>
		  
		 
		  <td width="100" align="right" class="light">{$lang.taxlevel2}:</td>
          <td width="200" align="left" ><input name="estimate[taxrate2]" size="7" value="{$estimate.taxrate2}" /> %</td>
		  
		  <td width="100" align="right"><input type="button" onclick="$('.tdetail a').click();return false;" value="{$lang.Cancel}"/></td>
        </tr>
        <tr>
          <td width="100" align="right"  class="light">{$lang.Amount}:</td>
          <td width="200" align="left" ><strong>{$estimate.total|price:$currency}</strong></td>
		  
		    <td width="100" align="right" class="light">{$lang.Discount}:</td>
          <td width="200" align="left" colspan="2"><input name="estimate[credit]" size="7" value="{$estimate.credit}" /> </td>
		  
		  
        </tr>
        
      </table>
	  {securitytoken}</form>
    </div>
	{if $ajax}
<script type="text/javascript">bindEstimatesDetForm();</script>
{/if}{/if}



