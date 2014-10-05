{if $action=='clientcontacts'}
	<div class="right" style="padding:3px 5px;"><a class="fs11 editbtn" href="?cmd=clients&action=newprofile&id={$client_id}">{$lang.addcontact}</a></div>

{if $contacts}
 <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
        <tbody>
          <tr>
            <th>#</th>
            <th>{$lang.lastname}</th>
            <th>{$lang.firstname}</th>
            <th>{$lang.email}</th>
            <th>{$lang.Created}</th>
            <th>{$lang.Status}</th>
            <th width="40"></th>
          </tr>
        </tbody>
        <tbody>

        {foreach from=$contacts item=client}
     <tr>
          <td><a href="?cmd=clients&action=showprofile&id={$client.id}">{$client.id}</a></td>
          <td><a href="?cmd=clients&action=showprofile&id={$client.id}">{$client.lastname}</a></td>
          <td><a href="?cmd=clients&action=showprofile&id={$client.id}">{$client.firstname}</a></td>
          <td>{$client.email}</td>
          <td>{$client.datecreated|dateformat:$date_format}</td>
          <td>{$lang[$client.status]}</td>
          <td align="right"><a  class=" editbtn"   href="?cmd=clients&action=showprofile&id={$client.id}" >{$lang.Edit}</a></td>
        </tr>
    {/foreach}
        </tbody>

      </table>
{if $totalpages}
			 <center class="blu"><strong>{$lang.Page} </strong>
			 {section name=foo loop=$totalpages}
{if $smarty.section.foo.iteration-1==$currentpage}<strong>{$smarty.section.foo.iteration}</strong>{else}
          <a href='?cmd=clients&action=clientcontacts&id={$client_id}&page={$smarty.section.foo.iteration-1}' class="npaginer">{$smarty.section.foo.iteration}</a>
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
{elseif $action=='ccadd' ||  $action=='ccshow' || $action=='ccard'}
{if $verify}
    {if $cardcode && $cmake=='ccadd'}
        <table cellpadding="5" cellspacing="0" border="0">
            {if $cardcode.token_gateway_id}
                <tbody id="ccbody">
                    <tr>
                        <td colspan="2">  Client credit card <b>{$cardcode.cardnum}</b> has been tokenised by payment module <b>{$cardcode.module}</b>. <br/>
                            This process is irreversible, to edit credit card remove current entry and add new CC</td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <input name="removeCC" value="Remove Credit Card" type="submit" style="font-weight:bold;color:red"/>
                            <input type="button" value="{$lang.Cancel}" onclick="$('#ccinfo').toggle();return false" />
                        </td>
                    </tr>
                </tbody>
            {else}
                <tbody id="ccbody">
                    <tr>
                        <td width="160">{$lang.ccardtype}:</td>
                        <td>
                            <select name="cardtype">
                                {foreach from=$supportedcc item=cc}
                                    <option {if $cardcode.cardtype==$cc}selected="selected"{/if}>{$cc}</option>
                                {/foreach}
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>{$lang.ccardnum}:</td>
                        <td id="cardnum"><input type="text" name="cardnum" size="25" value="{$cardcode.cardnum}"/></td>
                    </tr>
                    <tr>
                        <td>{$lang.ccexpiry}:</td><td><input type="text" name="expirymonth" size="2" maxlength="2"  value="{$cardcode.expirymonth}" /> /
                            <input type="text" name="expiryyear" size="2" maxlength="2"  value="{$cardcode.expiryyear}" /> (MM/YY)</td></tr>
                    <tr>
                        <td colspan="2" align="center">
                            <input name="updateCC" value="{$lang.updateccard}" type="submit" style="font-weight:bold"/> 
                            <input name="removeCC" value="Remove Credit Card" type="submit" style="font-weight:bold;color:red"/>
                            <input type="button" value="{$lang.Cancel}" onclick="$('#ccinfo').toggle();return false" />
                        </td>
                    </tr>
                </tbody>              
            {/if}
        </table>
    {elseif $cardcode && $cmake=='ccshow'}
        <table cellpadding="5" cellspacing="0" border="0">
            <tbody id="ccbody">
                <tr>
                    <td width="160">{$lang.ccardtype}:</td>
                    <td><strong>{$cardcode.cardtype}</strong></td>
                </tr>
                <tr>
                    <td>{$lang.ccardnum}:</td>
                    <td id="cardnum"><strong>{$cardcode.cardnum}</strong></td>
                </tr>
                <tr>
                    <td>{$lang.ccexpiry}:</td>
                    <td><strong>{$cardcode.expdate}</strong></td>
                </tr>
            </tbody>
        </table>
    {else}
        <table cellpadding="5" cellspacing="0" border="0">
            <tbody id="ccbody">
                <tr>
                    <td width="160">{$lang.ccardtype}:</td>
                    <td>
                        <select name="cardtype">
                            <option >Visa</option>
                            <option >MasterCard</option>
                            <option >Discover</option>
                            <option >American Express</option>
                            <option >Laser</option>
                            <option >Maestro</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>{$lang.ccardnum}:</td>
                    <td id="cardnum"><input type="text" name="cardnum" size="25" value=""/></td>
                </tr>
                <tr>
                    <td>{$lang.ccexpiry}:</td>
                    <td>
                        <input type="text" name="expirymonth" size="2" maxlength="2"  value="" /> /
                        <input type="text" name="expiryyear" size="2" maxlength="2"  value="" /> (MM/YY)
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <input name="updateCC" value="{$lang.addccard}" type="submit"  style="font-weight:bold"/> 
                        <input type="button" value="{$lang.Cancel}" onclick="$('#ccinfo').toggle();return false" />
                    </td>
                </tr>
            </tbody>
        </table>
    {/if}
{else}
    <form onsubmit="return verify_pass({if $admindata.access.editCC}'ccadd'{else}'ccshow'{/if})">
    {$lang.provideyourpassword} 
    <input  type="password" name="admin_pass" id="admin_pass" />
    <input type="submit" id="ccbutton" value="{$lang.submit}" style="font-weight:bold" />
    </form>
{/if}
{elseif $action=='field'}
{include file='ajax.clientfields.tpl'}
{elseif $action=='default'}
    {if $clients}
    {foreach from=$clients item=client}
     <tr>
          <td><input type="checkbox" class="check" value="{$client.id}" name="selected[]"/></td>
          <td><a href="?cmd=clients&amp;action=show&amp;id={$client.id}">{$client.id}</a></td>
              <td><a href="?cmd=clients&amp;action=show&amp;id={$client.id}">{$client.lastname}</a></td>
          <td><a href="?cmd=clients&amp;action=show&amp;id={$client.id}">{$client.firstname}</a></td>
          <td>{$client.email}</td>
          <td>{$client.companyname}</td>
          <td>{$client.services}</td>
          <td>{$client.datecreated|dateformat:$date_format}</td>
          <td>{if $client.affiliate}<div class="right inlineTags"><a href="?cmd=affiliates&action=affiliate&id={$client.affiliate}"><span>{$lang.affiliate}</span></a></div>{/if}</td>
        </tr>

    {/foreach}
    {else}
            <tr>
              <td colspan="10"><p align="center" >{$lang.Click} <a href="?cmd=newclient">{$lang.here}</a> {$lang.toregistercustomer}</p></td>
            </tr>
      {/if}

{elseif $action=='loadstatistics'}	  
	    <table border="0" cellpadding="3" cellspacing="0" width="100%">
  
  <tr><td>
  <tr><td width="160"><strong>{$lang.invoicespaid}</strong>	</td><td>{$stats.paid} ( {$stats.invoice_paid|price:$stats.currency_id} )</td></tr>
  <tr><td><strong>{$lang.invoicesdue}</strong>	</td><td>{$stats.unpaid} ( {$stats.invoice_unpaid|price:$stats.currency_id} )</td></tr>
  <tr><td><strong>{$lang.invoicescancel}</strong>	</td><td>{$stats.cancelled} ( {$stats.invoice_cancelled|price:$stats.currency_id} )</td></tr>

  <tr><td><strong>{$lang.Income}</strong>	</td><td><strong>{$stats.income|price:$stats.currency_id}</strong></td></tr>
  <tr><td><strong>{$lang.Credit}</strong>	</td>
      <td ><div class="editline left" style="margin-right:10px">
          <div class="a1 editor-line" style="display:none;">
              <textarea name="credit" style="height: 15px;width:80px;background:#fff;">{$stats.credit}</textarea><a href="#" class="savebtn" onclick="$('#clientsavechanges').click(); return false">{$lang.savechanges}</a></div>
              </div>
         <span class="a2  livemode" onclick="$('.secondtd').show();$('.tdetails').hide();$('.a2').hide();$('.a1').show();return false;"> <strong class="">{$stats.credit|price:$stats.currency_id}</strong></span>
        <span class="a2 fs11 "><a href="#" class="editbtn" onclick="$('.secondtd').show();$('.tdetails').hide();$('.a2').hide();$('.a1').show();return false;">{$lang.Edit}</a></span>
        <span class="fs11 ">[ <a class="editbtn" href="?cmd=transactions&amp;action=add&amp;related_client_id={$client_id}">{$lang.addcredit}</a> <a class="editbtn editgray" href="?cmd=clientcredit&filter[client_id]={$client_id}" target="_blank">信用日志</a>  ]</span>
         </td></tr>
  
  
  {if $stats.accounts}
  	{foreach from=$stats.accounts item=acct key=k}
	{assign var="descr" value="_hosting"}
	{assign var="baz" value="$k$descr"}
		<tr><td><strong>{if $lang.$baz}{$lang.$baz}{else}{$k}{/if}</strong>	</td><td>{$acct}</td></tr>
	{/foreach}
  {/if}
  

  
  <tr><td><strong>{$lang.Domains}</strong>	</td><td>{$stats.domain}</td></tr>
  <tr><td><strong>{$lang.supptickets}</strong>	</td><td>{$stats.ticket}</td></tr>
  {if $stats.affiliate}
   <tr class="blu"><td><strong>{$lang.affiliatehash}</strong>	</td><td><a href="?cmd=affiliates&action=affiliate&id={$stats.affiliate.id}">{$stats.affiliate.id}</a></td></tr>
   <tr class="blu"><td><strong>{$lang.affsince}</strong>	</td><td>{$stats.affiliate.date_created|dateformat:$date_format}</td></tr>
    <tr class="blu"><td><strong>{$lang.convrate}</strong>	</td><td>{$stats.affiliate.conversion} %</td></tr>
	<tr class="blu"><td><strong>{$lang.balance}</strong>	</td><td>{$stats.affiliate.balance|price:$stats.currency_id}</td></tr>
  {/if}
</table>
{elseif $action=='sendmailcriterias'}
    {if $criterias}
        <table width="100%">
        <tr><td colspan="5" width="16%"><input type="checkbox" onclick="checkAllItems(this,'{$type}')"><strong>{$lang.All}</strong></td></tr>
        {foreach from=$criterias item=criteria name=checker}
            {if $smarty.foreach.checker.index%6=='0'}<tr>{/if}
            <td width="16%"><input type="checkbox" class="check_{$type}" name="selected[{$type}][]" value="{$criteria.id}"> {$criteria.name}</td>
            {if $smarty.foreach.checker.index%6=='5'}</tr>{/if}
        {/foreach}
        </table>
    {else}
        {if $type=='services'}
            {$lang.noservices}
        {elseif $type=='servers'}
            {$lang.noservers}
        {elseif $type=='countries'}
            {$lang.nocountries}
        {/if}
    {/if}
{elseif $action=='getadvanced'} 
    <a href="?cmd=clients&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
    <form class="searchform filterform" action="?cmd=clients" method="post" onsubmit="return filter(this)">
      <table width="100%" cellspacing="2" cellpadding="3" border="0">
        <tbody>
          <tr>
            <td>{$lang.lastname}</td>
            <td><input type="text" value="{$currentfilter.lastname}" size="30" name="filter[lastname]"/></td>

            <td width="15%">{$lang.datecreated}</td>
            <td ><input type="text" value="{if $currentfilter.datecreated}{$currentfilter.datecreated|dateformat:$date_format}{/if}" size="15" name="filter[datecreated]" class="haspicker"/></td>

            <td>{$lang.city}</td>
            <td><input type="text" value="{$currentfilter.city}" size="30" name="filter[city]"/></td>
 
          </tr>

          <tr>
            <td>{$lang.firstname}</td>
            <td><input type="text" value="{$currentfilter.firstname}" size="30" name="filter[firstname]"/></td>

            <td>{$lang.address}</td>
            <td><input type="text" value="{$currentfilter.address1}" size="30" name="filter[address1]"/></td>
            
            <td>{$lang.state}</td>
            <td><input type="text" value="{$currentfilter.state}" size="30" name="filter[state]"/></td>
            
          </tr>

          <tr>
            <td>{$lang.company}</td>
            <td><input type="text" value="{$currentfilter.companyname}" size="30" name="filter[companyname]"/></td>

            <td>{$lang.address2}</td>
            <td><input type="text" value="{$currentfilter.address2}" size="30" name="filter[address2]"/></td>            

            <td>{$lang.Status}</td>
            <td>
                <select name="filter[status]">
                    <option value="" {if $currentfilter.status==''}selected="selected"{/if}>{$lang.All}</option>
                    <option {if $currentfilter.status=='Active'}selected="selected"{/if}>{$lang.Active}</option>
                    <option {if $currentfilter.status=='Closed'}selected="selected"{/if}>{$lang.Closed}</option>
                </select>
            </td>
          </tr>
          
          <tr>
            <td>{$lang.email}</td>
            <td><input type="text" value="{$currentfilter.email}" size="30" name="filter[email]"/></td>

            <td>{$lang.phone}</td>
            <td><input type="text" value="{$currentfilter.phonenumber}" size="30" name="filter[phonenumber]"/></td>

            <td>{$lang.country}</td>
            <td>
                <select name="filter[country]">
                    <option value=""></option>
                    {foreach from=$countries key=k item=v}
                        <option value="{$k}" {if $k==$currentfilter.country} selected="selected"{/if}>{$v}</option>
                    {/foreach}
                </select>
            </td>
          </tr>

          <tr>
            <td>账户类型</td>
            <td>
                <select name="filter[company]">
                    <option value="" {if $currentfilter.company==''}selected="selected"{/if}>{$lang.All}</option>
                    <option {if $currentfilter.company=='0'}selected="selected"{/if} value="0">{$lang.Private}</option>
                    <option {if $currentfilter.company=='1'}selected="selected"{/if} value="1">{$lang.Company}</option>
                </select>
            </td>

            <td>登录IP</td>
            <td><input type="text" value="{$currentfilter.ip}" size="30" name="filter[ip]"/></td>

            <td>用户组</td>
            <td>
                <select name="filter[group_id]">
                    <option value="">-</option>
                    {foreach from=$groups key=k item=v}
                        <option value="{$v.id}" {if $v.id==$currentfilter.group_id} selected="selected"{/if}>{$v.name}</option>
                    {/foreach}
                </select>
            </td>
          </tr>
          <tr>
            <td>过期通知</td>
            <td>
                <select name="filter[overideduenotices]">
                    <option value="" {if $currentfilter.overideduenotices==''}selected="selected"{/if}>-</option>
                    <option {if $currentfilter.overideduenotices=='0'}selected="selected"{/if} value="0">{$lang.Yes}</option>
                    <option {if $currentfilter.overideduenotices=='1'}selected="selected"{/if} value="1">{$lang.No}</option>
                </select>
            </td>

            <td>防止自动冻结/终止</td>
            <td>
                <select name="filter[overideautosusp]">
                    <option value="" {if $currentfilter.overideautosusp==''}selected="selected"{/if}>-</option>
                    <option {if $currentfilter.overideautosusp=='1'}selected="selected"{/if} value="1">{$lang.Yes}</option>
                    <option {if $currentfilter.overideautosusp=='0'}selected="selected"{/if} value="0">{$lang.No}</option>
                </select>
            </td>

            <td>滞纳金</td>
            <td>
                <select name="filter[latefeeoveride]">
                    <option value="" {if $currentfilter.latefeeoveride==''}selected="selected"{/if}>-</option>
                    <option {if $currentfilter.latefeeoveride=='0'}selected="selected"{/if} value="0">{$lang.Yes}</option>
                    <option {if $currentfilter.latefeeoveride=='1'}selected="selected"{/if} value="1">{$lang.No}</option>
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


{/if} 