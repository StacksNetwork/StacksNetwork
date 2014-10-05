<form action="" method="post">
    <div class="blu"><a href="?cmd=orders&list={$currentlist}" ><strong>&laquo; {$lang.backto} {$currentlist} {$lang.orders}</strong></a>

    </div>
    <div id="ticketbody">
        <h1>{$lang.orderhash}{$details.id}  {$lang.numabbrev}{$details.number} </h1>

        <div id="client_nav">
            <!--navigation-->
            <a class="nav_el nav_sel left" href="#">{$lang.orderdetails}</a>
            <a class="nav_el  left"  href="?cmd=orders&action=orderlogs&id={$details.id}" onclick="return false">{$lang.orderlog}</a>
            {include file="_common/quicklists.tpl"}
            <div class="clear"></div>
        </div>
        <div class="ticketmsg ticketmain" id="client_tab" style="margin-bottom:10px;">
            <div class="slide" style="display:block">
                <table cellspacing="2" cellpadding="3" border="0" width="100%">
                    <tbody>
                        <tr>
                            <td width="15%" >{$lang.orderid}</td>
                            <td >{$details.id}</td>
                            <td width="15%" >{$lang.paymethod}</td>
                            <td >{if $order.total<0}{$lang.amountcredited}{else}{if $details.module}{$details.module}{else}{$lang.none}{/if}{/if}</td>
                        </tr>
                        <tr>
                            <td >{$lang.Client}</td>
                            <td ><a href="?cmd=clients&action=show&id={$details.client_id}">{$details.firstname} {$details.lastname}</a> </td>
                            <td >{$lang.Amount}</td>
                            <td >{$details.total|price:$details.currency_id}</td>
                        </tr>
                        <tr>
                            <td >{$lang.ordernumber}</td>
                            <td >{$details.number}</td>
                            <td >{$lang.invoicehash}</td>
                            <td >{if $details.invoice_id!='0'}<a href="?cmd=invoices&action=edit&id={$details.invoice_id}">{$details.invoice_id}</a>{else}{$lang.noinvoice}{/if}</td>
                        </tr>
                        <tr>
                            <td >{$lang.orderdate}</td>
                            <td >
                                <span>
						  {$details.date_created|dateformat:$date_format}
                                    <a href="#" class="editbtn" onclick="$('#datespan').show();$(this).parent().hide();$(this).after('<input type=\'hidden\' value=\'1\' name=\'changedate\' >');return false;">{$lang.Edit}</a>
                                </span>
                                <span id="datespan" style="display:none">
                                    <input class="haspicker" value="{$details.date_created|dateformat:$date_format|regex_replace:'! [^\s]*$!':''}" name="orderdate"/>
                                    <input size="5" value="{$details.date_created|regex_replace:'!^[^\s]* !':''}" name="ordertime" />
                                    <a href="#" class="editbtn"  onclick="$(this).parents('form').submit(); return false">{$lang.Save}</a>
                                </span>
                            </td>
                            <td >{$lang.orderstatus}</td>
                            <td >
                                <select name="status" onchange="if($(this).val() != '{$details.status}'){literal} $('#statussubmit').css('visibility','visible');  else $('#statussubmit').css('visibility','hidden'); " {/literal}">
                                    {foreach from=$order_status_list item=status}
                                    <option {if $details.status == $status}selected="selected"{/if} value="{$status}">{$lang.$status}</option>
                                    {/foreach}
                                </select>
                                <input type="submit" name="simplechangestate" value="{$lang.Save}" style="visibility: hidden" id="statussubmit"/>
                            </td>
                        </tr>
                        <tr>
                            <td >{$lang.orderip}</td>
                            <td >{$details.order_ip} {if !$forbidAccess.fastBan}(<a href="?cmd=security&action=fastban&type=order&id={$details.id}" onclick="ajax_update($(this).attr('href'));return false;">{$lang.banthisip}</a>){/if}</td>
                            <td>{$lang.paymentstatus}</td>
                            <td><span class="{$details.balance}">{$lang[$details.balance]}</span></td>
                        </tr>
                        
                        <tr>
                            <td>{$lang.staffownership}</td>
                                <td>
                                    <span>
                                    {if $details.staff_member_id}
                                        <a href="?cmd=editadmins&action=administrator&id={$details.staff_member_id}">{$details.admin_firstname} {$details.admin_lastname}</a>
                                    {else}
                                        {$lang.none}
                                    {/if}
                                    
                                    <input type="button" onclick="$(this).parent().hide().next().show();return false;" value="{$lang.Change}"/>
                                    <input type="submit" name="takeownership" value="{$lang.takeownership}"/>
                                    </span>
                                    <span class="editbtn_flash" style="display:none">
                                        <select name="staff_member_id" class="inp" >
                                            <option value="0" >{$lang.none}</option>
                                            {foreach from=$staff item=adm}
                                                <option value="{$adm.id}" {if $details.staff_member_id==$adm.id}selected="selected"{/if} >{$adm.firstname} {$adm.lastname}</option>
                                            {/foreach}
                                        </select>
                                        <input type="submit" name="changeownership" value="{$lang.Save}"/>
                                    </span>
                                </td>
                            {if $affiliates && $details.total!=0}
                                <td>{$lang.referral}</td>
                                <td>
                                    {if $referral}
                                        <a href="?cmd=affiliates&action=affiliate&id={$referral.id}">{$referral.firstname} {$referral.lastname}</a>
                                    {elseif $referrals}
                                        <select name="referral" onchange="if($(this).val()!='0')$('#refer').css('visibility','visible');else $('#refer').css('visibility','hidden');">
                                            <option selected="selected" value="0">{$lang.none}</option>
                                                                {foreach from=$referrals item=ref}
                                            <option value="{$ref.id}">#{$ref.id} {$ref.firstname} {$ref.lastname}</option>
                                                                {/foreach}
                                        </select>
                                        <input type="submit" name="refered" value="{$lang.Assign}" style="visibility: hidden" id="refer"/>
                                    {else}
                                        {$lang.none}
                                    {/if}
                                </td>
                            {else}
                                <td colspan="2"></td>
                            {/if}
                            
                        </tr>
				
                    </tbody>
                </table>
            </div>
            <div class="slide">Loading</div>
           {include file="_common/quicklists.tpl" _placeholder=true}
        </div>




        {if $details.status=='Pending'}
        <input type="hidden" name="manual" value="1" />
        {/if}            {literal}
        <script type="text/javascript">
            function _cunc(ele) {
              if(!$(ele).is(':checked')) {
                $('.provision').removeAttr('checked');
                $('.provisioning').hide();
              } else {
                $('.provision').attr('checked','checked');
                $('.provisioning').show();
              }
                return false;
            }
            $(document).ready(function(){
                $('.provision').click(function(){
                    var rel=$(this).attr('rel');
                   if($(this).is(':checked')) {
                    $('.'+rel).show();
                   } else {
                    $('.'+rel).hide();
                   }
                });
                var is=false;
                $('.ordertable > tbody > tr:gt(0)').each(function(){
                    if($(this).hasClass('provisioning')) {
                        if(is) {
                            $(this).addClass('even');
                        }
                    } else {
                        if(!is) {
                            $(this).addClass('even');
                        }
                        is= !is;
                    }
                });
            });
        </script>            {/literal}


        <h1>订单内容</h1>

        <table width="100%" class="ordertable" cellpadding="3" cellspacing="0" border="0" style="border:solid 1px #ddd;border-bottom: none;">
            <tbody>
                 <tr  >
                     {if $details.status=='Pending'}<th width="80" style="padding-left:3px"><input type="checkbox" onclick="_cunc(this)" /><span style="font-size:11px; font-weight: normal">{$lang.Provision}</span></th>{/if}
                    <th align="left">{$lang.Item}</th>
                    <th width="100" style="text-align: center;">{$lang.billingcycle}</th>
                    <th width="100" style="text-align: center;">{$lang.Amount}</th>
                    <th width="100" style="text-align: center;">{$lang.Status}</th>
                </tr>

                {if $details.hosting}
                {foreach from=$details.hosting item=account}

		  {assign var="descr" value="_hosting"}
		  {assign var="baz2" value=$account.ptype}

		{assign var="baz" value="$baz2$descr"}

                <tr  class="havecontrols">
                     {if $details.status=='Pending'}<td><input type="checkbox" name="oaccounts[{$account.id}][modulecreate]" value="1" class="provision account" rel="accountrow{$account.id}" {if $account.autosetup=='1'}checked="checked"{/if}/></td>{/if}
                    <td ><a href="?cmd=accounts&action=edit&id={$account.id}"><b>{if $lang.$baz}{$lang.$baz}{else}{$account.ptype}{/if}:</b>  {$account.catname} - {$account.name}
                            {if $account.domain!=''}{$account.domain}{/if}</a></td>
                    <td align="center">{$lang[$account.billingcycle]}</td>
                    <td align="center">{$account.total|price:$details.currency_id}</td>
                    <td align="center"><span class="{$account.status}" id="acc_{$account.id}">{$lang[$account.status]}</span></td>
                </tr>
                {if $account.status=='Pending' && $details.status=='Pending' && $account.module!=0 && $account.module!=''}
                <tr {if $account.autosetup!='1'}style="display:none"{/if} id="" class="accountrow{$account.id} provisioning">
                    <td></td>
                    <td colspan="4" >
                        <table border="0" width="100%" cellpadding="2" cellspacing="0">

                            <tr {if $account.domain==''}style="display:none"{/if}>
                                <td width="160">{$lang.Hostname}:</td>
                                <td  ><input name="oaccounts[{$account.id}][domain]" value="{$account.domain}" /></td>
                            </tr>

                            <tr>
                                <td width="160" >{$lang.Username}:</td>
                                <td ><input name="oaccounts[{$account.id}][username]" value="{$account.username}" /></td>
                            </tr>
                            <tr>
                                <td width="160" >{$lang.Password}:</td>
                                <td  ><input name="oaccounts[{$account.id}][password]" value="{$account.password}" /></td>
                            </tr>
                            <tr {if $account.ptype!='dedicated'}style="display:none"{/if}>
                                <td width="160" >{$lang.rootpass}:</td>
                                <td  ><input name="oaccounts[{$account.id}][rootpassword]" value="{$account.rootpassword}" /></td>
                            </tr>
                            <tr>
                                <td width="160"  >{$lang.Server}:</td>
                                <td ><select name="oaccounts[{$account.id}][server_id]">
			{foreach from=$servers[$account.id] item=server}
                                        <option value="{$server.id}" {if $account.server_id==$server.id}selected="selected"{/if}>{$server.name} ({$server.accounts}{if $server.max_accounts>0}/{$server.max_accounts}{/if} Accounts)</option>{/foreach}

                                    </select></td>
                            </tr>
                           

                        </table>


                    </td>
                </tr>
                {/if}

                {/foreach}
                {/if}

                {if $details.addons}
                {foreach from=$details.addons item=addon}
                <tr  class="havecontrols">
                     {if $details.status=='Pending'}<td></td>{/if}
                    <td ><a href="?cmd=accounts&action=edit&id={$addon.account_id}"><b>{$lang.accountaddon}:</b> {$addon.name}</a></td>
                    <td align="center">{$lang[$addon.billingcycle]}</td>
                    <td align="center">{$addon.recurring_amount|price:$details.currency_id}</td>
                    <td align="center"><span class="{$addon.status}">{$lang[$addon.status]}</span></td>
                </tr>
                {/foreach}
                {/if}


		  {if $details.upgrades}
                {foreach from=$details.upgrades item=upgrade}
                <tr  class="havecontrols">
                     {if $details.status=='Pending'}<td></td>{/if}
                    <td ><a href="?cmd=accounts&action=edit&id={$upgrade.account_id}"><b>{$lang.Upgradeto}:</b> {$upgrade.name}</a></td>
                    <td align="center"> </td>
                    <td align="center">{$upgrade.total|price:$details.currency_id}</td>
                    <td align="center"><span class="{$upgrade.status}">{$lang[$upgrade.status]}</span></td>
                </tr>
                {/foreach}
                {/if}

                {if $details.fieldupgrades}
                {foreach from=$details.fieldupgrades item=upgrade}
                <tr  class="havecontrols">
                     {if $details.status=='Pending'}<td></td>{/if}
                    <td ><a href="?cmd={if $upgrade.rel_type=='Domain'}domains{else}accounts{/if}&action=edit&id={$upgrade.account_id}"><b>{$lang.Upgrade}</b> {$upgrade.catname}:
                            {if $upgrade.qty!=$upgrade.new_qty}
                            {$upgrade.qty} =&gt; {$upgrade.new_qty} x
                            {elseif $upgrade.oldname!=$upgrade.newname}
                            {$upgrade.oldname} =&gt; {$upgrade.newname}
                            {else}
                            =&gt; {$upgrade.new_qty} x
                            {/if}
                        </a></td>
                    <td align="center"> </td>
                    <td align="center">-</td>
                    <td align="center"><span class="{$upgrade.status}">{$lang[$upgrade.status]}</span></td>
                </tr>
                {/foreach}
                {/if}

                {if $details.domains}
                {foreach from=$details.domains item=domain}
                <tr  class="havecontrols">
                    {if $details.status=='Pending'}<td><input type="checkbox" name="domainregister[{$domain.id}]" value="1" checked="checked" value="1"  rel="domainrow{$domain.id}" class="provision domain"/></td>{/if}

                    <td ><a href="?cmd=domains&action=edit&id={$domain.id}"><b>Domain:</b> {$domain.type} - {$domain.name}</a></td>
                    <td align="center">{$domain.period} {$lang.yearslash}</td>
                    <td align="center">{$domain.firstpayment|price:$details.currency_id}</td>
                    <td align="center"><span class="{$domain.status}">{$lang[$domain.status]}</span></td>
                </tr>
                {if $domain.status=='Pending' && $details.status!='Active' }
               
                <tr class="domainrow{$domain.id} provisioning">
                    <td></td>
                    <td colspan="4" style="">
                        <table border="0" cellspacing="0" cellpadding="3" width="100%">
                              <tr>
                                <td width="160">{$lang.Registrar}:</td>
                                <td> <select name="domainmodule[{$domain.id}]">

			{foreach from=$domainmodules item=dom key=id}

                            <option value="{$id}" {if $id==$domain.reg_module}selected="selected"{/if}>{$dom}</option>

			{/foreach}

                        </select></td>
                            </tr>
                            <tr>
                                <td width="160">Nameserver 1</td>
                                <td><input name="nameservers[{$domain.id}][0]" value="{$domain.nameservers[0]}" /></td>
                            </tr>
                            <tr>
                                <td width="160">Nameserver 2</td>
                                <td><input name="nameservers[{$domain.id}][1]" value="{$domain.nameservers[1]}" /></td>
                            </tr>
                            <tr>
                                <td width="160">Nameserver 3</td>
                                <td><input name="nameservers[{$domain.id}][2]" value="{$domain.nameservers[2]}" /></td>
                            </tr>
                            <tr>
                                <td width="160">Nameserver 4</td>
                                <td><input name="nameservers[{$domain.id}][3]" value="{$domain.nameservers[3]}" /></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                {/if}
                {/foreach}
                {/if}
            </tbody>

        </table>

        



        <div style="text-align:center;margin-bottom:7px;padding:15px 0px;" class="p6 secondtd">


            <a onclick="$('input[name=markaccepted]').click(); return false;" href="#" class="menuitm {if $details.status=='Active'}disabled{else}greenbtn{/if}"><span>{$lang.acceptorder}</span></a>
            <a onclick="$('input[name=markcancelled]').click(); return false;" href="#" class="menuitm {if $details.status=='Cancelled'}disabled{/if}"><span>{$lang.cancelorder}</span></a>
            <span class="orspace">{$lang.Or}</span>

            <a onclick="$('input[name=markpending]').click(); return false;" href="#" class="menuitm menuf {if $details.status=='Pending'}disabled{/if}" ><span>{$lang.settopending}</span></a><!--
            --><a onclick="$('input[name=markfraud]').click(); return false;" href="#" class="menuitm menu{if !$forbidAccess.deleteOrders}c{else}l{/if} {if $details.status=='Fraud'}disabled{/if}"><span>{$lang.setasfraud}</span></a><!--
            -->{if !$forbidAccess.deleteOrders}<a href="#" class="menuitm menul"  onclick="return confirm1();"><span style="color:red">{$lang.deleteorder}</span></a>{/if}
        </div>

        {include file='orders/scenario.tpl'}


        {include file='_common/noteseditor.tpl'}
        <script type="text/javascript">AdminNotes.show();AdminNotes.hide();</script>
        

		{if $details.fraudmodule && !$steps}

			{if $details.status=='Fraud'}

        <div class="bigger" style="margin-bottom:10px;"><strong>{$lang.fraudscore}: <span style="color:#FF0000">{$details.fraudout.riskScore}%</span></strong></div>
        <div style="padding:5px;font-size:11px;"  class="lighterblue">
            <table width="100%" cellpadding="2" cellspacing="0">
	{foreach from=$details.fraudout item=f key=k name=checker}
		{if $smarty.foreach.checker.index%3=='0'}<tr>{/if}
                    {if $k!='explanation'} <td width="16%" align="right"><strong>{$k}</strong></td><td width="16%" align="left">{$f}</td>{/if}
                    {if $smarty.foreach.checker.index%3=='5'}</tr>{/if}

	{/foreach}

            </table>

	{if $details.fraudout.explanation}<br /><b>{$lang.Explanation}: </b>{$details.fraudout.explanation}{/if}
        </div>


			{else}
        <div class="bigger" style="margin-bottom:10px;"><strong>{$lang.fraudscore}: <span style="color:#00FF00">{$details.fraudout.riskScore}%</span></strong> <a href="#" onclick="$('#frauddetails').show();ajax_update('?cmd=orders&action=frauddetails&fraudmodule={$details.fraudmodule}&id={$details.id}',{literal}{}{/literal},'#frauddetails',true);$(this).hide();return false;">{$lang.getdetailedinfo} </a></div>
        <div style="padding:5px;display:none;font-size:11px;" id="frauddetails" class="lighterblue"></div>

			{/if}

		{/if}

    </div>

    <div class="blu"><a href="?cmd=orders&list={$currentlist}" ><strong>&laquo; {$lang.backto} {$currentlist} {$lang.orders}</strong></a>
        <div style="display:none"> <input type="submit" {if $details.status=='Active'}disabled=""{/if} name="markaccepted" value="{$lang.acceptorder}" onclick="$('#ticketbody').addLoader()" />
                                          <input type="submit" {if $details.status=='Cancelled'}disabled=""{/if} name="markcancelled" value="{$lang.cancelorder}"/>
                                          <input type="submit" {if $details.status=='Fraud'}disabled=""{/if}  name="markfraud" value="{$lang.setasfraud}"/>
                                          <input type="submit" {if $details.status=='Pending'}disabled=""{/if} name="markpending" value="{$lang.settopending}"/>
                                          <input type="submit"  style="color: #ff0000;" name="delete" value="{$lang.deleteorder}" onclick="return confirm1();"/>
            <input type="submit" name="send" value="{$lang.SendMessage}"></div>
    </div>

    {securitytoken}</form>
<div id="confirm_ord_delete" style="display:none" class="confirm_container">

    <div class="confirm_box">
        <h3>{$lang.orddelheading}</h3>
		{$lang.orddeldescr}<br />
        <br />


        <input type="radio" checked="checked" name="cc_" value="1" id="cc_hard"/> {$lang.deleteopt1}<br />
        <input type="radio"  name="cc_" value="0" id="cc_soft"/> {$lang.deleteopt2}<br />


        <br />
        <center><input type="submit" value="{$lang.Apply}" style="font-weight:bold"  onclick="confirmsubmit2()"/>&nbsp;<input type="submit" value="{$lang.Cancel}" onclick="cancelsubmit2()"/></center>

    </div>
    <script type="text/javascript">
        {literal}
        function confirm1() {
            $('#bodycont').css('position','relative');
            $('#confirm_ord_delete').width($('#bodycont').width()).height($('#bodycont').height()).show();
            return false;
        }
        function confirmsubmit2() {
            var add='';
            if($('#cc_hard').is(':checked'))
                add='&harddelete=true';
            window.location.href='?cmd=orders&delete=1&action=edit&id={/literal}{$details.id}&security_token={$security_token}{literal}'+add;
        }
        function cancelsubmit2() {
            $('#confirm_ord_delete').hide().parent().css('position','inherit');
        }
        {/literal}
    </script>
</div>