<script type="text/javascript" src="{$system_url}templates/common/facebox/facebox.js"></script>
<link rel="stylesheet" href="{$system_url}templates/common/facebox/facebox.css" type="text/css" />
<script type="text/javascript">{literal} 

	function metteredBillinghistory() {
                $('#meteredusagelog').addLoader();
		var url={/literal}'?cmd=accounts&action=edit&id={$details.id}&service={$details.id}&do=metered_history';{literal};
		ajax_update(url,{metered_period:$('#metered_period').val()},'#meteredusagelog');
		return false;
	}
    function bindMe() {
        $('#tabbedmenu').TabbedMenu({elem:'.tab_content',picker:'li.tpicker',aclass:'active'});
    }
    appendLoader('bindMe');
    {/literal}</script>

<form action="" method="post" id="account_form" >
    <input type="hidden" value="{$details.firstpayment}" name="firstpayment" />
    <input type="hidden" name="account_id" value="{$details.id}" id="account_id" />
    <div class="blu">
        <table border="0" cellpadding="2" cellspacing="0" >
            <tr>
                <td class="menubar"><a href="?cmd=accounts&list={$currentlist}"><strong>&laquo; {$lang.backto} {$lang.accounts}</strong></a>&nbsp;
                    <input type="submit" name="save" value="{$lang.savechanges}" style="font-weight:bold;display:none"  id="formsubmiter"/>
                    <a   class="menuitm"   href="#" onclick="$('#formsubmiter').click();return false" ><span ><strong>{$lang.savechanges}</strong></span></a>
                    <a   class=" menuitm menuf"    href="#" onclick="confirm1();return false;"><span style="color:#FF0000">{$lang.Delete}</span></a><a   class="setStatus menuitm menul" id="hd1" onclick="return false;"   href="#" ><span class="morbtn">{$lang.moreactions}</span></a>
                <td><input type="checkbox" name="manual" value="1" {if $details.manual == '1'}checked="checked" {/if}  id="changeMode" style="display:none"/></td>
            </tr>
        </table>
        <ul id="hd1_m" class="ddmenu">
            <li ><a href="AdminNotes">{$lang.editadminnotes}</a></li>
            <li ><a href="ChangeOwner">{$lang.changeowner}</a></li></ul>
    </div>

    <div class="lighterblue" id="ChangeOwner" style="display:none;padding:5px;"></div>



    <div id="ticketbody" >
        <h1>{$lang.accounthash}{$details.id}</h1>

        {include file='_common/accounts_cancelrequest.tpl'}


        <div id="client_nav">
            <!--navigation-->
            <a class="nav_el nav_sel left" href="#">{$lang.accountbdetails}</a>
            <a class="nav_el  left" href="?cmd=accounts&action=log&id={$details.id}" onclick="return false">{$lang.accountlog}</a>
            <div class="left">
                <span class="left" style="padding-top:5px;padding-left:5px;"><strong>{$details.lastname} {$details.firstname} 购买的业务:</strong>&nbsp;&nbsp;</span>

                {if $enableFeatures.profiles=='on'}<a class="nav_el  left"  href="?cmd=clients&action=clientcontacts&id={$details.client_id}" onclick="return false" >{$lang.Contacts}</a> {/if}
                <a class="nav_el  left"  href="?cmd=orders&action=clientorders&id={$details.client_id}" onclick="return false">{$lang.Orders}</a>
                <a class="nav_el  left"  href="?cmd=accounts&action=clientaccounts&id={$details.client_id}" onclick="return false">{$lang.Services}</a>
                <a class="nav_el  left" href="?cmd=domains&action=clientdomains&id={$details.client_id}" onclick="return false">{$lang.Domains}</a>
                <a class="nav_el  left" href="?cmd=invoices&action=clientinvoices&id={$details.client_id}" onclick="return false">{$lang.Invoices}</a>
                <a class="nav_el  left" href="?cmd=invoices&action=clientinvoices&id={$details.client_id}&currentlist=recurring" onclick="return false">{$lang.Recurringinvoices}</a>

		  {if $enableFeatures.estimates=='on'}<a class="nav_el  left" href="?cmd=estimates&action=clientestimates&id={$details.client_id}" onclick="return false">{$lang.Estimates}</a>{/if}

                <a class="nav_el  left" href="?cmd=transactions&action=clienttransactions&id={$details.client_id}" onclick="return false">{$lang.Transactions}</a>
                <a class="nav_el  left" href="?cmd=tickets&action=clienttickets&id={$details.client_id}" onclick="return false">{$lang.Tickets}</a>
                <a class="nav_el  left" href="?cmd=emails&action=clientemails&id={$details.client_id}" onclick="return false">{$lang.Emails}</a>
                <a class="nav_el direct left" href="?cmd=clients&action=show&id={$details.client_id}">{$lang.Profile}</a>

            </div>


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
                            <td >{if $metered_enable}Generate invoices{else}{$lang.billingcycle}{/if}</td>
                            <td ><select name="billingcycle">
                                    <option value="Free" {if $details.billingcycle=='Free'}selected='selected'{/if}>{if $metered_enable}Off{else}{$lang.Free}{/if}</option>
                                    {if !$metered_enable}<option value="One Time" {if $details.billingcycle=='One Time'}selected='selected'{/if}>{$lang.OneTime}</option>{/if}
                                    <option  value="Hourly" {if $details.billingcycle=='Hourly'}selected='selected'{/if}>{$lang.Hourly}</option>
                                    <option  value="Daily" {if $details.billingcycle=='Daily'}selected='selected'{/if}>{$lang.Daily}</option>
                                    <option  value="Weekly" {if $details.billingcycle=='Weekly'}selected='selected'{/if}>{$lang.Weekly}</option>
                                    <option  value="Monthly" {if $details.billingcycle=='Monthly'}selected='selected'{/if}>{$lang.Monthly}</option>
                                    <option value="Quarterly" {if $details.billingcycle=='Quarterly'}selected='selected'{/if}>{$lang.Quarterly}</option>
                                    <option value="Semi-Annually" {if $details.billingcycle=='Semi-Annually'}selected='selected'{/if}>{$lang.SemiAnnually} </option>
                                    <option value="Annually" {if $details.billingcycle=='Annually'}selected='selected'{/if}>{$lang.Annually} </option>
                                    <option value="Biennially" {if $details.billingcycle=='Biennially'}selected='selected'{/if}>{$lang.Biennially} </option>
                                    <option value="Triennially" {if $details.billingcycle=='Triennially'}selected='selected'{/if}>{$lang.Triennially} </option>
                                </select></td>
                        </tr>
                        <tr>
                            <td >{$lang.regdate}</td>
                            <td ><input type="text" class="haspicker" value="{$details.date_created|dateformat:$date_format}" name="date_created" size="12" /></td>
                            <td >{$lang.next_due}</td>
                            <td ><input type="text" class="haspicker" value="{$details.next_due|dateformat:$date_format}" name="next_due" size="12" /> <a class="editbtn" href="?cmd=invoices&filter[item_id]={$details.id}&filter[type]=Hosting" >{$lang.findrelatedinv}</a></td>
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
                            <td >{if $metered_enable}Next invoice total{else}{$lang.recurring}{/if}</td>
                            <td >{if $metered_enable}<b>{$details.metered_total|price:$details.currency}</b><a href="#" onclick="$('#tabbedmenu .tpicker').eq(1).click().ShowNicely();$('.tab_content').eq(1).ShowNicely();return false" class="editbtn orspace">Details</a><input type="hidden" value="0.00" name="total"/>{else}<input type="text" value="{$details.total}" name="total" size="10"/>{/if}</td>
                        </tr>

                    </tbody>
                </table>
            </div>
            {if $enableFeatures.profiles=='on'}<div class="slide">Loading</div>{/if}
            <div class="slide">Loading</div>
            <div class="slide">Loading</div>
            <div class="slide">Loading</div>
		  {if $enableFeatures.estimates=='on'}<div class="slide">Loading</div>{/if}
            <div class="slide">Loading</div>  <div class="slide">Loading</div><div class="slide">Loading</div>
            <div class="slide">Loading</div> <div class="slide">Loading</div><div class="slide">Loading</div>
        </div>



        <ul class="tabs" id="tabbedmenu">
            <li class="tpicker active"><a href="#tab1" onclick="return false">配置</a></li>
            <li class="tpicker"><a href="#tab2" onclick="return false">计费周期</a></li>
            <li class="tpicker"><a href="#tab2" onclick="return false">用户域名<span  class="top_menu_count">{$user_domains_cnt}</span> </a></li>
            <li class="tpicker"><a href="#tab3" onclick="return false">增值服务<span id="numaddons" class="top_menu_count">{$details.addons}</span> </a></li>
        </ul>
        <div class="tab_container">

            <div class="tab_content" style="display: block;">
                {include file='_common/accounts_details.tpl'}

            </div>
            <div class="tab_content" style="display: none;">
                <!--metered billing start-->
                {if !$metered_enable}
                    该套餐不适用此计费方式, <a href="?cmd=services&action=product&id={$details.product_id}" target="_blank">点击管理产品单价.</a>
                {else}
                <table class="whitetable" width="100%" cellspacing="0" cellpadding="3">
                    <tr class="odd havecontrols">
                        <td width="16%" align="right"><b>计费方式</b></td>
                        <td width="16%">{$details.previous_invoice|dateformat:$date_format} - {$details.next_invoice|dateformat:$date_format}</td>
                   
                        <td width="16%" align="right"><b>下一次账单总额</b></td>
                        <td width="16%"><b>{$summary.charge|price:$details.currency_id}</b>
                            <br><span class="fs11">{$user_domains_cnt} domains x {$curent_price|price:$details.currency_id:true:true}/domain</span></td>
                    
                        <td width="16%" align="right"><b>当前价格/域名</b></td>
                        <td width="16%">{$curent_price|price:$details.currency_id:true:true}</td>
                    </tr>
                    <tr class="even">
                        <td colspan="4"></td>
                        <td colspan="2" style="text-align:right">月 (yyyy-mm): <select name="metered_period" id="metered_period" onchange="metteredBillinghistory()">
                                {foreach from=$metered_periods item=p}
                                    <option value="{$p}">{$p}</option>
                                {/foreach}
                            </select></td>
                    </tr>
                </table>
                {if $metered_usage_log}<div id="meteredusagelog">{include file='_common/accounts_meteredtable.tpl'}</div>
                <br/><b>图例</b>
                <table class="whitetable" width="100%" cellspacing="0" cellpadding="3">
                    {foreach from=$metered_usage_log.variables item=vr}
                        <tr class="even">
                            <td width="150"><b>{$vr.name}</b></td>
                            <td>{$vr.description}</td>

                        </tr>
                    {/foreach}
                </table>

                {else}
                <table class="whitetable" width="100%" cellspacing="0" cellpadding="3">
                    <tr class="odd havecontrols">
                        <td align="center"><b>尚无任何报告</b></td>
                    </tr>

                </table>

                {/if}
              
               
                {/if}
                <!--eof: metered billing -->
            </div>
            <div class="tab_content" style="display: none;">
                <table cellspacing="0" cellpadding="3" border="0" width="100%" class="whitetable">
                    <thead>
                        <tr>
                            <th align="left">域名</th>
                            <th width="150">注册日期</th>
                                    {if $metered_enable}<th width="80">价格</th>{/if}
                            <th width="80"></th>
                        </tr>
                    </thead>

                    {if $user_domains}	<tbody>
                            {foreach from=$user_domains item=domain name=row}
                        <tr {if  $smarty.foreach.row.index%2 == 0}class="even"{else}class="odd"{/if}>
                            <td align="left"><a target="_blank" href="../?action=adminlogin&id={$details.client_id}&redirect=%3Fcmd%3Dclientarea%26action%3dservices%26service%3d{$details.id}%26act%3ddns_manage%26domain_id%3d{$domain.rawoutput}">{$domain.output}</a></td>
                            <td>{if $domain.date_created}{$domain.date_created|dateformat:$date_format}{else}-{/if}</td>
                                    {if $metered_enable}<td>{if $domain.charge}{$domain.charge|price:$domain.currency_id}{else}-{/if}</td> {/if}
                                    <td><a target="_blank" href="../?action=adminlogin&id={$details.client_id}&redirect=%3Fcmd%3Dclientarea%26action%3dservices%26service%3d{$details.id}%26act%3ddns_manage%26domain_id%3d{$domain.rawoutput}" class="editbtn">View zone</a></td>
                        </tr>
                            {/foreach}
                    </tbody>

                    <tbody>
                        <tr>
                            <th colspan="{if $metered_enable}1{else}3{/if}" style="font-weight:normal">域名数量:  <b {if $dom_limit && $user_domains_cnt==$dom_limit}style="color:red"{/if}>{$user_domains_cnt}</b> 最大允许: <b>{$dom_limit}</b></th>
                           {if $metered_enable}
                           <th align="right" style="text-align:right">Total:</th>
                           <th colspan="2" > <b>{$details.metered_total|price:$details.currency}</b></th>{/if}
                        </tr>
                    </tbody>
                        {else}
                        <tbody>
                            <tr>
                                <td colspan="{if $metered_enable}5{else}4{/if}" align="center">尚无任何域名</td>
                            </tr>
                       </tbody>

                        {/if}

                </table>

            </div>
            <div class="tab_content" style="display: none;">
                {include file='_common/accounts_addons.tpl'}
            </div>
        </div>

        <div class="clear"></div>
        {include file='_common/accounts_multimodules.tpl'}
        {include file='_common/noteseditor.tpl'}

    </div>



    <div class="blu">{include file='_common/accounts_nav.tpl'}</div>
    {securitytoken}
</form>