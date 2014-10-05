<script type="text/javascript">loadelements.domains=true;</script>
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter && !$details.manual}class="searchon"{/if}>
    <tr>
        <td ><h3>{$lang.Domains}</h3></td>
        <td  class="searchbox">
            <div id="hider2" style="text-align:right">
                &nbsp;&nbsp;&nbsp;
                <a href="?cmd=domains&action=getadvanced" class="fadvanced">{$lang.filterdata}</a> <a href="?cmd=domains&resetfilter=1" {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
            </div>
            <div id="hider" style="display:none"></div>
        </td>
    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=orders&amp;action=add"  class="tstyled" style="font-weight: bold">{$lang.newdomain}</a>
            <br />
            <a href="?cmd=domains&amp;list=all"  class="tstyled {if ($currentlist=='all' || !$currentlist) && $action!='sync'}selected{/if}">{$lang.Alldomains} <span>({$stats.All})</span></a>
            <a href="?cmd=domains&amp;list=active" class="tstyled {if $currentlist=='active'}selected{/if}">{$lang.Activedomains} <span>({$stats.Active})</span></a>
            <a href="?cmd=domains&amp;list=expired" class="tstyled {if $currentlist=='expired'}selected{/if}">{$lang.Expireddomains} <span>({$stats.Expired})</span></a>
            <a href="?cmd=domains&amp;list=pending" class="tstyled {if $currentlist=='pending'}selected{/if}">{$lang.Pendingdomains} <span>({$stats.Pending})</span></a>
            <a href="?cmd=domains&amp;list=pending_transfer" class="tstyled {if $currentlist=='pending transfer'}selected{/if}">{$lang.PendingTransfer} <span>({$stats.PendingTransfer})</span></a>
            <a href="?cmd=domains&amp;list=cancelled" class="tstyled {if $currentlist=='cancelled'}selected{/if}">{$lang.Cancelleddomains} <span>({$stats.Cancelled})</span></a>
            <br />
            <a href="?cmd=domains&amp;action=sync" class="tstyled {if $action=='sync'}selected{/if}">{$lang.domainsync_menu} </a>
        </td>

        <td  valign="top"  class="bordered"><div id="bodycont">
                {if $action=='edit' && $details}
                    <form action="" method="post" id="dom_forms">
                        <input type="hidden" name="domain_id" value="{$details.id}" id="domain_id" />
                        <input type="hidden" name="domain_name" value="{$details.name}" id="domain_name" />
                        <input type="hidden" name="submitcus" value="1" />
                        <div class="blu">
                            <table border="0" cellpadding="2" cellspacing="0" >
                                <tr>
                                    <td class="menubar"><a href="?cmd=domains&list={$currentlist}"><strong>&laquo; {$lang.backto} {$currentlist} {$lang.domains}</strong></a>&nbsp;
                                        <input type="submit" name="save" value="{$lang.savechanges}" style="font-weight:bold;display:none"  id="formsubmiter"/> 
                                        <a class="menuitm" href="#" onclick="$('#formsubmiter').click();return false" ><span ><strong>{$lang.savechanges}</strong></span></a>

                                        <a class=" menuitm menuf" href="#" onclick="return confirm_delete()"><span style="color:#FF0000">{$lang.Delete}</span></a>{*
                                        *}<a class="setStatus menuitm menul" id="hd1" onclick="return false;"   href="#" ><span class="morbtn">{$lang.moreactions}</span></a>
                                    </td>
                                    <td><input type="checkbox" name="manual" value="1" {if $details.manual == '1'}checked="checked" {/if}  class="changeMode" style="display:none"/></td>
                                </tr>


                            </table>
                            <ul id="hd1_m" class="ddmenu">
                                <li ><a href="AdminNotes">{$lang.editadminnotes}</a></li>
                                <li ><a href="ChangeOwner">{$lang.changeowner}</a></li>
                                <!-- <li ><a href="DeleteDomain" style="color:#ff0000">Delete Domain</a></li> -->

                            </ul>
                        </div>
                        <div class="lighterblue" id="ChangeOwner" style="display:none;padding:5px;">
                        </div>

                        <div id="ticketbody">
                            <h1>{$lang.Domain} {$details.name}</h1>

                            <div id="client_nav">
                                <!--navigation-->
                                <a class="nav_el nav_sel left" href="#">{$lang.domaindetails}</a>
                                <a class="nav_el  left" href="?cmd=domains&action=log&id={$details.id}" onclick="return false">{$lang.domainlog}</a>
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

                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td >{$lang.Client}</td>
                                                <td ><a href="?cmd=clients&action=show&id={$details.client_id}">{$details.firstname} {$details.lastname}</a> </td>
                                                <td >{$lang.regperiod}</td>
                                                <td ><input type="text" size="4" name="period" value="{$details.period}" class="manumode" {if $details.manual!='1'}style="display:none"{/if} /> <span class="livemode"  {if $details.manual=='1'}style="display:none"{/if}>{$details.period} {$lang.yearslash}</span></td>
                                            </tr>

                                            <tr>
                                                <td >{$lang.ordertype}</td>
                                                <td >{$lang[$details.type]}</td>
                                                <td >{$lang.expirydate}</td>
                                                <td ><span class="manumode" {if $details.manual!='1'}style="display:none"{/if}><input type="text" class="haspicker" name="expires" value="{$details.expires|dateformat:$date_format}" size="12"/></span> <span class="livemode"  {if $details.manual=='1'}style="display:none"{/if}>{if !$details.expires || $details.expires == '0000-00-00'}{$lang.none}{else}{$details.expires|dateformat:$date_format}{/if}</span></td>
                                            </tr>

                                            <tr>
                                                <td >{$lang.regdate}</td>
                                                <td><span class="manumode" {if $details.manual!='1'}style="display:none"{/if}><input type="text" class="haspicker" value="{$details.date_created|dateformat:$date_format}" name="date_created" size="12" /></span> <span class="livemode"  {if $details.manual=='1'}style="display:none"{/if}>{if !$details.date_created || $details.date_created == '0000-00-00'}{$lang.none}{else}{$details.date_created|dateformat:$date_format}{/if}</span></td>
                                                <td >{$lang.next_due}</td>
                                                <td ><input type="text" class="haspicker" value="{$details.next_due|dateformat:$date_format}" name="next_due" size="12" /></td>
                                            </tr>
                                            <tr>
                                                <td >{$lang.Registrar}</td>
                                                <td >

                                                    <select name="reg_module" class="manumode" {if $details.manual!='1'}style="display:none"{/if} onclick="new_registrar(this)">
                                                        <option value="0">{$lang.none}</option>
                                                        {foreach from=$registrars item=registrar key=id}
                                                            <option {if $details.reg_module == $id}selected="selected" {/if}value="{$id}">{$registrar}</option>
                                                        {/foreach}
                                                        <option value="new" style="font-weight: bold">{$lang.newregistrar}</option>
                                                    </select>

                                                    {if $module_set}
                                                        {foreach from=$registrars item=registrar key=id}
                                                            {if $details.reg_module == $id}
                                                                <span class="livemode"  {if $details.manual=='1'}style="display:none"{/if}>{$registrar}</span>
                                                            {/if}
                                                        {/foreach}
                                                    {else}
                                                        <em class="livemode" {if $details.manual=='1'}style="display:none"{/if}>None</em>
                                                    {/if}

                                                </td>
                                                <td >{$lang.firstpayment}</td>
                                                <td ><input type="text" value="{$details.firstpayment}" name="firstpayment" size="10"/></td>
                                            </tr>

                                            <tr>
                                                <td >{$lang.Status}</td>
                                                <td >
                                                    <select name="status" {if $details.manual != '1'}style="display:none"{/if} class="manumode">
                                                        <option {if $details.status == 'Pending'}selected="selected" {/if} value="Pending">{$lang.Pending}</option>
                                                        <option {if $details.status == 'Pending Transfer'}selected="selected" {/if} value="Pending Transfer">{$lang.PendingTransfer}</option>
                                                        <option {if $details.status == 'Pending Registration'}selected="selected" {/if} value="Pending Registration">{$lang.PendingRegistration}</option>
                                                        <option {if $details.status == 'Active'}selected="selected" {/if} value="Active">{$lang.Active}</option>
                                                        <option {if $details.status == 'Cancelled'}selected="selected" {/if} value="Cancelled">{$lang.Cancelled}</option>
                                                        <option {if $details.status == 'Expired'}selected="selected" {/if} value="Expired">{$lang.Expired}</option>
                                                    </select>

                                                    <span class="{$details.status} livemode" {if $details.manual == '1'}style="display:none"{/if}><strong>{$lang[$details.status]}</strong></span>
                                                </td>
                                                <td >{$lang.recurring}</td>
                                                <td ><input type="text" value="{$details.recurring_amount}" name="recurring_amount" size="10"/></td>
                                            </tr>

                                        </tbody>
                                    </table>
                                </div>
                                {include file="_common/quicklists.tpl" _placeholder=true}
                            </div>

                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td valign="top">
                                        <ul class="accor">
                                            <li><a href="#">{$lang.domainmanagement}</a>
                                                <div class="sor">
                                                    <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                                        <tr>
                                                            <td width="50%">
                                                                <table cellspacing="2" cellpadding="3" border="0" width="100%">
                                                                    <tr><td width="150">{$lang.Domain}</td>
                                                                        <td><input type="text" size="30"  name="name" value="{$details.name}" id="domainname" {if $details.manual !='1'}readonly="readonly"{/if}/> 
                                                                            <a href="http://www.{$details.name}" target="_blank" style="color: rgb(204, 0, 0);" class="fs11">www</a>
                                                                            <a href="{$system_url}?cmd=checkdomain&action=whois&domain={$details.name}" onclick="window.open(this.href,'WHOIS','width=500, height=500, scrollbars=1'); return false"  class="fs11">whois</a>
                                                                            {if $details.tld_category}<a href="?cmd=services&action=product&id={$details.tld_id}" target="_blank" class="fs11">tld settings</a>{/if}
                                                                        </td>
                                                                    </tr>
                                                                    {if !$details.tld_category}
                                                                        <tr><td width="150">Product</td>
                                                                            <td>
                                                                                <select name="tld_id" style="width: 205px;">
                                                                                {foreach from=$categories item=category}
                                                                                    <optgroup label="{$category.name}" >
                                                                                    {foreach from=$category.products item=tld}
                                                                                        <option {if substr($details.name,-(strlen($tld.name))) == $tld.name}selected="selected"{/if} value="{$tld.id}">{$tld.name}</option>
                                                                                    {/foreach}
                                                                                    </optgroup>
                                                                                {/foreach}
                                                                                </select>
                                                                            </td>
                                                                        </tr>
                                                                    {/if}
                                                                    {if $module_set}
                                                                        {foreach from=$details.nameservers item=nameserver key=number}
                                                                            <tr {if !$allowns}class="manumode"{/if} {if !$allowns && $details.manual!='1'}style="display:none"{/if} >
                                                                                <td >{$lang.Nameserver} {$number+1}</td><td ><input type="text" size="40" value="{$nameserver}" name="nameservers[ns{$number+1}]"/>
                                                                                </td>
                                                                            </tr>
                                                                        {/foreach}
                                                                        {if $details.nsips && $details.nsips|is_array}
                                                                            {foreach from=$details.nsips item=nsip key=nnumber}
                                                                                <tr {if !$allowns}class="manumode"{/if} {if !$allowns && $details.manual!='1'}style="display:none"{/if} >
                                                                                    <td >{$lang.Nameserver} IP {$nnumber+1}</td><td ><input type="text" size="40" value="{$nsip}" name="nsips[nsip{$nnumber+1}]"/>
                                                                                    </td>
                                                                                </tr>
                                                                            {/foreach}
                                                                        {/if}
                                                                    {/if}

                                                                    <tr {if !$alloweppcode} id="epp_code"{if $details.manual!='1'} style="display:none"{/if}{/if}>
                                                                        <td>{$lang.Eppcode}</td>
                                                                        <td><input type="text" size="30" name="epp_code" value="{$details.epp_code|escape}" /></td>
                                                                    </tr>

                                                                    {if $autorenew}
                                                                        <tr {if !$showautorenew}class="manumode"{/if} {if !$showautorenew && $details.manual!='1'}style="display:none"{/if}>
                                                                            <td>{$lang.AutoRenew}</td>
                                                                            <td>
                                                                                <input type="checkbox" name="autorenew" value="1" {if $details.autorenew==1}checked="checked"{/if} />
                                                                            </td>
                                                                        </tr>
                                                                    {/if}

                                                                    {if $registrarlock}
                                                                        <tr {if !$showregistrarlock}class="manumode"{/if} {if !$showregistrarlock && $details.manual!='1'}style="display:none"{/if}>
                                                                            <td >{$lang.RegistrarLock}</td>
                                                                            <td>
                                                                                <input type="checkbox" name="reglock" value="1" {if $details.reglock=='1'}checked="checked"{/if} />
                                                                            </td>
                                                                        </tr>
                                                                    {/if}


                                                                    <tr>
                                                                        <td >{$lang.AutoRenew}</td><td >
                                                                            <input type="checkbox" name="autorenew" id="autorenewid" value="1" {if $details.autorenew == 1}checked="checked"{/if}/> <label for="autorenewid"></label>
                                                                        </td>
                                                                    </tr>

                                                                    {if $module_set}
                                                                        <tr>
                                                                            <td>{$lang.availablecommands}</td>
                                                                            <td class="dom_commands">
                                                                                <input type="submit" name="synch" value="{$lang.Synchronize}" {if !$allowsynch}class="manumode"{/if} {if !$allowsynch && $details.manual!='1'}style="display:none"{/if}/>
                                                                                {if $allowregister}
                                                                                    <input type="submit"  name="register"  value="{$lang.Register}" {if !$showregister}class="manumode"{/if} {if !$showregister && $details.manual!='1'}style="display:none"{/if}/>
                                                                                {/if}
                                                                                {if $allowrenew}
                                                                                    <input type="submit"  name="renew"  value="{$lang.Renew}" {if !$showrenew}class="manumode"{/if} {if !$showrenew && $details.manual!='1'}style="display:none"{/if}/>
                                                                                {/if}
                                                                                {if $allowtransfer}
                                                                                    <input type="submit"  name="transfer"  value="{$lang.Transfer}" {if !$showtransfer}class="manumode"{/if} {if !$showtransfer && $details.manual!='1'}style="display:none"{/if}/>
                                                                                {/if}
                                                                                {if $allowdelete}
                                                                                    <input type="submit"  name="delete"  value="{$lang.Delete}" {if !$showdelete}class="manumode"{/if} {if !$showdelete && $details.manual!='1'}style="display:none"{/if} 
                                                                                           onclick="return confirm('{$lang.deletedomconfirm}');"/>
                                                                                {/if}
                                                                                {if $details.status == 'Pending'}
                                                                                    <input type="submit"  name="preparecontacts"  value="Edit registration contacts" class="toLoad" />
                                                                                {/if}
                                                                                {if $custom}<br />{/if}
                                                                                {foreach from=$custom key=c_name item=btn}
                                                                                    <input type="submit" name="regcommand" value="{$c_name}" {if !$btn.toload}onclick="call_regcommand(this); return false;"{/if} class="{if $btn.toload}toLoad{/if} {if !$allowcustom}manumode{/if}" {if !$allowcustom && $details.manual!='1'}style="display:none"{/if}/>
                                                                                {/foreach}
                                                                            </td>
                                                                        </tr>
                                                                    {/if}
                                                                <tr>
                                                                    <td>{$lang.senddomainemail}</td>
                                                                    <td><select name="mail_id" id="mail_id">
                                                                            {foreach from=$domain_emails item=send_email}
                                                                                <option value="{$send_email.id}">{$send_email.tplname}</option>
                                                                            {/foreach}
                                                                            <option value="custom" style="font-weight:bold">{$lang.newmess}</option>
                                                                        </select>
                                                                        <input type="button" name="sendmail" value="{$lang.Send}" id="sendmail"/>
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
                                                                                                <option value="{$itm.id}" {if $c.values[$itm.id]}selected="selected"{/if}>{$itm.name} {if $itm.price}({$itm.price|price:$currency}){/if}</option>
                                                                                            {/foreach}
                                                                                        </select>


                                                                                    {elseif $c.type=='qty'}
                                                                                        {foreach from=$c.items item=cit}
                                                                                            <input name="custom[{$kk}][{$cit.id}]"  size="2" value="{$c.qty}"/> {if $cit.name}x {$cit.name}{/if}  
                                                                                            {if $cit.price}({$cit.price|price:$currency})
                                                                                            {/if}
                                                                                        {/foreach}
                                                                                    {else}
                                                                                        {include file=$c.configtemplates.accounts}
                                                                                    {/if}
                                                                                </td>
                                                                            </tr>
                                                                        {/if}
                                                                    {/foreach}
                                                                </table>
                                                            {/if}
                                                        </td>
                                                        <td width="50%" style="padding-left:10px" valign="top">
                                                            {if $details.status!='Cancelled'}
                                                                <b>{$lang.automationqueue}</b>
                                                                <div style="margin:5px 0px;-moz-box-shadow: inset 0 0 2px #888;-webkit-box-shadow: inset 0 0 2px #888;box-shadow: inner 0 0 2px #888;background:#F5F9FF;padding:10px;" class="fs11">
                                                                    <div class="sor fs11" id="autoqueue" style="max-height:100px;overflow:auto">
                                                                        {$lang.Loading}
                                                                        {literal}
                                                                            <script type="text/javascript">
                                                                                appendLoader('getAccQueue');
                                                                            
                                                                                function getAccQueue() {
                                                                                    ajax_update("?cmd=domains&action=getqueue&id={/literal}{$details.id}{literal}",false,'#autoqueue');
                                                                                    }
                                                                                
                                                                            </script>
                                                                        {/literal}
                                                                    </div>
                                                                </div>       
                                                                <div class="fs11" style="text-align: right">
                                                                    <div class="left">
                                                                        <a href="?cmd=services&action=product&id={$details.tld_id}&picked_tab=2" target="_blank">{$lang.schedulenewtask}</a>
                                                                    </div>
                                                                    <div class="right">{$lang.currservertime} {$currentt|dateformat:$date_format}</div>
                                                                    <div class="clear"></div>
                                                                </div>
                                                            {/if}
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </li>
                                    </ul>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <ul class="accor" id="dommanager" style="display:none;margin-bottom:5px;">
                                        <li><a href="#" id="man_title"></a>
                                            <div class="sor" id="man_content"></div>
                                        </li>
                                    </ul>
                                    {literal}
                                        <script type="text/javascript">
                                        
                                function new_gateway(elem) {
                                    if($(elem).val() == 'new') {
                                        window.location = "?cmd=managemodules&action=payment";
                                        $(elem).val(($("select[name='"+$(elem).attr('name')+"'] option:first").val()));
                                    }
                                }function new_registrar(elem) {
                                    if($(elem).val() == 'new') {
                                        window.location = "?cmd=managemodules&action=domain";
                                        $(elem).val(($("select[name='"+$(elem).attr('name')+"'] option:first").val()));
                                    }
                                }
                                function ext_submit(el) {
                                    ajax_update('?cmd=domains&action=callcustom&id='+$('#domain_id').val()+'&command='+$(el).attr('name'), $('#dom_forms').serialize(),'#man_content',true);
                                    return false;
                                }
                                function call_regcommand(el) {
                                                window.location = '?cmd=domains&action=callcustom&regcommand=true{/literal}&security_token={$security_token}{literal}&refresh=true&id='+$('#domain_id').val()+'&command='+$(el).attr('value');

                                }
                                        
                                        </script>
                                    {/literal}
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    {include file='_common/noteseditor.tpl'}
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="blu">
                        <table border="0" cellpadding="2" cellspacing="0" >
                            <tr>
                                <td class="menubar"><a href="?cmd=domains&list={$currentlist}"><strong>&laquo; {$lang.backto} {$currentlist} {$lang.domains}</strong></a>&nbsp;
                                    <a   class="menuitm"   href="#" onclick="$('#formsubmiter').click();return false" ><span ><strong>{$lang.savechanges}</strong></span></a>
                                    <a   class=" menuitm menuf"    href="#" onclick="return confirm_delete()"><span style="color:#FF0000">{$lang.Delete}</span></a><a   class="setStatus menuitm menul" id="hd1" onclick="return false;"   href="#" ><span class="morbtn">{$lang.moreactions}</span></a>
                                </td>
                                <td></td>
                            </tr>
                        </table>

                        <ul id="hd1_m" class="ddmenu">
                            <li ><a href="AdminNotes">{$lang.editadminnotes}</a></li>
                            <li ><a href="SendEmail">{$lang.senddomainemail}</a></li>

                        </ul>
                    </div>
                    {securitytoken}
                </form>
                {literal}
                    <script type="text/javascript">
                    
                    function confirm1() {

                        var c = confirm('{/literal}{$lang.confdomdel}{literal}');
                        if(c) {
                            window.location='?cmd=domains&action=edit&make=delete{/literal}&security_token={$security_token}{literal}&id='+$('#domain_id').val();
                        }
                        return false;

                    }
                    
                    </script>
                {/literal}
            {elseif $action=='sync'}
                {include file='domainsync.tpl'}
            {else}
                <form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
                    <div class="blu">
                        <div class="right"><div class="pagination"></div></div>
                        <div class="left menubar">
                            {$lang.withselected}
                            <a class="menuitm menuf submiter renew confirm" name="renew" onclick="return false" href="#" {if $enablequeue}queue='push'{/if}><span>{$lang.Renew}</span></a>{*}
                            {*}<a class="menuitm menuc" onclick="$('#syncsubmit').click();return false" href="#"><span>{$lang.Synchronize}</span></a>{*}
                            {*}<a class="menuitm menuc" onclick="return confirm_delete_selected()" href="#"><span style="color:#FF0000">{$lang.Delete}</span></a>{*}
                            {*}<a class="setStatus menuitm menul" id="hd1" onclick="return false;"   href="#" ><span class="morbtn">{$lang.moreactions}</span></a>

                            <ul id="hd1_m" class="ddmenu">
                                <li ><a href="#">Send expiration notice</a></li>
                                <li ><a href="#" onclick="return send_msg('domains')">{$lang.SendMessage}</a></li>

                            </ul>
                            <input type="submit" name="sendmail" value="{$lang.SendMessage}" onclick="return send_msg('domains')" style="display:none"/>
                            <input type="submit" name="sync" value="1"  style="display:none" id="syncsubmit" />
                        </div>
                        <div class="clear"></div>
                    </div>

                    <a href="?cmd=domains&list={$currentlist}" id="currentlist" style="display:none"  updater="#updater"></a>
                    <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
                        <tbody>
                            <tr>
                                <th width="20"><input type="checkbox" id="checkall"/></th>
                                <th width="35"><a href="?cmd=domains&list={$currentlist}&orderby=id|ASC" class="sortorder">{$lang.idhash}</a></th>
                                <th><a href="?cmd=domains&list={$currentlist}&orderby=name|ASC"  class="sortorder">{$lang.Domain}</a></th>
                                <th><a href="?cmd=domains&list={$currentlist}&orderby=lastname|ASC"  class="sortorder">{$lang.clientname}</a></th>
                                <th  width="110"><a href="?cmd=domains&list={$currentlist}&orderby=module|ASC"  class="sortorder">{$lang.Registrar}</a></th>
                                <th width="70"><a href="?cmd=domains&list={$currentlist}&orderby=period|ASC"  class="sortorder">{$lang.Period}</a></th>
                                <th width="90"><a href="?cmd=domains&list={$currentlist}&orderby=date_created|ASC"  class="sortorder">{$lang.estimate_date}</a></th>
                                <th width="90"><a href="?cmd=domains&list={$currentlist}&orderby=expires|ASC"  class="sortorder">{$lang.Expires}</a></th>
                                <th width="90"><a href="?cmd=domains&list={$currentlist}&orderby=status|ASC"  class="sortorder">{$lang.Status}</a></th>
                                <th width="100">{$lang.options}</th>
                                <th width="20">&nbsp;</th>
                            </tr>
                        </tbody>
                        <tbody id="updater">

                            {include file='ajax.domains.tpl'}
                        </tbody>
                        <tbody id="psummary">
                            <tr>
                                <th></th>
                                <th colspan="10">
                                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>

                                </th>
                            </tr>
                        </tbody>
                    </table>

                    <div class="blu">
                        <div class="right"><div class="pagination"></div></div>
                        <div class="left menubar">
                            {$lang.withselected}   
                            <a class="menuitm menuf submiter renew confirm" name="renew" onclick="return false" href="#" {if $enablequeue}queue='push'{/if}><span>{$lang.Renew}</span></a>{*}
                            {*}<a class="menuitm menuc" onclick="$('#syncsubmit').click();return false" href="#"><span>{$lang.Synchronize}</span></a>{*}
                            {*}<a class="menuitm menuc" onclick="return confirm_delete_selected()" href="#"><span style="color:#FF0000">{$lang.Delete}</span></a>{*}
                            {*}<a class="setStatus menuitm menul" id="hd1" onclick="return false;"   href="#" ><span class="morbtn">{$lang.moreactions}</span></a>

                        </div>
                        <div class="clear"></div>
                    </div>
                    {securitytoken}</form>
                {/if}
                {if ($action=='edit' || !$action || $action=='default') && !$ajax}
                    {literal}
                        <script type="text/javascript">
                            var _delete_multi = false;
                            function confirm_delete_selected() {
                                if ($("#testform input[class=check]:checked").length < 1) {
                                    alert('Nothing checked');
                                }else{
                                    confirm_delete();
                                    _delete_multi = true;
                                }
                                return true;
                            }
                            function confirm_delete() {
                                _delete_multi = false;
                                $('#bodycont').css('position', 'relative');
                                $('#confirm_ord_delete').width($('#bodycont').width()).height($('#bodycont').height()).show();
                            }
                            function confirm_delete2() {
                                var add = '';
                                if ($('#cc_hard').is(':checked'))
                                    add = '&harddelete=true';
                                if(_delete_multi){
                                    ajax_update('?cmd=domains&delete=1&' + $.param($("#testform input[class=check]:checked")) + add, {stack: 'push'});
                                }else{
                                    window.location.href = '?cmd=domains&action=edit&make=delete&id='+$('#domain_id').val()+add+'&security_token='+$('input[name=security_token]').val();
                                }
                                
                                cancel_delete();
                                return false;
                            }
                            function cancel_delete() {
                                $('#confirm_ord_delete').hide().parent().css('position', 'inherit');
                                return false;
                            }

                        </script>
                    {/literal}
                    <div id="confirm_ord_delete" style="display:none" class="confirm_container">
                        <div class="confirm_box">
                            <h3>{$lang.deletedomain}</h3>
                            {$lang.deletedomattempt}<br />
                            <br />
                            <input type="radio" checked="checked" name="cc_" value="1" id="cc_hard"/> {$lang.deletedomhard}<br />
                            <input type="radio"  name="cc_" value="0" id="cc_soft"/> {$lang.deletedomsoft}<br />
                            <br />
                            <center>
                                <input type="submit" value="{$lang.Apply}" style="font-weight:bold" onclick="return confirm_delete2()"/>&nbsp;
                                <input type="submit" value="{$lang.Cancel}" onclick="return cancel_delete()"/>
                            </center>
                        </div>
                    </div>
                {/if}
        </div>
    </td>
</tr>
</table>