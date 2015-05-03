{literal}
    <script type="text/javascript">
        function bindMe() {
            $('#tabbedmenu').TabbedMenu({elem:'.tab_content',picker:'li.tpicker',aclass:'active'});
        }
        appendLoader('bindMe');
    </script>
{/literal}
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

    <div class="lighterblue" id="ChangeOwner" style="display:none;padding:5px;">
    </div>

    <div id="ticketbody" >
        <h1>{$lang.accounthash}{$details.id}</h1>
        {include file='_common/accounts_cancelrequest.tpl'}
        <div id="client_nav">
            <!--navigation-->
            <a class="nav_el nav_sel left" href="#">{$lang.accountbdetails}</a>
            <a class="nav_el  left" href="?cmd=accounts&action=log&id={$details.id}" onclick="return false">{$lang.accountlog}</a>
            <div class="left">
                <span class="left" style="padding-top:5px;padding-left:5px;"><strong>{$details.firstname} {$details.lastname}'s:</strong>&nbsp;&nbsp;</span>

                {if $enableFeatures.profiles=='on'}
                    <a class="nav_el  left"  href="?cmd=clients&action=clientcontacts&id={$details.client_id}" onclick="return false" >{$lang.Contacts}</a> 
                {/if}
                <a class="nav_el  left"  href="?cmd=orders&action=clientorders&id={$details.client_id}" onclick="return false">{$lang.Orders}</a>
                <a class="nav_el  left"  href="?cmd=accounts&action=clientaccounts&id={$details.client_id}" onclick="return false">{$lang.Services}</a>
                <a class="nav_el  left" href="?cmd=domains&action=clientdomains&id={$details.client_id}" onclick="return false">{$lang.Domains}</a>
                <a class="nav_el  left" href="?cmd=invoices&action=clientinvoices&id={$details.client_id}" onclick="return false">{$lang.Invoices}</a>
                <a class="nav_el  left" href="?cmd=invoices&action=clientinvoices&id={$details.client_id}&currentlist=recurring" onclick="return false">{$lang.Recurringinvoices}</a>

                {if $enableFeatures.estimates=='on'}
                    <a class="nav_el  left" href="?cmd=estimates&action=clientestimates&id={$details.client_id}" onclick="return false">{$lang.Estimates}</a>
                {/if}

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
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td >{$lang.Client}</td>
                            <td ><a href="?cmd=clients&action=show&id={$details.client_id}">{$details.firstname} {$details.lastname}</a> </td>
                            <td >{if $metered_enable}Generate invoices{else}{$lang.billingcycle}{/if}</td>
                            <td ><select name="billingcycle" {if $details.metered_type=='PrePay'}style="display:none"{/if}>
                                    <option value="Free" {if $details.billingcycle=='Free'}selected='selected'{/if}>{if $metered_enable}Off{else}{$lang.Free}{/if}</option>
                                {if !$metered_enable}<option value="One Time" {if $details.billingcycle=='One Time'}selected='selected'{/if}>{$lang.OneTime}</option>
                                    <option  value="Hourly" {if $details.billingcycle=='Hourly'}selected='selected'{/if}>{$lang.Hourly}</option>{/if}
                                    <option  value="Daily" {if $details.billingcycle=='Daily'}selected='selected'{/if}>{$lang.Daily}</option>
                                    <option  value="Weekly" {if $details.billingcycle=='Weekly'}selected='selected'{/if}>{$lang.Weekly}</option>
                                    <option  value="Monthly" {if $details.billingcycle=='Monthly'}selected='selected'{/if}>{$lang.Monthly}</option>
                                    <option value="Quarterly" {if $details.billingcycle=='Quarterly'}selected='selected'{/if}>{$lang.Quarterly}</option>
                                    <option value="Semi-Annually" {if $details.billingcycle=='Semi-Annually'}selected='selected'{/if}>{$lang.SemiAnnually} </option>
                                    <option value="Annually" {if $details.billingcycle=='Annually'}selected='selected'{/if}>{$lang.Annually} </option>
                                    <option value="Biennially" {if $details.billingcycle=='Biennially'}selected='selected'{/if}>{$lang.Biennially} </option>
                                    <option value="Triennially" {if $details.billingcycle=='Triennially'}selected='selected'{/if}>{$lang.Triennially} </option>
                                </select>
                                {if $details.metered_type=='PrePay'}
                                    <em>On low credit</em>
                                {/if}
                            </td>
                        </tr>
                        <tr>
                            <td >{$lang.regdate}</td>
                            <td ><input type="text" class="haspicker" value="{$details.date_created|dateformat:$date_format}" name="date_created" size="12" /></td>
                            <td >{$lang.next_due}</td>
                            <td ><input type="text" class="haspicker" value="{$details.next_due|dateformat:$date_format}" name="next_due" size="12" {if $details.metered_type=='PrePay'}style="display:none"{/if}/> <a class="editbtn" href="?cmd=invoices&filter[item_id]={$details.id}&filter[type]=Hosting" >{$lang.findrelatedinv}</a></td>
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
                            {if $details.metered_type=='PrePay'}<td colspan="2"></td>
                            {else}
                                <td >{if $metered_enable}Next invoice total{else}{$lang.recurring}{/if}</td>
                                <td >{if $metered_enable}<b>{$details.metered_total|price:$currency}</b><a href="#" onclick="$('#tabbedmenu .tpicker').eq(1).click().ShowNicely();$('.tab_content').eq(1).ShowNicely();return false" class="editbtn orspace">Details</a>{else}<input type="text" value="{$details.total}" name="total" size="10"/>{/if}</td>
                                {/if}
                        </tr>

                    </tbody>
                </table>
            </div>
            {if $enableFeatures.profiles=='on'}<div class="slide">Loading</div>
            {/if}
            <div class="slide">Loading</div>
            <div class="slide">Loading</div>
            <div class="slide">Loading</div>
            {if $enableFeatures.estimates=='on'}<div class="slide">Loading</div>
            {/if}
            <div class="slide">Loading</div>  <div class="slide">Loading</div><div class="slide">Loading</div>
            <div class="slide">Loading</div> <div class="slide">Loading</div><div class="slide">Loading</div>
        </div>

        <ul class="tabs" id="tabbedmenu">
            <li class="tpicker active"><a href="#tab1" onclick="return false">Provisioning</a></li>
            {if $provisioning_type == 'cloud'}
                <li class="tpicker"><a href="#tab2" onclick="return false">Virtual Machines<span  class="top_menu_count" id="vm_count">0</span> </a></li>
            {/if}
            {if $provisioning_type == 'single'}
                <li class="tpicker"><a href="#tab2" onclick="return false">Virtual Machine</a></li>
            {/if}
            <li class="tpicker"><a href="#tab3" onclick="return false">Addons<span id="numaddons" class="top_menu_count">{$details.addons}</span> </a></li>
        </ul>
        <div class="tab_container">
            <div class="tab_content" style="display: block;">
                {* ACCOUNT DETAILS *}
                <input type="hidden" name="submit" value="1" />
                <table width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="50%" valign="top">
                            <table cellspacing="2" cellpadding="3" border="0" width="100%" >
                                <tbody>
                                    {if $allowsynchronize}
                                        <tr {if $details.manual == '1' || $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if} {if $details.status != 'Pending' || $details.status=='Terminated'}class="livemode"{/if}>
                                            <td width="150">{$lang.lastsync}</td>
                                            <td>{if $details.synch_date == '0000-00-00 00:00:00'}{$lang.None}{else}{if $details.synch_error}<font style="color:#990000; font-weight: bold; margin-right: 10px;">{$lang.Failed}</font>{else}<font style="color:#006633; font-weight: bold; margin-right: 10px;">{$lang.Successful}</font>{/if}{$details.synch_date|dateformat:$date_format}{/if} <button type="submit" name="synchronize">{$lang.Synchronize}</button></td>
                                        </tr>
                                    {/if}
                                    <tr>
                                        <td width="150">{$lang.Package}</td>
                                        <td >
                                            <select name="product_id" id="product_id" onchange="sh1xa(this,'{$details.product_id}')">
                                                {foreach from=$packages item=package}
                                                    <option {if $package.id==$details.product_id}selected="selected" def="def"{/if} value="{$package.id}" {if $package.simmilar=='0'}class="h_manumode"{/if} {if $package.simmilar=='0' && $details.manual=='0'}disabled="disabled"{/if}>{$package.catname} - {$package.name}</option>
                                                {/foreach}
                                            </select>
                                            <div style="display:none;padding:3px;" id="upgrade_opt" class="lighterblue">
                                                <input type="submit" name="charge_upgrade" value="{$lang.orderupgrade}" {if  $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if}/>
                                                {if $allowpckgchange}
                                                    <input type="submit" name="changepackage" onclick="return checkup()" value="{$lang.changepackage}" class="livemode" {if  $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if}/>
                                                {/if}
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td >{$lang.Server} / App</td>
                                        <td>
                                            <div  id="serversload">
                                                <select name="server_id" id="server_id" class="{if $details.status!='Pending' && $details.status!='Terminated'}manumode{/if}" {if $details.manual != '1' && $details.status!='Pending' && $details.status!='Terminated'}style="display:none"{/if}>
                                                    <option value="0" {if $server.id=='0'}selected="selected" def="def"{/if}>{$lang.none}</option>
                                                    {if $servers}
                                                        {foreach from=$servers item=server}
                                                            <option value="{$server.id}" {if $details.server_id==$server.id}selected="selected" def="def"{/if}>{$server.name} ({$server.accounts}/{$server.max_accounts} Accounts)</option>
                                                        {/foreach}
                                                    {else}
                                                        <option value="0">{$lang.noservers}</option>
                                                    {/if}
                                                </select>
                                            </div>
                                            <span class="{if $details.status!='Pending' && $details.status!='Terminated'}livemode{/if}" {if $details.manual=='1' || $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if}>{if $details.server_name}{$details.server_name}{else}{$lang.none}{/if}</span>
                                        </td>
                                    </tr>
                                    {if !$details_fields && $details.domain!=''}
                                        <tr>
                                            <td >{$lang.Hostname}</td>
                                            <td >
                                                <input type="text" value="{$details.domain}" name="domain" id="domain_name"  class="{if $details.status!='Pending' && $details.status!='Terminated'}manumode{/if}"  {if $details.manual!='1' && $details.status!='Pending' && $details.status!='Terminated'}style="display:none"{/if}/>
                                                <span class="{if $details.status!='Pending' && $details.status!='Terminated'}livemode{/if}" {if $details.manual=='1' || $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if}>{$details.domain}</span>
                                                <a style="color: rgb(204, 0, 0);" target="_blank" href="http://{$details.domain}">www</a> <a target="_blank" href="{$system_url}?cmd=checkdomain&action=whois&domain={$details.domain}" onclick="window.open(this.href,'WHOIS','width=500, height=500, scrollbars=1'); return false">whois</a>
                                            </td>
                                        </tr>
                                        {if $details.ptype=='Dedicated' || $details.ptype=='Server'}
                                            <tr>
                                                <td >{$lang.Username}</td>
                                                <td >{if $details.user_error == '1' && $details.status != 'Pending' && $details.status != 'Terminated' && $details.manual != '1'}<strong style="color: red">{$lang.userdiff}</strong><br />{/if}
                                                    <input type="text" value="{$details.username}" name="username" size="20" id="username" class="{if $details.status!='Pending' && $details.status!='Terminated'}manumode{/if}"  {if $details.manual!='1' && $details.status!='Pending' && $details.status!='Terminated'}style="display:none"{/if}/>
                                                    <span class="{if $details.status!='Pending' && $details.status!='Terminated'}livemode{/if}" {if $details.manual=='1' || $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if}>{$details.username}</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td >{$lang.Password}</td>
                                                <td ><input type="text" value="{$details.password}" name="password" size="20" id="password"/>  {if $allowpasschange}<input type="submit" name="changepassword" value="{$lang.changepassword}" />{/if}</td>
                                            </tr>
                                            <tr>
                                                <td >{$lang.rootpass}</td>
                                                <td ><input type="text" value="{$details.rootpassword}" name="rootpassword" size="20" id="password"/></td>
                                            </tr>
                                        {/if}
                                    {elseif $details_fields}
                                        {foreach from=$details_fields item=field key=field_key}
                                            {if $field.name == 'domain'}
                                                {if $field.type == 'hidden'}
                                                <input value="{$details.domain}" name="domain" id="domain_name" type="hidden"/>
                                            {else}
                                                <tr>
                                                    <td >{if $details.ptype=='Dedicated' || $details.ptype=='Server'}{$lang.Hostname}{else}{$lang.Domain}{/if}</td>
                                                    <td >
                                                        <input type="text" value="{$details.domain}" name="domain" id="domain_name"  class="{if $details.status!='Pending' && $details.status!='Terminated'}manumode{/if}"  {if $details.manual!='1' && $details.status!='Pending' && $details.status!='Terminated'}style="display:none"{/if}/>
                                                        <span class="{if $details.status!='Pending' && $details.status!='Terminated'}livemode{/if}" {if $details.manual=='1' || $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if}>{$details.domain}</span>
                                                        <a style="color: rgb(204, 0, 0);" target="_blank" href="http://{$details.domain}">www</a> <a target="_blank" href="{$system_url}?cmd=checkdomain&action=whois&domain={$details.domain}" onclick="window.open(this.href,'WHOIS','width=500, height=500, scrollbars=1'); return false">whois</a>
                                                    </td>
                                                </tr>
                                            {/if}
                                        {elseif $field.name == 'username'}
                                            {if $field.type == 'hidden'}
                                                <input type="hidden" value="{$details.username}" name="username" size="20" id="username" />
                                            {else}
                                                <tr>
                                                    <td >{$lang.Username}</td>
                                                    <td >{if $details.user_error == '1' && $details.status != 'Pending' && $details.status != 'Terminated' && $details.manual != '1'}<strong style="color: red">{$lang.userdiff}</strong><br />{/if}

                                                        <input type="text" value="{$details.username}" name="username" size="20" id="username" class="{if $details.status!='Pending' && $details.status!='Terminated'}manumode{/if}"  {if $details.manual!='1' && $details.status!='Pending' && $details.status!='Terminated'}style="display:none"{/if}/>

                                                        <span class="{if $details.status!='Pending' && $details.status!='Terminated'}livemode{/if}" {if $details.manual=='1' || $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if}>{$details.username}</span>
                                                    </td>
                                                </tr>
                                            {/if}
                                        {elseif $field.name == 'password'}
                                            {if $field.type == 'hidden'}
                                                <input type="hidden" value="{$details.password}" name="password" size="20" id="password"/>
                                            {else}
                                                <tr>
                                                    <td >{$lang.Password}</td>
                                                    <td ><input type="text" value="{$details.password}" name="password" size="20" id="password"/>  {if $allowpasschange}<input type="submit" name="changepassword" value="{$lang.changepassword}" />{/if}</td>
                                                </tr>
                                            {/if}
                                        {elseif $field.name == 'rootpassword' && $provisioning_type == 'single'}
                                            {if $field.type == 'hidden'}
                                                <input type="hidden" value="{$details.rootpassword}" name="rootpassword" size="20" id="password"/>
                                            {else}
                                                <tr>
                                                    <td >{$lang.rootpass}</td>
                                                    <td ><input type="text" value="{$details.rootpassword}" name="rootpassword" size="20" id="password"/></td>
                                                </tr>
                                            {/if}
                                        {elseif $field.name}
                                            
                                            {if $field.type == 'hidden' || $provisioning_type != 'single'}
                                                <input type="hidden" value="{if $details.extra_details.$field_key}{$details.extra_details.$field_key|escape:'html':'utf-8'}{/if}" name="extra_details[{$field_key}]" />
                                            {else}
                                                <tr>
                                                    <td>{if $lang[$field.name]}{$lang[$field.name]}{else}{$field.name}{/if}</td>
                                                    <td>
                                                        {if $field.type == 'input'}
                                                            <input type="text" value="{if $details.extra_details.$field_key}{$details.extra_details.$field_key|escape:'html':'utf-8'}{/if}" 
                                                                   name="extra_details[{$field_key}]" size="20" 
                                                                   class="{if $details.status!='Pending' && $details.status!='Terminated'}manumode{/if}"  
                                                                   {if $details.manual!='1' && $details.status!='Pending' && $details.status!='Terminated'}style="display:none"
                                                                   {/if}/> 
                                                        {if $field_key == 'option10' && !( $details.manual!='1' && $details.status!='Pending' && $details.status!='Terminated' )}
                                                            <a href="#" onclick="show_nodes(); $(this).hide(); return false">Select Node</a>
                                                        {/if}
                                                            <span class="{if $details.status!='Pending' && $details.status!='Terminated'}livemode{/if}" {if $details.manual=='1' || $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if}>{if $details.extra_details.$field_key}{$details.extra_details.$field_key}{/if}</span>
                                                        {elseif $field.type == 'check'}

                                                        {/if}
                                                        {if $field_key == 'option6'}
                                                            {* VEID FIELD *}
                                                            <input type="hidden" value="{if $details.veid}{$details.veid}{/if}" name="veid" class="bindto" rel="option6" /> 
                                                        {/if}
                                                        {if $field_key == 'option10'}
                                                            {* NODE FIELD *}
                                                            <input type="hidden" value="{if $details.node}{$details.node}{/if}" name="node" class="bindto" rel="option10" /> 
                                                        {/if}
                                                    </td>
                                                </tr>
                                            {/if}
                                        {/if}
                                    {/foreach}
                                {/if}
                                {if ($details.status=='Active' || $details.status=='Suspended') && $custom.GetStatus}
                                    <tr>
                                        <td >{$lang.Status}</td>
                                        <td ><a href="" onclick="getStatus({$details.id}, this); return false;">Get Status</a></td>
                                    </tr>
                                {/if}
                                {literal}
                                    <script type="text/javascript">
                                        function getStatus(id, elem) {
                                            var field=$(elem).parent();
                                            $(field).html('{/literal}{$lang.Loading}...{literal}');
                                            ajax_update('?cmd=accounts&action=getstatus&id='+id,{},field);
                                            return false;
                                        }
                                        $('.bindto').each(function(){
                                            var that = this;
                                            $(this).val($('input[name="extra_details['+$(this).attr('rel')+']"]').change(function(){$(that).val($(this).val())}).val());
                                        });
                                    </script>
                                {/literal}
                                <tr class="uneditables" style="display:none"><td>
                                    {* FOR DEDITACTED TYPE *}
                                    <input type="hidden" name="type" value="{$details.type}" />
                                    <input type="hidden" name="ip" value="{$details.ip}" />
                                    {if is_array($details.additional_ip)}{foreach from=$details.additional_ip item=ip}
                                        <input type="hidden" name="additional_ip[]" value="{$ip}" />
                                    {/foreach}{else}
                                        <input type="hidden" name="additional_ip" value="{$details.additional_ip}" />
                                    {/if}
                                    <input type="hidden" name="guaranteed_ram" value="{$details.guaranteed_ram}" />
                                    <input type="hidden" name="burstable_ram" value="{$details.burstable_ram}" />
                                    <input type="hidden" name="disk_usage" value="{$details.disk_usage}" />
                                    <input type="hidden" name="disk_limit" value="{$details.disk_limit}" />
                                    <input type="hidden" name="bw_usage" value="{$details.bw_usage}" />
                                    <input type="hidden" name="bw_limit" value="{$details.bw_limit}" />
                                    <input type="hidden" name="os" value="{$details.os}" />
                                    {include file="`$moduletpldir`extra.tpl" inputname="extra" extra=$details.extra}
                                </td></tr>
                                <tr {if !$allowterminate && !$allowsuspend && !$allowcreate && !$allowunsuspend}class="manumode" {if $details.manual!='1'}style="display:none"{/if}{/if}>
                                    <td >{$lang.availactions}</td>
                                    <td >
                                        <input type="submit" onclick="$('body').addLoader();"  name="create" value="Create" {if !$allowcreate}class="manumode"{/if} {if !$allowcreate && $details.manual!='1'}style="display:none"{/if}/>
                                        <input type="submit"  name="suspend" value="Suspend" {if !$allowsuspend} class="manumode"{/if} {if !$allowsuspend && $details.manual!='1'}style="display:none"{/if}  onclick="return confirm('{$lang.suspendconfirm}')"/>
                                        <input type="submit" name="unsuspend" value="Unsuspend" {if !$allowunsuspend} class="manumode"{/if} {if !$allowunsuspend && $details.manual!='1'}style="display:none"{/if}/>
                                        <input type="submit" name="terminate"  value="Terminate" {if !$allowterminate}class="manumode"{/if} {if !$allowterminate && $details.manual!='1'}style="display:none;color:#ff0000;"{else} style="color:#ff0000"{/if} onclick="return confirm('{$lang.terminateconfirm}')"/>
                                        <input type="submit" name="renewal"  value="Renewal" {if !$allowrenewal}style="display:none"{/if}/>
                                        {foreach from=$custom item=btn}
                                            {if $btn!='GetOsTemplates' && $btn!='GetNodes' && $btn!='GetStatus' && $btn!='restoreBackup' && $btn!='createBackup' && $btn!='deleteBackup'}
                                                <input type="submit" name="customfn" value="{$btn}" class="{if $details.status!='Active'}manumode{/if} {if $loadable[$btn]}toLoad{/if}" {if $details.status!='Active' && $details.manual!='1'}style="display:none"{/if} />
                                            {/if}
                                        {/foreach}
                                    </td>
                                </tr>
                                <tr {if !$allowautosuspend}style="display:none"{/if}>
                                    <td>{$lang.overridesus}
                                    </td>
                                    <td><input type="checkbox"  name="autosuspend" value="1" {if $details.autosuspend==1}checked="checked"{/if} onclick="autosus(this)" style="float:left"/>
                                        <div id="autosuspend_date" {if $details.autosuspend!=1}style="display:none"{/if} >
                                            <input  name="autosuspend_date" value="{$details.autosuspend_date|dateformat:$date_format}" class="haspicker" size="12"/>
                                        </div>
                                    </td>
                                </tr>
                                <tr><td>{$lang.sendacce}</td>
                                    <td><select name="mail_id" id="mail_id">
                                            {foreach from=$product_emails item=send_email}
                                                <option value="{$send_email.id}">{$send_email.tplname}</option>
                                            {/foreach}
                                            <option value="custom" style="font-weight:bold">{$lang.newmess}</option>
                                        </select>
                                        <input type="button" name="sendmail" value="{$lang.Send}" id="sendmail"/>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </td>
                        <td width="50%" valign="top">
                            {if $details.status!='Pending'}
                                <strong>{$lang.automationqueue}</strong>
                                <div style="margin:5px 0px;-moz-box-shadow: inset 0 0 2px #888;-webkit-box-shadow: inset 0 0 2px #888;box-shadow: inner 0 0 2px #888;background:#F5F9FF;padding:10px;" class="fs11">
                                    <div id="autoqueue" style="max-height:100px;overflow:auto">{$lang.Loading}
                                        <script type="text/javascript">
                                            appendLoader('getAccQueue');
                                            function getAccQueue() {literal}{{/literal}
                                                ajax_update("?cmd=accounts&action=getqueue&id={$details.id}",false,'#autoqueue');
                                        {literal}}{/literal}
                                    </script>
                                </div>
                            </div>
                            <div class="fs11" style="text-align: right">
                                <div class="left">
                                    <a href="?cmd=services&action=product&id={$details.product_id}&picked_tab=2" target="_blank">{$lang.schedulenewtask}</a>
                                </div>
                                <div class="right">{$lang.currservertime} {$currentt|dateformat:$date_format}</div>
                                <div class="clear"></div>
                            </div>
                        {/if}
                    </td>
                </tr>
            </table>
            {if $details.custom}
                <input type="hidden" name="arecustom" value="1"/>
                <table cellspacing="2" cellpadding="3" border="0" width="100%" >
                    {foreach from=$details.custom item=c key=kk}
                        {if $c.items}
                            <tr>
                                <td style="vertical-align: top" width="150" >{$c.name} </td>
                                <td>
                                    {if $c.type=='select'}
                                        <select name="custom[{$kk}]">
                                            <option value="0" {if $c.value=='0'}selected="selected"{/if}>-</option>
                                            {foreach from=$c.items item=itm}
                                                <option value="{$itm.id}" {if $c.values[$itm.id]}selected="selected"{/if}>{$itm.name} {if $itm.price}({$itm.price|price:$details.currency:true:true}){/if}</option>
                                            {/foreach}
                                        </select>
                                    {elseif $c.type=='qty'}
                                    {foreach from=$c.items item=cit}<input name="custom[{$kk}][{$cit.id}]"  size="2" value="{$c.qty}"/> {if $cit.name}x {$cit.name}{/if}  
                                        {if $cit.price}({$cit.price|price:$details.currency:true:true})
                                        {/if}
                                    {/foreach}
                                {else}
                                    {include file=$c.configtemplates.accounts currency=$details.currency forcerecalc=true}
                                {/if}
                            </td>
                        </tr>
                    {/if}
                {/foreach}
            </table>
        {/if}
        {*END ACCOUNT DETAILS*}
    </div>
    {if $provisioning_type == 'cloud' || $provisioning_type == 'single'}
        <div class="tab_content" style="display: none;">
            <div id="lmach">
                <br />
            </div>
        </div>
    {/if}
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
{literal}
    <script type="text/javascript">
                function show_nodes(){
                    var url={/literal}'?cmd=accounts&action=edit&id={$details.id}&service={$details.id}';{literal}
                    var inp = $('input[name="extra_details[option10]"]');
                        inp.wrap('<div class="left" />');inp.parent().addLoader();
                    $.post(url,{vpsdo: 'list_nodes','current':inp.val()},function(data){
                        var r = parse_response(data);
                        inp.parent().replaceWith(r); 
                    });
                }
                function sync_alert(){
                    var tab = $('#tabbedmenu li a[href=#tab2]');
                    if(!tab.parent().is('.active'))
                    $('#tabbedmenu li a[href=#tab2]').append('<span id="numaddons" class="top_menu_count"><b style="color:red">1</b></span>').bind('click.note',function(){
                        $(this).unbind('click.note').find('span').remove();
                    });
                }
                function load_clientvm(loader, sync){
                    if(loader != undefined) 
                        $('#lmach').addLoader();
                    ajax_update('{/literal}?cmd=accounts&action=edit&id={$details.id}&service={$details.id}&vpsdo=clientsvms{literal}'+ (sync != undefined && sync == 'sync' ? '&synchronize=sync':'') + (sync > 0 ? '&synchronize='+sync:''),'','#lmach');
                }
                function shutdown_clientvm(){
                    ajax_update('{/literal}?cmd=accounts&action=edit&id={$details.id}&service={$details.id}&vpsdo=shutdown{literal}','');
                    load_clientvm(true);
                }
                function startup_clientvm(){
                    ajax_update('{/literal}?cmd=accounts&action=edit&id={$details.id}&service={$details.id}&vpsdo=startup{literal}','');
                    load_clientvm(true);
                }
                function reboot_clientvm(){
                    ajax_update('{/literal}?cmd=accounts&action=edit&id={$details.id}&service={$details.id}&vpsdo=reboot{literal}','');
                    load_clientvm(true);
                }
                function destroyVM_onapp(url) {
                    if(confirm('Are you sure you wish to destroy this VM?')) {
                     $('#lmach').addLoader();
                     ajax_update(url,'','#lmach');
                         }
                             return false;
                }
                function power_onapp(url,what) {
                    var conf = what=='off'?confirm('Are you sure you wish to power-off this VM?'):true;
                    if(conf) {
                     $('#lmach').addLoader();
                     ajax_update(url+'&power='+what,'','#lmach');
                         }
                             return false;
                }
                function loadClientMachines_onapp() {
                    var url={/literal}'?cmd=accounts&action=edit&id={$details.id}&service={$details.id}&vpsdo=clientsvms';{literal}
                    ajax_update(url,'','#lmach',true);

                setInterval ( function(){
                    if(!$('#tabbedmenu .tpicker').eq(2).hasClass('active'))
                        return;
                      $('#lmach').addLoader();
                     ajax_update(url,'','#lmach');
                }, 20000);

                }
               appendLoader('loadClientMachines_onapp');
    </script> 

    <style type="text/css">
        ul.accor li > div.darker {
            background:#e3e2e4 !important;
            border-bottom:1px solid #d7d7d7  !important;
            border-left:1px solid #d7d7d7  !important;
            border-right:1px solid #d7d7d7  !important;
        }
        ul.accor li > a.darker {
            background:url("{/literal}{$template_dir}{literal}img/plus1.gif") no-repeat scroll 6px 50% #444547 !important;
        }
        #lmach {
            padding:10px;
        }
        a.power {
            float: left;
            display: block;
            width: 31px;
            height: 19px;
            margin-left: 3px;
            text-decoration: none;
            text-align: center;
            color: #555 !important;
            cursor: default;
        }
        a.power.on-inactive, a.power.off-inactive, a.power.on-disabled, a.power.off-disabled {
            background: transparent url({/literal}{$system_url}{literal}includes/types/onappcloud/images/power-bg.png) no-repeat scroll 0 0;
        }

        a.power.on-inactive:hover {
            background: transparent url({/literal}{$system_url}{literal}includes/types/onappcloud/images/power-bg.png) no-repeat scroll -32px 0;
        }

        a.power.off-inactive:hover {
            background: transparent url({/literal}{$system_url}{literal}includes/types/onappcloud/images/power-bg.png) no-repeat scroll -64px 0;
        }

        a.power.on-active {
            background: transparent url({/literal}{$system_url}{literal}includes/types/onappcloud/images/power-bg.png) no-repeat scroll -96px 0;
        }

        a.power.off-active {
            background: transparent url({/literal}{$system_url}{literal}includes/types/onappcloud/images/power-bg.png) no-repeat scroll -128px 0;
        }
        .power.pending {
            background: transparent url({/literal}{$system_url}{literal}includes/types/onappcloud/images/power-bg.png) no-repeat scroll -160px 0;
            width: 65px;
            color: #909090 !important;
        }
        .vm-overview a.power {
            margin-left: 0;
            margin-right: 3px;
            text-shadow: none;
        }
        a.power.on-inactive:hover, a.power.off-inactive:hover {
            cursor: pointer;
            color: #fafafa !important;
        }

        a.power.on-active {
            color: #efe !important;
        }

        a.power.off-active {
            color: #fee !important;
        }

        a.power.on-disabled, a.power.off-disabled {
            color: #909090 !important;
            opacity: 0.8;
        }
        .power-status .yes {
            background:url("{/literal}{$system_url}{literal}includes/types/onappcloud/images/vm-on.png") no-repeat scroll 0 0 transparent;
            display:block;
            height:16px;
            text-indent:-99999px;
            width:16px;
        }
        .power-status .no {
            background:url("{/literal}{$system_url}{literal}includes/types/onappcloud/images/vm-off.png") no-repeat scroll 0 0 transparent;
            display:block;
            height:16px;
            text-indent:-99999px;
            width:16px;
        }
        .right-aligned {
            text-align:right;
        }
        .ttable td {
            padding:3px 4px;
        }
        table.data-table.backups-list thead {
            border:1px solid #DDDDDD;
        }
        table.data-table.backups-list thead {
            border-left:1px solid #005395;
            border-right:1px solid #005395;
        }
        table.data-table.backups-list thead {
            font-size:80%;
            font-weight:bold;
            text-transform:uppercase;
        }
        table.data-table.backups-list thead td {
            background:none repeat scroll 0 0 #777777;
            color:#FFFFFF;
            padding:8px 5px;
        }
        table.data-table tbody td {
            background:none repeat scroll 0 0 #FFFFFF;
            border-top:1px solid #DDDDDD;
        }
        table.data-table tbody tr:hover td {
            background-color: #FFF5BD;
        }
        table.data-table tbody tr td {
            border-color:-moz-use-text-color #DDDDDD #DDDDDD;
            border-right:1px solid #DDDDDD;
            border-style:none solid solid;
            border-width:0 1px 1px;
            font-size:90%;
            padding:8px;
        }
    </style> 
{/literal}