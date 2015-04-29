<script type="text/javascript">loadelements.accounts = true;</script>
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter && !$details.manual}class="searchon"{/if}>
    <tr>
        <td ><h3>{$lang.Accounts}</h3></td>
        <td  class="searchbox"><div id="hider2" style="text-align:right">
                <a href="?cmd=accounts&action=getadvanced{if $list_type}&list={$list_type}{/if}" class="fadvanced">{$lang.filterdata}</a> <a href="?cmd=accounts&resetfilter=1" {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>

            </div>
            <div id="hider" style="display:none"></div></td>
    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=orders&amp;action=add"  class="tstyled" style="font-weight: bold">{$lang.newaccount}</a><br />

            <a href="?cmd=accounts&amp;list=all"  class="tstyled {if $currentlist=='all'  || $plist=='all'}selected{/if}">{$lang.allaccounts} <span>({$stats.All.total})</span></a>
            {if $currentlist=='all' || $plist=='all'}
                <a href="?cmd=accounts&amp;list=all_active"  class="tstyled tsubit {if $plist=='all' && $flist=='active'}selected{/if}">{$lang.Active} <span>({if $stats.All.Active}{$stats.All.Active}{else}0{/if})</span></a>
                <a href="?cmd=accounts&amp;list=all_pending"  class="tstyled tsubit {if $plist=='all' && $flist=='pending'}selected{/if}">{$lang.Pending} <span>({if $stats.All.Pending}{$stats.All.Pending}{else}0{/if})</span></a>
                <a href="?cmd=accounts&amp;list=all_suspended"  class="tstyled tsubit {if $plist=='all' && $flist=='suspended'}selected{/if}">{$lang.Suspended} <span>({if $stats.All.Suspended}{$stats.All.Suspended}{else}0{/if})</span></a>
                <a href="?cmd=accounts&amp;list=all_terminated"  class="tstyled tsubit {if $plist=='all' && $flist=='terminated'}selected{/if}">{$lang.Terminated} <span>({if $stats.All.Terminated}{$stats.All.Terminated}{else}0{/if})</span></a>
                <a href="?cmd=accounts&amp;list=all_cancelled"  class="tstyled tsubit {if $plist=='all' && $flist=='cancelled'}selected{/if}">{$lang.Cancelled} <span>({if $stats.All.Cancelled}{$stats.All.Cancelled}{else}0{/if})</span></a>
                <a href="?cmd=accounts&amp;list=all_fraud"  class="tstyled tsubit {if $plist=='all' && $flist=='fraud'}selected{/if}">{$lang.Fraud} <span>({if $stats.All.Fraud}{$stats.All.Fraud}{else}0{/if})</span></a>
            {/if}

            {foreach from=$stats item=stat key=k}
                {if $k!='All'}

                    {assign var="descr" value="_hosting"}
                    {assign var="baz" value="$k$descr"}
                    <a href="?cmd=accounts&amp;list={$k}"  class="tstyled {if $currentlist==$k || $plist==$k}selected{/if}">{if $lang.$baz}{$lang.$baz}{else}{$k}{/if} <span>({$stat.total})</span></a>
                    {if $currentlist==$k || $plist==$k}
                        <a href="?cmd=accounts&amp;list={$k}_active"  class="tstyled tsubit {if $plist==$k && $flist=='active' }selected{/if}">{$lang.Active} <span>({if $stat.Active}{$stat.Active}{else}0{/if})</span></a>
                        <a href="?cmd=accounts&amp;list={$k}_pending"  class="tstyled tsubit {if  $plist==$k && $flist=='pending'}selected{/if}">{$lang.Pending} <span>({if $stat.Pending}{$stat.Pending}{else}0{/if})</span></a>
                        <a href="?cmd=accounts&amp;list={$k}_suspended"  class="tstyled tsubit {if  $plist==$k && $flist=='suspended'}selected{/if}">{$lang.Suspended} <span>({if $stat.Suspended}{$stat.Suspended}{else}0{/if})</span></a>
                        <a href="?cmd=accounts&amp;list={$k}_terminated"  class="tstyled tsubit {if  $plist==$k && $flist=='terminated'}selected{/if}">{$lang.Terminated} <span>({if $stat.Terminated}{$stat.Terminated}{else}0{/if})</span></a>
                        <a href="?cmd=accounts&amp;list={$k}_cancelled"  class="tstyled tsubit {if  $plist==$k && $flist=='cancelled'}selected{/if}">{$lang.Cancelled} <span>({if $stat.Cancelled}{$stat.Cancelled}{else}0{/if})</span></a>
                        <a href="?cmd=accounts&amp;list={$k}_fraud"  class="tstyled tsubit {if  $plist==$k && $flist=='fraud'}selected{/if}">{$lang.Fraud}
                            <span>({if $stat.Fraud}{$stat.Fraud}{else}0{/if})</span>
                        </a>
                    {/if}
                {/if}
            {/foreach}

            {literal}
                <script type="text/javascript">
                    appendLoader('loadCancelRequests');
                    function loadCancelRequests() {
                        ajax_update('?cmd=accounts&action=cancelrequests', false, '#cancel_requests');
                    }
                </script>
            {/literal}
            <div id="cancel_requests"></div>
        </td>

        <td  valign="top"  class="bordered">
            <div id="bodycont">


                {if $action=='edit' && $details}


                    {if $typetemplates.adminaccounts.details.replace}
                        {include file=$typetemplates.adminaccounts.details.replace}
                    {else}
                        {assign var="descr" value="_hosting"}
                        {assign var="baz" value="$plist$descr"}

                        <form action="" method="post" id="account_form" >

                            <input type="hidden" name="account_id" value="{$details.id}" id="account_id" />
                            <div class="blu">
                                <table border="0" cellpadding="2" cellspacing="0" >
                                    <tr>
                                        <td class="menubar"><a href="?cmd=accounts&list={$currentlist}"><strong>&laquo; {$lang.backto} {$lang.accounts}</strong></a>&nbsp;
                                        <input type="submit" name="save" value="{$lang.savechanges}" style="font-weight:bold;display:none" id="formsubmiter"/>
                                        <a class="menuitm"   href="#" onclick="$('#formsubmiter').click();return false" ><span ><strong>{$lang.savechanges}</strong></span></a>

                                        {if !$forbidAccess.deleteServices}
                                            <a class=" menuitm menuf" href="#" onclick="confirm1();return false;"><span style="color:#FF0000">{$lang.Delete}</span></a>{*
                                        *}{/if}{*
                                        *}<a class="setStatus menuitm menu{if !$forbidAccess.deleteOrders}l{/if}" id="hd1" onclick="return false;" href="#" ><span class="morbtn">{$lang.moreactions}</span></a>     
                                        <td><input type="checkbox" name="manual" value="1" {if $details.manual == '1'}checked="checked" {/if}  id="changeMode" style="display:none"/></td>
                                    </tr>
                                </table>
                                <ul id="hd1_m" class="ddmenu">
                                    <li ><a href="AdminNotes">{$lang.editadminnotes}</a></li>
                                    <li ><a href="ChangeOwner">{$lang.changeowner}</a></li></ul>
                            </div>

                            <div class="lighterblue" id="ChangeOwner" style="display:none;padding:5px;">
                            </div>



                            <div id="ticketbody">
                                <h1>{$lang.accounthash}{$details.id}</h1>

                                {include file='_common/accounts_cancelrequest.tpl'}


                                <div id="client_nav">
                                    <!--navigation-->
                                    <a class="nav_el nav_sel left" href="#">{$lang.accountbdetails}</a>
                                    <a class="nav_el  left" href="?cmd=accounts&action=log&id={$details.id}" onclick="return false">{$lang.accountlog}</a>
                                    {include file="_common/quicklists.tpl"}


                                    <div class="clear"></div>
                                </div>
                                <div class="ticketmsg ticketmain" id="client_tab">
                                    <div class="slide" style="display:block">
                                        <table cellspacing="2" cellpadding="3" border="0" width="100%">
                                            <tbody>
                                                <tr>
                                                    <td width="15%" >{$lang.orderid}</td>
                                                    <td width="35%"><a href="?cmd=orders&action=edit&id={$details.order_id}">{$details.order_id}</a></td>
                                                    <td width="15%" >{$lang.paymethod}</td>
                                                    <td width="35%"><select name="payment_module" onclick="new_gateway(this)">
                                                            <option value="0">{$lang.none}</option>
                                                            {foreach from=$gateways item=module key=id}
                                                                <option value="{$id}" {if $details.payment_module==$id}selected="selected"{/if}>{$module}</option>
                                                            {/foreach}
                                                            <option value="new" style="font-weight: bold">{$lang.newgateway}</option>

                                                        </select></td>
                                                </tr>
                                                <tr>
                                                    <td >{$lang.Client}</td>
                                                    <td ><a href="?cmd=clients&action=show&id={$details.client_id}">{$details.lastname} {$details.firstname}</a> </td>
                                                    <td >{$lang.billingcycle}</td>
                                                    <td ><select name="billingcycle">
                                                            <option value="Free" {if $details.billingcycle=='Free'}selected='selected'{/if}>{$lang.Free}</option>
                                                            <option value="One Time" {if $details.billingcycle=='One Time'}selected='selected'{/if}>{$lang.OneTime}</option>
                                                            <option  value="Hourly" {if $details.billingcycle=='Hourly'}selected='selected'{/if}>{$lang.Hourly}</option>
                                                            <option  value="Daily" {if $details.billingcycle=='Daily'}selected='selected'{/if}>{$lang.Daily}</option>
                                                            <option  value="Weekly" {if $details.billingcycle=='Weekly'}selected='selected'{/if}>{$lang.Weekly}</option>
                                                            <option  value="Monthly" {if $details.billingcycle=='Monthly'}selected='selected'{/if}>{$lang.Monthly}</option>
                                                            <option value="Quarterly" {if $details.billingcycle=='Quarterly'}selected='selected'{/if}>{$lang.Quarterly}</option>
                                                            <option value="Semi-Annually" {if $details.billingcycle=='Semi-Annually'}selected='selected'{/if}>{$lang.SemiAnnually} </option>
                                                            <option value="Annually" {if $details.billingcycle=='Annually'}selected='selected'{/if}>{$lang.Annually} </option>
                                                            <option value="Biennially" {if $details.billingcycle=='Biennially'}selected='selected'{/if}>{$lang.Biennially} </option>
                                                            <option value="Triennially" {if $details.billingcycle=='Triennially'}selected='selected'{/if}>{$lang.Triennially} </option>
                                                        </select>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td >{$lang.regdate}</td>
                                                    <td ><input type="text" class="haspicker" value="{$details.date_created|dateformat:$date_format}" name="date_created" size="12" /></td>
                                                    <td >{$lang.next_due}</td>
                                                    <td ><input type="text" class="haspicker" value="{$details.next_due|dateformat:$date_format}" name="next_due" size="12" /> <a class="editbtn" href="?cmd=invoices&filter[item_id]={$details.id}&filter[type]=Hosting" >{$lang.findrelatedinv}</a></td>
                                                </tr>
                                                <tr>
                                                    <td >{$lang.Addons}</td>
                                                    <td ><span id="numaddons">{$details.addons}</span> {$lang.addons_plu}</td>
                                                    <td >{$lang.firstpayment}</td>
                                                    <td >{$details.currency.sign}<input type="text" value="{$details.firstpayment}" name="firstpayment" size="10"/></td>
                                                </tr>

                                                <tr>
                                                    <td >{$lang.Status}</td>
                                                    <td >
                                                        <select name="status" {if $details.manual != '1'}style="display:none"{/if} class="manumode">
                                                            <option {if $details.status == 'Pending'}selected="selected" {/if} value="Pending">{$lang.Pending}</option>
                                                            <option {if $details.status == 'Active'}selected="selected" {/if} value="Active">{$lang.Active}</option>
                                                            <option {if $details.status == 'Suspended'}selected="selected" {/if}  value="Suspended">{$lang.Suspended}</option>
                                                            <option {if $details.status == 'Terminated'}selected="selected" {/if}  value="Terminated">{$lang.Terminated}</option>
                                                            <option {if $details.status == 'Cancelled'}selected="selected" {/if}  value="Cancelled">{$lang.Cancelled}</option>
                                                            <option {if $details.status == 'Fraud'}selected="selected" {/if}  value="Fraud">{$lang.Fraud}</option>
                                                        </select>

                                                        <span class="{$details.status} livemode" {if $details.manual == '1'}style="display:none"{/if}><strong>{$lang[$details.status]}</strong></span>
                                                    </td>
                                                    <td >{$lang.recurring}</td>
                                                    <td >{$details.currency.sign}<input type="text" value="{$details.total}" name="total" size="10"/></td>
                                                </tr>

                                            </tbody>
                                        </table>
                                    </div>
                                    {include file="_common/quicklists.tpl" _placeholder=true}
                                </div>

                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td width="100%" valign="top">
                                            <ul class="accor">
                                                <li><a href="#">{$lang.accountdetails}</a>
                                                    <div class="sor">

                                                        {include file='_common/accounts_details.tpl'}
                                                    </div>
                                                </li>
                                            </ul>
                                            <ul class="accor" id="dommanager" style="display:none;margin-bottom:5px;">
                                                <li><a href="#" id="man_title"></a>
                                                    <div class="sor" id="man_content"></div>
                                                </li>
                                            </ul>


                                        </td></tr>
                                    <tr>


                                        <td  valign="top" width="100%">

                                            {if $custom_template}
                                                {include file=$custom_template}
                                            {/if}
                                            <ul class="accor">
                                                <li><a href="#">{$lang.accaddons}</a>
                                                    {include file='_common/accounts_addons.tpl'}
                                                </li>
                                            </ul>
                                            <br />
                                            {include file='_common/accounts_extrabilling.tpl'}
                                            {include file='_common/accounts_multimodules.tpl'}
                                            {include file='_common/noteseditor.tpl'}
                                            
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="blu">{include file='_common/accounts_nav.tpl'}</div>
                            {securitytoken}
                        </form>


                    {/if}

                {else}
                    <form action="" method="post" id="testform" >
                        <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
                        <div class="blu">
                            <div class="right"><div class="pagination"></div></div>
                            <div class="left menubar">
                                {$lang.withselected}
                                <a class="submiter menuitm menuf" name="create" {if $enablequeue}queue='push'{/if}  href="#" ><span><strong>{$lang.Activate}</strong></span></a>{*
                                *}<a class="submiter menuitm menuc" name="suspend" {if $enablequeue}queue='push'{/if} href="#" ><span>{$lang.Suspend}</span></a>{*
                                *}<a class="submiter menuitm menuc" {if $enablequeue}queue='push'{/if} name="unsuspend"  href="#" ><span>{$lang.Unsuspend}</span></a>{*
                                *}<a class="submiter menuitm confirm menul" name="delete" {if $enablequeue}queue='push'{/if}  href="#" ><span style="color:#FF0000">{$lang.Terminate}</span></a>{*
                                *}<a class="menuitm setStatus" id="hd1" onclick="return false;"   href="#" ><span class="morbtn">{$lang.moreactions}</span></a>
                                <ul id="hd1_m" class="ddmenu">
                                    <li><a href="#" onclick="return send_msg('accounts')">{$lang.SendMessage}</a></li>
                                    <li><a href="#" onclick="return send_msg('accounts_ticket')">Create Tickets</a></li>
                                    {if !$forbidAccess.deleteServices}<li><a href="Delete">{$lang.delete|ucfirst}</a></li>
                                        {/if}
                                </ul>
                            </div>
                            <div class="clear"></div>
                        </div>

                        <a href="?cmd=accounts&list={$currentlist}" id="currentlist" style="display:none"  updater="#updater"></a>
                        {if $custolist_dir}
                            {include file="`$custolist_dir`admin_list.tpl"}
                        {else}
                            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
                                <tbody>
                                    <tr>
                                        <th width="20"><input type="checkbox" id="checkall"/></th>
                                        <th><a href="?cmd=accounts&list={$currentlist}&orderby=id|ASC" class="sortorder">{$lang.accounthash}</a></th>
                                        <th><a href="?cmd=accounts&list={$currentlist}&orderby=lastname|ASC"  class="sortorder">{$lang.clientname}</a></th>
                                        <th><a href="?cmd=accounts&list={$currentlist}&orderby=domain|ASC"  class="sortorder">{$lang.Domain}</a></th>
                                        <th><a href="?cmd=accounts&list={$currentlist}&orderby=name|ASC"  class="sortorder">{$lang.Service}</a></th>
                                        <th><a href="?cmd=accounts&list={$currentlist}&orderby=total|ASC"  class="sortorder">{$lang.Price}</a></th>
                                        <th><a href="?cmd=accounts&list={$currentlist}&orderby=billingcycle|ASC"  class="sortorder">{$lang.billingcycle}</a></th>
                                        <th><a href="?cmd=accounts&list={$currentlist}&orderby=status|ASC"  class="sortorder">{$lang.Status}</a></th>
                                        <th><a href="?cmd=accounts&list={$currentlist}&orderby=next_due|ASC"  class="sortorder">{$lang.nextdue}</a></th>
                                        <th width="20"/>
                                    </tr>
                                </tbody>
                                <tbody id="updater">

                                    {include file='ajax.accounts.tpl'}
                                </tbody>
                                <tbody id="psummary">
                                    <tr>
                                        <th></th>
                                        <th colspan="9">
                                            {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                                        </th>
                                    </tr>
                                </tbody>
                            </table>
                        {/if}
                        <div class="blu">
                            <div class="right"><div class="pagination"></div></div>
                            <div class="left menubar">

                                {$lang.withselected}
                                <a class="submiter menuitm menuf" name="create" {if $enablequeue}queue='push'{/if}  href="#" ><span ><strong>{$lang.Activate}</strong></span></a>{*
                                *}<a class="submiter menuitm menuc" name="suspend" {if $enablequeue}queue='push'{/if} href="#" ><span>{$lang.Suspend}</span></a>{*
                                *}<a class="submiter menuitm menuc" {if $enablequeue}queue='push'{/if} name="unsuspend"  href="#" ><span>{$lang.Unsuspend}</span></a>{*
                                *}<a class="submiter menuitm confirm menul" name="delete" {if $enablequeue}queue='push'{/if}  href="#" ><span style="color:#FF0000">{$lang.Terminate}</span></a>{*
                                *}<a class="menuitm setStatus" id="hd1" onclick="return false;"   href="#" ><span class="morbtn">{$lang.moreactions}</span></a>
                            </div>
                            <div class="clear"></div>
                        </div>
                        {securitytoken}
                    </form>
                    <div id="confirm_ord_delete" style="display:none" class="confirm_container">

                        <div class="confirm_box">
                            <h3>{$lang.accdelheading}</h3>
                            {$lang.accdeldescr}<br />
                            <br />


                            <input type="radio" checked="checked" name="cc_" value="1" id="cc_hard"/> {$lang.deleteopt1}<br />
                            <input type="radio"  name="cc_" value="0" id="cc_soft"/> {$lang.deleteopt2}<br />


                            <br />
                            <center><input type="submit" value="{$lang.Apply}" style="font-weight:bold"  onclick="return confirmsubmit2()"/>&nbsp;<input type="submit" value="{$lang.Cancel}" onclick="return cancelsubmit2()"/></center>

                        </div>
                    </div>
                    {literal} 
                        <script type="text/javascript">

            function confirm1() {
                $('#bodycont').css('position', 'relative');
                $('#confirm_ord_delete').width($('#bodycont').width()).height($('#bodycont').height()).show();
                return false;
            }
            function confirmsubmit2() {
                var add = '';
                if ($('#cc_hard').is(':checked'))
                    add = '&harddelete=true';
                ajax_update('?cmd=accounts&make=fulldelete&' + $.param($("#testform input[class=check]:checked")) + add, {stack: 'push'});
                cancelsubmit2();
                return false;
            }
            function cancelsubmit2() {
                $('#confirm_ord_delete').hide().parent().css('position', 'inherit');
                return false;
            }
                        </script>
                    {/literal}
                {/if}
            </div>
        </td>
    </tr>
</table>