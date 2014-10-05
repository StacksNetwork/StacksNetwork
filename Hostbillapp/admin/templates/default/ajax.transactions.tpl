 {if $action=='default'}{if $showall}
                <form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
                    <div class="blu">
                        <div class="right"><div class="pagination"></div></div>
                        <div class="left menubar">
                            {if !$forbidAccess.addTransactions}
                            <a style="margin-right: 30px;font-weight:bold;" href="?cmd=transactions&action=add"  data-pjax class="menuitm"><span class="addsth">{$lang.addnewtransaction}</span></a>
                            {/if}
                            </div>
                        <div class="clear"></div>
                    </div>

                    <a href="?cmd=transactions" id="currentlist" style="display:none"></a>
                    <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
                        <tbody>
                            <tr>
                                <th><a href="?cmd=transactions&orderby=trans_id|ASC"  class="sortorder">{$lang.Transactionid}</a></th>
                                <th><a href="?cmd=transactions&orderby=lastname|ASC"  class="sortorder">{$lang.clientname}</a></th>
                                <th class="acenter"><a href="?cmd=transactions&orderby=date|ASC"  class="sortorder">{$lang.Date}</a></th>

                                <th><a href="?cmd=transactions&orderby=module|ASC"  class="sortorder">{$lang.Gateway}</a></th>
                                <th><a href="?cmd=transactions&orderby=description|ASC"  class="sortorder">{$lang.Description}</a></th>
                                <th><a href="?cmd=transactions&orderby=in|ASC"  class="sortorder">{$lang.amountin}</a></th>
                                <th><a href="?cmd=transactions&orderby=out|ASC"  class="sortorder">{$lang.amountout}</a></th>
                                <th  class="acenter"><a href="?cmd=transactions&orderby=fee|ASC"  class="sortorder">{$lang.fees}</a></th>
                                <th width="20">&nbsp;</th>
                                <th width="20">&nbsp;</th>
                            </tr>
                        </tbody>
                        <tbody id="updater">{/if}
                            {if $transactions}

    {foreach from=$transactions item=transaction}
<tr>
<td><a href="?cmd=transactions&action=edit&id={$transaction.id}" data-pjax>{$transaction.trans_id}</a></td>
  <td><a href="?cmd=clients&action=show&id={$transaction.client_id}">{$transaction.firstname} {$transaction.lastname}</a></td>
  <td  class="acenter">{$transaction.date|dateformat:$date_format}</td>
  <td>{$transaction.module}</td>
  <td>{$transaction.description}</td>
  <td>{$transaction.in|price:$transaction.currency_id}</td>
  <td>{$transaction.out|price:$transaction.currency_id}</td>
  <td >{$transaction.fee|price:$transaction.currency_id}</td>
  <td><a href="?cmd=transactions&action=edit&id={$transaction.id}" class="editbtn">{$lang.Edit}</a></td>
  <td>
      {if !$forbidAccess.deleteTransactions}
      <a href="?cmd=transactions&make=delete&id={$transaction.id}&security_token={$security_token}" onclick="return confirm('{$lang.deletetransconfirm}');" class="delbtn">delete</a>
      {/if}
  </td>
</tr>
{/foreach}
  
{else}
<tr>
  <td colspan="10"><p align="center" >{$lang.Click} <a href="?cmd=transactions&action=add">{$lang.here}</a> {$lang.notransclick}</p></td>
</tr>
{/if}
{if $showall}

                        </tbody>
                        <tbody id="psummary">
                            <tr>
                                <th colspan="10">
                                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                                </th>
                            </tr>
                        </tbody>
                    </table>
                    <div class="blu">
                        <div class="right"><div class="pagination"></div> </div>
                        <div class="clear"></div>

                    </div>

                    {securitytoken}</form>
                    {/if}
                {elseif $action=='edit'}

                    {include file='transactions/edit.tpl'}

                {elseif $action=='add'}

                    {include file='transactions/add.tpl'}

    

{elseif $action=='clienttransactions'}
<div class="blu" style="text-align:right">
<form action="?cmd=transactions&action=add" method="post">
<input type="hidden" name="related_client_id" value="{$client_id}" />
<input type="submit" value="{$lang.newtransaction}" onclick="window.location='?cmd=transactions&action=add&related_client_id={$client_id}';return false;"/>{securitytoken}</form></div>


{if $transactions}
 <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
      
              <tr>
              <th>{$lang.Transactionid}</th>
                <th class="acenter">{$lang.Date}</th>
                <th>{$lang.Gateway}</th>
                <th>{$lang.Description}</th>
                <th>{$lang.amountin}</th>
                <th>{$lang.amountout}</th>
                <th  class="acenter">{$lang.fees}</th>
                <th width="20">&nbsp;</th>
              
              </tr>
       
       
            
          
 {foreach from=$transactions item=transaction}
<tr>
   <td><a href="?cmd=transactions&action=edit&id={$transaction.id}" >{$transaction.trans_id}</a></td>
  <td  class="acenter">{$transaction.date|dateformat:$date_format}</td>
  <td>{$transaction.module}</td>
  <td><a href="?cmd=transactions&action=edit&id={$transaction.id}" >{$transaction.description}</a></td>
  <td>{$transaction.in|price:$transaction.currency_id}</td>
  <td>{$transaction.out|price:$transaction.currency_id}</td>
  <td >{$transaction.fee|price:$transaction.currency_id}</td>
  <td><a href="?cmd=transactions&action=edit&id={$transaction.id}" class="editbtn">{$lang.Edit}</a></td>
  
</tr>
{/foreach}
 
           
            
          </table>{if $totalpages}
			 <center class="blu"><strong>{$lang.page} </strong>
			 {section name=foo loop=$totalpages}
			 {if $smarty.section.foo.iteration-1==$currentpage}<strong>{$smarty.section.foo.iteration}</strong>{else}
          <a href='?cmd=transactions&action=clienttransactions&id={$client_id}&page={$smarty.section.foo.iteration-1}' class="npaginer">{$smarty.section.foo.iteration}</a>
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

{elseif $action=='getadvanced'} <a href="?cmd=transactions&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
<form class="searchform filterform" action="?cmd=transactions" method="post" onsubmit="return filter(this)">
  <table width="100%" cellspacing="2" cellpadding="3" border="0">
    <tbody>
  
	  
      <tr>
       
        <td>{$lang.Transactionid}</td>
        <td><input type="text" value="{$currentfilter.trans_id}" size="20" name="filter[trans_id]"/></td>
		
	    <td>{$lang.Description}</td>
        <td><input type="text" value="{$currentfilter.description}" size="40" name="filter[description]"/></td>
		
		
		 <td>{$lang.paymethod}</td>
        <td><select name="filter[module]">
      
            <option value="">{$lang.Any}</option>
		  {foreach from=$modules item=module key=id}
		  	<option value="{$id}"  {if $currentfilter.module==$id}selected="selected"{/if}>{$module}</option>
		  {/foreach}
			
          </select></td>
      </tr>
	  

      <tr>
        <td width="15%">{$lang.clientname}</td>
        <td >
		<input type="text" value="{$currentfilter.lastname}" size="40" name="filter[lastname]"/>
		
		</td>
        <td width="15%">{$lang.transactiondate}</td>
        <td ><input type="text" value="{if $currentfilter.date}{$currentfilter.date|dateformat:$date_format}{/if}" size="15" name="filter[date]" class="haspicker"/></td>
		<td>{$lang.amountin}</td>
        <td ><input type="text" value="{$currentfilter.in}" size="8" name="transaction[in]"/></td>
		
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


{/if} 